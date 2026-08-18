# Step 16: Pricing Framework

## Pricing metric
Per-location, monthly (matches Step 15's selected model).

## Value anchor (from Step 8)
Quantified value: ~$6,000/year per location (unproven target) | Proposed price: $1,788/year
($149/month) per location | Capture ratio: ≈30%.

## Price point(s) / tiers
| Tier | Price | Who buys it | What's included | Differentiator |
|---|---|---|---|---|
| Standard | $149/location/month | Groups of 10-50 locations (beachhead) | Full Must-have feature set (Step 7) | — |
| Volume (11+ locations in one contract) | $129/location/month | Larger groups within the beachhead band | Same features, volume discount | Encourages full-group (not partial) adoption |

No free tier — Step 15 explicitly rejected freemium as mismatched to the DMU. A time-limited pilot
(see Step 13's `ka-013-pilot-needed`) is a sales-motion decision, not a permanent pricing tier, and
is not listed here as a price point.

## Competitive anchor check
7shifts and HotSchedules (the incumbent tools this beachhead already pays for) are estimated,
**unverified**, to run in a similar $2-4/location/month band for their base scheduling product
(per Maria's general recollection, not confirmed pricing pages) — ShiftCover's $149/location/month
is a materially higher price point for a narrower single-purpose tool, which is only defensible if
the quantified value (Step 8) genuinely holds up. This tension is stated plainly rather than
glossed over.

## Validation status
**Not tested with real prospects.** $149/location/month has not been stated out loud to any of the
Step 9 prospects yet — it is anchored only to the Step 8 value estimate and a rough, unverified
sense of incumbent pricing. See `ka-016-price-point` below.

## Open assumptions
```json
{ "id": "ka-016-price-point", "statement": "Proposed price of $149/location/month is untested with prospects; anchored only to Step 8's unproven value estimate and an unverified sense of incumbent (7shifts/HotSchedules) pricing.", "step_ref": "16_set_your_pricing_framework", "confidence": "low", "test_plan": "State this price in the next 5 real sales conversations (starting with Step 9's prospect #1, Alex Torres) and record reactions before treating it as final.", "test_result": null }
```

## Quantitative claims logged
```json
{ "id": "qc-016-price", "claim": "Beachhead price point", "value": "$149/month per location ($1,788/year); volume tier $129/month for 11+ locations", "step_ref": "16_set_your_pricing_framework", "source": "founder estimate, anchored to Step 8 quantified value (~$6,000/yr per location, itself unproven) at ~30% capture ratio; not yet tested with prospects", "confidence": "low", "ai_risk_flag": true }
```
