---
name: 18-map-the-sales-process-to-acquire-a-customer
description: >
  Use once Step 13's qualitative DMU acquisition map and Step 17's LTV are drafted and the
  founder needs to cost out the sales process to feed COCA. Triggers: "cost the sales process,"
  "sales cycle length," "conversion rates," "time to close," "sales funnel with numbers," "step
  18." Extends Step 13's stage map with time-per-stage, resources required, and conversion/close
  rates at each stage — it is Step 13 plus rigor, not a repeat of it; state that distinction
  explicitly rather than re-deriving the map from scratch.
---

# Step 18: Map the Sales Process to Acquire a Customer

## What this step is (and how it differs from Step 13)

Step 13 answered *what happens and who has to agree* — the qualitative DMU-keyed acquisition
map. Step 18 takes that exact map and makes it **costable**: how long each stage takes, what
resources (founder time, sales rep time, marketing spend, tools) each stage consumes, and what
fraction of prospects survive each stage. This is deliberate rigor added to the same map, not
independent work — **do not re-derive the stage list from scratch**; pull it directly from Step
13's output and extend each row. If Step 13 is missing or `not_started`, stop and draft it first.

The output of this step is the direct, required input to Step 19 (COCA calculation) — every cost
driver COCA needs must trace back to a row in this map.

For self-serve businesses (most `consumer_app`, some `saas`/`physical_product`), "sales process"
is really a marketing/conversion funnel — impression/ad → signup → activation → paid conversion —
with no human rep touching most prospects. Cost per stage there is overwhelmingly paid-acquisition
spend and product/onboarding friction, not loaded rep time; don't force a multi-stage enterprise
sales-cycle shape onto a motion that's actually self-serve. Read `business_basics.business_type`
first. Step 13's stage list should already reflect the right shape if it was done well — if it
doesn't (e.g. it lists "champion" and "procurement" for a $9/mo self-serve product), flag that
gap back to Step 13 rather than silently costing the wrong shape here.

## Reads

- `.startup/<slug>/business-state.json` (whole file). Check `business_basics.business_type` —
  it determines whether the stages below are an enterprise sales cycle or a self-serve funnel.
- `.startup/<slug>/plan/13-map-the-process-to-acquire-a-paying-customer.md` — required, and the
  primary source of truth for the stage list. Reuse its stages verbatim; do not rename or
  reorder them without explaining why.
- `.startup/<slug>/plan/09-identify-your-next-10-customers.md` if present — real prospect data
  (even anecdotal) is the best source for actual time-per-stage and conversion estimates.
- `.startup/<slug>/plan/16-set-your-pricing-framework.md` if present — deal size affects how
  much sales effort is economically justified per stage.

## Founder-facing deliverables

For every stage carried over from Step 13, add:

1. **Time in stage** — typical calendar time a prospect spends here (days/weeks), and effort
   time (hours of founder/rep attention actually spent).
2. **Resources consumed** — whose time (founder, AE, SDR, solutions engineer), what tools/spend
   (ads, events, demo environment, legal review cost), attributed to this stage.
3. **Conversion rate into the next stage** — % of prospects entering this stage who advance.
4. **Total sales cycle length** — sum of time-in-stage across the whole map, start to signed.
5. **Overall funnel conversion** — leads/prospects needed at stage 1 to yield one paying
   customer, given the chained conversion rates.

Ask the founder directly:
- "Of the last N real conversations you've had, how many advanced past each of these stages?"
  (use real data if any customers/prospects exist yet, even a handful)
- "Where does the process actually stall the longest, and why?"
- "What does that stalled stage cost you in founder time you're not spending elsewhere?"

## When the founder doesn't know

Pre-revenue founders frequently have zero real conversion data. Never invent plausible-sounding
conversion percentages or stage durations. Add a `key_assumptions` entry and mark the specific
cells in the table as assumptions:

```json
{ "id": "ka-018-conversion", "statement": "No real funnel data yet; assumes 25% of first calls convert to a demo based on founder's prior-company benchmark, not this venture's data", "step_ref": "18_map_the_sales_process_to_acquire_a_customer", "confidence": "low", "test_plan": "Recompute from actual funnel data once 20 real prospects have moved through the process", "test_result": null }
```

## Quantitative claims (required)

Total sales cycle length, blended conversion rate, and fully-loaded stage costs are numbers
presented as fact and need `quantitative_claims` entries:

```json
{ "id": "qc-018-cycle-length", "claim": "Average sales cycle length, beachhead segment", "value": "34 days", "step_ref": "18_map_the_sales_process_to_acquire_a_customer", "source": "founder estimate from 6 informal prospect conversations to date; not yet a statistically meaningful sample", "confidence": "low", "ai_risk_flag": true }
```

## Output file: `plan/18-map-the-sales-process-to-acquire-a-customer.md`

```markdown
# Step 18: Map the Sales Process to Acquire a Customer

> Extends Step 13's qualitative DMU map with time, resource cost, and conversion data. See
> `plan/13-map-the-process-to-acquire-a-paying-customer.md` for the stage rationale and DMU
> roles; this file does not repeat that reasoning.

## Costed process map
| Stage (from Step 13) | Time in stage | Resources/cost consumed | Conversion to next stage | Source / assumption |
|---|---|---|---|---|
| 1. Awareness | ... | ... | ...% | ... |
| ... | | | | |
| N. Signed & paid | ... | ... | ...% | ... |

## Roll-up
- Total sales cycle length: ...
- Overall funnel conversion (top of funnel → paying customer): ...
- Total resource cost per closed customer (feeds Step 19): $...

## Open assumptions
- ka-018-...: ...
```

## Update business-state.json

```json
"18_map_the_sales_process_to_acquire_a_customer": {
  "status": "drafted",
  "summary": "<sales cycle length, overall conversion rate, and confidence level>",
  "file": "plan/18-map-the-sales-process-to-acquire-a-customer.md"
}
```

Append `quantitative_claims` and `key_assumptions` entries; preserve all other keys.

## Done means

- `plan/18-map-the-sales-process-to-acquire-a-customer.md` written, explicitly extending Step
  13's map rather than duplicating it.
- Every stage's cost/conversion figures used elsewhere have `quantitative_claims` entries.
- `business-state.json` key `18_map_the_sales_process_to_acquire_a_customer` set to `status:
  "drafted"`; leave review/approval to the later council skill.
