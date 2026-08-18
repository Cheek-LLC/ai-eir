# Testing Strategy — 30-Minute Startup

This plugin is being built as a swarm: roughly 15 people/agents writing `agents/*.md` and
`skills/*/SKILL.md` files in parallel right now, with a stated trajectory toward hundreds of
agents and thousands of skills. Nothing enforces consistency automatically at that scale unless
we make it a deliberate layer of the system, not an afterthought a human reviewer catches by
reading every diff. This document is that layer's specification.

Three layers, each catching a different class of problem:

1. **Structural QA** — is this file well-formed and does it agree with the rest of the repo?
   (static, per-file and cross-file, fast, no execution required)
2. **Behavioral eval** — does this agent/skill actually do the right thing when run?
   (dynamic, requires execution, uses Claude Code's built-in eval tooling)
3. **Pre-release regression** — does the *plugin as a whole* still work end to end?
   (dynamic, whole-system, run before any release/version bump)

None of these substitutes for the others. A file can pass structural QA and still behave badly.
A file can behave fine in isolation and still silently break another skill's read/write chain.
A change can pass both file-level layers and still break the full lifecycle if a phase
transition in `agents/orchestrator.md` no longer matches what the phase's skills actually do.

---

## Layer 1 — Structural QA

**Owned by:** `agents/qa/skill-quality-auditor.md`, `agents/qa/consistency-checker.md`,
`skills/qa/eval-a-skill/SKILL.md`.

**What it checks, per file** (via `skill-quality-auditor`):
- Frontmatter is valid and complete per CONVENTIONS §2 (skills) / §3 (agents).
- The description is trigger-focused, not a vague topic label.
- The body specifies concrete deliverables — a file, a `business-state.json` field, a decision,
  a score — never "provide general guidance" (CONVENTIONS §7 bans this explicitly).
- Any file that can produce a number enforces the sourced-claim rule from
  `docs/DATA-CONTRACT.md` (every fact-presented number needs a `quantitative_claims[]` entry
  with a real source).
- No unexplained jargon, no stacked filler/disclaimers (CONVENTIONS §7).
- Review-council agents commit to the CONVENTIONS §6 verdict schema.

**What it checks, across files** (via `consistency-checker`):
- Two skills/agents don't claim to own the same `business-state.json` field with incompatible
  shapes.
- Every path a file claims to read from is actually written by some file in the corpus, and
  matches `docs/DATA-CONTRACT.md` / `docs/DE-24-STEPS.md` exactly (slugs, filenames).
- No duplicate agent or skill names.
- No path referenced outside the CONVENTIONS §1 directory layout without a corresponding update
  to `CONVENTIONS.md` / `docs/DATA-CONTRACT.md` in the same change.
- The review-council panel(s) under `agents/council/` actually have 3-5 distinct personas, not
  one persona duplicated under different filenames.

**How it's invoked:** `skills/qa/eval-a-skill` runs both agents against a target (one file, a
directory, or the whole repo) and returns one findings report with an overall
`READY TO MERGE` / `NOT READY` verdict. See merge policy below for when this is mandatory.

**What it deliberately does not do:** run anything. It never invokes a skill's actual logic,
never simulates a founder interview, never checks whether a council persona's judgment is any
good. That's Layer 2.

---

## Layer 2 — Behavioral eval

**Owned by:** Claude Code's built-in `claude plugin eval` command and the accompanying
skill-doctor workflow (see Claude Code's own documentation — this repo does not reimplement or
wrap it, `skills/qa/eval-a-skill` explicitly defers to it).

Use this layer to answer questions structural QA cannot:
- Does this DE-step skill actually push back on a vague founder answer the way
  `agents/orchestrator.md`'s Tone section demands, or does it accept "huge market" quietly?
- Does a council persona's score and required-revisions list hold up as *that persona* would
  plausibly render it, not a generic reviewer?
- Does `business-plan-editor`'s refusal-of-cosmetic-revisions logic actually catch a synonym-swap
  revision in practice, or only in the abstract?
- Does a skill ask the right follow-up questions when the founder's answer is ambiguous rather
  than just accepting whatever it's given?

Run `claude plugin eval` (with scripted or scenario-based test cases appropriate to the
agent/skill under test) whenever a change is more than a mechanical fix — new agent, new skill,
or a meaningful rewrite of an existing one's judgment logic. A pure structural fix (a missing
frontmatter field, a corrected file path) doesn't need a fresh behavioral eval; a change to what
an agent actually decides or how it phrases pushback does.

### Layer 2 status (as of this round)

This layer now has a starting implementation: **`evals/`** at the plugin root, a real
`claude plugin eval` case suite (six behavioral properties, `evals/**/case.yaml` +
`scaffold.sh` fixtures) plus a deterministic non-LLM reference check for the council
aggregation rule and a structural validator for the case files themselves. This replaces the
"never actually built" state this section previously implied — Layer 2 is no longer only a
description of what `claude plugin eval` *should* be used for, it is also six concrete cases
plus a runner (`evals/run-evals.sh`) that exercise it.

**Read `evals/README.md`'s "Honest status" section before treating this as a green-lit
regression suite.** The short version: `claude plugin eval`'s `case.yaml` schema was extracted
directly from this environment's installed Claude Code binary (the official public docs don't
document it yet), and every case file validates structurally against that schema — but actually
*running* the six cases against live model turns was blocked in the environment this round ran
in by a `` `plugin eval` is currently in early access `` feature flag, so no case has yet been
confirmed to pass (or to fail informatively) end to end. The next round with early access
enabled should run `bash evals/run-evals.sh` for real, fix whatever grader wording doesn't fire
the way it was intended to, and update `evals/README.md`'s status note once that's actually
happened — do not assume green just because the case files are well-formed.

`evals/` is a starting point (six cases), not full coverage of every judgment-logic surface
this plugin has — see `evals/README.md`'s "Extending this suite" section for the next-priority
additions (the `business-plan-editor` cosmetic-revision refusal, the founder-override path, a
second DE-step branching pair, the privacy-check Mode A/B split).

---

## Layer 3 — Pre-release regression checklist

Run this before any version bump / release, and after any change that touches
`agents/orchestrator.md`, the Data Contract, or more than one phase's worth of skills at once —
not just before a release, whenever a change is broad enough that Layer 1 (per-file/cross-file)
and Layer 2 (per-behavior) could both pass while the *whole lifecycle* still breaks.

### 3.1 Full lifecycle dry run

Drive one synthetic business end to end and confirm every stage transition in
`agents/orchestrator.md`'s state machine happens, in order, with no skipped stage and no stage
value that lags behind what actually happened:

- [ ] `/start-business` creates `.startup/<slug>/` with the full skeleton (`plan/`, `reviews/`,
      `gtm/`, `ops/`, `business-state.json`, `interview-log.md`) and `stage: "interview"`.
- [ ] Onboarding interview completes; `stage` advances to `de_steps_in_progress` only after
      founder info is actually captured, not before.
- [ ] All 24 DE steps run **in order** (01→24), each writes `plan/NN-slug.md` with the exact
      filename from `docs/DE-24-STEPS.md`, and each updates its
      `disciplined_entrepreneurship.NN_slug` entry (`status`, `summary`, `file`) — confirm the
      dependency ordering in `agents/orchestrator.md` Phase 2 is actually respected (e.g. step 05
      isn't started before 02-04 are `approved`).
- [ ] Steps 20-21 (Identify/Test Key Assumptions) actually operate on a `key_assumptions[]` list
      populated by steps 1-19, not an empty one.
- [ ] `stage: "plan_assembled"` is only set *after* `plan/business-plan.md` exists — confirm the
      file is on disk before the stage flips, not the other way around.
- [ ] Council review runs, verdict recorded in `reviews[]` with the full schema (CONVENTIONS
      §6), `resolved` set correctly for the branch taken.
- [ ] Founder greenlight moves `approved` → `gtm` → (on launch) `operating`, each with the
      correct sub-fields (`gtm.status`, `gtm.launch_plan_file`, `ops.status`) populated, not left
      at their initial defaults.

### 3.2 REVISE verdict actually routes back through revise-business-plan

- [ ] Force a council run that returns `REVISE` on at least one persona. Confirm
      `stage` moves to `"revising"` and every item in "Required revisions" is listed to the
      founder — none silently dropped.
- [ ] Confirm each revision routes to the *correct* owner per `agents/orchestrator.md`'s
      routing table: a content problem → the owning DE-step skill (or
      `skills/business-plan/revise-business-plan` → `agents/business-plan-editor.md`), an
      AI-risk/legal/privacy finding → `agents/risk/*`, a structural plan issue →
      `skills/business-plan/assemble-business-plan`. A revision routed to the wrong owner is a
      regression even if the plan eventually improves.
- [ ] Confirm `business-plan-editor.md`'s cosmetic-revision refusal actually fires: submit a
      revision that only reorders/rewords a flagged section and confirm it comes back
      **not resolved**, not silently accepted as fixed.
- [ ] Confirm the re-review targets the new plan version and re-invokes the same council/persona
      that raised the objection (or the full council, per the routing rule), not an unrelated
      fresh review that happens to return APPROVE.
- [ ] Confirm the founder-override path (CONVENTIONS §5 / orchestrator Non-negotiable #3) works
      when exercised: requires an explicit "yes, override" (not a shrug), writes a `risk_log`
      entry with `raised_by: "startup-operator (founder override)"` and a specific description,
      and marks the review file noted-but-overridden rather than deleting or hiding it.

### 3.3 `business-state.json` stays schema-valid across a full lifecycle

- [ ] After every write during the dry run in 3.1, the file parses as valid JSON and every field
      present matches `docs/DATA-CONTRACT.md`'s schema — no undocumented stray fields, no field
      silently dropped between reads.
- [ ] Confirm read-modify-write discipline: pick at least two points in the lifecycle, snapshot
      `business-state.json` immediately before and after one agent's write, and confirm every key
      that agent doesn't own is byte-identical across the snapshot (per CONVENTIONS §5: "write
      back only the keys they own... never blind-overwrite the file").
- [ ] Confirm `risk_log` entries are never deleted across the run — only status-transitioned
      (`open` → `mitigated`/`accepted`) with a note, per `docs/DATA-CONTRACT.md`'s convention.
- [ ] Confirm the sourced-claims gate actually blocks: introduce one number into a step file with
      no matching `quantitative_claims[]` source, run it through council review, and confirm it
      surfaces as an AI-risk finding that blocks approval rather than sailing through.

### 3.4 Cadence / check-in mechanics

- [ ] With a scheduling tool available in the environment: confirm `cadence.next_check_in` is
      computed correctly from the chosen frequency, a real scheduled prompt is created, and
      `cadence.scheduling_mechanism` records the actual tool used (not a placeholder string).
- [ ] With no scheduling tool available: confirm the session says so plainly, sets
      `scheduling_mechanism: "manual-reminder"`, and ends by reminding the founder to run
      `/business-status` themselves — not buried, the literal last thing said.
- [ ] Confirm a scheduled/resumed session re-reads `business-state.json` before saying or doing
      anything about where the business stands (Non-negotiable #1) — it must not assume it
      remembers the prior session's conversation.

### 3.5 Multi-business isolation

- [ ] Run two businesses through overlapping phases in the same environment and confirm neither
      one's `.startup/<slug>/` directory is ever read from or written to by the other's session.

### 3.6 Plan hygiene

- [ ] Confirm `plan/business-plan.md` is never hand-edited directly by any agent outside
      `agents/business-plan-editor.md` invoked via the assemble/revise skills — a fix to a wrong
      fact should regenerate from the source step file, not patch the generated file.

Any unchecked box in this list blocks a release. A partial pass ("mostly works") is not a pass —
record exactly which box failed and why, the same discipline this repo expects of a council
verdict.

---

## Merge policy — how new agents/skills get QA'd

This repo is being built by many contributors in parallel, so the policy has to be enforceable
without a single human reading every file:

1. **Every new or meaningfully-changed `agents/*.md` or `skills/*/SKILL.md` file gets run
   through `skills/qa/eval-a-skill` before it is considered done.** Not optional, not "if there's
   time" — a file that hasn't been run through it is not finished work, the same way an
   unreviewed DE step in the plugin's own domain model is `drafted`, not `approved`.
2. **A `NOT READY` verdict (any blocking finding) must be resolved before merge**, either by
   fixing the file or — rarely, and only with explicit reasoning recorded in the PR/commit —
   by a maintainer explicitly waiving a specific finding with a stated reason. A waived finding
   is not a silently ignored one; write down why.
3. **Advisory findings from `consistency-checker` don't block merge by themselves**, but should
   be triaged, not accumulated indefinitely — a growing pile of "advisory" items is itself a
   signal the repo is drifting.
4. **New agents/skills that introduce a new `business-state.json` field or a new directory
   under the CONVENTIONS §1 layout must update `docs/DATA-CONTRACT.md` / `CONVENTIONS.md` in the
   same change** — `consistency-checker` will flag it otherwise, and it should.
5. **A change to judgment logic (not just structure) should also get a Layer 2 behavioral eval**
   via `claude plugin eval` before being considered done — structural QA passing is necessary,
   not sufficient, for anything that changes what an agent actually decides.
6. **As the corpus grows past what any one PR touches, run `agents/qa/consistency-checker`
   repo-wide on a recurring basis** (not only per-PR) — two unrelated PRs can each pass their own
   targeted check and still collide once both land (e.g. two builders independently pick the
   same agent name, or two skills each start claiming ownership of a field neither's targeted
   check saw the other touch). A repo-wide sweep is the only way to catch that class of bug at
   this scale, and it only gets more necessary as the plugin grows toward hundreds of agents and
   thousands of skills.
7. **This document changes with the QA layer, in the same commit.** If `skill-quality-auditor`
   or `consistency-checker`'s checklist changes, update the corresponding section here so the
   merge policy never describes a check that no longer exists (or omits one that now does).
