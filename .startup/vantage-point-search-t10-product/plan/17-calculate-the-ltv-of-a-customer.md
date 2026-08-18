# Step 17: Calculate the LTV of a Customer

## Formula and inputs (services branching)

Per this step's services guidance: `Average contract/engagement value × expected number of
renewals or follow-on engagements`, net of **delivery cost** (loaded labor cost to actually
deliver the engagement — the dominant cost line here, unlike SaaS's hosting/support margin).
Explicitly not defaulting to a SaaS-typical 70-80% gross margin assumption without confirming
loaded delivery cost per engagement, per this step's own instruction.

- **Engagement value:** $70,500 average fee (`qc-016-price`).
- **Delivery cost:** ~90 hours of Jordan's own sourcing/screening/coordination/negotiation time
  per engagement (`ka-016-delivery-hours-estimate`, low confidence — not precisely time-tracked)
  × a $100/hr placeholder founder-time rate (same placeholder used in Step 19's COCA buildup, so
  the two figures are internally consistent) = **$9,000 delivery cost per engagement**.
- **Engagement margin (fee minus delivery cost):** $70,500 − $9,000 = **$61,500** (87.2% margin,
  net of delivery, before any COCA/BD cost is subtracted — COCA is a separate line, per Step 19,
  not double-counted here).
- **Expected renewals/follow-on engagements ("lifetime"):** of Jordan's 6 distinct closed clients
  over 14 months, 2 have generated a second signed engagement (one within the same 14-month
  window) — an observed **1.33 engagements per client relationship** (8 total signed engagements
  ÷ 6 distinct clients). This is a real, observed rate, not a projection, but it rests on a small
  sample (n=6 clients).

## Two figures, presented explicitly (per this step's SaaS-parallel practice for expansion-adjacent
figures)

- **Conservative, single-engagement LTV (no repeat assumption): $61,500.**
- **Repeat-adjusted headline LTV: $61,500 × 1.33 = $81,795 (~$81,800).**

The repeat-adjusted figure is presented as the headline in the assembled plan's unit-economics
section, with the conservative figure shown alongside it — not silently substituted — because the
1.33 repeat rate is real but thin (n=6), and Jordan has an unvalidated belief the *true* long-run
repeat rate is higher (portfolio companies that raise a later round often need more leadership
hires over a multi-year relationship) that is explicitly **not** folded into either figure above,
since it has no evidence behind it yet — see `ka-017-repeat-rate-optimism` below.

## What this LTV does NOT include, stated plainly

- **COCA/BD time** — kept separate per Step 19's own contract; this step's LTV is the value of
  the relationship net of delivery cost only.
- **Founder's own senior-delivery-time value beyond the $100/hr placeholder** — if Jordan's real
  market-rate time were costed at, say, $150-200/hr (closer to what a search-firm partner
  actually bills internally), the delivery cost and therefore the margin figure above would look
  materially different. This is exactly the `services-unit-economics-reviewer` persona's
  distinctive concern and is flagged here explicitly rather than left for that review to discover
  cold.

## Business-type note (marketplace's "N/A side" concept doesn't apply)

Unlike a marketplace, there is no second "side" with no representable LTV here — Vantage Point
Search has one paying customer type (the hiring company), so both figures above apply straight-
forwardly; no N/A treatment needed.

## Quantitative claims

```json
{ "id": "qc-017-ltv", "claim": "LTV per client relationship (repeat-adjusted headline figure)", "value": "$81,800 (conservative single-engagement figure: $61,500)", "step_ref": "17_calculate_the_ltv_of_a_customer", "source": "computed: $70,500 average engagement fee (qc-016-price) minus $9,000 delivery cost (90 hrs x $100/hr placeholder rate, see ka-019-founder-rate) x 1.33 observed repeat-engagements-per-client rate (8 signed engagements / 6 distinct clients over 14 months, small sample)", "confidence": "low", "ai_risk_flag": true }
```

## Open assumptions

```json
{ "id": "ka-017-repeat-rate-optimism", "statement": "Jordan believes the true long-run repeat-engagement rate is higher than the observed 1.33 (portfolio companies scaling often need more leadership hires over a multi-year relationship), but this belief is not reflected in the headline LTV figure above, which uses only the observed rate", "step_ref": "17_calculate_the_ltv_of_a_customer", "confidence": "low", "test_plan": "Recompute the repeat-rate input annually as more client history accumulates; do not raise the headline figure on belief alone", "test_result": null }
```

```json
{ "id": "ka-017-founder-delivery-rate", "statement": "Delivery cost is computed using the same $100/hr placeholder founder-time rate as Step 19's COCA buildup; this is an unvalidated placeholder, not a sourced market comp for a search-firm partner's actual billing rate", "step_ref": "17_calculate_the_ltv_of_a_customer", "confidence": "low", "test_plan": "Source a real comparable rate (e.g., what a contract technical recruiter or search-firm associate would bill per hour) to replace the placeholder", "test_result": null }
```

## Note for Step 19

This LTV will be compared against COCA once Step 19 is drafted for the LTV:COCA sanity check — no
ratio is computed here. Both the conservative ($61,500) and repeat-adjusted ($81,800) figures
should be carried into that comparison, not just the more flattering one.

## Mandatory AI-risk gate

Called. Result recorded in the AI-Risk Gate section of this report.

## Update business-state.json

```json
"17_calculate_the_ltv_of_a_customer": {
  "status": "drafted",
  "summary": "LTV $81,800 repeat-adjusted (conservative single-engagement: $61,500), net of a $9,000 delivery-cost estimate built on an untimed, placeholder-rate assumption; repeat rate is real but thin (n=6 clients)",
  "file": "plan/17-calculate-the-ltv-of-a-customer.md"
}
```
