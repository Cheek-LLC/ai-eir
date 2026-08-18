# QA Layer 3 Regression — Round 5: First Real Pass Against `docs/TESTING.md`'s Checklist

**Method.** `docs/TESTING.md`'s Layer 3 section has existed since it was written but had never
actually been run as a pass/fail exercise against the repo's real artifacts — this document is
that pass. I did not role-play a new founder or invoke any skill live. Instead I treated the three
existing dry-run fixtures under `.startup/` (round 2's `shiftcover`, round 3's `skyclaim`, round
4's `vantage-point-search`) as the real, already-collected test data the checklist asks for, and
checked each box in `docs/TESTING.md` §3.1–§3.6 against:

- the full contents of all three fixtures' `business-state.json`, every `plan/*.md`,
  `reviews/*.md`, and `interview-log.md` file that exists on disk (mechanically verified with
  `find`/`grep`, not sampled);
- a Python schema check of all three `business-state.json` files against `docs/DATA-CONTRACT.md`
  (top-level keys, all 24 `disciplined_entrepreneurship` keys/names/files, `reviews[]`/
  `key_assumptions[]`/`quantitative_claims[]`/`risk_log[]` required fields and enums, referenced
  file paths checked for existence on disk);
- the current text of `agents/orchestrator.md`, `skills/business-plan/run-review-council/SKILL.md`,
  `skills/business-plan/revise-business-plan/SKILL.md`, `agents/business-plan-editor.md`,
  `agents/gtm/launch-director.md`, and `skills/risk/privacy-check/SKILL.md`;
- `docs/QA-FINDINGS-ROUND2.md` and `docs/QA-FINDINGS-ROUND4.md` for what earlier rounds already
  found, to distinguish "still broken" from "already fixed, fixture just predates the fix."

Where the checklist asks for something none of the three fixtures ever reached (nothing has gone
past `approved`), I say so as a gap, not a hypothetical pass. Where I found a real, demonstrated
defect, I fixed it directly (one case, logged below) because it was small and confined to a single
file with no fixture edits and no conflicting round-5 work in progress (`git status --short`
showed a clean tree before I touched anything).

**Overall Layer 3 verdict: NOT READY as a full pass — 6 PASS, 9 GAP, 2 FAIL (1 fixed this round,
1 logged).** This is expected at this stage of the project (nothing has run GTM/ops live yet) and
is not a regression from where the project actually is — but per `docs/TESTING.md`'s own rule, "a
partial pass is not a pass," so this file records exactly which boxes are unchecked and why,
the same discipline expected of a council verdict.

---

## 3.1 Full lifecycle dry run

| # | Checklist item | Verdict | Evidence |
|---|---|---|---|
| 1 | `/start-business` creates the full skeleton + `stage: "interview"` | **PASS** | All three `.startup/<slug>/` trees have `plan/`, `reviews/`, `gtm/`, `ops/`, `business-state.json`, `interview-log.md`. Final `stage` values (`revising`, `revising`, `approved`) prove the interview phase completed and moved on for all three. |
| 2 | `stage` advances to `de_steps_in_progress` only after founder info is captured | **PASS (indirect)** | All three `founder`/`business_basics` blocks are fully populated and internally consistent with each `interview-log.md`'s onboarding narrative; no fixture shows a `de_steps_in_progress`-or-later stage with an empty `founder`/`business_basics`. |
| 3 | All 24 DE steps run in order 01→24, each writes `plan/NN-slug.md`, each updates its `disciplined_entrepreneurship.NN_slug` entry | **PASS** | Mechanically verified for all three fixtures: all 24 `plan/NN-slug.md` files exist on disk with filenames matching `docs/DE-24-STEPS.md` exactly, and all 24 `disciplined_entrepreneurship` keys match the exact expected slug-to-underscore naming, in the exact expected order, each with `status`/`summary`/`file` populated and `file` pointing at the file that actually exists. Zero mismatches across 3 × 24 = 72 entries. |
| 3a | Dependency ordering is actually respected (step 05 not started before 02-04 drafted) | **GAP — unverifiable from static fixtures** | The fixtures record only final state; `interview-log.md` in all three covers only the onboarding session, not a per-DE-step timeline, so there's no timestamp evidence of *execution order*, only of final content coherence. Content-level evidence is consistent with correct ordering (e.g. shiftcover's Step 20 summary: "29-item register swept from Steps 1-19" — the right count for steps 1-19's actual assumption yield), but this is not proof steps ran in 01→24 order rather than out of order with the same eventual content. A future round should capture a timestamped trace (or at minimum log DE-step start/end into `interview-log.md`) to make this checkable. |
| 4 | Steps 20-21 operate on a real, populated `key_assumptions[]`, not empty | **PASS** | shiftcover: 26 items before/entering step 20, step 20 summary states "29-item register swept from Steps 1-19"; skyclaim: 31-item register per its own step-20 summary; vantage-point-search: "14 assumptions carried from Steps 1-19 plus one new one." All three show step 20/21 content that is specific to and traceable from steps 1-19's actual output, not generic filler. |
| 5 | `stage: "plan_assembled"` only set after `plan/business-plan.md` exists on disk | **PASS (indirect)** | All three have `plan/business-plan.md` on disk and are at a stage past `plan_assembled` (`revising`/`revising`/`approved`), consistent with the file having existed before the later transitions. No fixture shows a stage-vs-file-existence mismatch. |
| 6 | Council review runs, verdict recorded in `reviews[]` with full CONVENTIONS §6 schema, `resolved` set correctly for the branch taken | **PASS for shiftcover/skyclaim, FAIL for vantage-point-search** | shiftcover: `REVISE`, `resolved: false` — correct, no revision cycle has closed the loop yet. skyclaim: `REJECT`, `resolved: false` — correct, same reason. **vantage-point-search: `APPROVE_WITH_NOTES`, `resolved: false`, while `stage` is already `"approved"`.** `agents/orchestrator.md` Phase 4 step 2 is explicit: on `APPROVE`/`APPROVE_WITH_NOTES` the skill deliberately leaves `resolved: false`, and it is *the orchestrator's* job to flip it to `true` once the founder has been told the notes. Nothing in `interview-log.md` or the review file shows that founder-notification step happened, and `resolved` was never flipped. This is either (a) a real miss — the orchestrator reached `stage: approved` without completing its own mandated closing step, or (b) an honest mid-session fixture snapshot taken before that step ran. Static evidence can't fully disambiguate, but the checklist item ("resolved set correctly for the branch taken") is not satisfied as recorded — flagging as **FAIL**, not fixed (fixtures are off-limits to edit), for a future round to close explicitly by either completing the step live or clarifying in `agents/orchestrator.md` exactly when this write is expected to have landed. |
| 7 | Founder greenlight moves `approved → gtm → operating`, sub-fields populated not left at defaults | **GAP — never exercised** | No fixture has left `approved`. `gtm.status` is `not_started` and `ops.status` is `not_started` in all three. **This is the single biggest, most explicit gap in the plugin's live-testing history**: across three independent dry runs (rounds 2, 3, 4) covering `saas`/`idea_only`, `marketplace`/`pivoting`, and `services`/`already_operating`, not one has ever driven a business through `gtm` or `operating`. `agents/gtm/launch-director.md`, every `skills/gtm/*` skill, every `agents/ops/*` and `skills/ops/*` skill, and the entire back half of the state machine in `agents/orchestrator.md` (Phases 5-6) are structurally reviewed (Layer 1) and read correctly, but have **zero real-run evidence** behind them. State this plainly rather than inferring it works because the files read well — that is exactly the trap this document exists to avoid. |

**Additional finding not on the checklist but directly relevant to it:** vantage-point-search's
`gtm.launch_plan_file` is set to `"gtm/launch-plan.md"` even though `gtm.status` is `"not_started"`
and no such file exists on disk (mechanically confirmed — `os.path.exists` returns `False`).
shiftcover and skyclaim both correctly leave this field at `""` (its true initial default,
confirmed by `agents/gtm/launch-director.md`, which is the sole owner of this field and only
writes it once GTM work actually starts). This is a real inconsistency inside the one fixture that
reached furthest, caught by the same principle checklist item 3.1's last bullet names ("sub-fields
populated ... not left at their initial defaults" — the inverse failure mode also matters: a
sub-field populated *before* its owning phase ran). Logged here, not fixed (fixture is off-limits).

---

## 3.2 REVISE verdict routes back through `revise-business-plan`

**Headline finding: the revision loop has never been exercised end-to-end by any dry run, and
checking the code path for real (rather than assuming it works because it reads correctly)
surfaced an actual bug that would have broken it.**

| # | Checklist item | Verdict | Evidence |
|---|---|---|---|
| 1 | Force a `REVISE`, confirm `stage → "revising"`, every "Required revisions" item listed to founder | **PASS (the `REVISE`/`REJECT` half only)** | shiftcover (`REVISE`) and skyclaim (`REJECT`) both show `stage: "revising"` and both review files contain full, itemized "Required revisions" sections per CONVENTIONS §6. |
| 2 | Each revision routes to the correct owner per the routing table | **GAP — never exercised** | No fixture has a second plan version or any evidence a routing decision was ever made past the point of *recording* the required revisions. Routing only happens inside `revise-business-plan`, which no fixture has invoked. |
| 3 | `business-plan-editor.md`'s cosmetic-revision refusal actually fires | **GAP — never exercised** | The refusal contract (`agents/business-plan-editor.md` "Refusing cosmetic revisions," lines 104-126) is well-specified in prose — three concrete steps, an explicit "resolved (substantively)" / "not resolved" reporting contract — but it has never been invoked by a real dry run, so there is no evidence it actually catches a synonym-swap revision in practice, only that the instruction exists. This is exactly the Layer-2-shaped question `docs/TESTING.md` itself flags (§Layer 2, "does the refusal logic actually catch a synonym-swap revision in practice, or only in the abstract") — it remains open at both layers. |
| 4 | Re-review targets the new plan version, re-invokes the same council/persona | **GAP — never exercised**, and **found a real FAIL blocking it, now fixed** | See below. |
| 5 | Founder-override path works when exercised (explicit "yes, override," `risk_log` entry with `raised_by: "startup-operator (founder override)"`, review file marked noted-but-overridden) | **GAP — never exercised** | No `risk_log` entry in any of the three fixtures has `raised_by` matching `"startup-operator (founder override)"` or any override language. The mechanism (`agents/orchestrator.md` Non-negotiable #3) is specified but has no real-run evidence. |

### FAIL found and fixed: `revise-business-plan` wrote a `stage` value `run-review-council` would
### have rejected

Reading `skills/business-plan/revise-business-plan/SKILL.md` against `agents/orchestrator.md` and
`skills/business-plan/run-review-council/SKILL.md` (rather than reading each file in isolation, per
this checklist item's actual intent) surfaced a genuine, three-way contradiction that would have
broken the very loop this section is meant to verify:

- `agents/orchestrator.md`'s state-machine notes say plainly: `run-review-council` "writes stage
  straight to approved/revising ... it never persists 'council_review' as an on-disk value, so
  never write that value to business-state.json yourself," and Phase 4 step 4 says the re-review
  call "must still read `'revising'`, which is exactly what the skill's precondition expects."
- `skills/business-plan/run-review-council/SKILL.md` §0.2 confirms this from the other side: its
  precondition is "Confirm `stage` is `plan_assembled` or `revising`... If `stage` is anything
  else, stop and report."
- **`skills/business-plan/revise-business-plan/SKILL.md` (before this round's fix) contradicted
  both of them**: its old §6 ("Advance stage for re-review") instructed writing
  `stage = "council_review"` once revision work finished, and its old §7 final-write list and
  frontmatter description repeated the same instruction.

Had any dry run actually exercised this loop, `revise-business-plan` would have left
`business-state.json.stage = "council_review"` on disk, and the very next call to
`run-review-council` — the one meant to re-review the fixed plan — would have failed its own
precondition check and refused to run. The loop this checklist section exists to verify would have
stalled at exactly the handoff point between the two skills. This is precisely why item 2's
prediction (unexercised code paths are where undetected contradictions hide) holds here concretely,
not just in the abstract.

**Fix applied** (single file, no fixture touched, `git status` was clean before editing):
`skills/business-plan/revise-business-plan/SKILL.md` — changed §6, §7, and the frontmatter
description so the skill leaves `stage` at `"revising"` (unchanged, as set in its own §2) rather
than writing `"council_review"`. `run-review-council`'s precondition now matches what
`revise-business-plan` actually writes. This is a structural fix to a file `revise-business-plan`
alone owns; it does not touch `agents/orchestrator.md`, `run-review-council`, or any fixture.

**This fix is unverified by a live run** — I fixed the contradiction between the three files'
stated contracts, but no fixture exercises the corrected path yet. The next round that runs a real
revision cycle should confirm `run-review-council` actually accepts the handoff now.

---

## 3.3 `business-state.json` stays schema-valid across a full lifecycle

| # | Checklist item | Verdict | Evidence |
|---|---|---|---|
| 1 | Parses as valid JSON, every field matches `docs/DATA-CONTRACT.md`, no stray/dropped fields | **PASS** | All three files parse cleanly. All 17 top-level keys present, in identical order, in all three. All 24 `disciplined_entrepreneurship` keys present with correct names/order/files in all three. `reviews[]`/`key_assumptions[]`/`quantitative_claims[]`/`risk_log[]` entries all carry every required field with valid enum values (verdict ∈ {APPROVE, APPROVE_WITH_NOTES, REVISE, REJECT}, confidence ∈ {low, medium, high}, risk type ∈ {ai_risk, privacy, legal, business}, risk status prefix ∈ {open, mitigated, accepted}, stage ∈ the 9 documented values) — checked mechanically, zero violations. One benign cross-fixture difference: `business_basics.funding_intent` is present only in vantage-point-search (round 4); shiftcover/skyclaim (rounds 2/3) predate the field. `skills/business-plan/run-review-council/SKILL.md` §2 step 1a explicitly handles this as an expected "absent" case with a documented fallback, not a bug — schema evolution across rounds, handled gracefully by the consuming skill. |
| 2 | Read-modify-write discipline: snapshot before/after one agent's write, confirm untouched keys are byte-identical | **GAP — unverifiable from static fixtures** | The fixtures capture only final state; there is no intermediate snapshot of `business-state.json` at any point mid-lifecycle to diff. The *final* state of all three is internally consistent with every field being owned by exactly one agent per the Data Contract's ownership notes (no field shows content that looks like it was written by the wrong owner), which is necessary but not sufficient evidence of read-modify-write discipline in practice. A future round should capture at least two real before/after snapshots to close this properly. |
| 3 | `risk_log` entries never deleted, only status-transitioned with a note | **PASS (as far as final-state evidence can show)** | Every `risk_log` entry in all three fixtures has a `mitigated`/`accepted`/`open` status, and every `mitigated` entry carries an explanatory note in its `status` string pointing to the fix and (where applicable) the QA-findings doc that documents it. No entry shows any sign of having been overwritten rather than status-transitioned. Full non-deletion cannot be proven without version history, which this pass didn't use (git commands were out of scope per the task instructions). |
| 4 | Sourced-claims gate actually blocks an unsourced number | **PASS — extensively, if not freshly this round** | This exact pattern is independently demonstrated across all three fixtures, not synthesized: shiftcover `ar-shiftcover-002` (missing `qc-017-ltv` entry, BLOCKED, fixed), skyclaim `ar-skyclaim-001`/`ar-skyclaim-004`/`ar-skyclaim-005` (three separate false-precision/unsourced-claim BLOCKs, each fixed and re-passed), vantage-point-search `ar-vps-001` (false-precision BLOCK on COCA, fixed, and its own note observes this is "the third consecutive round" the gate caught this pattern). This is real, repeated, cross-round evidence the gate works — not a fresh test run this round, but strong standing evidence. |

---

## 3.4 Cadence / check-in mechanics

| # | Checklist item | Verdict | Evidence |
|---|---|---|---|
| 1 | Scheduling-tool-available path: `cadence.next_check_in` computed, real trigger created, `scheduling_mechanism` records the real tool | **GAP — entirely unexercised** | All three fixtures show `cadence.next_check_in: null` and `cadence.scheduling_mechanism: ""`. |
| 2 | No-scheduling-tool path: says so plainly, `scheduling_mechanism: "manual-reminder"`, ends by reminding founder to run `/business-status` | **GAP — entirely unexercised, and not even at its documented default** | All three show `cadence.scheduling_mechanism: ""` (empty string) rather than `"manual-reminder"`. `agents/orchestrator.md`'s "Recurring check-ins" section requires *every* session involving a business to end by asking the cadence question and writing an answer to disk — "Don't let a session end silently." None of the three fixtures' final state shows this ever having been written, for either branch. Since all three dry runs stopped mid-lifecycle (at `revising`/`revising`/`approved`, none reaching a session end that exercised the mandatory closing sequence, or the closing sequence happened conversationally but was never captured on disk), this is a real, clean gap — not just "the operating-stage cadence logic is unexercised" but "no session in any fixture shows evidence the mandatory end-of-session cadence write ever fired at all." |
| 3 | Scheduled/resumed session re-reads `business-state.json` before saying/doing anything (Non-negotiable #1) | **GAP — unexercised** | No fixture shows a resumed session (all three are single continuous sessions from onboarding to their final stage). Nothing to check. |

---

## 3.5 Multi-business isolation

| # | Checklist item | Verdict | Evidence |
|---|---|---|---|
| 1 | Neither business's `.startup/<slug>/` is ever read from or written to by the other | **PASS, with two minor, non-functional observations** | Grepped all three fixtures' full directory trees for every other business's slug, name, and founder name. Two false-positive-looking hits turned out to be harmless: (a) `plan/09-...md` in shiftcover lists a prospect named "Derek Osei, RiverBend QSR Group" — coincidentally the same name as skyclaim's actual founder, but a wholly separate fictional prospect in an unrelated document with no shared id, file, or field — a naming coincidence from fixture authorship, not a functional leak. (b) skyclaim's `plan/23-...md` and vantage-point-search's own `risk_log` entry `ar-vps-001` both contain **prose narration** naming "ShiftCover" and/or "SkyClaim" by name, inside process-meta commentary ("this is the third consecutive round... following round 2's ShiftCover and round 3's SkyClaim") documenting a recurring AI-risk-gate pattern across rounds — this is QA-continuity narration bleeding into a business's own risk_log/plan-step file, not one business's session actually reading or writing another's directory. **Crucially, the founder-facing `plan/business-plan.md` in all three fixtures is completely clean of any cross-business reference** (grepped directly; the only apparent hits were the substring "vantage" inside the unrelated word "advantage" — a grep false positive, not a real match). No id collision, no shared file path, no field pointing into another business's directory anywhere in any of the three fixtures. |

---

## 3.6 Plan hygiene

| # | Checklist item | Verdict | Evidence |
|---|---|---|---|
| 1 | `plan/business-plan.md` never hand-edited outside `business-plan-editor.md` via assemble/revise | **GAP for the untested revise path; one disclosed historical violation on the assemble path, now closed** | No fixture has exercised `revise-business-plan`'s version-bumping (`plan/business-plan-v2.md` etc. — confirmed by directory listing: zero `business-plan-vN.md` files exist anywhere under `.startup/`, and `plan.history` is `[]` in all three), so the revise-path half of this rule is entirely unexercised, exactly per this task's expected gap. On the assemble path, shiftcover's own `risk_log` entry `ar-shiftcover-001` **self-discloses** a real violation: "fix applied by hand to this one plan file for QA purposes; the underlying skill files ... were NOT patched." That is a literal, admitted hand-edit of a plan file outside the proper channel, during round 2. I verified the follow-up claim that this was later fixed at the root cause: `agents/business-plan-editor.md` (lines 86, 93) and `skills/business-plan/assemble-business-plan/SKILL.md` (lines 197, 203) now both explicitly instruct writing the "Confidence & Validation Status" section, and both skyclaim (round 3) and vantage-point-search (round 4) show that section present in their `plan/business-plan.md` **without** any disclosed hand-edit — real, verified evidence the round-2 hygiene violation's root cause was actually fixed, not just claimed fixed. |

---

## Summary table

| Section | Item | Verdict |
|---|---|---|
| 3.1 | Skeleton + `stage: interview` on create | PASS |
| 3.1 | Stage advances only after founder info captured | PASS (indirect) |
| 3.1 | All 24 steps run, write files, update state | PASS |
| 3.1 | Dependency ordering respected | GAP (unverifiable from static fixtures) |
| 3.1 | Steps 20-21 use real accumulated assumptions | PASS |
| 3.1 | `plan_assembled` set only after file exists | PASS (indirect) |
| 3.1 | Review recorded, `resolved` correct for branch | **FAIL** (vantage-point-search) |
| 3.1 | `approved → gtm → operating` sub-fields populated | GAP (never exercised — biggest gap in the project) |
| 3.2 | REVISE routes `stage → revising`, revisions listed | PASS |
| 3.2 | Revisions routed to correct owner | GAP (never exercised) |
| 3.2 | Cosmetic-revision refusal fires | GAP (never exercised) |
| 3.2 | Re-review targets new version, same council | GAP (never exercised) — **FAIL found and fixed** blocking this |
| 3.2 | Founder-override path works | GAP (never exercised) |
| 3.3 | JSON valid, schema matches Data Contract | PASS |
| 3.3 | Read-modify-write discipline | GAP (unverifiable from static fixtures) |
| 3.3 | `risk_log` never deleted | PASS (as far as final-state evidence shows) |
| 3.3 | Sourced-claims gate blocks | PASS (strong cross-round evidence) |
| 3.4 | Scheduling-available path | GAP (entirely unexercised) |
| 3.4 | Manual-reminder path | GAP (entirely unexercised, not even at documented default) |
| 3.4 | Resumed session re-reads state first | GAP (unexercised) |
| 3.5 | Multi-business isolation | PASS (two minor, non-functional observations) |
| 3.6 | Plan never hand-edited outside proper channel | GAP for revise path (unexercised); one historical, disclosed, now-fixed violation on assemble path |

**Totals: 6 PASS, 9 GAP, 2 FAIL** (1 fixed this round — the `revise-business-plan` /
`run-review-council` stage-value contradiction; 1 logged, not fixed — vantage-point-search's
un-flipped `resolved` field, which is fixture data this task is barred from editing).

## What a future round needs to do to actually close this out

1. Run a real dry run that gets a `REVISE`/`REJECT` verdict all the way through
   `revise-business-plan` and back to a passing re-review — this is the single highest-value next
   test, since it exercises five of the nine open GAPs at once (3.2's four unexercised bullets plus
   3.6's revise-path bullet) and would confirm this round's fix to
   `skills/business-plan/revise-business-plan/SKILL.md` actually works end to end.
2. Run at least one business past `approved` into `gtm` and `operating` for real — nothing in this
   repo's live-testing history has ever done this, and it's the largest untested surface.
3. Capture real before/after `business-state.json` snapshots at two lifecycle points to close 3.3's
   read-modify-write bullet properly, instead of inferring it from final-state consistency alone.
4. Resolve the vantage-point-search `resolved`/`stage: approved` discrepancy explicitly — either by
   clarifying in `agents/orchestrator.md` exactly when that write is expected relative to `stage`
   flipping, or by confirming in a live run that the founder-notification step reliably completes
   before a session ends.
