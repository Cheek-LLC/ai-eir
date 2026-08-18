---
name: 19-calculate-the-coca
description: >
  Use once Step 18's costed sales process and Step 17's LTV are drafted and the founder needs
  the fully-loaded Cost of Customer Acquisition. Triggers: "COCA," "CAC," "cost of customer
  acquisition," "customer acquisition cost," "LTV to CAC ratio," "step 19." Sums the resource
  costs from Step 18's costed process map, divides by customers acquired, and runs the explicit
  LTV:COCA sanity check against Step 17's output — the two together are this venture's core unit
  economics gate.
---

# Step 19: Calculate the COCA

## What this step is

The fully-loaded cost to acquire one paying customer: all sales and marketing spend, plus the
cost of everyone's time who touches the acquisition process, divided by the number of customers
actually closed in that period. This step must be **built directly from Step 18's costed sales
process map** — every cost line here should trace to a stage in that map. It is not a fresh
estimate; if Step 18 is missing or `not_started`, stop and draft it first.

This step also runs the **LTV:COCA sanity check**, the single most important unit-economics gate
in the whole plan: compare Step 17's LTV to this step's COCA and state the ratio and payback
period explicitly.

## Reads

- `.startup/<slug>/business-state.json` (whole file)
- `.startup/<slug>/plan/18-map-the-sales-process-to-acquire-a-customer.md` — required. Source of
  every cost input: resources consumed per stage, sales cycle length, funnel conversion rates.
- `.startup/<slug>/plan/17-calculate-the-ltv-of-a-customer.md` — required. Source of the LTV
  figure this step's COCA is compared against.
- `.startup/<slug>/plan/16-set-your-pricing-framework.md` if present — deal size context for
  whether a given COCA is economically sane relative to first-year revenue.

## Founder-facing deliverables

1. **Fully-loaded cost buildup** — sum every cost line from Step 18's stage map: paid marketing
   spend, tools/software attributable to acquisition, and the loaded cost of time (founder/rep
   hourly-equivalent cost × hours spent per stage, summed across the funnel using Step 18's
   conversion rates to account for prospects who drop off along the way).
2. **Blended vs. paid-channel COCA** — if multiple acquisition channels exist (founder-led sales,
   inbound content, paid ads), compute COCA per channel where data allows, plus a blended figure.
3. **COCA = Total acquisition cost in period / New paying customers acquired in period.**
4. **LTV:COCA ratio** — `LTV (Step 17) / COCA (this step)`, stated as an explicit ratio (e.g.,
   "4.2:1"). State the standard interpretation plainly: below roughly 3:1 signals the business
   as modeled is not economically viable at scale; comfortably above 3:1 (many venture investors
   look for closer to 5:1+) signals healthy unit economics — but treat these as reference bands
   framed as planning aids, not universal thresholds, and always caveat against the confidence
   of the underlying LTV and COCA inputs.
5. **Payback period** — months of gross margin needed to recoup COCA on one customer
   (`COCA / (monthly revenue per customer × gross margin %)`); shorter is better for cash-
   constrained early-stage ventures regardless of the LTV:COCA ratio.

Ask the founder directly:
- "Of everything in Step 18's cost buildup, what's the single biggest lever you could pull to
  lower this?"
- "Does this COCA number still work if you had to pay a rep market salary instead of your own
  sweat equity?" (loaded founder time is a real cost and must not be left out just because it's
  currently unpaid)

## When the founder doesn't know

Do not fabricate a marketing spend figure or an hourly cost-of-time rate. If loaded cost inputs
are missing, add a `key_assumptions` entry and use a clearly labeled placeholder rate (e.g., a
stated reasonable founder-time rate) rather than presenting an invented number as settled:

```json
{ "id": "ka-019-founder-rate", "statement": "Founder time in sales process valued at $75/hr (unvalidated placeholder) for COCA loading, since no market comp has been sourced", "step_ref": "19_calculate_the_coca", "confidence": "low", "test_plan": "Replace with a sourced local market salary comp for an equivalent AE/SDR role", "test_result": null }
```

## Quantitative claims (required)

COCA itself, the LTV:COCA ratio, and the payback period are numbers presented as fact and each
need a `quantitative_claims` entry:

```json
{ "id": "qc-019-coca", "claim": "Fully-loaded COCA, beachhead segment", "value": "$1,410", "step_ref": "19_calculate_the_coca", "source": "computed from Step 18 stage costs (qc-018-cycle-length) and founder time at $75/hr placeholder rate (see ka-019-founder-rate)", "confidence": "low", "ai_risk_flag": true }
```

```json
{ "id": "qc-019-ltv-coca-ratio", "claim": "LTV:COCA ratio", "value": "4.2:1", "step_ref": "19_calculate_the_coca", "source": "computed: LTV $5,988 (qc-017-ltv) / COCA $1,410 (qc-019-coca)", "confidence": "low", "ai_risk_flag": true }
```

## Output file: `plan/19-calculate-the-coca.md`

```markdown
# Step 19: Calculate the COCA

## Cost buildup (from Step 18)
| Stage | Cost driver | Cost | Source |
|---|---|---|---|
| ... | | | |
**Total acquisition cost per closed customer: $...**

## COCA
Blended COCA: $... (per channel, if applicable: ...)

## LTV:COCA sanity check
LTV (Step 17): $... | COCA: $... | **Ratio: X:1**
Payback period: N months
Interpretation: <plain statement of what this ratio means for viability, with confidence caveat>

## Open assumptions
- ka-019-...: ...
```

## Update business-state.json

```json
"19_calculate_the_coca": {
  "status": "drafted",
  "summary": "<COCA figure, LTV:COCA ratio, and payback period>",
  "file": "plan/19-calculate-the-coca.md"
}
```

Append `quantitative_claims` and `key_assumptions` entries; preserve all other keys.

## Done means

- `plan/19-calculate-the-coca.md` written, built directly from Step 18's cost map.
- LTV:COCA ratio and payback period computed and stated explicitly.
- Every figure has a `quantitative_claims` entry with a source.
- `business-state.json` key `19_calculate_the_coca` set to `status: "drafted"`; leave
  review/approval to the later council skill.
