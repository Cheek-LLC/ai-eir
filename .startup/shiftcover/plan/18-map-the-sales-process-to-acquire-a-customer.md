> Extends Step 13's qualitative DMU map with time, resource cost, and conversion data. See
> `plan/13-map-the-process-to-acquire-a-paying-customer.md` for the stage rationale and DMU
> roles; this file does not repeat that reasoning.

# Step 18: Map the Sales Process to Acquire a Customer

## Costed process map
| Stage (from Step 13) | Time in stage | Resources/cost consumed | Conversion to next stage | Source / assumption |
|---|---|---|---|---|
| 1. Awareness | ~3 weeks calendar | Founder time only (association/network activity, amortized) | 30% (of "aware" Directors of Ops take a first call) | Founder estimate, no real funnel data yet — zero customers closed to date |
| 2. First conversation | 1 week | 1.5 hrs founder time (demo prep + call) | 50% | Founder estimate |
| 3. Champion/internal buy-in | 2.5 weeks | 1 hr founder time (follow-up) | 60% | Founder estimate |
| 4. Franchisor check (brand-dependent) | 2 weeks when applicable, 0 when not (blended ~1.2 weeks) | Blended 1.2 hrs founder time | 80% blended (assumes 60% of prospects skip this stage entirely — not yet confirmed per brand, see `ka-012-franchisor-veto`) | Founder estimate |
| 5. Contract & pricing | 2 weeks | 2 hrs founder time (negotiation) | 50% | Founder estimate |
| 6. Signed & paid | — | — | — | — |

## Roll-up
- **Total sales cycle length:** ≈ 3 + 1 + 2.5 + 1.2 + 2 = **9.7 weeks ≈ 68 days** (all founder
  estimates — no real deal has closed yet to measure against).
- **Overall funnel conversion (aware → signed):** 0.30 × 0.50 × 0.60 × 0.80 × 0.50 ≈ **3.6%** — it
  takes roughly **28 "aware" leads to close 1 customer** at these assumed rates.
- **Total founder-time cost per closed customer:** summing hours consumed at each stage across the
  leads that actually reach it (28 aware → 8.4 first-conversation → 4.2 champion → 2.5
  franchisor-check → 2.0 contract, converging to ~1 signed):
  - Awareness: 28 × 0.5 hr ≈ 14.0 hrs
  - First conversation: 8.4 × 1.5 hr ≈ 12.6 hrs
  - Champion buy-in: 4.2 × 1.0 hr ≈ 4.2 hrs
  - Franchisor check: 2.52 × 1.2 hr ≈ 3.0 hrs
  - Contract: 2.02 × 2.0 hr ≈ 4.0 hrs
  - **Total ≈ 37.8 hours of founder time per closed customer** (feeds Step 19).

## Update (revision cycle, week of 2026-08-25 — council required revision [SALES-CYCLE], NOT
resolved this cycle)
The council asked for this funnel to be recomputed once 5+ real prospects have moved through at
least the first two stages. Real status as of this revision: **2 of 7** Step 9 prospects have
reached Stage 2 (Alex Torres/Copperline — first conversation held, doubling as the Step 12
franchisor-veto call above; Priya Nair/Nair Hospitality — first conversation scheduled for the
following week). That is 2 prospects, not the 5+ the council asked for, and neither has moved
further than Stage 2. **This table and the roll-up below are deliberately left unchanged** —
recomputing a 6-stage, 5-point conversion funnel from 2 real data points would be exactly the kind
of false-precision, evidence-thin claim `ar-shiftcover-003` and this council's own
`customer-discovery-skeptic` review already warned against. This required revision is carried
forward as **not resolved**, honestly: getting 5 real prospects through 2 stages of a ~3-4 week
combined Stage 1+2 process realistically takes several more weeks beyond this revision cycle, not
something a single revision session can produce without fabricating data.

## Open assumptions
```json
{ "id": "ka-018-conversion", "statement": "No real funnel data yet; all stage conversion rates and time-in-stage figures are founder estimates, not measured from actual prospect conversations — the Step 9 pipeline has not yet advanced anyone past 'in conversation.'", "step_ref": "18_map_the_sales_process_to_acquire_a_customer", "confidence": "low", "test_plan": "Recompute from actual funnel data once the first 5-10 real prospects have moved through the process.", "test_result": null }
```
```json
{ "id": "ka-018-channel-scalability", "statement": "The entire funnel above is sourced from Maria's existing warm network (Step 9 found only 7 real named prospects total) — this cost/conversion model has no paid-marketing or outbound-cold channel in it, and does not represent what acquisition would cost once the warm-network list (≈7-28 leads) is exhausted.", "step_ref": "18_map_the_sales_process_to_acquire_a_customer", "confidence": "low", "test_plan": "Model a paid/outbound channel's likely cost and conversion once the warm-network pipeline (Step 9) is exhausted, before presenting COCA as representative of the business at scale.", "test_result": null }
```

## Quantitative claims logged
```json
{ "id": "qc-018-cycle-length", "claim": "Average sales cycle length, beachhead segment", "value": "≈68 days (9.7 weeks)", "step_ref": "18_map_the_sales_process_to_acquire_a_customer", "source": "founder estimate — no real deal has closed yet, so this is a projection, not a measured average", "confidence": "low", "ai_risk_flag": true }
```
