# Step 18: Map the Sales Process to Acquire a Customer

> Extends Step 13's qualitative maps with time, resource cost, and conversion data. See
> `plan/13-map-the-process-to-acquire-a-paying-customer.md` for stage rationale and DMU roles.
>
> **Marketplace gap encountered here too:** like Step 17, this step's SKILL.md has no
> marketplace-specific branching (confirmed by grep — zero mentions of "marketplace") despite its
> own instruction to "reuse Step 13's stages verbatim," and Step 13 explicitly produced **two**
> parallel stage lists for a marketplace, not one. Nothing in this step's file says whether to
> produce one costed table or two. I costed **both** processes separately below, since costing
> only one (and silently picking which) would hide exactly the kind of asymmetry Step 9 already
> found between the two sides (demand is Derek's stronger network, supply is the harder
> constraint) — but this was my own improvisation, not something the step instructed.

## Costed process map — SUPPLY (pilot onboarding, from Step 13)
| Stage (from Step 13) | Time in stage | Resources/cost consumed | Conversion to next stage | Source / assumption |
|---|---|---|---|---|
| 1. Awareness | 1-3 days | Derek's time: ~1 hr/pilot (personal outreach or FB group post) | ~70% (Derek's network is warm) | Founder estimate from the 8 real supply-side conversations to date |
| 2. Evaluation | 2-5 days | Derek's time: ~0.5 hr/pilot (answering pay/terms questions) | ~60% | Founder estimate |
| 3. Sign-up & vetting | 3-7 days | Derek's time: ~1 hr/pilot (reviewing cert/insurance docs — no automated vetting flow exists yet) | ~80% (most who get this far follow through) | Founder estimate |
| 4. First job accepted & completed | Variable — depends on real job availability | Derek's time: ~0.5 hr/pilot (coordination); no cash spend | ~90% once a real job is offered | Founder estimate |
| 5. Repeat engagement | Ongoing | Minimal marginal cost per repeat job | Unmeasured — depends on Step 6's flagged renewal risk | No real data yet |

**Roll-up (supply):** Total time-in-funnel to first completed job: ~2-3 weeks. Overall funnel
conversion (aware → first job completed): ~70% × 60% × 80% × 90% ≈ **30%**. Total founder-time
cost per onboarded, job-completing pilot: ~3 hours, at an unvalidated $75/hr placeholder rate (see
Step 19) = **≈$225/pilot** in loaded founder time (no cash spend).

## Costed process map — DEMAND (contractor onboarding, from Step 13)
| Stage (from Step 13) | Time in stage | Resources/cost consumed | Conversion to next stage | Source / assumption |
|---|---|---|---|---|
| 1. Awareness | Immediate (existing relationship) for the 4 warm prospects; 1-2 weeks for a cold trade-association lead | Derek's time: ~1 hr | ~90% for warm, unmeasured for cold | Founder estimate; only warm-path data exists so far |
| 2. Evaluation | 1-2 weeks | Derek's time: ~2 hrs (pricing/vendor-relationship conversation) | ~70% | Founder estimate |
| 3. Carrier-acceptance check | 1-4 weeks — **the flagged riskiest, longest stage per Step 13** | Derek's time: ~2 hrs (supporting the contractor's internal validation); no direct cost, but real elapsed-time risk | Unmeasured — no real prospect has completed this stage yet | No data — genuinely unknown, stated honestly |
| 4. First booking | Depends on next real storm event | Derek's time: ~1 hr (coordination) | Unmeasured | No data yet |
| 5. Repeat/expanded use | Ongoing | Minimal marginal cost | Unmeasured | No data yet |

**Roll-up (demand):** Total time-in-funnel to first booking: **unknown — dominated by an
untimed, unmeasured Stage 3** (the carrier-acceptance check), which per Step 13's own flag is the
single highest-risk unknown in the whole acquisition path. Total founder-time cost to first booking
(excluding the unmeasured Stage 3 wait): ~4 hours at the same $75/hr placeholder = **≈$300/
contractor** in loaded founder time, explicitly **not including** whatever real elapsed time and
effort the carrier-acceptance check actually consumes, since that's unmeasured.

## Open assumptions
- `ka-018-supply-conversion`: "Supply-side funnel conversion rates (~70/60/80/90%) are founder
  estimates from a small, warm-network sample (8 conversations) — not measured against pilots
  outside Derek's existing network." `step_ref`: `18_map_the_sales_process_to_acquire_a_customer`,
  `confidence`: `low`, `test_plan`: "Recompute once at least 5 pilots with no prior relationship
  to Derek have gone through the funnel," `test_result`: `null`.
- `ka-018-carrier-check-unmeasured`: "Demand-side Stage 3 (carrier-acceptance check) has no time
  or conversion data at all — this is a genuine, not-yet-resolvable unknown, not an estimate."
  `step_ref`: `18_map_the_sales_process_to_acquire_a_customer`, `confidence`: `low`, `test_plan`:
  "Directly observable outcome of the first real demand-side sales conversation (Ray Delgado,
  Step 9 prospect #6) once he actually attempts to validate a SkyClaim report with his carrier
  contacts," `test_result`: `null`.
- `ka-018-no-marketplace-guidance`: "This step's SKILL.md gives no instruction on whether to cost
  one shared process or two separate ones for a marketplace, despite Step 13 explicitly producing
  two parallel maps — I produced two tables as the more honest choice, but this was an
  improvisation, not an instruction." `step_ref`: `18_map_the_sales_process_to_acquire_a_customer`,
  `confidence`: `low`, `test_plan`: "Flag to plugin maintainers — see QA-FINDINGS-ROUND3.md,"
  `test_result`: `null`.

## Quantitative claims (required)
```json
{ "id": "qc-018-supply-funnel", "claim": "Supply-side funnel conversion and cost to first completed job", "value": "≈30% aware-to-first-job conversion; ≈$225/pilot loaded founder-time cost (no cash spend)", "step_ref": "18_map_the_sales_process_to_acquire_a_customer", "source": "founder estimate from 8 real supply-side conversations to date; time-per-stage and $75/hr rate are both unvalidated placeholders (see ka-019-founder-rate in Step 19)", "confidence": "low", "ai_risk_flag": true }
```
```json
{ "id": "qc-018-demand-funnel", "claim": "Demand-side loaded founder-time cost to first booking (excluding unmeasured carrier-check stage)", "value": "≈$300/contractor, with total elapsed time to first booking genuinely unknown pending the carrier-acceptance stage", "step_ref": "18_map_the_sales_process_to_acquire_a_customer", "source": "founder estimate; carrier-acceptance stage explicitly unmeasured, not estimated", "confidence": "low", "ai_risk_flag": true }
```
