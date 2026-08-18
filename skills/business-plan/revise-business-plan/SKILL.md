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
  leaves stage at revising (unchanged) so run-review-council's own precondition picks it up for
  re-review.
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
   **Also extract the `### Discarded-but-real concerns` and `### Also flagging, regardless of
   severity` subsections if either is present** (per `skills/business-plan/run-review-council`'s
   §8.4 — these exist precisely because a genuinely credible persona concern can be excluded from
   the Required Revisions checklist by the outlier-discard rule or a softer aggregate severity,
   without that concern having been resolved). These items are **not part of your mandatory work
   order** — routing every discarded concern as mandatory would partly defeat the point of
   outlier-discard, which exists to stop one uncorroborated objection from dictating the outcome.
   But they must not silently vanish either: for each one, make a real, brief judgment call —
   address it now if it's genuinely small and clearly in scope (note this in step 4's
   `summary_of_changes` the same as any other change), or explicitly carry it forward. Confirmed
   live in round 6 as a real gap: without this step, a discarded persona's concerns are never
   worked at all and can resurface identically on the very next re-review, making a revision that
   substantively addressed everything in its literal work order look like it "did nothing" when it
   actually just never saw the rest of the picture.
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

**Distinguish decision-gated items from time-gated items — they need different honest handling.**
Some required revisions are blocked on a decision the founder can make right now in this session
(pick a build approach, state a funding preference) — route these per the rule above. Others are
blocked on real-world elapsed time or evidence that literally cannot exist yet within a single
revision session no matter how fast the founder moves (e.g. "recompute the funnel once 5+
prospects have moved through two pipeline stages," which can take weeks of real prospect
conversations to satisfy honestly). Confirmed live in round 6's dry run
(`docs/QA-FINDINGS-ROUND6.md`): fabricating a satisfied version of a time-gated item is exactly
the false-precision/automation-bias failure this plugin exists to prevent, so don't do it — but
don't report it identically to a founder-decision block either, since the caller and founder need
to know "wait for real time to pass and re-review" is a different next action than "make a
decision and I'll re-synthesize immediately." Report time-gated items explicitly as **open,
time-gated** (name what real-world evidence must accumulate and roughly how), distinct from
**blocked, needs founder decision** in your final report and in `plan.history`'s
`summary_of_changes`.

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
- **Explicit instruction to re-verify (not just carry forward) the mandatory `Confidence &
  Validation Status` section** — `key_assumptions`/`risk_log` entries change between revisions
  (a test resolves, a new AI-risk finding lands), so this section must be regenerated against the
  current state, not copied unchanged from the prior version. Per
  `agents/business-plan-editor.md`'s contract and `docs/AI-RISK-FRAMEWORK.md`, name it explicitly
  in the delegation — do not assume the editor includes it unprompted.
- Write the result to `plan/business-plan-v{N+1}.md` where N is the current `plan.version`
  (e.g. current version 1 -> write `plan/business-plan-v2.md`). Also update
  `plan/business-plan.md` itself to match the latest version (it's the canonical
  "current plan" pointer other skills read) — either as a copy or a symlink-equivalent full
  rewrite; this repo has no symlink convention, so rewrite `plan/business-plan.md` with the new
  content directly.

## 3.5. Mandatory AI-risk gate — before the revision is presented as addressing feedback

Per `skills/risk/ai-risk-review`'s own "Who must call this, and when" table, this skill is a
required caller: invoke `skills/risk/ai-risk-review` against the freshly-written
`plan/business-plan-v{N+1}.md`, handing it the whole document plus the `business-slug`, **after**
§3's re-synthesis and **before** §4's `summary_of_changes` / §5's "mark items addressed" step. A
revision that introduces a new unsourced number should not be reported as having addressed the
council's feedback.

- **PASS** → proceed to §4.
- **BLOCKED** → do not mark any required-revision item resolved in §5, do not advance `stage` in
  §6. Either fix the specific finding(s) and re-run the gate to confirm, or route to the
  orchestrator for an explicit, logged founder override (per `agents/orchestrator.md`
  Non-negotiable #3) — this skill does not accept an override itself. As with
  `assemble-business-plan`, there is no "presented with a caveat" middle path.

Note the finding's `risk_log` entry ids in your final report per §8.

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

**If any Discarded-but-real or Also-flagging item from §0 was addressed, name it explicitly
here too** ("also addressed the discarded customer-discovery-skeptic concern re: prospect
evidence quality — see step 09 rework"). **For any such item carried forward instead**, add a
`### Known concerns not required this cycle` section to `plan/business-plan-v{N+1}.md` itself
(near the Confidence & Validation Status section) naming the concern, which persona raised it,
and why it wasn't addressed this cycle — this is what keeps it visible to the founder and to the
next council review, rather than only living in a prior review file nobody re-reads. Do not
invent this section if nothing was carried forward.

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

## 6. Leave stage at "revising" for re-review

Once re-synthesis is complete (whether or not every item was resolved — an honest partial
revision still needs review), **do not change `stage`** — leave it exactly as `"revising"` (set
in §2 and never persisted as anything else by this skill). `skills/business-plan/run-review-council`
owns the transition out of `"revising"`; its own precondition (§0.2 of that skill) requires
`stage` to be exactly `"plan_assembled"` or `"revising"` when it is invoked, and it never reads or
expects an on-disk `"council_review"` value — that string describes the activity in progress, not
a stage this or any skill writes to disk (see `agents/orchestrator.md`'s state-machine notes,
which say the same thing from the caller's side). Writing `stage = "council_review"` here would
fail `run-review-council`'s precondition on the very next call and stall the revision loop. If one
or more required-revision items are still open, say so plainly in your final report so whoever
triggers the re-review knows this is not a claim of full resolution.

## 7. Update business-state.json — final write

Read the full file, write back only:

- `plan.version = N+1`
- `plan.file = "plan/business-plan.md"` (unchanged path, content updated)
- `plan.history`: append-only, per step 4.
- `reviews[]`: the triggering review's `resolved` field only, per step 5.
- `stage`: leave as `"revising"` — do not write `"council_review"` (see §6; that value is never
  persisted to disk by any skill in this plugin).
- `updated_at`: current timestamp.

Do not touch `disciplined_entrepreneurship` entries directly (the step skills you delegated to
own their own status updates), `gtm`, `ops`, `connectors`, `cadence`. You may append to
`risk_log` only if the revision surfaced a genuinely new risk that wasn't previously logged —
never delete or silently alter an existing entry.

## 8. Done looks like

- `plan/business-plan-v{N+1}.md` exists; `plan/business-plan.md` matches it.
- `skills/risk/ai-risk-review` returned PASS on the new version, or every BLOCKED finding was
  fixed-and-rechecked or carries a logged founder override — see §3.5. A revision that skipped
  this call is not done per this plugin's contract.
- `plan.version` bumped, `plan.history` has a specific, itemized `summary_of_changes`.
- The triggering review's `resolved` flag accurately reflects whether every item was fixed.
- `stage` is still `"revising"` (unchanged — see §6).
- Report back: version number, per-required-revision-item status (resolved/not resolved with
  reason), the file path of the new plan version, and the AI-risk gate's PASS/BLOCKED result with
  any `risk_log` ids it wrote.
