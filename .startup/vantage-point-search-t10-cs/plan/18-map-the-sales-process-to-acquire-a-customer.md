# Step 18: Map the Sales Process to Acquire a Customer

> Extends Step 13's qualitative DMU map with time, resource cost, and conversion data. Reuses
> Step 13's 5 stages verbatim; does not repeat that reasoning.

## Services branching note

Per this step's guidance: the process is almost entirely relationship/referral-driven, so cost is
dominated by founder/BD loaded time on discovery calls, proposals, and follow-up; paid marketing
spend is near zero. Confirmed directly — of the ~$5,200 total COCA computed below (see Step 19),
essentially all of it is loaded founder time; direct marketing spend (LinkedIn Recruiter
subscription, one industry conference) is a small minority.

## Costed process map

| Stage (from Step 13) | Time in stage | Resources/cost consumed | Conversion to next stage | Source / assumption |
|---|---|---|---|---|
| 1. First real conversation | ~1 week turnaround | ~1 hr founder time/conversation | 74% (26/35) | Founder-tracked count, 14 months |
| 2. Discovery call | ~1 week | ~1.5 hr founder time/call (call + prep) | 69% (18/26) | Founder-tracked |
| 3. Proposal sent | ~1 week | ~2 hr founder time/proposal (writing, comp research) | ~85% advance to budget check | Founder estimate |
| 4. Internal budget check | 1-3 weeks (comp-committee cases run longer) | ~1 hr founder follow-up time | ~52% (8/15 est.) | Founder-tracked; this is the single biggest drop-off point |
| 5. Signed & paid | ~1 week (contract paperwork) | ~0.5 hr founder time | n/a (endpoint) | — |

Combined stage 3→5 conversion: ~44% (8/18), matching Step 13's directly observed figure.

## Background relationship-maintenance time — flagged as a gap in how this step's template maps to a referral-driven business

The stage-by-stage table above accounts for only ~16 hours of founder time per signed engagement.
Jordan's actual total BD time is closer to **45 hours per signed engagement** (see Step 19's cost
buildup) — the remaining ~29 hours/engagement is background relationship maintenance (staying in
touch with past clients/candidates who are the actual referral sources per Step 9, general
network activity) that does not map cleanly to any single discrete stage in Step 13's process map.
**This is a real gap in this step's own template, not just an artifact of this one business**: a
referral-driven services business's real BD cost is dominated by undifferentiated relationship
maintenance that happens *between* discrete funnel stages, and neither Step 13 nor this step's
template has a row for it. Logging it here as its own line rather than force-fitting it into one
of the five stages above, since doing so would understate what each discrete stage actually costs.

## Roll-up

- Total sales cycle length: ~5-9 weeks (conversation to signed), driven mostly by how long the
  internal budget check takes.
- Overall funnel conversion (top of funnel → paying customer): 23% (8/35).
- Total resource cost per closed customer (feeds Step 19): ~16 hrs stage-mapped time + ~29 hrs
  background relationship-maintenance time = **~45 hrs founder time per signed engagement**, plus
  ~$673/engagement in tools/marketing spend (LinkedIn Recruiter subscription + one annual
  conference, annualized).

## Quantitative claims

```json
{ "id": "qc-018-cycle-length", "claim": "Average sales cycle length, beachhead segment", "value": "5-9 weeks, conversation to signed (range, not a point estimate)", "step_ref": "18_map_the_sales_process_to_acquire_a_customer", "source": "founder-tracked estimate from 8 real signed engagements over 14 months; not a CRM export, see ka-013-conversion-sample", "confidence": "medium", "ai_risk_flag": false }
```

## Open assumptions

```json
{ "id": "ka-018-relationship-maintenance-cost", "statement": "The ~29 hours/engagement of background relationship-maintenance time is a rough backed-out estimate (total 14-month BD hours minus stage-mapped hours), not independently tracked", "step_ref": "18_map_the_sales_process_to_acquire_a_customer", "confidence": "low", "test_plan": "Time-track relationship-maintenance activity separately going forward instead of backing it out by subtraction", "test_result": null }
```

## Update business-state.json

```json
"18_map_the_sales_process_to_acquire_a_customer": {
  "status": "drafted",
  "summary": "5-9 week sales cycle, 23% overall conversion, ~45 hrs founder time per signed engagement (only ~16 hrs of which maps to a discrete Step 13 stage — the rest is background relationship maintenance the step template has no row for)",
  "file": "plan/18-map-the-sales-process-to-acquire-a-customer.md"
}
```
