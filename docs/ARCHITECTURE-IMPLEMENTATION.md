# Architecture — Implementation

This is the mechanical, file-level view: what discovers what, what reads and writes which file,
and how to check the repo hasn't drifted from `CONVENTIONS.md`. For the *why* behind these
choices — the design rationale for the state machine, the council system, the connectors layer —
see `docs/ARCHITECTURE.md`. For the canonical schema of `business-state.json`, see
`docs/DATA-CONTRACT.md`. This document assumes you've read `CONVENTIONS.md`.

## 1. `plugin.json`'s role

`.claude-plugin/plugin.json` is the plugin manifest Claude Code reads once, at load time, to
identify and describe the plugin as a whole (`name`, `description`, `version`, `author`,
`homepage`, `repository`, `license`, `keywords`). It is metadata, not a manifest of contents:

- It does **not** enumerate agents, skills, or commands by name or path. Claude Code discovers
  those by walking the plugin's standard directories directly (see §2) — `plugin.json` never goes
  stale as new agents/skills/commands are added, because it never lists them.
- CONVENTIONS.md §1 says not to edit its structure, only "add discoverable dirs if needed." In
  practice that means: if a future addition needs a directory Claude Code doesn't already scan by
  convention (agents/skills/commands are scanned automatically; something genuinely new — e.g. a
  hooks directory — would not be), that's the one reason to touch this file. Adding another
  `skills/<category>/` folder or `agents/<category>/` folder is **not** such a case — those are
  already inside directories Claude Code walks recursively.
- `version` here is the plugin's own release version, unrelated to `business-state.json`'s
  per-business `plan.version`. Bump it when cutting a release, not on every commit.

This is why the swarm-build model works at all: ~15 (eventually hundreds of) contributors can add
files under `agents/`, `skills/`, and `commands/` in parallel without ever touching a shared
manifest file, which would otherwise be the merge-conflict bottleneck for every single PR.

## 2. How Claude Code discovers agents, skills, and commands

Discovery is directory-convention-based, not manifest-based, and recursive within each root:

- **Agents** — every `agents/**/*.md` file is a subagent definition. Its frontmatter `name` and
  `description` (CONVENTIONS.md §3) are what Claude Code uses for auto-routing: when a user's
  request matches what a `description` says the agent handles, Claude Code can delegate to it by
  invoking that agent with its file body as the system prompt. Subfolders under `agents/`
  (`council/`, `gtm/`, `ops/`, `risk/`, `qa/`, `connectors/`) are purely organizational — they
  group agents by domain for humans and for `/list-skills`, but Claude Code discovers a file at
  any depth under `agents/`, not just top-level files.
- **Skills** — every `skills/*/SKILL.md` (and, for the Disciplined Entrepreneurship steps,
  `skills/disciplined-entrepreneurship/NN-slug/SKILL.md`, one directory level deeper) is a skill
  package. `name` and `description` (CONVENTIONS.md §2) drive the same trigger-matching mechanism
  agents use, scoped to "this is a packaged procedure for doing one thing," not a persona. The
  body is read in full only once the skill is actually invoked — the `description` is what has to
  carry enough signal to trigger correctly among thousands of sibling skills as the repo grows.
- **Commands** — every `commands/*.md` file becomes a slash command named after its filename
  (`commands/check-in.md` → `/check-in`). Unlike agents/skills, a command has no `name` field
  (CONVENTIONS.md §4) — the filename *is* the identifier — and no auto-routing: a command only
  runs when a user (or a scheduled trigger prompt) explicitly types `/command-name`. The file body
  is a prompt template, with `$ARGUMENTS` substituted for whatever the user typed after the
  command name.

None of these three discovery mechanisms requires a build step, an index file, or a registration
call — a new contributor's PR that adds one well-formed file is immediately live. The cost of that
convenience is that nothing structurally stops two contributors from picking the same `name`, an
agent from shipping without a `description`, or a `disciplined-entrepreneurship` folder from being
misnamed — which is exactly the drift `scripts/validate-plugin.sh` exists to catch (§4).

## 3. How `business-state.json` flows between all of it

`docs/DATA-CONTRACT.md` is the authoritative schema; this section is about the *flow*, not the
shape. Mechanically:

1. **One file per business is the only shared memory.** `.startup/<slug>/business-state.json`
   is created once, at the start of onboarding (`/start-business` → `startup-operator` agent →
   `skills/interview/onboarding-interview`), and every subsequent agent/skill invocation for that
   business — regardless of which contributor authored it, which session it runs in, or how much
   time has passed — starts by reading this file in full. There is no other channel: conversation
   memory does not persist across sessions, and nothing may be treated as true about a business
   unless it is written here or in one of the markdown artifacts this file points to
   (`interview-log.md`, `plan/*.md`, `reviews/*.md`, `gtm/*`, `ops/*`).
2. **Read-modify-write, never blind-overwrite.** Every agent/skill that touches
   `business-state.json` reads the whole file, changes only the top-level keys it owns (per the
   Data Contract's per-key ownership implied by which agent/skill the key belongs to — e.g.
   `disciplined_entrepreneurship.NN_slug` is owned by that step's skill, `reviews[]` entries by
   `skills/business-plan/run-review-council`, `cadence` by the orchestrator and
   `/check-in`/`/business-status`), preserves every other key untouched, and updates `updated_at`.
   This is what lets independently-authored agents/skills interoperate on one file without a
   central coordinator reconciling writes.
3. **The `stage` field is the flow-control hub.** Every agent that can move a business between
   states (`interview` → `de_steps_in_progress` → `plan_assembled` → `council_review` ⇄
   `revising` → `approved` → `gtm` → `operating`, with `paused` reachable from anywhere) writes the
   new `stage` value itself, the moment the transition happens — see `agents/orchestrator.md`'s
   state machine and `docs/ARCHITECTURE.md`'s lifecycle diagram for the full edge set. Any command
   or agent that resumes work (`/business-status`, `/check-in`, a scheduled trigger firing) reads
   `stage` first and resumes from exactly there; nothing infers state from conversation history.
4. **Markdown artifacts are addressed *by* the JSON, not duplicated *into* it.** `business-state.json`
   holds structured pointers (`file` fields, `reviews[].file`, `gtm.artifacts[].file`) into the
   markdown tree under `.startup/<slug>/`; the prose itself lives in those files, not inlined into
   JSON. `plan/business-plan.md` in particular is always generated from `plan/NN-slug.md` files
   plus `key_assumptions`/`quantitative_claims` — it is never hand-edited, so it can be safely
   regenerated whenever a source step changes.
5. **Numbers carry provenance through the same file.** Any figure landing in
   `plan/business-plan.md` as fact must have a matching `quantitative_claims[]` entry with a real
   `source`; this is enforced by `agents/orchestrator.md` before assembly and checked again by
   AI-risk review before a council can approve. The mechanism is entirely: both live in the same
   JSON file, so any consumer (a council agent, a GTM agent citing a claim, this repo's own
   tooling) can cross-reference a claim to its source without re-deriving it.
6. **This plugin engineering layer touches `business-state.json` in three narrow ways:**
   `/run-council` resolves a review target and records the resulting `reviews[]` entry (without
   claiming ownership of `stage` unless the business is already mid-gate — see
   `commands/run-council.md`); `/check-in` updates `cadence.last_check_in`,
   `cadence.check_in_frequency`, `cadence.next_check_in`, and `cadence.scheduling_mechanism`
   exactly as the orchestrator's recurring check-in logic specifies; `/list-skills` never touches
   `business-state.json` at all — it only walks the plugin's own source tree, not any business's
   working directory.

## 4. Running `scripts/validate-plugin.sh`

`scripts/validate-plugin.sh` is a self-contained bash script (POSIX-ish tools only — `bash`,
`grep`, `awk`, `sed`, `find`; no `jq`, no `yq`, no language runtime) that walks the whole plugin
tree and checks it against `CONVENTIONS.md`:

- every `skills/**/SKILL.md` has YAML frontmatter with a non-empty `name` and `description`;
- every `agents/**/*.md` has YAML frontmatter with a non-empty `name` and `description`;
- every `commands/**/*.md` has a non-empty `description`;
- no two agents/skills (combined) share the same `name`;
- every `NN-slug` folder under `skills/disciplined-entrepreneurship/` matches one of the 24
  canonical slugs parsed live out of `docs/DE-24-STEPS.md` (parsed, not hardcoded, so the check
  can't itself drift from that doc).

**Run it locally, from the plugin root, before opening a PR that adds or touches an
agent/skill/command file:**

```bash
./scripts/validate-plugin.sh
```

It prints a per-section progress log, then a pass/fail summary with counts, and exits `0` on a
clean pass or `1` if any check failed (each failure is listed with the offending file and reason).
Non-fatal issues (an empty category directory, a canonical-slug count that isn't exactly 24) are
reported as warnings and do not affect the exit code — they're informational for a repo that is
still mid-build.

It optionally accepts a repo-root path as its first argument (`./scripts/validate-plugin.sh
/path/to/checkout`), defaulting to its own parent directory — useful for running it against a
worktree or a fixture directory without `cd`-ing first.

**CI candidate, not yet wired up:** this script's exit code is designed to gate a merge — it is a
natural fit for a GitHub Actions workflow step (`run: ./scripts/validate-plugin.sh`) triggered on
pull requests touching `agents/**`, `skills/**`, `commands/**`, or `docs/DE-24-STEPS.md`. That
workflow file itself is out of scope here; this is the one-line pointer for whoever picks it up.

## 5. Where this leaves a new contributor

Adding a new agent, skill, or command to this plugin requires touching exactly the files
CONVENTIONS.md describes, in their conventional location, with correct frontmatter — nothing else.
No manifest entry, no registration call, no index to update. `scripts/validate-plugin.sh` is the
mechanical safety net that catches the most common ways that goes wrong before it reaches
`main`; `docs/ARCHITECTURE.md` is where to understand *why* the system is shaped this way before
deciding where a new piece of work belongs within it.
</content>
