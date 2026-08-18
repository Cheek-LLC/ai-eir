---
name: 22-define-the-mvbp
description: >
  Use once Steps 15-21 (business model, pricing, LTV, sales process, COCA, assumptions) are
  drafted and the founder needs to define the smallest real offer that can close and deliver to
  one genuine paying customer. Triggers: "MVBP," "minimum viable business product," "what do we
  actually sell first," "smallest offer that works," "step 22." This is a *business* MVP — the
  minimum sellable, deliverable process/offer — not a software MVP or feature-trimmed product;
  do not conflate the two.
---

# Step 22: Define the Minimum Viable Business Product (MVBP)

## What this step is (and isn't)

The MVBP is **not** a stripped-down piece of software. It is the minimum integrated combination
of product, price, and process needed to run one real, complete transaction: get a real customer
to say yes, pay, and receive something that delivers on the value proposition — even if parts of
the delivery are manual, concierge, or unscalable behind the scenes. Aulet's framing: the MVBP
tests the single overarching assumption that integrates all the individual ones — that a real
customer will actually pay for this. A polished demo, a free pilot, or a feature-complete app
with no real payment attached does **not** satisfy this step. If the founder describes a "beta"
with no money changing hands, push back: that's product validation, not MVBP validation.

The MVBP explicitly combines outputs from every step in Theme 4 (Steps 14-19) — it is where the
business model, price, sales process, and cost economics stop being separate analyses and become
one thing a founder can actually go execute this week.

## Reads

- `.startup/<slug>/business-state.json` (whole file). Read `business_basics.business_type` — what
  "manual/concierge delivery" actually means differs sharply by type (see "Business-type MVBP
  shapes").
- `.startup/<slug>/plan/15-design-a-business-model.md` — required. Determines what "paying"
  looks like operationally (one-time invoice, first subscription charge, signed contract).
- `.startup/<slug>/plan/16-set-your-pricing-framework.md` — required. The MVBP must be sold at a
  real price from this framework, not "free to start."
- `.startup/<slug>/plan/18-map-the-sales-process-to-acquire-a-customer.md` — required. The MVBP's
  sales motion should follow this map, simplified to its essential stages only.
- `.startup/<slug>/plan/07-high-level-product-specification.md` if present — the full product
  spec the MVBP is a deliberate, temporary subset of.
- `.startup/<slug>/plan/21-test-key-assumptions.md` — required. The MVBP should be designed to
  test the highest-ranked still-open assumptions from Step 21, not arbitrary ones.

## Founder-facing deliverables

1. **The offer** — precisely what the customer gets, stated in plain terms a prospect would
   recognize (not an internal feature list). What's explicitly *excluded* from this version and
   why that's acceptable to a real customer at this price.
2. **The price** — the real number from Step 16 that will actually be charged; no "founding
   customer discount to zero."
3. **The delivery process** — how the product/service actually gets to the customer. Manual,
   concierge-style delivery (founder does part of the work by hand behind the scenes) is
   explicitly acceptable and often correct at this stage — state clearly what's automated vs.
   manual today, and what triggers automating each manual piece later (ties forward to Step 24).
4. **The sales motion** — the simplified version of Step 18's map used to actually close this
   first real deal.
5. **What this MVBP is designed to prove** — map explicitly to the top 1-3 open assumptions from
   Step 21 (e.g., "will the economic buyer approve this price without a discount," "will the end
   user actually complete onboarding without hand-holding").
6. **Definition of success** — the specific, falsifiable bar (e.g., "3 signed and paid customers
   at full list price within 6 weeks") that would count as the MVBP having done its job.

Ask the founder directly:
- "If you had to close one real, paying customer next week with what exists today, what would
  you actually sell them, and what would you do by hand to deliver it?"
- "What are you tempted to give away for free to make this easier, and why would that undermine
  what this step is supposed to prove?"

## Business-type MVBP shapes

"Manual behind the scenes" (deliverable 3) means something different by
`business_basics.business_type` — push for the concrete version, not a generic one:

- **SaaS:** The MVBP is often a concierge version of the software — a spreadsheet, a manual
  ops process, or the founder personally doing what the eventual product will automate — sold and
  invoiced as if the product already existed, at the real Step 16 price. The software isn't the
  MVBP; the whole transaction is.
- **Physical product:** Usually a small-batch or handmade run sold directly to a handful of real
  first customers before any manufacturing scale-up; the founder often fulfills and ships by hand.
  Resist the urge to wait for "production quality" before selling — that's over-building ahead of
  validation, exactly what this step exists to prevent.
- **Marketplace:** Almost always a concierge/hand-matched marketplace first — the founder manually
  sources and pairs supply and demand before any matching or discovery technology exists. Decide
  explicitly which side (supply or demand) gets sourced first and why that side is the harder
  liquidity problem.
- **Services:** The MVBP is usually close to the eventual delivery model already — a real client
  engagement, just narrower in scope or shorter in duration than the full offering. The "minimum"
  cut here is scope, not realism — don't let this collapse into a free diagnostic call.

## When the founder doesn't know

If the founder hasn't decided what's in/out of scope or is unsure the delivery process actually
works end to end, do not invent scope decisions to make the plan look complete. Add a
`key_assumptions` entry:

```json
{ "id": "ka-022-delivery", "statement": "Assumes manual onboarding (no self-serve) is acceptable to beachhead buyers at full price", "step_ref": "22_define_the_mvbp", "confidence": "low", "test_plan": "Directly observable outcome of the MVBP sales attempts themselves", "test_result": null }
```

This step does not itself produce quantitative claims beyond the price (already sourced in Step
16) — no new number-inventing risk here beyond reusing that entry.

## Output file: `plan/22-define-the-mvbp.md`

```markdown
# Step 22: Define the Minimum Viable Business Product (MVBP)

## The offer
What's included: ...
What's explicitly excluded (and why that's OK for now): ...

## Price
$... (from Step 16, qc-016-price)

## Delivery process
Automated today: ...
Manual/concierge today: ...
Automation trigger for each manual piece: ...

## Sales motion (simplified from Step 18)
...

## What this MVBP is designed to prove
1. ka-XXX-... (from Step 21)
2. ...

## Definition of success
...

## Open assumptions
- ka-022-...: ...
```

## Update business-state.json

```json
"22_define_the_mvbp": {
  "status": "drafted",
  "summary": "<one-sentence description of the MVBP offer, price, and what it's designed to prove>",
  "file": "plan/22-define-the-mvbp.md"
}
```

Append any new `key_assumptions` entries; preserve all other keys.

## Done means

- `plan/22-define-the-mvbp.md` written with a concrete, real-price, real-delivery offer — not a
  free trial or feature-trimmed software MVP.
- MVBP explicitly tied to the top open assumptions from Step 21.
- `business-state.json` key `22_define_the_mvbp` set to `status: "drafted"`; leave
  review/approval to the later council skill.
