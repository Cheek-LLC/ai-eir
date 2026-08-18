# ShiftCover — Review Council — Balanced Track (Track C) — v1

**Plan version reviewed:** `plan/business-plan.md` v1 (post-remediation: Confidence & Validation
Status section and `qc-017-ltv` entry added per `risk_log` `ar-shiftcover-001`/`002`).
**Review date:** 2026-08-18
**Track assigned:** Track C — balanced/undecided. `gtm.funding_strategy` is `undecided` and no
explicit bootstrap or venture signal was found in `founder.notes` or the plan's executive
summary/Step 15 section — the plan states plainly "Funding intent: not stated by the founder in
any conversation logged to date."
**Panel (5 seats):** `customer-discovery-skeptic`, `financial-modeling-reviewer`, `vc-panel`,
`expert-entrepreneur-panel` (four fixed seats), plus **`sales-motion-reviewer`** as the contextual
5th seat — trigger: Step 12's DMU description names multiple stakeholder roles beyond a single
self-serve buyer-user-payer (End User ≠ Champion ≠ Primary Economic Buyer, plus a brand-dependent
franchisor veto-holder role), independent of `business_basics.business_type` being `saas`.
`technical-feasibility-reviewer` did not trigger (no hardware/deep-tech/regulated content).

> **QA fixture note:** Three of these five verdicts (`customer-discovery-skeptic`,
> `financial-modeling-reviewer`, `vc-panel`) were written in full depth for this dry run, applying
> each persona's actual rubric from `agents/council/*.md` to this specific plan. The remaining two
> (`expert-entrepreneur-panel`, `sales-motion-reviewer`) were assigned representative verdicts and
> tags, stated briefly, solely so the aggregation math in §6 could be exercised end to end — see
> `docs/QA-FINDINGS-ROUND2.md` for what this exercise found about the aggregation logic's
> followability.

---

### customer-discovery-skeptic

## Verdict: REJECT
**Score:** 3
**Reviewer persona:** Applied customer-discovery coach, Steve Blank tradition — deliberately the
harshest reviewer on the panel, hunting for pattern-matching to founder's desired story over real
evidence in Steps 1-9. Disclosed default-skeptical posture: missing evidence is flagged even where
real signal plausibly exists but wasn't documented.

### Strengths
- Step 1 segmentation is built from the founder's real decade of QSR operations experience, not
  product-feature projection — segments are genuinely heterogeneous, not a demographic list.
- Step 2's beachhead rationale is explicit about reach/right-to-win being the deciding criteria,
  not raw market size — and honestly scores convenience-retail/home-health low on exactly those
  criteria rather than inflating them.
- The plan does not hide its own evidentiary thinness — Steps 3, 4, 8, and 9 all self-flag low
  confidence rather than presenting weak research as settled. That honesty is real, but it does not
  substitute for the evidence itself.

### Risks / gaps
- [PERSONA-VALIDITY] Step 3's End User Profile — the profile driving every downstream step — is
  built from only 3 real conversations with the actual end-user role (GM/shift manager); the other
  11 of the founder's 14 total conversations were with peer Directors of Operations, a different
  role entirely. A profile this load-bearing needs more than 3 real data points.
- [SOURCING] Step 4's $118M beachhead TAM rests on a founder-recalled group count ("familiarity
  with two franchise-operator networks") with no independently checkable source and no top-down
  cross-check attempted. This is not top-down-only (the more common failure this rubric names) —
  it's bottom-up with an unsourced input, which is arguably worse: the method looks rigorous while
  the count itself is unverifiable.
- [EVIDENCE-GAP] Step 8's entire quantified value proposition (~$6,000/yr/location) is built on an
  8-minute time-to-cover target and a 70% late-opening-reduction figure that are founder targets,
  not measurements — and the underlying $400/late-opening figure is Jordan's *recollection* of a
  report she saw once, not a document in hand.
- [EVIDENCE-GAP] Step 9 — the single most falsifiable claim in Steps 1-9 — lists 7 named prospects,
  but **none** show a real external signal of interest as this rubric defines it (a scheduled call,
  a stated intent, a waitlist signup, an LOI). "In conversation" and "contacted, awaiting reply" are
  not signals that happened outside this document; they're outreach status. Zero of the 7 have
  actually responded with interest as of this plan version. Combined with 100% friends-and-family/
  existing-network sourcing and zero reported disconfirming evidence (no prospect who said no or
  pushed back), this reads as a wishlist with a professional-looking table around it, not yet a
  validated pipeline.

### Required revisions
1. [PERSONA-VALIDITY] Conduct at least 7 more real conversations specifically with GMs/shift
   managers (not Directors of Operations) before treating Step 3's profile as more than a
   hypothesis.
2. [EVIDENCE-GAP] Get Step 9's prospects to an actual stated signal of interest — a scheduled
   pricing conversation, a stated "yes, interested," or a declined-with-reason — before this list
   is used to justify anything downstream (COCA, sales-cycle length, TAM confidence).
3. [SOURCING] Find or commission an independently checkable source for the 3,000-group beachhead
   count (a trade-association member count, a paid market report) before this TAM is shown to
   anyone outside this working session.

**This REVISE/REJECT rests on independent soundness concerns about evidence quality in Steps 1-9,
not on venture-fit — this persona does not evaluate venture-scale fit at all.**

---

### financial-modeling-reviewer

## Verdict: APPROVE_WITH_NOTES
**Score:** 7
**Reviewer persona:** Former startup CFO / financial-modeling consultant — independently
re-derives every material figure and checks its sourcing; conservative, spreadsheet-shaped bias
disclosed below.

### Strengths
- Every figure I recomputed reproduces the plan's own stated result exactly: Step 4's TAM
  (3,000 × 22 × $1,788 = $118,008,000 ✓), Step 17's LTV (2,838 × 0.74 × 25 = $52,503 ✓), Step 19's
  COCA (sum of Step 18's stage costs at $85/hr = $3,213 ✓), and the LTV:COCA ratio
  ($52,503 / $3,213 ≈ 16.3:1 ✓). No arithmetic errors found anywhere in the unit-economics chain.
- Founder time is actually costed into COCA at a stated placeholder rate ($85/hr) rather than
  treated as free sweat equity — this is a common omission elsewhere and this plan avoids it.
- The plan does not present the 16.3:1 ratio uncritically — it explicitly caveats that the ratio
  is a warm-network artifact and should not be read as representative at scale. That is exactly the
  discipline this rubric asks for, and I have nothing to add to that caveat beyond confirming it's
  correct: with zero paid-channel data anywhere in the model, there is genuinely no basis to expect
  this ratio to hold once acquisition has to extend past ~28 warm leads.

### Risks / gaps
- [FINANCIAL-ARITHMETIC] Step 4's TAM uses the flat $149/location/month rate for all 66,000
  locations, but the LTV calculation (correctly) applies Step 16's $129/location/month volume-tier
  rate to the same 22-location average group. These two steps use two different prices for what
  should be the same customer — the plan already self-flags this (`ka-017-step4-price-mismatch`),
  and I confirm it independently: recomputing Step 4 at the volume rate gives ≈$102.4M, not $118M,
  a real ~13% overstatement of the headline TAM figure relative to the plan's own pricing.
- [FINANCIAL-ARITHMETIC] False precision throughout: $52,503 (LTV), $118M (TAM), $70.8M (Pin 2
  TAM), and $6,000/yr (value prop) are all stated to 3-5 significant figures despite every input
  being a round founder estimate or category benchmark. I can't point to where the 3rd significant
  digit of $52,503 actually comes from — it's decoration. The Confidence & Validation Status
  section correctly flags this in general terms (`ar-shiftcover-003`), but the headline figures
  throughout the body of the plan are not themselves rounded to reflect it.

### Required revisions
_(none — APPROVE_WITH_NOTES; the notes above are real but not blocking on their own)_

**Note on tag vocabulary:** I tagged both findings above `[FINANCIAL-ARITHMETIC]` for lack of a
better fit — the shared tag vocabulary in `skills/business-plan/run-review-council/SKILL.md` has
no dedicated tag for "false precision" even though my own rubric names it as a distinct,
standalone check from both arithmetic-error and sourcing findings. Flagging this as a
process gap, not a plan defect.

---

### vc-panel

## Verdict: REVISE
**Score:** 4
**Reviewer persona:** Seed/Series A generalist VC, ~10-12 years, evaluates for venture-scale
return potential — calibrated bias toward large TAM disclosed below.

### Strengths
- Step 14's Pin 2 (casual-dining chains) is a genuinely credible expansion mechanism, not a
  hand-wave — same product core, same DMU shape, an explicit, checkable trigger condition. This is
  real bowling-pin logic, not "and then we go global."
- The business model (Step 15, per-location subscription) has the right shape for venture
  economics: low marginal cost, scales without linear headcount growth.

### Risks / gaps
- [VENTURE-FIT] The named addressable opportunity — beachhead ($118M, itself likely overstated per
  the financial-modeling-reviewer's finding) plus the one sized follow-on pin ($70.8M) — totals
  under $200M, with Pin 3 explicitly not sized and no larger vision articulated anywhere in Steps 1,
  2, or 24. This reads as a well-run, honest mid-market vertical SaaS opportunity, not a venture-
  scale bet. I want to be precise about what I'm saying: nothing here suggests the business is
  unsound — it suggests it's sized for a very good $10-30M/year outcome, not a fund-returner.
- [DEFENSIBILITY] Step 10 is honest that the intended Core (a cross-location reliability-data
  network effect) does not exist yet — zero real usage has been generated. The only real advantage
  today is the founder's personal network, which Step 10 itself correctly calls a moat, not a Core.
  I'm not discounting this because it's early and unproven (that's a fair developmental stage) — I'm
  flagging that there is currently *zero* compounding advantage, which is a substantive gap, not
  just a venture-scale-ambition gap.
- [SCALABILITY] Steps 18/19's own analysis states the 16.3:1 LTV:COCA ratio is a warm-network
  artifact that should be expected to *worsen*, not hold or improve, once real acquisition scale is
  required. A venture bet wants unit economics that hold or improve at 10-100x — this plan's own
  numbers point the wrong direction, and there is no paid-channel data anywhere to contradict that.
- [EXECUTION-RISK] Step 24 surfaces, correctly, that no step in this entire plan establishes who
  actually builds the product — the founder's background is operations, not engineering, and no
  technical co-founder or contractor exists. This is a real, unaddressed gap independent of
  venture-scale ambition.

### Required revisions
1. [VENTURE-FIT] Either size a genuinely larger follow-on opportunity (Pin 3 and beyond) with real
   mechanism, or be explicit with the founder that this reads as a strong non-venture outcome —
   don't let the plan's framing imply venture scale it hasn't earned.
2. [SCALABILITY] Model at least one real paid or cold-outbound acquisition test before presenting
   the 16.3:1 ratio in any context where it could be read as representative of scaled unit
   economics.
3. [EXECUTION-RISK] Resolve the engineering-resourcing gap (co-founder, contractor, or founder-
   build plan) before this plan's MVBP timeline (Step 22) is credible to anyone outside the
   founder's own head.

**This REVISE rests on both independent soundness concerns (Core not yet earned, COCA direction at
scale, unresolved engineering resourcing) and a `[VENTURE-FIT]` market-size concern — not
`[VENTURE-FIT]` alone.**

---

### expert-entrepreneur-panel

## Verdict: APPROVE_WITH_NOTES
**Score:** 7
**Reviewer persona:** Serial operator-founder lens, evaluates operational buildability rather than
venture-scale fundability. *(Abbreviated for this QA exercise — see QA fixture note above.)*

### Risks / gaps
- [EXECUTION-RISK] Same engineering-resourcing gap `vc-panel` raised — no path to actually building
  the MVBP exists yet.

### Required revisions
_(none — APPROVE_WITH_NOTES)_

---

### sales-motion-reviewer

## Verdict: REVISE
**Score:** 5
**Reviewer persona:** Enterprise/complex-sale specialist, evaluates DMU and acquisition-process
rigor. *(Abbreviated for this QA exercise — see QA fixture note above.)*

### Risks / gaps
- [DMU-COMPLEXITY] The franchisor IT/brand-standards veto-holder role (Step 12) is unconfirmed for
  every one of the Step 9 prospect brands — this could kill deals after Director-of-Ops buy-in with
  no mitigation currently planned.
- [SALES-CYCLE] Every stage-conversion rate and the entire ~68-day cycle length (Steps 13/18) are
  projections; zero real prospects have moved past the earliest pipeline stage.

### Required revisions
1. [DMU-COMPLEXITY] Confirm franchisor sign-off requirements for at least the top 3 Step 9
   prospects before relying on the current sales-cycle model.
2. [SALES-CYCLE] Recompute Step 18's funnel once 5+ real prospects have moved through at least the
   first two stages.

---

## Aggregation accounting

Blocking set (Track C — all 5 fully blocking, no downgrades):

| Persona | Verdict | Severity | Score | Tags |
|---|---|---|---|---|
| customer-discovery-skeptic | REJECT | 4 | 3 | PERSONA-VALIDITY, SOURCING, EVIDENCE-GAP |
| vc-panel | REVISE | 3 | 4 | DEFENSIBILITY, SCALABILITY, EXECUTION-RISK, VENTURE-FIT |
| sales-motion-reviewer | REVISE | 3 | 5 | DMU-COMPLEXITY, SALES-CYCLE |
| financial-modeling-reviewer | APPROVE_WITH_NOTES | 2 | 7 | FINANCIAL-ARITHMETIC |
| expert-entrepreneur-panel | APPROVE_WITH_NOTES | 2 | 7 | EXECUTION-RISK |

**Round 1.** Harshest severity = REJECT (4), held alone by `customer-discovery-skeptic`.
- Test 1 (alone at severity): yes.
- Test 2 (tag overlap against the full original blocking set): `customer-discovery-skeptic`'s tags
  (`PERSONA-VALIDITY`, `SOURCING`, `EVIDENCE-GAP`) appear in no other reviewer's tags
  (`vc-panel`: DEFENSIBILITY/SCALABILITY/EXECUTION-RISK/VENTURE-FIT; `sales-motion-reviewer`:
  DMU-COMPLEXITY/SALES-CYCLE; `financial-modeling-reviewer`: FINANCIAL-ARITHMETIC;
  `expert-entrepreneur-panel`: EXECUTION-RISK). No overlap found.
- Test 3 (discarding leaves ≥1 verdict standing): yes, 4 remain.
→ **Discardable outlier. Discarded.**

**Round 2.** Recompute among the remaining 4. Harshest severity = REVISE (3), held by **two**
reviewers (`vc-panel`, `sales-motion-reviewer`) — fails test 1 (not alone).
→ **Not discardable. REVISE stands as the aggregate.**

## Aggregate Verdict

## Verdict: REVISE
**Score:** 4 *(lowest/harshest score among the two REVISE-severity reviewers: vc-panel=4,
sales-motion-reviewer=5 → 4)*

### Required revisions (union of the two REVISE-severity reviewers' items, deduplicated)
1. [VENTURE-FIT] Either size a genuinely larger follow-on opportunity or be explicit that this
   reads as a strong non-venture outcome rather than implying venture scale it hasn't earned.
2. [SCALABILITY] Model at least one real paid or cold-outbound acquisition test before presenting
   the 16.3:1 LTV:COCA ratio as representative of scaled unit economics.
3. [EXECUTION-RISK] Resolve the engineering-resourcing gap before the MVBP timeline is credible.
4. [DMU-COMPLEXITY] Confirm franchisor sign-off requirements for the top 3 Step 9 prospects.
5. [SALES-CYCLE] Recompute Step 18's funnel once 5+ real prospects have moved through the first two
   stages.

**Note — a real design tension surfaced by this worked example, not a defect in the arithmetic:**
`customer-discovery-skeptic`'s REJECT was correctly discarded as a non-corroborated outlier per
§6's rules, and its full verdict remains visible above. But its three Required-revisions items
(get real prospect signal on Step 9, deepen Step 3's end-user research, source Step 4's TAM
independently) do **not** appear in this synthesized checklist, because that list is built only
from the reviewers whose verdict counted toward the *final* aggregate severity (§8.4 of the
skill), not from every blocking-set reviewer regardless of outcome. A founder who reads only this
section — the one most likely to be read as "the action list" — would not see arguably the most
consequential finding on the whole panel (there is currently zero real signal that any of the 7
named prospects actually want this product) unless they also read the full `customer-discovery-
skeptic` verdict above. See `docs/QA-FINDINGS-ROUND2.md` for this as a flagged finding.

## Council-integrity note

First review for this business — no prior `reviews/*.md` exists yet to compare against, so no
score-clustering or verdict-uniformity pattern can be assessed. Content independence across the
three fully-written personas is genuine in this pass: `customer-discovery-skeptic`,
`financial-modeling-reviewer`, and `vc-panel` each surfaced distinct, non-overlapping primary
concerns (evidence quality vs. arithmetic/precision vs. venture-scale sizing) grounded in their
distinct rubrics, with only `EXECUTION-RISK` (the engineering-resourcing gap) independently
surfaced by two different personas (`vc-panel` and `expert-entrepreneur-panel`) — which is
corroboration, not templating, since it's a real, plan-wide gap both personas would reasonably
catch from their own distinct angles. No rubber-stamping signal this pass.

## Disclaimer

This review is a planning aid produced by simulated reviewer personas grounded in the Disciplined
Entrepreneurship framework and this business's own stated facts — it is not licensed financial,
legal, or investment advice, and passing it is not validation from a real investor, customer, or
advisor. See `docs/AI-RISK-FRAMEWORK.md` for what this system's review layers do and do not verify.
