---
name: 17-calculate-the-ltv-of-a-customer
description: >
  Use once pricing (Step 16) is drafted and the founder needs the lifetime value of an acquired
  customer. Triggers: "LTV," "lifetime value," "customer lifetime value," "how much is a
  customer worth," "LTV:CAC," "step 17." Produces a sourced LTV calculation (revenue per period
  × gross margin × expected lifetime, or ARPU / churn) that Step 19 will later divide against
  COCA for the LTV:COCA sanity check — do not compute that ratio here, COCA doesn't exist yet.
---

# Step 17: Calculate the LTV of a Customer

## What this step is

The dollar value a typical beachhead customer generates over the full time they remain a
customer, net of the cost to deliver the product to them. This step produces the LTV number and
its full derivation. The LTV:COCA ratio sanity check itself happens in Step 19, once COCA exists
— this step's job is to make LTV defensible and correctly sourced so that later comparison means
something.

## Reads

- `.startup/<slug>/business-state.json` (whole file). Read `business_basics.business_type` before
  choosing what "lifetime" and "revenue per period" actually mean for this business — see
  "Business-type branching."
- `.startup/<slug>/plan/16-set-your-pricing-framework.md` — required. Price point(s) are the
  starting input for revenue per period.
- `.startup/<slug>/plan/15-design-a-business-model.md` — required. Determines whether "lifetime"
  is measured in renewal periods (subscription), repeat purchase cycles (consumables), or a
  single transaction with expansion revenue (project/licensing).
- `.startup/<slug>/plan/08-quantify-the-value-proposition.md` if present — cross-check that LTV
  doesn't imply capturing more value than was quantified as deliverable there.

## Founder-facing deliverables

Compute LTV using the standard formula, showing every input explicitly rather than presenting
only the final number:

```
LTV = (Average Revenue Per Account per period × Gross Margin %) × Expected Customer Lifetime (periods)
```

Where `Expected Customer Lifetime = 1 / churn rate` for subscription models, or a founder/industry
estimate of repeat-purchase count × average order value for transactional/consumables models.
For simple cases, a discount rate can be layered in for rigor (NPV of the revenue stream) but a
flag as "undiscounted, nominal" is acceptable at this stage as long as it's stated.

Require the founder to supply or source:
1. **ARPU / average deal size** — from Step 16, per pricing tier if tiers exist; blend by
   expected tier mix if known.
2. **Gross margin %** — cost to serve one customer (hosting, support, fulfillment, payment
   processing) subtracted from revenue. If unknown, do not assume 100% margin — flag as an
   assumption.
3. **Expected lifetime / churn** — from founder's prior experience, industry benchmark for the
   category, or (most defensible) early cohort data if any customers already exist. Never invent
   a churn rate; benchmark ranges vary enormously by category (monthly SMB SaaS churn commonly
   3-7%/mo; enterprise annual contracts commonly 5-15%/yr) — cite whichever is used as source.
4. Compute LTV per pricing tier if tiers exist, plus a blended figure.

## Business-type branching

The standard formula's inputs — "revenue per period," "expected lifetime" — mean something
different depending on `business_basics.business_type`. Don't force churn-based subscription math
onto a business that doesn't work that way:

- **SaaS:** The standard formula applies most directly — `ARPU × gross margin × (1 / churn rate)`.
  Where the pricing model includes expansion (seat growth, tier upgrades), compute LTV two ways:
  a conservative flat-ARPU version and a net-revenue-retention-adjusted version that accounts for
  expansion revenue exceeding the churned-revenue base — state which one is presented as the
  headline figure and why, since presenting only the NRR-adjusted number without the flat baseline
  overstates confidence.
- **Physical product:** "Lifetime" is not a churn rate but a repeat-purchase pattern — compute
  `average order value × expected purchase frequency per year × expected years as an active
  customer (from reorder/repeat-purchase data or a category benchmark)`, net of COGS, fulfillment,
  payment processing, and a return-rate haircut if returns are material. A one-time-purchase
  product (no consumable/replacement cycle) has an LTV that is honestly just that one order's
  margin, plus any cross-sell — say so plainly rather than inventing a multi-year repeat pattern
  that doesn't exist for the category.
- **Marketplace:** LTV must be computed **per side** and the side being measured stated explicitly
  — a marketplace has no single "the customer." For the side being measured: `GMV per active
  participant per period × take rate × expected active lifetime on that side (from repeat-
  transaction/re-listing rate, not a subscription churn rate)`. Supply-side and demand-side LTV
  are often structurally different (e.g., a small number of high-volume sellers vs. many
  low-frequency buyers) — compute both if both sides generate take-rate revenue, and never blend
  them into one figure without saying so.
- **Services:** `Average contract/engagement value × expected number of renewals or follow-on
  engagements`, net of **delivery cost** (loaded labor cost to actually deliver the engagement,
  which is usually the dominant cost line here, unlike SaaS's hosting/support margin). Margins are
  frequently much thinner than SaaS gross margin once real delivery time is counted — do not
  default to a SaaS-typical 70-80% gross margin assumption without the founder confirming loaded
  delivery cost per engagement.
- **Consumer app:** Revenue per user is often not a single number — a freemium app has payers and
  non-payers, and non-payers may still generate ad revenue. Compute a **blended** LTV across the
  full user base (not just paying users): `(ad revenue per user + subscription/IAP revenue per
  paying user × payer conversion rate) × expected active lifetime`, where expected lifetime comes
  from an actual retention curve (D1/D7/D30/D90 retention feeding an estimated total session count
  or subscription months) rather than a flat churn percentage — consumer retention curves are
  famously non-linear (steep early drop-off, then a long flatter tail), and collapsing that into
  `1/churn` the way SaaS does will misstate the number materially.
- **Other:** Ask the founder which of the above lifetime/revenue models actually fits, or whether
  it's a genuine hybrid, rather than guessing (per `docs/UX-INTERVIEW-DESIGN.md` §4).

## When the founder doesn't know

Churn rate and gross margin are the two inputs founders most often don't have real data for pre-
launch. Do not silently plug in an optimistic industry-average number and present it as the
founder's number. Add a `key_assumptions` entry and carry the number forward clearly labeled as
an assumption:

```json
{ "id": "ka-017-churn", "statement": "No cohort data yet; LTV uses an assumed 5%/mo churn based on category benchmark, not founder data", "step_ref": "17_calculate_the_ltv_of_a_customer", "confidence": "low", "test_plan": "Recompute from actual cohort retention once 6 months of paying-customer data exists", "test_result": null }
```

## Quantitative claims (required)

The LTV figure itself, and each material input (ARPU, margin, churn/lifetime), needs a
`quantitative_claims` entry:

```json
{ "id": "qc-017-ltv", "claim": "Blended LTV per beachhead customer", "value": "$5,988", "step_ref": "17_calculate_the_ltv_of_a_customer", "source": "computed: $499/mo ARPU x 80% gross margin x 15-month expected lifetime (1/5% monthly churn, category benchmark, no cohort data yet — see ka-017-churn)", "confidence": "low", "ai_risk_flag": true }
```

Set `ai_risk_flag: true` whenever any input (especially churn or margin) is an assumed benchmark
rather than founder-measured data.

## Output file: `plan/17-calculate-the-ltv-of-a-customer.md`

```markdown
# Step 17: Calculate the LTV of a Customer

## Formula and inputs
ARPU: $X (from Step 16, tier: ...)
Gross margin: Y% (source: ...)
Expected lifetime: Z periods (source / churn assumption: ...)

## LTV calculation
LTV = $X × Y% × Z = **$LTV**
(per tier, if applicable, plus blended)

## Open assumptions
- ka-017-...: ...

## Note for Step 19
This LTV will be compared against COCA once Step 19 is drafted for the LTV:COCA sanity check —
no ratio is computed here.
```

## Mandatory AI-risk gate — before this step is reported done

This step is one of the five DE steps `skills/risk/ai-risk-review`'s own "Who must call this, and
when" table names explicitly. After writing `plan/17-calculate-the-ltv-of-a-customer.md` and
before setting `status: "drafted"`, invoke `skills/risk/ai-risk-review` against this step's plan
file (whole file, not a summary) plus the business-slug.

- **PASS** → proceed to write `business-state.json` below.
- **BLOCKED** → do not set `status: "drafted"`. Fix the finding and re-run the gate, or route to
  the orchestrator for an explicit founder override (per `agents/orchestrator.md` Non-negotiable
  #3) — this step does not accept an override itself.

## Update business-state.json

```json
"17_calculate_the_ltv_of_a_customer": {
  "status": "drafted",
  "summary": "<blended LTV figure and the confidence level of its inputs>",
  "file": "plan/17-calculate-the-ltv-of-a-customer.md"
}
```

Append `quantitative_claims` and `key_assumptions` entries; preserve all other keys.

## Done means

- `plan/17-calculate-the-ltv-of-a-customer.md` written with full derivation, not just a headline
  number.
- Every material figure has a `quantitative_claims` entry with a source — **specifically
  including the headline LTV figure itself**, not just its input assumptions. It is easy to log
  `key_assumptions` entries for churn/margin/lifetime inputs and forget the derived LTV result
  needs its own `quantitative_claims` entry too; before reporting `drafted`, re-read this file's
  "Quantitative claims" section and confirm the LTV figure has a JSON block under it, not just a
  heading.
- The mandatory AI-risk gate above returned PASS, or a BLOCKED finding was resolved/overridden.
- `business-state.json` key `17_calculate_the_ltv_of_a_customer` set to `status: "drafted"`;
  review/approval is a later council skill's job.
