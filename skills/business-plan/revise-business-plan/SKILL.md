---
name: revise-business-plan
description: >
  Use after a council review comes back REVISE or REJECT (verdict schema in CONVENTIONS.md §6,
  in a reviews/*.md file with a matching business-state.json reviews entry). Triggers on "the
  council sent it back," "revise the plan," "address the review feedback," "council said
  REVISE." Reads the required-revisions list, routes each item to the owning
  disciplined-entrepreneurship step skill or fixes it at the synthesis level, produces
  plan/business-plan-v{N}.md via the same synthesis logic as assemble-business-plan, bumps
  plan.version, appends a specific plan.history entry, marks which items were addressed, and
  moves stage revising -> council_review for re-review.
---

# Revise Business Plan

You close the loop after a council rejects or sends back a plan. You do not create a new plan
from scratch — you make the smallest set of *substantive* changes that actually fix what the
council flagged, and you produce a clean record of what changed so the council can re-review
efficiently. Read `agents/business-plan-editor.md` before starting; it does the actual editing
and is the one that enforces "no cosmetic revisions."

## 0. Preconditions

1. Load `.startup/<business-slug>/business-state.json`.
2. Find the triggering review: the most recent `reviews[]` entry with `verdict` in
   `{REVISE, REJECT}` and `resolved: false`. If told which review to address explicitly, use
   that one instead. If no unresolved REVISE/REJECT review exists, stop and report that —
   don't invent revision work.
3. Read that review's file (`reviews/<timestamp>-<council>.md`) in full. Confirm it follows the
   verdict schema (CONVENTIONS.md §6) and extract the numbered **Required revisions** list
   exactly as written — this list is your work order, don't paraphrase it away.
4. Read the current `plan/business-plan.md` (or the highest-numbered `plan/business-plan-vN.md`
   if this is a second-or-later revision cycle) and `plan.version`/`plan.history` to know the
   current version number.

## 1. Route each required revision

For every numbered item in the review's Required revisions list, decide where the fix belongs:

- **Underlying-step issue** (the number, claim, or analysis itself is wrong or missing) —
  identify which `disciplined_entrepreneurship` step(s) own that fact (cross-reference against
  `docs/DE-24-STEPS.md` and the step's `plan/NN-slug.md`), and delegate back to that
  `skills/disciplined-entrepreneurship/NN-slug` skill to rework its `plan/NN-slug.md` and
  update its own `business-state.json` status entry. Wait for that skill to finish and its file
  to be updated before re-synthesizing.
- **Synthesis-level issue** (the underlying step data is fine but the plan's synthesis got it
  wrong — a reconciliation was missed, a section misrepresented a step, the executive summary
  overstated something, the LTV:COCA ratio wasn't surfaced) — fix this directly via the
  business-plan-editor subagent, no need to touch the step files.
- Keep an explicit mapping of `revision item -> {step(s) reworked | synthesis fix}` — you need
  this to write a real `summary_of_changes` in step 4 and to report per-item status.

If a required revision needs founder input you don't have (a new number, a decision only the
founder can make), do not fabricate it — flag it back to the caller/orchestrator as blocked,
and proceed with the other items. Report the blocked item clearly rather than silently
skipping it.

## 2. Update state before re-synthesizing

- Set `stage = "revising"` in `business-state.json` while work is in progress (write this
  immediately, before delegating to step skills, so the state file reflects reality mid-cycle).
- Any `disciplined_entrepreneurship` step you sent back for rework should get its `status`
  updated by that step's own skill, not by you — but confirm it happened before you proceed to
  re-synthesis; don't re-synthesize against a stale step file.

## 3. Re-synthesize the plan

Apply the same synthesis logic as `assemble-business-plan` (theme-to-step mapping, the
13+18 acquisition narrative, TAM reconciliation, LTV:COCA reconciliation, Key Assumptions &
Open Risks, appendix, executive-summary-written-last) to produce the next version — but scope
the actual editing to what changed. Call the `business-plan-editor` subagent with:

- The full prior plan (`plan/business-plan-v{N}.md` or `plan/business-plan.md` if this is the
  first revision).
- The updated/reworked step files (whichever changed).
- The required-revisions list with your routing decisions from step 1.
- Explicit instruction: **do not accept a cosmetic fix.** For each required-revision item, the
  editor must report back `resolved (substantively)` with what changed, or `not resolved` with
  what's blocking it, per the refusal contract in `agents/business-plan-editor.md`. If the
  editor reports an item as not resolved, do not mark it resolved in your own bookkeeping —
  carry it forward as still-open in your report and in `plan.history`.
- Write the result to `plan/business-plan-v{N+1}.md` where N is the current `plan.version`
  (e.g. current version 1 -> write `plan/business-plan-v2.md`). Also update
  `plan/business-plan.md` itself to match the latest version (it's the canonical
  "current plan" pointer other skills read) — either as a copy or a symlink-equivalent full
  rewrite; this repo has no symlink convention, so rewrite `plan/business-plan.md` with the new
  content directly.

## 4. Write a real summary_of_changes

Append to `plan.history` an entry:

```json
{
  "version": <N+1>,
  "file": "plan/business-plan-v{N+1}.md",
  "created_at": "<ISO-8601 timestamp>",
  "summary_of_changes": "<specific, itemized>"
}
```

`summary_of_changes` must name specifics — e.g. "Reworked step 04 beachhead TAM from
bottom-up-only to blended top-down/bottom-up per council request, revised TAM from $180M to
$64M; corrected LTV:COCA ratio in section 4 from a miscalculated 5.2:1 to the accurate 2.1:1
and flagged it as a risk; step 19 COCA channel mix updated to include the paid-search cost the
council flagged as omitted." Never write "addressed feedback," "incorporated council notes,"
or any other summary that doesn't let a reader tell what actually changed without re-reading
the diff themselves.

## 5. Mark the review's items addressed — don't force a full re-review

- Update the triggering review's entry in `business-state.json`'s `reviews[]`: set
  `resolved: true` only if **every** required-revision item was substantively resolved. If any
  item remains unresolved, leave `resolved: false` and note in your report exactly which
  item(s) are still open — do not claim resolution you didn't achieve.
- In the plan itself (or in a short changelog note at the top of the new version), list which
  specific required-revision items from that review were addressed and how, by number, so the
  council can re-review the delta rather than reading the whole plan cold. This is for the
  humans/agents on the review side, not just your own bookkeeping — make it visible in the
  document.
- Do not touch other `reviews[]` entries.

## 6. Advance stage for re-review

Once re-synthesis is complete (whether or not every item was resolved — an honest partial
revision still needs review), set `stage = "council_review"` so
`skills/business-plan/run-review-council` (owned by another builder) picks it up again. If one
or more required-revision items are still open, say so plainly in your final report so whoever
triggers the re-review knows this is not a claim of full resolution.

## 7. Update business-state.json — final write

Read the full file, write back only:

- `plan.version = N+1`
- `plan.file = "plan/business-plan.md"` (unchanged path, content updated)
- `plan.history`: append-only, per step 4.
- `reviews[]`: the triggering review's `resolved` field only, per step 5.
- `stage = "council_review"`
- `updated_at`: current timestamp.

Do not touch `disciplined_entrepreneurship` entries directly (the step skills you delegated to
own their own status updates), `gtm`, `ops`, `connectors`, `cadence`. You may append to
`risk_log` only if the revision surfaced a genuinely new risk that wasn't previously logged —
never delete or silently alter an existing entry.

## 8. Done looks like

- `plan/business-plan-v{N+1}.md` exists; `plan/business-plan.md` matches it.
- `plan.version` bumped, `plan.history` has a specific, itemized `summary_of_changes`.
- The triggering review's `resolved` flag accurately reflects whether every item was fixed.
- `stage = "council_review"`.
- Report back: version number, per-required-revision-item status (resolved/not resolved with
  reason), and the file path of the new plan version.
