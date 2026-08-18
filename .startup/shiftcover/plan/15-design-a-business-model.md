# Step 15: Design a Business Model

## Value capture logic (from Step 8)
Value metric: manager time reclaimed + reduced late-opening risk | Value quantified: ~$6,000/year
per location (unproven target, `ka-008-target-unproven`).

## Archetypes considered
| Archetype | Fits? | Why / why not | Effect on COCA | Effect on LTV | Operational requirement |
|---|---|---|---|---|---|
| Subscription (per-location, monthly) | Yes | Value is delivered continuously (every call-out, ongoing), matches how the buyer already thinks about SaaS spend (7shifts/HotSchedules are also subscriptions) | Neutral — standard SaaS sales motion | Standard recurring-revenue LTV model (Step 17) | Billing infra (Stripe-equivalent), no major build |
| Usage-based (per broadcast sent) | Considered, rejected | Would undercharge in a low-call-out-frequency month and overcharge in a high one — actively fights the buyer's preference for predictable ops-tech spend | Could lower initial barrier to trial | Unpredictable, harder to project | Metering infrastructure not otherwise needed |
| Freemium (free for 1 location, paid for 2+) | Considered as an onboarding wedge, not the core model | Could help a single GM try it before the Director of Ops commits group-wide, but doesn't map to how this DMU actually buys (Director of Ops decides for the whole group, not GM-led bottom-up adoption per Step 12) | Could lower COCA for initial trial | N/A for free tier | Would require self-serve signup flow not otherwise prioritized in Step 7 |
| Fee-for-service / project-based | Rejected | Wrong shape — this is not a custom engagement, it's a repeatable product | N/A | N/A | N/A |
| Marketplace take-rate (charge backup workers or take a cut of shift value) | Rejected | Backup workers are already employees of the franchise group being paid their normal wage for the shift — inserting a take-rate here misaligns incentives and likely violates wage-and-hour norms the founder is not positioned to evaluate | N/A | N/A | Flagged as a legal/compliance question outside this step's scope, not just a product decision |

## Selected model
**Per-location monthly subscription**, sold at the franchise-group level (one contract, priced by
location count) via the Director of Ops. Decisive rationale: matches the buyer's existing mental
model (they already pay 7shifts/HotSchedules per-location), avoids the DMU mismatch of a
freemium/bottom-up model in a top-down-buyer DMU (Step 12), and gives predictable revenue that
scales cleanly with the beachhead TAM's counting unit (Step 4).

## Open assumptions
- `ka-015-model-fit` (below): pricing tier/discount structure for larger groups is not yet
  validated with a real buyer.

```json
{ "id": "ka-015-model-fit", "statement": "Assumes Directors of Operations prefer per-location monthly subscription pricing over a single flat group-wide fee — not yet validated with a real prospect conversation.", "step_ref": "15_design_a_business_model", "confidence": "low", "test_plan": "Ask directly in the first 5 real sales conversations (starting with Step 9's prospect #1) whether per-location pricing feels fair vs. a flat group fee.", "test_result": null }
```

## Dependencies flagged for Step 22 (MVBP)
- Billing infrastructure (recurring per-location subscription billing) is a real build dependency
  not yet scoped anywhere in Step 7's product spec — flagged here for Step 22 to account for.
