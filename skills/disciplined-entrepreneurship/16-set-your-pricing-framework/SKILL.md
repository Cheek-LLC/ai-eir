---
name: 16-set-your-pricing-framework
description: >
  Use once the business model (Step 15) is drafted and the founder needs actual price points,
  not just the monetization mechanism. Triggers: "how much should we charge," "pricing," "price
  point," "pricing tiers," "what's our price," "willingness to pay," "step 16." Produces a
  value-based pricing framework — pricing metric, tier structure, and specific price point(s) —
  anchored to the quantified value proposition (Step 8) and competitive position (Step 11), not
  cost-plus guessing.
---

# Step 16: Set Your Pricing Framework

## What this step is

Step 15 chose the *mechanism* (subscription, usage-based, etc.); this step sets the *number(s)*.
Aulet's guidance: price should be anchored to the value delivered to the customer (quantified in
Step 8), not to your costs and not purely to competitors. A common rule of thumb is that the
price should let the customer capture the majority of the value created while still being high
enough to fund the business — many B2B tools price in the range of 10-30% of the quantified
value delivered, but the right number is market- and category-specific and must be stated as a
reasoned choice, not asserted as a universal rule.

## Reads

- `.startup/<slug>/business-state.json` (whole file). Read `business_basics.business_type` before
  asking the pricing questions below — see "Business-type starting points."
- `.startup/<slug>/plan/08-quantify-the-value-proposition.md` — required. The quantified value
  (e.g., "$50k/year saved") is the ceiling and the anchor for the pricing conversation.
- `.startup/<slug>/plan/15-design-a-business-model.md` — required. Determines the pricing metric
  (per seat, per unit consumed, flat fee, % of transaction).
- `.startup/<slug>/plan/11-chart-your-competitive-position.md` if present — competitor price
  points set customer reference anchors even under value-based pricing.
- `.startup/<slug>/plan/05-profile-the-persona-for-the-beachhead-market.md` if present — the
  persona's budget authority and existing spend category affect what price triggers what level
  of approval friction (feeds back into Step 13/18's DMU process).

## Founder-facing deliverables

1. **Pricing metric** — the unit the customer is charged against (per seat, per transaction, per
   GB, flat monthly, % of value delivered). Must match the model selected in Step 15.
2. **Value-to-price ratio** — quantified value from Step 8 divided into the proposed price;
   state the ratio explicitly and justify it (why this ratio and not a higher/lower one).
3. **Price point(s) or tiers** — specific numbers, not ranges pretending to be numbers. If
   tiered, name each tier, what differentiates it, and which persona buys it.
4. **Anchor check** — how this compares to the closest competitive alternative's price (from
   Step 11) and to the "do nothing" cost the customer currently bears.
5. **Sensitivity read** — has this been tested with real prospects (a stated price in a sales
   conversation, a Van Westendorp-style price-sensitivity question, or a landing-page test)? If
   not yet, say so plainly rather than presenting price as validated.

Ask the founder directly:
- "What's the highest price you've actually said out loud to a real prospect, and what did they
  say?"
- "If we doubled the price tomorrow, who would still buy, and who would walk?"
- "Is there a natural tier boundary in how differently small vs. large customers get value?"

## Business-type starting points

The pricing metric question (deliverable 1) has a genuinely different shape by business type —
ask the version below, not a generic one:

- **SaaS:** Is it seat-based, usage-based, flat-tier, or hybrid? Is there a free tier or trial,
  and what specifically is it meant to prove before the customer converts? How does price scale
  as the customer grows — this expansion-revenue question is a direct input to Step 17's LTV.
- **Physical product:** Walk the full markup chain explicitly — unit COGS, wholesale price if
  selling through retail, retail markup, and what margin survives at each stage — and how DTC
  pricing compares to any wholesale channel price. A single "the price" answer that ignores
  channel is incomplete here.
- **Marketplace:** The "price" is a take rate (% of transaction value) or a flat listing/
  subscription fee on one or both sides — ask which, and whether the rate is actually viable
  given what each side would tolerate before liquidity breaks down. Ask specifically what take
  rate comparable marketplaces in this category charge (10-20% is common for services/goods
  marketplaces, lower for high-value/low-frequency categories like real estate or freight) and
  whether this marketplace's rate needs to start lower to bootstrap liquidity before rising once
  the network effect makes switching costly for participants.
- **Services:** Ask whether pricing is hourly, per-project/milestone, or retainer-based, and what
  determines which engagements get quoted which way — the "unit" being priced is the harder
  question here than the number itself. Ask explicitly what the effective hourly/day rate works
  out to once scope creep and non-billable delivery time (revisions, project management, client
  communication) are accounted for — a headline project price that looks healthy can hide an
  effective rate well below what the founder intended, and this is the number Step 19's COCA and
  the delivery-capacity question actually depend on.
- **Consumer app:** Ask whether the price point is a subscription tier (monthly/annual, and what
  the annual discount is meant to do to retention), a one-time purchase, or IAP priced at
  psychological price-point anchors (e.g., $0.99/$4.99/$9.99) — and if freemium, what specific
  paid-tier feature or limit is meant to trigger conversion, and at roughly what conversion rate
  from free to paid the model needs to work (state it as an assumption if untested, since
  freemium-to-paid conversion rates are commonly in the low single digits and an unstated
  optimistic assumption here quietly breaks the whole model). If ad-supported, ask what eCPM
  assumption is being used and whether it's sourced from a comparable app's reported figures or
  invented.
- **Other:** Ask the founder which of the above pricing shapes fits best, or whether it's a
  genuine hybrid, rather than guessing (per `docs/UX-INTERVIEW-DESIGN.md` §4).

## When the founder doesn't know

Pricing is one of the highest-stakes numbers in the whole plan and the easiest for an AI to
invent a plausible-sounding figure for. Never assert a specific price point as validated when it
hasn't been tested with a real prospect. Add a `key_assumptions` entry instead:

```json
{ "id": "ka-016-price-point", "statement": "Proposed price of $499/mo is untested with prospects; anchored only to competitor pricing", "step_ref": "16_set_your_pricing_framework", "confidence": "low", "test_plan": "State this price in the next 5 sales conversations and record reactions before treating it as final", "test_result": null }
```

## Quantitative claims (required)

Every price point and every value-to-price ratio presented as fact needs a
`quantitative_claims` entry:

```json
{ "id": "qc-016-price", "claim": "Beachhead price point", "value": "$499/month per seat", "step_ref": "16_set_your_pricing_framework", "source": "founder estimate, anchored to Step 8 quantified value ($4,200/mo saved) at ~12% capture ratio; not yet tested with prospects", "confidence": "low", "ai_risk_flag": true }
```

## Output file: `plan/16-set-your-pricing-framework.md`

```markdown
# Step 16: Pricing Framework

## Pricing metric
...

## Value anchor (from Step 8)
Quantified value: $X | Proposed price: $Y | Capture ratio: Z%

## Price point(s) / tiers
| Tier | Price | Who buys it | What's included | Differentiator |
|---|---|---|---|---|

## Competitive anchor check
...

## Validation status
Tested with real prospects? Y/N — details, or see ka-016-...

## Open assumptions
- ka-016-...: ...
```

## Mandatory AI-risk gate — before this step is reported done

This step is one of the five DE steps `skills/risk/ai-risk-review`'s own "Who must call this, and
when" table names explicitly. After writing `plan/16-set-your-pricing-framework.md` and before
setting `status: "drafted"`, invoke `skills/risk/ai-risk-review` against this step's plan file
(whole file, not a summary) plus the business-slug.

- **PASS** → proceed to write `business-state.json` below.
- **BLOCKED** → do not set `status: "drafted"`. Fix the finding and re-run the gate, or route to
  the orchestrator for an explicit founder override (per `agents/orchestrator.md` Non-negotiable
  #3) — this step does not accept an override itself.

## Update business-state.json

```json
"16_set_your_pricing_framework": {
  "status": "drafted",
  "summary": "<pricing metric and headline price point(s)>",
  "file": "plan/16-set-your-pricing-framework.md"
}
```

Append `quantitative_claims` and `key_assumptions` entries; preserve all other keys.

## Done means

- `plan/16-set-your-pricing-framework.md` written with specific price points, not vague ranges.
- Every price figure has a `quantitative_claims` entry with a source — before reporting
  `drafted`, re-read this file's own claims section and confirm every stated price has a matching
  entry.
- **State the final headline figure to no more precision than your weakest chained input
  supports — round explicitly before writing it, not after the AI-risk gate catches it.** Four
  consecutive rounds of live dry runs have hit false-precision BLOCKED findings at exactly this
  cluster of steps (04/14/16/17/19) — check yours before you finish.
- The mandatory AI-risk gate above returned PASS, or a BLOCKED finding was resolved/overridden.
- `business-state.json` key `16_set_your_pricing_framework` set to `status: "drafted"`; leave
  review/approval to the later council skill.
