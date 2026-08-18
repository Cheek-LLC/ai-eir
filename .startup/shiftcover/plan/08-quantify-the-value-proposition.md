# Step 8: Quantified Value Proposition

## Persona's top priority metric
Labor cost as a % of sales (target ≤28%) and on-time-opening compliance (Step 5). The value
proposition is quantified primarily as **manager time reclaimed** and **reduced late-opening
risk**, both of which roll up into those two metrics without inventing a new metric Jordan
doesn't already track.

## As-is state
- Time-to-cover a call-out: **45 minutes average** (Jordan's stated figure; corroborated
  directionally, not precisely, by the other 2 real GM conversations from Step 3).
- Frequency: **~3 call-outs/week** per location (Jordan's estimate).
- As-is manager time cost: 45 min × 3/week = **135 minutes/week** spent working the call list.
- Late-opening incidents attributable to uncovered call-outs: **~1/month**, each estimated by
  Jordan at roughly **$400** in lost sales (her recollection of a corporate report she saw once,
  not a document she has in hand — flagged low confidence below).

## Possible state with product
- Target time-to-cover with ShiftCover: **8 minutes** (Step 7's core-flow target). This is a
  **founder-set target, not a measured result** — no pilot has run yet. Stated as a target, not a
  claim of fact.
- Manager time at target: 8 min × 3/week = 24 minutes/week.
- Late-opening incident reduction: estimated **70%** reduction (founder judgment, not measured).

## Quantified value proposition
- Manager time saved: 135 − 24 = **111 minutes/week ≈ 1.85 hours/week**, at a fully-loaded GM
  cost estimate of **$28/hour** (founder estimate blending wage + overhead, not a payroll
  document) ≈ **$52/week ≈ $2,700/year** in manager time per location.
- Late-opening risk reduction: $400 × 12 × 0.70 ≈ **$3,360/year** per location.
- **Total quantified value ≈ $6,000/year per location.**

## Comparison to next best alternative / status quo
The next best alternative is the status quo itself (the laminated call list + group text), not a
named competitor — consistent with what Jordan described in Step 3/6. Switching cost is real but
modest: no new hardware, workers already carry phones capable of SMS, and the base schedule stays
in 7shifts/HotSchedules unchanged. The switching cost is mostly behavioral (Jordan trusting a new
tool during an actual crisis) rather than technical or financial.

## Judgment: is the gap big enough?
**Marginal-to-sufficient, and explicitly conditional on an unproven number.** $6,000/year in
quantified value against a $1,788/year price (Step 16) is a healthy ~3.4:1 value-to-price ratio
*if* the 8-minute target and the 70% late-opening reduction both hold up in real use. Both are
currently founder targets, not measured results. If time-to-cover only improves to, say, 20
minutes instead of 8, the manager-time-saved component drops by roughly half and the value case
gets meaningfully thinner. This should be treated as **not yet validated** rather than a settled
number — Step 21 should test it directly rather than let it ride into the plan as fact.

## Quantitative claims logged
```json
{ "id": "qc-08-value-delta", "claim": "Quantified value proposition per location for ShiftCover vs. status quo", "value": "$2,700/yr manager-time savings + $3,360/yr late-opening risk reduction = ~$6,000/yr per location", "step_ref": "08_quantify_the_value_proposition", "source": "founder estimate, derived from Jordan Vasquez's (Step 5) reported as-is figures and Maria Chen's unvalidated 8-minute/70%-reduction targets for the possible state — no pilot data exists yet", "confidence": "low", "ai_risk_flag": true }
```

## Assumptions flagged
```json
{ "id": "ka-008-target-unproven", "statement": "The 8-minute time-to-cover target and the 70% late-opening-reduction estimate that the entire quantified value proposition rests on are founder targets, not measured pilot results.", "step_ref": "08_quantify_the_value_proposition", "confidence": "low", "test_plan": "Measure actual time-to-cover and late-opening incident rate during the Step 22 MVBP pilot before presenting this value figure as validated in any external context.", "test_result": null }
```

*This is a planning aid, not financial, legal, or tax advice.*
