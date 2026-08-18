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

Read `business_basics.business_type` first — see "Business-type branching" below for what the cost
buildup is actually dominated by per type. Step 13's stage list should already reflect the right
shape if it was done well — if it doesn't (e.g. it lists "champion" and "procurement" for a $9/mo
self-serve product), flag that gap back to Step 13 rather than silently costing the wrong shape
here.

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

## Business-type branching

What dominates the costed buildup — and what "conversion rate" even measures — differs sharply by
`business_basics.business_type`:

- **SaaS:** If Step 13's map is a sales-led/multi-role process, cost each stage in loaded rep/AE
  time plus tools (demo environment, CRM, proposal software). If it's self-serve/PLG, the process
  is really a marketing/conversion funnel — impression/ad → signup → activation → paid conversion
  — with no human rep touching most prospects; cost per stage there is overwhelmingly paid-
  acquisition spend (CPC/CPM) and product/onboarding friction, not loaded rep time. Many SaaS
  businesses run both motions in parallel (self-serve for small deals, sales-assisted for larger
  ones) — cost them as two separate funnels, not one blended average.
- **Physical product:** Cost the DTC funnel as paid-acquisition spend per stage (impression → click
  → cart → checkout), and include payment-processing fees and a returns-handling cost as a stage-
  level line if return rate is material — acquiring a customer who returns the item isn't really a
  closed sale. If a wholesale/retail channel exists, it is a **separate, much longer** process
  (trade show or broker outreach → buyer meeting → line-sheet review → PO negotiation → first
  shipment) costed in founder/rep time and travel/event spend, not ad spend — do not average its
  cycle length or cost against the DTC funnel.
- **Marketplace:** Cost the supply-side acquisition funnel and the demand-side acquisition funnel
  **completely separately** — their stages, time-per-stage, resources, and conversion rates rarely
  match. Supply-side often needs manual outreach and onboarding calls (loaded founder/BD time);
  demand-side is often a self-serve app-install/browse/transact funnel (paid-acquisition spend).
  Blending them into one "marketplace sales process" produces a number that hides which side is
  actually expensive to acquire — the exact thing Step 19's COCA needs to see clearly.
- **Services:** The process is almost entirely relationship/referral-driven, so cost is dominated
  by founder/BD loaded time spent on discovery calls, proposal writing, and follow-up — paid
  marketing spend is usually near zero early on. The single most important conversion rate here is
  proposals-sent-to-signed; track it explicitly, since it's the number that determines how much
  unpaid founder time gets spent per closed client.
- **Consumer app:** The "sales process" is a pure marketing/conversion funnel with no rep time at
  all — impression/ad → install → activation → paid conversion (if freemium/subscription). Cost
  each stage in paid-acquisition spend (CPI/CPC/CPM) and use app-funnel-standard conversion metrics
  (install→signup, signup→activation, activation→paid) rather than a sales-cycle framing; there is
  no meaningful "sales cycle length" in calendar days the way an enterprise deal has one — measure
  time-to-conversion in hours/days from install instead.
- **Other:** Ask the founder which shape — sales-led, self-serve funnel, referral-driven, or a
  genuine hybrid — actually describes their process rather than guessing (per
  `docs/UX-INTERVIEW-DESIGN.md` §4).

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

## Background relationship/network maintenance (referral-driven businesses — see note below)
| Activity | Time/period | Who does it | Notes |
|---|---|---|---|
| e.g. staying in touch with referral source X | ... | ... | ... |

## Roll-up
- Total sales cycle length: ...
- Overall funnel conversion (top of funnel → paying customer): ...
- Total resource cost per closed customer, discrete stages only (feeds Step 19): $...
- Total resource cost per closed customer, including background relationship maintenance
  allocated per engagement (feeds Step 19 if material — see note below): $...

## Open assumptions
- ka-018-...: ...
```

**For a referral-driven business specifically** (the default pattern this step's services guidance
names): a founder/BD person's real acquisition time is often materially larger than the sum of
time spent in the discrete stages above. The remainder is background relationship-maintenance —
staying in touch with the handful of referral sources that generate most of the pipeline — which
happens *between* discrete funnel stages, not *within* any one of them, so it has nowhere to go in
the stage-row table above and is easy to leave structurally uncounted. Ask directly: "does your
real total time-per-engagement in sales/BD activity match the sum of the stage rows above, or is
there a gap?" If there's a material gap, use the Background relationship/network maintenance
table to capture it (e.g. periodic check-ins with referral sources, allocated per engagement they
generate) and include it in the second Roll-up line — Step 19's COCA calculation needs the
complete figure, not just the discrete-stage total, or it will understate founder/BD loaded cost
for exactly the business shape (referral-driven services) where this cost is often the largest
single line. Omit this section entirely if the business's acquisition process is genuinely
confined to discrete, countable stages (e.g. most paid-acquisition or self-serve funnels).

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
- **Cross-check your chained overall-funnel conversion rate (multiplying every stage's
  stage-to-stage conversion together) against any conversion-rate assumption stated in a different
  step for the same underlying quantity** (most commonly Step 16's freemium-to-paid rate for a
  consumer app, or a similar top-of-funnel-to-close assumption elsewhere) — if they disagree by a
  material amount, flag it explicitly in Open assumptions rather than silently using one number in
  this file and a different one elsewhere. Two related steps computing the same real-world quantity
  two different ways is a known, recurring failure mode in this plugin (confirmed independently in
  rounds 2, 3, and 5) — this step is often the one that surfaces the discrepancy first, since it's
  the one doing the actual chained arithmetic.
- `business-state.json` key `18_map_the_sales_process_to_acquire_a_customer` set to `status:
  "drafted"`; leave review/approval to the later council skill.
