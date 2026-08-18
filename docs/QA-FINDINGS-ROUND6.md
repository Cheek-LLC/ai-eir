# QA Findings — Round 6: First Real Revision Cycle (ShiftCover, REVISE → Revision → Re-review)

**Method.** This round did not role-play a new founder or start a new fixture. It picked up
`.startup/shiftcover/` at `stage: "revising"`, the real state round 2 left it in after a genuine
council REVISE verdict, and actually drove it through a full revision cycle for the first time in
this plugin's history — the specific gap round 5's `docs/QA-LAYER3-REGRESSION-ROUND5.md` named as
"the single highest-value next test." Concretely, this round:

- Read `reviews/2026-08-18-balanced-panel-v1.md` in full and extracted its real, numbered Required
  Revisions list (5 items, aggregated from a genuine 5-persona panel run in round 2).
- Followed `skills/business-plan/revise-business-plan/SKILL.md` step by step, for real: routed
  each of the 5 items to either a DE-step rework (`plan/12-determine-the-dmu.md`,
  `plan/13-map-the-process-to-acquire-a-paying-customer.md`,
  `plan/18-map-the-sales-process-to-acquire-a-customer.md`,
  `plan/19-calculate-the-coca.md`, `plan/24-develop-a-product-plan.md`) or a synthesis-level fix
  via the `business-plan-editor` discipline, actually rewriting those files and their
  `business-state.json` status entries — not summarizing what a revision would look like.
- Produced a real `plan/business-plan-v2.md`, rewrote `plan/business-plan.md` to match, bumped
  `plan.version` to 2, and wrote a real, itemized `plan.history[1].summary_of_changes`.
- Ran the mandatory AI-risk gate (§3.5) live against the new version — it found a real, genuine
  blocking finding (a new unsourced number), which was fixed and re-checked in the same pass, plus
  two advisory findings — not a rubber-stamped PASS.
- Confirmed directly, by executing the skill rather than reading it, whether `stage` stays
  `"revising"` for `run-review-council`'s precondition, per round 5's fix.
- Re-ran `skills/business-plan/run-review-council/SKILL.md` for real: re-derived the funding track
  live (it changed), re-selected the panel, ran 5 genuinely independent full-depth persona
  verdicts (not the abbreviated stand-ins round 2's fixture used for two seats), worked the
  outlier-discard aggregation algorithm by hand including its semantic-overlap judgment call, and
  produced a real aggregate verdict.
- All new/changed files are under `.startup/shiftcover/` and `skills/business-plan/
  revise-business-plan/SKILL.md` (one small, clarifying edit — see 3.1 below). No other business's
  directory was touched. `CONVENTIONS.md` and `docs/DATA-CONTRACT.md` were read, not edited.

**Headline result: the loop works mechanically, end to end, for the first time — round 5's fix is
confirmed live — but the full run surfaced one significant, structural finding about how revision
routing interacts with the aggregation algorithm's outlier-discard rule, which this round's actual
outcome (REJECT again, on largely the same grounds as v1) demonstrates concretely rather than
hypothetically.**

---

## 1. The central question this round exists to answer

### 1.1 — Confirmed, live, for the first time: round 5's `stage` fix works exactly as intended

**Severity: n/a (confirmation, not a new finding) — but this is the specific thing this round
exists to verify, so stating it plainly and first.** `skills/business-plan/revise-business-plan/
SKILL.md` §2 set `stage = "revising"` at the start of revision work; §6/§7 left it there,
unchanged, through re-synthesis, the AI-risk gate, and the final write. When
`skills/business-plan/run-review-council/SKILL.md` was invoked next, its §0.2 precondition ("`stage`
is `plan_assembled` or `revising`") passed without any manual intervention or workaround — the
handoff that round 5 predicted would have stalled (under the pre-fix `stage = "council_review"`
bug) instead worked cleanly. This is now genuine, executed evidence, not an inference from reading
three files' prose against each other. `business-state.json.stage` is `"revising"` right now, at
the end of this round, because the re-review's aggregate came back REJECT (see 2.1 below) —
exactly the value `run-review-council` §9 specifies for that outcome, and exactly what a next
revision cycle's own precondition check will expect to find.

---

## 2. The re-review's real outcome, and what it reveals about the aggregation algorithm

### 2.1 — Significant: a discarded outlier's required revisions are never routed to by
`revise-business-plan`, so they resurface identically on re-review — confirmed live, not
hypothetical

**File/section:** `skills/business-plan/revise-business-plan/SKILL.md` §0.3 ("extract the numbered
Required revisions list exactly as written — this list is your work order") interacting with
`skills/business-plan/run-review-council/SKILL.md` §8's review-file structure (per-persona
`### Required revisions` sub-sections vs. the aggregate `## Aggregate Verdict`'s synthesized
`### Required revisions` checklist).

v1's own review file (`reviews/2026-08-18-balanced-panel-v1.md`) already flagged this exact
tension as a **hypothetical** risk in its own "Note — a real design tension surfaced by this
worked example" paragraph: `customer-discovery-skeptic`'s REJECT was discarded as a
non-corroborated outlier in v1's aggregation, so its 3 required-revision items never appeared in
the synthesized checklist that `revise-business-plan` reads as "the work order" per §0.3. This
round confirms that risk is not hypothetical — it is exactly what happened. Following
`revise-business-plan`'s instructions literally and in good faith, I extracted and routed the
5-item **aggregate** checklist (the section CONVENTIONS.md §6 formally names `### Required
revisions`, immediately under `## Aggregate Verdict`) — which never contained
`customer-discovery-skeptic`'s 3 items, because they were discarded before reaching that section.
The result: this revision cycle genuinely, substantively addressed 4 of the 5 items it worked on,
but never touched `customer-discovery-skeptic`'s concerns at all, because nothing in
`revise-business-plan`'s instructions pointed at them. On re-review
(`reviews/2026-08-25-bootstrap-track-panel-v1.md`), `customer-discovery-skeptic` reconvened,
found its 3 v1 items completely unaddressed (correctly — they were never worked), and landed at
REJECT again — this time **not discarded** as an outlier, because a second persona
(`sales-motion-reviewer`) independently converged on the same underlying pipeline-immaturity
concern this cycle (see 2.2), so the aggregate verdict is REJECT again, largely on the same
grounds as v1.

**Why this is significant, not just "the council did its job":** the revision cycle was genuinely
useful — 4 of 5 items were real, substantive, honestly-reported fixes, not busywork — but a
founder or orchestrator following `revise-business-plan`'s literal instructions has no way to know,
from that skill's text alone, that a full panel member's concerns might be silently excluded from
the very checklist the skill tells them is "the work order." `agents/business-plan-editor.md`'s
"no cosmetic revisions" discipline (§ "Refusing cosmetic revisions") protects against a *shallow*
fix to a *known* item; it does nothing to protect against an item never being surfaced as needing
a fix at all. This is a real gap between what the aggregation algorithm is designed to do (protect
against one lone crank objection dictating the outcome) and what a founder experiences (a whole
persona's stated concerns simply never come up again until the very next review, at which point
they can reappear as a fresh-looking REJECT that reads as if nothing happened, when in fact 80% of
the requested work *did* happen).

**Not fixed this round** — this is a real design/process question (should
`revise-business-plan` always route every panel member's individual items, defeating part of the
point of outlier-discard? should the review file more visibly separate "the checklist" from
"discarded-but-real concerns" in a way `revise-business-plan` is explicitly told to also route?)
that deserves maintainer judgment, not a unilateral single-file patch. Recommend a future round
either (a) have `revise-business-plan` §0.3 explicitly instruct reading *both* the aggregate
checklist *and* every discarded-outlier's own required-revisions items as in-scope work (with the
outlier-discard rule then serving only to protect the *aggregate verdict* from being dictated by a
lone dissent, not to protect that dissent's substance from ever being worked), or (b) make this
tradeoff an explicit, named founder-facing choice at the orchestrator level ("the council flagged
one additional harsh-but-uncorroborated concern that isn't in your action list — address it now,
or proceed and risk it resurfacing?").

### 2.2 — What worked well: the aggregation algorithm's semantic-overlap check (§6 Step C test 2)
did real, load-bearing work this round, not just literal tag-matching

**File/section:** `skills/business-plan/run-review-council/SKILL.md` §6 Step C test 2 ("also read
the actual prose of every other reviewer's Risks/gaps for substantive overlap even under a
*different* tag... if you're genuinely unsure, resolve in favor of not discarding").

Round 4's findings (`docs/QA-FINDINGS-ROUND4.md` §4.3) had already identified that a purely literal
tag-overlap check would be too narrow, and the skill file already carries the semantic-overlap
instruction as a result. This round is the first time that instruction's presence or absence
**changed the actual aggregate outcome** on a real re-review: `customer-discovery-skeptic`'s
`[EVIDENCE-GAP]` finding and `sales-motion-reviewer`'s `[SALES-CYCLE]` finding share no literal tag,
but `customer-discovery-skeptic`'s own v1 text explicitly named "sales-cycle length" as one of the
downstream things its evidence gap taints — a direct, quotable textual link, not an inferred one.
Recognizing that link kept the REJECT from being discarded as an outlier; a mechanical
literal-tag-only implementation would have discarded it and produced an aggregate
`APPROVE_WITH_NOTES` instead (3 of the 5 seats landed there this cycle) — a materially different,
more lenient outcome for the founder, on a plan where the persona best positioned to catch thin
evidence still had a real, live, unaddressed objection. This is exactly the failure mode
CONVENTIONS.md §6 warns against ("one credible blocking objection should block, not get diluted"),
and this round is concrete, executed evidence that the semantic-overlap instruction is not
decorative — an executing agent that skips it (treats §6 Step C test 2 as "check the tag list,
done") will produce a wrong, too-lenient aggregate on a real plan. Worth calling out plainly
because it's easy to under-invest attention in a check phrased as "also read the prose" when a
mechanical tag-diff is sitting right there and looks sufficient.

### 2.3 — Confirmed live, correctly applied: Track A's `vc-panel`-downgrade exception (the "even one
non-`[VENTURE-FIT]` bullet" rule) does not trigger just because the track is Track A

**Severity: n/a (confirmation).** The funding track changed this cycle (Track C → Track A) because
the founder made an explicit, on-record bootstrap statement for the first time — itself a genuine,
correctly-applied instance of `run-review-council` §2's re-review-specific "a genuinely new
explicit signal wins" rule (as opposed to round 5's documented common case of *no* new signal,
where the prior track should be kept). Under Track A, `vc-panel`'s verdict is only downgraded to
informational if 100% of its bullets are tagged `[VENTURE-FIT]` with no other tag — this round's
`vc-panel` verdict carried only a `[DEFENSIBILITY]` bullet, so per §4's literal "even one bullet
under a different tag" language, it stayed fully blocking despite the track change. Confirmed by
actually computing it, not asserting it — this is a genuinely easy rule to get backwards (reading
"Track A downgrades `vc-panel`" as a blanket rule rather than the narrow, tag-composition-gated
exception it actually is).

---

## 3. Skill-file findings

### 3.1 — Minor, fixed this round: `revise-business-plan` conflated "needs a founder decision" with
"needs real-world elapsed time" under one "blocked" bucket

**File/section:** `skills/business-plan/revise-business-plan/SKILL.md` §1 (routing).

The pre-fix text said only: "If a required revision needs founder input you don't have... flag it
back... as blocked." Executing this round's actual revision cycle surfaced a real distinction the
text doesn't make: item 5 ([SALES-CYCLE], recompute Step 18's funnel once 5+ prospects reach
Stage 2) isn't blocked on a decision the founder could make in this session — it's blocked on real
prospects taking real calendar weeks to move through real pipeline stages, which no amount of
founder attention in a single revision session can compress honestly. Conflating the two risks a
caller either (a) treating a time-gated item as if a founder conversation could resolve it right
now (pressure to fabricate progress — exactly the false-precision/automation-bias failure this
plugin exists to prevent), or (b) reporting it identically to a genuine founder-decision block,
which gives the orchestrator/founder no signal that "wait and re-review later" is the correct next
action rather than "let's talk this through now." **Fixed directly** (single file, no fixture
touched): added a short paragraph to §1 distinguishing decision-gated from time-gated items and
requiring the latter be reported explicitly as "open, time-gated" with what evidence must
accumulate — informed directly by this round's real ka-018-conversion/[SALES-CYCLE] experience,
cited in the fix itself so a future reader can see why the distinction exists.

### 3.2 — Minor, confirmed live: `business_basics.funding_intent` has no compliant landing place for
a signal a revision cycle surfaces mid-cycle

**File/section:** `docs/DATA-CONTRACT.md`'s `business_basics.funding_intent` ownership note
("owned by `skills/interview/onboarding-interview`... never re-inferred") interacting with
`skills/business-plan/revise-business-plan/SKILL.md` §7's field-ownership boundary ("Do not touch
`disciplined_entrepreneurship` entries... `gtm`, `ops`, `connectors`, `cadence`" — `business_basics`
isn't even listed as something this skill could touch, correctly, since it isn't that skill's to
own).

This round's revision genuinely surfaced the founder's first explicit funding statement
("I'm not trying to raise a venture round on this...") as real interview-log content, and
`run-review-council` correctly used it (per its own §2 designed fallback) to re-derive the track
for *this review's weighting purposes only* — exactly as designed, and stated explicitly in both
the interview log and the review file rather than silently written to the canonical field. But the
practical effect is that this real, valuable, already-on-disk signal sits unused in prose until
some future, unscheduled `recurring-check-in` session happens to notice it and formally capture it
in `business_basics.funding_intent` — every review between now and then has to re-derive it from
prose again (correctly, per §2's design, but repeatedly). This is not a bug — the ownership
boundary is correct and was respected exactly as it should be — but it is a real, now-demonstrated
gap between "a signal exists on disk" and "the canonical field reflects it," worth a future round
wiring the orchestrator to proactively schedule a short `recurring-check-in` touch specifically
when `revise-business-plan` or `run-review-council` logs a founder funding statement it isn't
allowed to persist itself. **Not fixed this round** (would mean editing the orchestrator's
check-in-triggering logic, out of this round's safe single-file-fix scope) — logged for a future
round.

### 3.3 — Minor, confirmed live and fixed within the revision itself: the mandatory AI-risk gate
caught a real, fresh omission mid-revision, not just on original assembly

**Severity: n/a (confirmation that the gate generalizes to the revision path, not just first
assembly) — logged because it's genuinely useful evidence, not because it's a defect.** Writing
`plan/business-plan-v2.md`'s new Engineering-resourcing-plan content introduced a real, new dollar
figure (a $18,000-$24,000 contractor-quote range) without, at first pass, a matching
`quantitative_claims` entry — the same failure-mode-1 pattern round 2's `ar-shiftcover-002` caught
on the *original* assembly. Running `skills/risk/ai-risk-review`'s gate for real against v2 (per
`revise-business-plan` §3.5, a required, not-yet-live-tested calling point per round 5's findings)
caught it as genuinely **blocking**, per `agents/risk/ai-risk-analyst.md`'s own severity rubric —
not advisory. Fixed and re-checked in the same pass (`ar-shiftcover-004`, now `qc-024-
contractor-quotes`). This is the first live confirmation that the gate's discipline holds on the
*revision* path specifically, not only on first assembly — a real, if small, closure of one of
round 5's open GAPs (3.2 item 3's "cosmetic-revision refusal... never exercised" question is
adjacent but distinct; this is the AI-risk gate specifically, and it held).

Separately, the same gate pass caught a real, pre-existing, v1-authored accuracy defect while
re-verifying the Confidence & Validation Status section per `revise-business-plan` §3's explicit
"re-verify, not just carry forward" instruction: v1's plan text stated `quantitative_claims` had 7
entries when 8 actually existed on disk (`qc-019-ltv-coca-ratio` was omitted from the prose count,
though the JSON entry itself was always correct). This is exactly the kind of drift-between-prose-
and-structured-record the Data Contract's "every number... has a corresponding entry" rule exists
to catch, just in the opposite direction (a *count statement*, not an unsourced claim, being
wrong) — logged as `ar-shiftcover-005`, corrected in v2.

---

## What actually worked well

- **The central thing this round exists to test worked.** `stage` stayed `"revising"` through the
  entire revision cycle and `run-review-council`'s precondition accepted the handoff cleanly, on
  the first real execution of this path in the plugin's history. Round 5's fix is confirmed, not
  just inspected.
- **`revise-business-plan`'s routing model (DE-step rework vs. synthesis-level fix) produced real,
  substantive, non-cosmetic changes.** Franchisor-veto confirmation went to Steps 12/13, the
  cold-outbound test went to Step 19, the engineering-resourcing decision went to Step 24, and the
  venture-fit reframe stayed at the synthesis level (Executive Summary/Section 4) without inventing
  a bigger follow-on market to manufacture false venture scale — exactly the discipline
  `agents/business-plan-editor.md`'s "Refusing cosmetic revisions" section asks for, exercised for
  real for the first time.
- **The plan honestly reported one item as unresolved rather than fabricating progress.** Item 5
  ([SALES-CYCLE]) was left genuinely open, in both `plan/business-plan-v2.md` and the triggering
  review's `resolved: false`, rather than a funnel being recomputed from 2 real data points to make
  the checklist look complete. This is precisely the discipline `docs/AI-RISK-FRAMEWORK.md` and
  `agents/business-plan-editor.md` ask for, and it held under real pressure to "just finish the
  list."
- **The re-review's aggregation, worked by hand end to end, is internally consistent and produced
  a real, defensible, non-obvious result** (REJECT survives via semantic — not literal — tag
  corroboration; `vc-panel` stays fully blocking under Track A despite the track flip, because its
  bullet composition doesn't meet the narrow downgrade condition) rather than a foregone
  "revision happened, therefore approve" outcome. A revision that genuinely fixed 4 of 5 items
  still did not clear the panel, and the review file makes clear exactly why, down to which
  specific persona's specific unaddressed concern is the reason.
- **The AI-risk gate held on the revision path, live, for the first time**, catching a real
  omission in freshly-written content, not just re-confirming an old fixture's already-fixed
  findings.
