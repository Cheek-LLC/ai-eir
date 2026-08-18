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

- `.startup/<slug>/business-state.json` (whole file). Read `business_basics.business_type` — it
  determines what the dominant cost driver in the buildup actually is (see "Business-type cost
  drivers").
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

## Business-type cost drivers

The fully-loaded buildup (deliverable 1) is dominated by a different cost line depending on
`business_basics.business_type` — check the right one isn't being left out:

- **SaaS:** Often a mix of paid-acquisition spend (per click/lead) for the self-serve funnel and
  loaded rep/AE time for sales-assisted deals — compute both and blend, don't pick one channel and
  ignore the other if both exist.
- **Physical product / DTC:** COCA is usually dominated by paid social/search spend per order;
  include payment-processing fees and, if the product has a meaningfully high return rate, the
  loaded cost of returns/refunds as part of acquiring a *net* paying customer, not just a first
  order. Wholesale-channel COCA (trade shows, broker/distributor fees) is a distinct number from
  DTC COCA — don't blend them into one figure without saying so.
- **Marketplace:** Cost supply-side and demand-side acquisition **separately** — they're rarely
  symmetric, and one side is often subsidized (free listings, incentive payments) to reach
  liquidity. A single blended "marketplace COCA" hides which side is actually expensive.
  **When comparing each side's COCA to Step 17's LTV, check explicitly whether that side has a
  representable LTV at all** — per Step 17's marketplace guidance, a side that is paid by the
  business (not charged) has no positive LTV under the standard formula. Report that side's ratio
  as "N/A — compensated side, not charged" rather than omitting it or forcing a number, and use
  Step 17's substitute sustainability metric for that side instead. Do not present a single
  flattering LTV:COCA ratio (typically the demand side's) as if it represented the whole business
  — state both sides' status explicitly, even when one is N/A.
- **Services:** Usually dominated by founder/BD loaded time (referral- and network-driven), with
  near-zero paid marketing spend early on — the "ask the founder" question above about a market-
  rate rep salary is especially load-bearing here, since unpaid founder time is most of the real
  cost and easiest to leave out.
- **Consumer app:** Usually dominated by paid-install spend (CPI) and/or ad-network spend, blended
  with any organic/referral installs. The critical decision this business type forces that others
  don't: COCA must be computed at a **stated funnel stage** — per install, per activated user, or
  per paying user — and these can differ by an order of magnitude for a freemium app with a low
  free-to-paid conversion rate. State explicitly which one is "the" COCA being compared against
  LTV in the sanity check below; comparing a per-install COCA against a per-paying-user LTV
  understates the ratio catastrophically and is the single most common mistake at this step for
  this business type.
- **Other:** Ask the founder which cost driver actually dominates their acquisition spend rather
  than assuming one of the above patterns applies (per `docs/UX-INTERVIEW-DESIGN.md` §4).

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

## Mandatory AI-risk gate — before this step is reported done

This step is one of the five DE steps `skills/risk/ai-risk-review`'s own "Who must call this, and
when" table names explicitly. After writing `plan/19-calculate-the-coca.md` and before setting
`status: "drafted"`, invoke `skills/risk/ai-risk-review` against this step's plan file (whole
file, not a summary) plus the business-slug.

- **PASS** → proceed to write `business-state.json` below.
- **BLOCKED** → do not set `status: "drafted"`. Fix the finding and re-run the gate, or route to
  the orchestrator for an explicit founder override (per `agents/orchestrator.md` Non-negotiable
  #3) — this step does not accept an override itself.

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
- Every figure has a `quantitative_claims` entry with a source — before reporting `drafted`,
  re-read this file's claims section and confirm COCA, the ratio, and the payback period each
  have a matching entry, not just the cost inputs.
- **State COCA, the ratio, and the payback period to no more precision than your weakest chained
  input supports — round explicitly before writing them, not after the AI-risk gate catches it.**
  This step is the single most common place this plugin's own live dry runs have hit a
  false-precision BLOCKED finding — four consecutive rounds, most often right here, because COCA is
  structurally the most downstream step in the TAM→LTV→funnel-costing→COCA chain and accumulates
  the most compounded uncertainty. Check yours before you finish; don't count on the gate.
- The mandatory AI-risk gate above returned PASS, or a BLOCKED finding was resolved/overridden.
- `business-state.json` key `19_calculate_the_coca` set to `status: "drafted"`; leave
  review/approval to the later council skill.
