# Experiments Log — Vantage Point Search

Produced by `skills/ops/experimentation-and-optimization`, delegated from
`agents/ops/growth-analyst.md`. Append-only — see that skill's Step 4 for the format contract.

## Candidate shortlist this cycle (sourced from `ops/2026-09-29-growth-metrics.md` and
`plan/13-...md` / `plan/18-...md`'s real stage-by-stage conversion data)

Per Step 1's priority order: (1) biggest stage-to-stage drop in the most recent growth-metrics
derived conversion rates, (2) the funnel-losses table's repeated reason, (5) the
onboarding/activation standing slot (this business's closest equivalent is the top-of-funnel
Stage 1→2 step, since there is no signup/activation moment in a referral-driven search
engagement).

Real stage data (from `plan/18-map-the-sales-process-to-acquire-a-customer.md`, 14 months, 35
tracked real conversations):

| Stage transition | Conversion | n (numerator/denominator) |
|---|---|---|
| 1. First conversation → 2. Discovery call | ~74% | 26/35 |
| 2. Discovery call → 3. Proposal sent | ~69% | 18/26 |
| 3. Proposal sent → 4. Internal budget check | ~85% | ~15/18 (est.) |
| 4. Internal budget check → 5. Signed | ~52% (computed: 53.3%) | 8/15 (est.) |
| Overall (1 → 5) | 23% | 8/35 |

| # | Candidate | Sourced from | Impact | Confidence | Ease | **Avg ICE** |
|---|---|---|---|---|---|---|
| 1 | **Add an ROI/business-case one-pager to the proposal packet, aimed at helping the champion get the budget-check stage (4) approved** | Biggest stage-to-stage drop (Step 1 priority 1): Stage 4→5 is explicitly named in Step 18 as "the single biggest drop-off point" (52%/48-point loss), and 2 of 2 real declines this period at this stage cited the same budget-justification mechanism | 8/10 — stage 4 gates 100% of remaining revenue for everyone who reaches it, and it's the largest single point of loss in the whole funnel | 7/10 — real, repeated, specific reason (2/2 this period, consistent with 14-month pattern), not a hunch | **2/10 — see Step 3 below: real volume through this stage is ~15/14 months (~1/month); the time-to-valid-sample math makes this untestable quantitatively for decades at current traffic** | **5.7/10** |
| 2 | **Segment-specific fee-floor/payment-plan alternative for sub-120-employee prospects** (directly = `ka-025-segment-fee-floor`'s untested alternative) | Funnel-losses table's repeated reason (Step 1 priority 2): #2 and #4 this period, same wording, same mechanism | 4/10 — real mechanism, but the founder is actively narrowing the beachhead to exclude this exact segment (pivot signal `ops-vantage-point-search-001`), which caps the strategic upside of "winning" this test | 6/10 — n=2 same-mechanism, real and specific, but thin | 2/10 — segment volume is a fraction of an already-tiny stage-4 volume, and shrinking further as the beachhead narrows | **4.0/10** |
| 3 | **Outbound message/template test on the first-touch email** | Standing activation-equivalent slot (Step 1 priority 5) — no signup step exists in this business, so Stage 1→2 (first conversation → discovery call) is the nearest analog | 5/10 — highest stage volume (100% of entrants) but already converts well (74%), leaving less absolute room than stage 4 | 3/10 — no repeated funnel-loss reason recorded for this stage; this is a hunch-driven standing slot, not evidence-backed | 3/10 — highest historical volume of any stage (35/14mo ≈ 2.5/month), but still thin in absolute terms | **3.7/10** |

**Ranked:** #1 (5.7) > #2 (4.0) > #3 (3.7). Top pick by ICE: **#1, the budget-check ROI one-pager.**
Not a founder override — this is ICE's own ranking, logged per the skill's requirement to show all
three, not a single silent pick.

---

## EXP-01 — Budget-check ROI one-pager (Stage 4→5)
**Started:** 2026-09-29 | **Concluded:** not started as a live A/B test — see Decision |
**Status:** running *(see Notes — the skill's 4-value Status enum has no accurate value for
"designed, rigor-checked, and found not quantitatively testable at current traffic before ever
shipping a variant"; "running" is the least-wrong of the four available values, not a claim that a
variant is live)*

**Hypothesis:** If we add a one-page ROI/business-case document to the proposal packet at Stage 3,
addressed to the internal budget-check approver, then **Stage 4→5 conversion (internal budget
check → signed)** will improve from ~52% (8/15) to roughly 65% (a 25% relative lift), because the
two most recent real declines at this stage (#2, #4, both 2026-09) and the historical pattern both
cite difficulty justifying the fee internally — a documentation/justification gap, not outright
price rejection — as the actual failure mode.

**Target metric:** Stage 4 (internal budget check) → Stage 5 (signed) conversion %, as used in
`plan/18-map-the-sales-process-to-acquire-a-customer.md`'s costed process table.
**Sourced from:** stage drop-off (biggest in the funnel) + funnel-loss reason (repeated, this
period).

**ICE score:** Impact 8/10, Confidence 7/10, Ease 2/10 → Average 5.7/10 (Ranked #1 of 3
candidates considered this cycle — see shortlist above.)

**What changed (variant vs. control):** Control = current proposal packet (no ROI document).
Variant = current proposal packet + 1-page ROI/business-case document addressed to the
budget-check approver. Single variable.

### Step 3 — sample-size arithmetic (real numbers, shown in full)

**Baseline (control) rate p:** 8/15 = **0.5333** (the plan states "~52%"; the precise count is
53.3% — see Findings doc for this small stated-vs-computed discrepancy).

**Real historical volume through this exact stage:** 15 conversations reached Stage 4 over 14
months = **~1.07/month ≈ 12.9/year.** This is the number that actually determines whether this
test is runnable, and it is not a number the skill's formula asks for directly — it has to be
pulled separately from `plan/18-...md` and divided into the required sample size by hand.

**Scenario A — detect a 25% relative lift (52% → 65%, the hypothesis as stated above):**
```
d = 0.5333 × 0.25 = 0.1333
n = 16 × p × (1−p) / d²
  = 16 × 0.5333 × 0.4667 / 0.1333²
  = 16 × 0.2489 / 0.01777
  = 3.983 / 0.01777
  ≈ 224.1 → round up to 225 per variant
```
100-conversions-per-arm floor check: 225 × 0.5333 ≈ 120 conversions in the control arm — the
floor is already cleared by the formula-derived n, so **n = 225/arm binds** (450 total entrants to
Stage 4, both arms combined).

**Required minimum duration:** ≥1 full week / 2 full business cycles per Step 3's duration rule —
moot here, since the sample-size requirement takes far longer than any duration floor.

**Time to reach 450 total Stage-4 entrants at this business's real rate (~12.9/year):**
```
450 / 12.9 ≈ 34.9 years
```

**Scenario B — detect the boldest plausible variant, a 50% relative lift (52% → 78%):**
```
d = 0.5333 × 0.50 = 0.2667
n(formula) = 16 × 0.2489 / 0.2667² = 3.983 / 0.0711 ≈ 56.0 → 57/arm
100-conversion floor: 57 × 0.5333 ≈ 30.4 conversions — BELOW the ~100 floor, so the floor binds
instead: n ≥ 100 / 0.5333 ≈ 187.5 → 188/arm
```
Total required = 376 entrants to Stage 4 (both arms). Time at 12.9/year: **376 / 12.9 ≈ 29.2
years.**

**Cross-check against the highest-volume stage instead (Stage 1→2, 74% baseline, all 35
conversations/14mo = ~30/year), same bold 50%-relative-lift assumption:**
```
d = 0.7429 × 0.50 = 0.3714
n(formula) = 16 × 0.7429 × 0.2571 / 0.3714² ≈ 22.2 → 23/arm
100-conversion floor binds: n ≥ 100 / 0.7429 ≈ 135/arm → 270 total
Time at ~30/year: 270 / 30 = 9.0 years
```
Even the best case in this entire business — highest-volume funnel stage, boldest plausible
variant, letting the 100-conversion floor (not the formula) set the requirement — is **~9 years**.
The actual top-ICE candidate (Stage 4, the real leak) is **~29–35 years** depending on how bold
the variant is assumed to be.

**Required sample size per variant (formula):** 225 (25% lift target) / 188 (50% lift target,
floor-bound) — see both scenarios above; no single number, since neither the skill nor this
business's real data picks one for you.
**Required minimum duration:** N/A — sample-size requirement dominates by decades; the 1-week/
2-cycle duration floor from Step 3 is never the binding constraint here.

**Sample reached:** control n=0, conversions=0 | variant n=0, conversions=0 — **no variant has
been shipped.** Per Step 3's own explicit instruction ("accept up front that this stage can't be
validly A/B tested at current traffic and route the change through qualitative signal... instead
of a numbers-based test you can't actually power"), this candidate is being **routed to
qualitative signal, not run as a quantitative A/B test.**

**Duration actually run:** 0 days (not started as a quantitative test).
**z-score:** N/A | **Significant (|z|≥1.96)?** N/A | **Direction:** N/A
**Practically significant?** N/A — no result exists to evaluate.

**Decision:** Neither SHIP, KILL, nor a real INCONCLUSIVE—RETEST in the sense Step 5 defines (no
variant has ever run, so there's no interim read to be ambiguous about). The honest call, applying
Step 3's own guidance to this business's real numbers: **do not attempt this as an A/B test at
all.** Ship the ROI one-pager directly as a qualitative-informed change (it is well-supported by
real, repeated founder-reported reasons), and continue tracking loss reasons in the funnel-losses
table (`ops/*-growth-metrics.md`) rather than a quantitative significance test this business's real
volume cannot power within any usable timeframe.
**Reasoning:** At the real historical Stage-4 volume of ~15 entries/14 months, the formula's own
sample-size requirement (225–450 entrants, or 188–376 with the 100-conversion floor binding)
implies a 29-to-35-year test. That is not a testing recommendation this skill should produce
without flagging it as unusable — see the QA findings doc for the specific critique.

**quantitative_claims update (if SHIPPED and this changes a plan figure):** None. No experiment
result exists to source a `quantitative_claims[]` update; `qc-018-cycle-length` and Step 13's
stage conversion rates remain sourced as founder-tracked estimates, unchanged.

**Notes:** This entry exists to document that the ICE-ranked top candidate was rigor-checked per
Step 3 and found **not quantitatively testable at this business's real scale**, not to log a live
test. The Status field was forced into "running" for lack of a better enum value — flagged as a
gap in `docs/QA-FINDINGS-GROWTH-ROUND10.md`. This is a deliberate, reasoned outcome of applying the
skill correctly to real numbers, not a shortcut around Step 3's rigor — see that skill's own
"accept up front that this stage can't be validly A/B tested" clause, which is exactly what this
computation confirms for this business.
