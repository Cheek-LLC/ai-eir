---
name: eval-a-skill
description: >
  Use this skill to run structural QA on one agent/skill file, a directory of them, or the
  whole plugin, before considering new or changed agents/skills done. Triggers: "eval this
  skill", "QA this before I merge it", "run eval-a-skill on <path>", "check my new agent
  against CONVENTIONS.md", "audit the whole repo", "is this ready to merge". Runs
  agents/qa/skill-quality-auditor against every target file individually and
  agents/qa/consistency-checker across the target set, then produces one findings report with
  a clear overall verdict. This is the structural/static QA layer (frontmatter, deliverables,
  cross-file consistency) — for behavioral testing of what a skill actually *does* when run,
  use Claude Code's built-in `claude plugin eval` / skill-doctor tooling instead (see below);
  this skill does not reimplement that.
---

# Eval a Skill

You run this skill to structurally QA one or more `agents/*.md` / `skills/*/SKILL.md` files
before they're considered done, per the merge policy in `docs/TESTING.md`. You are an
orchestrator here, not an auditor yourself — the actual checking is done by
`agents/qa/skill-quality-auditor` (per file) and `agents/qa/consistency-checker` (across the
set). Your job is to determine scope, dispatch both, and assemble one honest report.

## What you read

- The target path(s) given by the caller (a single file, a directory, or nothing).
- `CONVENTIONS.md` and `docs/DATA-CONTRACT.md` are not yours to re-read line by line — the two
  agents you dispatch own that; you just need enough context to describe scope accurately in
  the report header.

## What you write

Nothing to disk by default. Your deliverable is the findings report, returned in the
conversation to whoever invoked you (a human maintainer, or another agent acting on a swarm
builder's behalf). If the caller explicitly asks you to persist the report as a file, write it
wherever they specify — do not invent a new default location under a directory
`CONVENTIONS.md` §1 doesn't declare; a QA report is not business data and has no place under
`.startup/`, and the plugin repo layout has no standing "reports" directory today.

## Steps

1. **Determine scope.**
   - A specific file path given → scope is that one file.
   - A directory given (e.g. `agents/gtm/`, `skills/disciplined-entrepreneurship/`) → scope is
     every `*.md` under it that matches `agents/*.md` or `skills/*/SKILL.md`.
   - Nothing given, or "the whole repo" / "everything" → scope is every file matching
     `agents/**/*.md` and `skills/**/SKILL.md` in the plugin.
   - If the path given doesn't exist, or matches zero files, stop and say so plainly — don't
     silently widen the scope to something that does exist.

2. **Enumerate target files** with `Glob`. List them in the report header so the caller can see
   exactly what was and wasn't covered — this matters as the repo grows past what fits in one
   skim.

3. **Run `agents/qa/skill-quality-auditor` once per target file.** Dispatch it as a subagent
   (via the Task tool) for each file in scope, in parallel where the harness allows it — these
   audits are independent of each other. Collect each PASS/FAIL verdict verbatim; do not
   summarize away the specific fixes it lists.

4. **Run `agents/qa/consistency-checker` once for the whole check.** Pass it the same target
   scope, but remind it (per its own instructions) to read enough of the surrounding corpus to
   actually cross-reference — a consistency check needs more than the target set to be
   meaningful when the target is a single new file. For a repo-wide scope, it's already checking
   everything against everything.

5. **Assemble one report** (format below). Do not silently drop a FAIL or a blocking finding to
   make the summary look cleaner — the whole point of this skill is that "done" is earned, not
   assumed, matching the plugin's own tone bar in CONVENTIONS §7.

6. **State the overall verdict** plainly at the top: `READY TO MERGE` only if every audited file
   PASSed and the consistency check found zero blocking findings. Otherwise `NOT READY` with the
   count of blockers. Advisory-only findings (from the consistency checker) don't block the
   verdict by themselves, but list them — they're real inconsistencies a maintainer should
   triage even if they're not load-bearing yet.

## Report format

```
# Eval report — <scope description>

**Overall: READY TO MERGE | NOT READY (<n> blocking issue(s))**
**Files audited:** <count>
**Run at:** <date, from context — never fabricate a timestamp>

## Per-file audits
### agents/gtm/launch-planner.md — PASS
### skills/gtm/launch-brief/SKILL.md — FAIL
- 3. Concrete deliverables — FAIL: "provide general guidance on channel selection" (line ~40)
  → name the specific file (`gtm/launch-plan.md`) and the specific decision (channel + budget
  split) this skill commits to producing.
...

## Cross-file consistency
### Blocking
1. [Broken chain] `skills/gtm/launch-brief/SKILL.md` reads `plan/business-plan.md` before it's
   guaranteed to exist if invoked pre-`plan_assembled` — no guard against that stage in the body.
   Fix: add a stage precondition, per how `agents/orchestrator.md` gates other phases.

### Advisory
1. ...

## What this did NOT check
Behavioral correctness — whether the skill/agent actually produces good output when run. Use
Claude Code's built-in `claude plugin eval` (and the skill-doctor tooling it documents) for
that: it runs a skill/agent against real or scripted scenarios and grades the *output*, where
this report only grades the *file*. A file can pass every check here and still perform badly in
practice, or fail here on a structural nit while behaving fine — the two layers are
complementary, not redundant; see `docs/TESTING.md` for how they fit together in this repo's
overall testing strategy.
```

## Relationship to `claude plugin eval` / skill-doctor

Do not reimplement behavioral testing inside this skill. Claude Code ships its own eval-suite
tooling (`claude plugin eval` and the accompanying skill-doctor workflow, documented in Claude
Code's own docs) purpose-built for running an agent or skill against real scenarios and grading
what it actually does — tone, correctness of judgment calls, whether it asks the right follow-up
questions, whether a council persona's score is defensible. That is a fundamentally different
kind of check than anything in this skill (which only ever reads files, never runs them), and
duplicating it badly here would be worse than pointing at the real thing. When a maintainer needs
"does this actually work," point them there. When they need "is this file well-formed and
non-contradictory before we even try running it," that's this skill.
