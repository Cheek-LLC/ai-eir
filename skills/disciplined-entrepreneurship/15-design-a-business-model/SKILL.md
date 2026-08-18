---
name: 15-design-a-business-model
description: >
  Use once the value proposition (Step 8) and core (Step 10) are drafted and the founder needs
  to decide *how* the business captures value — not just what it sells. Triggers: "business
  model," "how do we make money," "revenue model," "subscription vs one-time," "monetization
  model," "step 15." Produces a selected business-model archetype (or hybrid) with an explicit
  rationale tied to the value proposition, customer buying behavior, and its expected effect on
  COCA and LTV — distinct from Step 16 (the actual price points) which comes next.
---

# Step 15: Design a Business Model

## What this step is

The business model is the mechanism for capturing part of the value created (quantified in
Step 8) — it answers "what do we charge for and how does money change hands," not "what's the
exact price" (that's Step 16) and not "what's the LTV/COCA math" (Steps 17-19, which depend on
the choice made here). A wisely chosen model can lower COCA, raise LTV, and create a durable
edge; a poorly chosen one fights the customer's natural buying behavior no matter how good the
product is.

## Reads

- `.startup/<slug>/business-state.json` (whole file). Read `business_basics.business_type`
  before running the archetype checklist below — it should sharply narrow which archetypes are
  even plausible starting points (see "Business-type starting points").
- `.startup/<slug>/plan/08-quantify-the-value-proposition.md` — required. The value metric
  identified there (cost saved, revenue generated, time saved, risk reduced) should drive which
  business model captures it most naturally.
- `.startup/<slug>/plan/10-define-your-core.md` — required. A core built on network effects,
  data, or platform lock-in favors different models (e.g., usage-based, marketplace take-rate)
  than a core built on proprietary IP (favors licensing) or brand (favors premium retail).
- `.startup/<slug>/plan/06-full-life-cycle-use-case.md` if present — how the customer actually
  uses the product day-to-day affects whether usage-based, seat-based, or flat pricing fits.
- `.startup/<slug>/plan/11-chart-your-competitive-position.md` if present — incumbents' business
  models set customer expectations; deviating from them is a real choice, not a default.

## Founder-facing deliverables

Walk through the common business-model archetypes as a checklist and require the founder to
explicitly rule in/out each one, not just default to whatever's trendy:

- **Subscription** (recurring fee for ongoing access) — fits when value is delivered continuously.
- **Usage-based / metered** (pay per unit of consumption) — fits when value scales with usage and
  usage is easy to measure and predict for the customer.
- **Consumables / "razor and blades"** (low-cost or free core, recurring paid consumable) — fits
  physical or platform products with a genuine recurring consumable.
- **Fee-for-service / project-based** (one-time or milestone-based service fee) — fits
  high-touch, customized delivery, especially early on before a repeatable product exists.
- **Licensing** (fee for rights to use IP/technology) — fits when the core is defensible IP and
  the founder doesn't want to own manufacturing/distribution/support.
- **Freemium / "give-to-get"** (free tier drives adoption, paid tier captures value) — fits
  products with strong self-serve virality and a clear upgrade trigger.
- **Advertising / marketplace take-rate** (a third party pays for access to your users, or you
  take a cut of transactions) — fits high-engagement or two-sided markets, not most B2B tools.
- **Reseller / channel** (sell through a distributor who marks up) — fits when direct
  distribution is prohibitively expensive relative to deal size.
- **Franchise** (license the whole operating model) — fits highly replicable local-service
  businesses.

For each candidate the founder considers seriously, require:
1. Why it fits (or a hybrid combining two — common and often correct).
2. How it aligns incentives with the customer (does the customer pay more exactly when they get
   more value, or is there a mismatch that will cause churn/resentment?).
3. Its expected directional effect on COCA and LTV (e.g., "usage-based lowers the barrier to
   first sale, which should lower COCA, but makes early revenue less predictable").
4. What it requires operationally (billing infrastructure, usage metering, sales-assisted
   checkout vs. self-serve) — flag anything not yet built as a dependency for Step 22 (MVBP).

Ask explicitly: "How do comparable products in this market typically get paid, and is there a
real reason to differ from that norm?"

## Business-type starting points

Don't run the checklist blind — `business_basics.business_type` should narrow the live
candidates before the founder rules anything in or out:

- **SaaS:** Subscription (flat or usage-based) is the default starting hypothesis; freemium is a
  real contender only with genuine self-serve virality. Ask which of seat-based, usage-based, or
  flat-tier actually tracks how the customer perceives value growing.
- **Physical product:** Consumables/"razor and blades" is worth ruling in/out explicitly if there's
  any recurring-use component; otherwise it's one-time-sale-plus-accessories. The real question is
  channel: DTC-only, wholesale/reseller, or both — each implies a different margin structure and
  a different archetype from the list above.
- **Marketplace:** Advertising/take-rate is the near-default, but *which side pays* is the actual
  decision — supply-side fee, demand-side fee, or a cut of the transaction — and it's rarely
  symmetric. State explicitly which side is price-sensitive enough that charging them would kill
  liquidity, and price the other side instead. The business model here is structurally GMV-based,
  not seat- or unit-based: value capture is `GMV × take rate`, so the model conversation must
  cover both the take-rate mechanism *and* what drives GMV (transaction frequency and value on the
  reused side). Consider explicitly whether a hybrid is warranted once volume exists — a pure
  take-rate model often needs a flat subscription/listing fee layered in for high-volume sellers
  once they'd rather pay flat than a percentage (the Etsy/Airbnb Plus pattern) — and whether a
  two-sided or one-sided fee structure best protects the harder-to-source side from churning off
  the marketplace to transact directly (disintermediation risk is a real threat to this archetype
  specifically and should be named, not assumed away).
- **Services:** Fee-for-service/project-based is the honest starting point pre-productization.
  Ask what would have to be standardized before a subscription/retainer model becomes credible
  rather than defaulting to it aspirationally. Because the "unit" being sold is founder/team time,
  the business model choice here is inseparable from a delivery-capacity question that SaaS and
  marketplace models don't have: does this model let revenue grow without linearly adding
  headcount (a tiered/productized retainer with a capped scope, or IP/template reuse across
  clients), or does every dollar of revenue require a proportional dollar of delivery cost (pure
  hourly/project billing)? A model that can't answer that question is choosing "won't scale" by
  default, not by decision — surface that trade-off explicitly rather than letting fee-for-service
  stand unexamined as the permanent answer.
- **Consumer app:** The live candidates are usually subscription, advertising, in-app purchase
  (IAP), or a freemium hybrid of these — and which one fits depends on engagement pattern more
  than product category. A high-frequency utility the user depends on regularly supports
  subscription; broad reach with high session volume but lower per-user intent supports
  advertising; occasional or impulse-driven engagement supports one-time or consumable IAP.
  Require the founder to state which engagement pattern actually describes their product (not
  which monetization model they'd prefer) before selecting the archetype. Flag explicitly whether
  the model requires app-store platform billing (with the associated ~15-30% platform fee, a real
  cost to the business model, not just a technical detail) or supports direct/web billing instead.

When `business_type` is `other` or a genuine hybrid, ask the founder which of the above framings
fits best rather than guessing (per `docs/UX-INTERVIEW-DESIGN.md` §4) — and if the hybrid spans two
of the listed types (e.g., a marketplace with a services layer, or a consumer app with a B2B
services upsell), require the founder to state which side is primary for value-capture purposes so
the model conversation doesn't default to whichever archetype is easiest to describe.

## When the founder doesn't know

Choosing a business model without customer input is a real risk, not a research task to
outsource entirely to AI judgment. If the founder hasn't validated how the beachhead persona
prefers to buy, add a `key_assumptions` entry:

```json
{ "id": "ka-015-model-fit", "statement": "Assumes beachhead buyers prefer monthly subscription over annual contract", "step_ref": "15_design_a_business_model", "confidence": "low", "test_plan": "Ask next 5 sales conversations for stated preference and reasoning", "test_result": null }
```

Do not present a chosen model as validated fact if it rests on an unvalidated guess about buyer
preference — flag it plainly in the plan file.

## Output file: `plan/15-design-a-business-model.md`

```markdown
# Step 15: Design a Business Model

## Value capture logic (from Step 8)
Value metric: ... | Value quantified: ...

## Archetypes considered
| Archetype | Fits? | Why / why not | Effect on COCA | Effect on LTV | Operational requirement |
|---|---|---|---|---|---|
| Subscription | ... | ... | ... | ... | ... |
| ... | | | | | |

## Selected model
<Archetype or hybrid, with the decisive rationale>

## Open assumptions
- ka-015-...: ...

## Dependencies flagged for Step 22 (MVBP)
- ...
```

## Update business-state.json

```json
"15_design_a_business_model": {
  "status": "drafted",
  "summary": "<the selected model and the one-sentence reason it fits>",
  "file": "plan/15-design-a-business-model.md"
}
```

Append any `key_assumptions` entries; preserve all other keys.

## Done means

- `plan/15-design-a-business-model.md` written with a clearly selected model and rejected
  alternatives explained.
- `business-state.json` key `15_design_a_business_model` set to `status: "drafted"`. Review is a
  later council skill's job — stop at `drafted`.
