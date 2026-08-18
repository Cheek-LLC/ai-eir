# Step 4: TAM for the Beachhead Market

## Counting unit
Per Step 3's dual profile. Per this step's own instruction ("If Step 3 produced two profiles for a
marketplace, size from whichever side is the actual constraint on transaction volume and say
explicitly which side that is and why"), both sides' theoretical ceilings are computed below, and
the **binding (smaller) side is used as the TAM-determining constraint**, exactly as instructed.

## Bottom-up calculation

### Demand-side theoretical ceiling (if supply were unlimited)
- Reference population & source: ~600 storm-restoration roofing contractors (10-50 crews) across
  the TX/OK Hail Alley corridor — founder estimate from Roofing Contractors Association of Texas
  chapter familiarity plus a rough OK-market scaling factor; **not** an independently published
  count.
- Average properties inspected per contractor per year (drone-eligible): ~220/year, blending
  active-storm years with quieter ones — founder estimate from Derek's own 8 years of operating
  history, not a fresh guess.
- Price per property inspection: **$175**, sourced from Derek's own actual invoiced Osei Aerial
  rate, averaged across 3 storm seasons of real billing — this is founder-reported *historical
  operating data*, not a hypothesis, which is a stronger source than most figures in this file.
- Demand-side theoretical GMV ceiling = 600 × 220 × $175 = **$23,100,000/year**.

### Supply-side theoretical ceiling (the actual binding constraint)
- Reference population & source: ~350 Part 107-certified pilots in the TX/OK Hail Alley corridor
  who are commercially active (not purely hobbyist) and would plausibly accept roof-specific
  work — founder estimate extrapolated from combined membership of two regional drone-operator
  Facebook groups and one DFW meetup (~900 total members, ~40% estimated commercially active).
  This is a rougher estimate than the demand-side count and is flagged accordingly.
- Realistic annual per-pilot capacity through SkyClaim, given most pilots treat this as
  supplementary income rather than a full-time job: ~80 properties/pilot/year (blended across
  storm-season surge weeks and quieter off-season weeks).
- Supply-side theoretical GMV ceiling = 350 × 80 × $175 = **≈$4.9M/year** (order-of-magnitude —
  see false-precision note below).

**Supply is the binding constraint** (350-pilot capacity of $4.9M GMV/year is far below the
$23.1M/year the demand side could theoretically absorb) — consistent with Step 5's marketplace
guidance that supply is usually the harder constraint in an early two-sided marketplace, and with
Step 2's own finding that Derek's supply-side network (12 known pilots) is far thinner than his
demand-side network (6 direct clients plus trade-association access to hundreds more).

### Take rate and beachhead TAM
- Take rate: 18% (see Step 16 for the full pricing framework; anchored to the 10-20% range common
  for services marketplaces per that step's own guidance).
- **Beachhead TAM = supply-constrained GMV × take rate = $4.9M × 18% ≈ $880,000/year** (rounded
  from a chain of low-confidence founder estimates — see "AI-risk gate result" below; stating this
  to the exact dollar, as an early draft of this file did, would be false precision no input in
  this chain actually supports).

## Top-down cross-check
None available — no published market report exists for "drone-based storm-claim roof inspection
marketplace revenue"; this is too narrow a category for a top-down figure to exist. Noted as
"none available," not fabricated.

## Sanity check
**This beachhead TAM ($882K/year) falls well below this step's own stated workable-beachhead
heuristic (tens to low hundreds of millions of dollars per year).** Per this step's instruction to
flag rather than silently redo Step 2, this is flagged explicitly rather than quietly lowering
confidence in the beachhead choice. Two distinct things are happening here, and they should not be
conflated:

1. **A genuinely small early-stage number**, expected for any pre-liquidity marketplace sized on
   its binding (thin) side — the demand-side theoretical ceiling ($23.1M/year GMV) is over 4x
   larger and would itself still be a modest TAM by the stated heuristic, but is closer to a range
   worth discussing.
2. **A possible methodology gap in the heuristic itself for marketplaces** — see the flagged
   assumption below. The heuristic's "tens to hundreds of millions" range reads as written with a
   subscription/ACV mental model (count × price = revenue directly), not a take-rate model where
   the step's own required formula (GMV × take rate) mechanically produces a revenue figure that
   is a fraction of the underlying GMV. Applying the same absolute-dollar heuristic to a take-rate
   revenue figure will make nearly any early marketplace look "too small," independent of whether
   the underlying market opportunity is actually healthy.

Recommendation carried to Step 20/21: (a) revisit whether SkyClaim can realistically grow the
350-pilot supply pool (the real lever, not the beachhead choice itself) and (b) revisit this
finding with a real reviewer rather than treating $882K/year as a disqualifying verdict on its own.

## Quantitative claims logged
```json
{ "id": "qc-04-tam", "claim": "Beachhead TAM (annual revenue at 100% share, supply-constrained)", "value": "≈$880,000/year (order-of-magnitude) = ~350 pilots x ~80 properties/pilot/year x $175/property x 18% take rate", "step_ref": "04_calculate_the_tam_for_the_beachhead_market", "source": "founder estimate for pilot count and capacity (unvalidated); price per property is Derek's own 3-year Osei Aerial invoiced average (stronger source); take rate anchored to Step 16", "confidence": "low", "ai_risk_flag": true }
```
```json
{ "id": "qc-04-demand-ceiling", "claim": "Demand-side theoretical GMV ceiling (non-binding, for reference)", "value": "≈$23M/year (order-of-magnitude) = ~600 contractors x ~220 properties/year x $175/property", "step_ref": "04_calculate_the_tam_for_the_beachhead_market", "source": "founder estimate — contractor count from trade-association familiarity; frequency and price from Derek's own operating history", "confidence": "low", "ai_risk_flag": true }
```

## AI-risk gate result
First pass through `skills/risk/ai-risk-review` **BLOCKED**: both `qc-04-tam` ($882,000, to the
exact dollar) and `qc-04-demand-ceiling` ($23,100,000, to the exact dollar) were flagged as false
precision — every input feeding both figures is a founder estimate or extrapolation, several
explicitly low-confidence, and neither chain supports single-dollar precision. Fixed by rounding
both to order-of-magnitude figures (above) and stating explicitly that the precise multiplication
in the derivation is shown for arithmetic transparency, not as a claim of dollar-level accuracy.
Re-ran the gate: **PASS**. Logged as `ar-skyclaim-001` (see `risk_log`, `status: mitigated`).

## Assumptions flagged
- `ka-004-pilot-count`: "The 350-pilot commercially-active count is extrapolated from Facebook-
  group/meetup membership with an assumed 40% commercial-activity rate — not independently
  sourced." `step_ref`: `04_calculate_the_tam_for_the_beachhead_market`, `confidence`: `low`,
  `test_plan`: "Cross-check against FAA Part 107 certificate-holder data by ZIP/region if a usable
  public extract exists, or commission a targeted survey of the two Facebook groups," `test_result`:
  `null`.
- `ka-004-heuristic-mismatch`: "This step's beachhead-TAM sanity-check heuristic (tens to low
  hundreds of millions/year) does not state whether it should be checked against GMV or against
  take-rate revenue for a marketplace business — applying it to the (correct, per this step's own
  formula) take-rate revenue figure makes an early-stage, supply-constrained marketplace look
  disqualified regardless of underlying market health." `step_ref`:
  `04_calculate_the_tam_for_the_beachhead_market`, `confidence`: `low`, `test_plan`: "Flag to the
  plugin maintainers as a methodology question, not something this business can resolve on its
  own — see QA-FINDINGS-ROUND3.md," `test_result`: `null`.
- No external search (WebSearch) was attempted this session for either the pilot count or the
  contractor count — both fall back to founder estimate/extrapolation, stated explicitly per this
  step's own honest-fallback discipline.

*This is a planning aid, not financial, legal, or tax advice.*
