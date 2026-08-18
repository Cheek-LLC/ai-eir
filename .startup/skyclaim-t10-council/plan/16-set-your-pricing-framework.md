# Step 16: Pricing Framework

## Pricing metric
Take rate: percentage of the job price retained by SkyClaim, deducted from the pilot's payout;
demand side pays the full stated job price with no separate marketplace fee shown.

## Value anchor (from Step 8)
Quantified value: demand-side value is directional/unquantified (capacity-unlock); supply-side
value is ≈$300-525/month incremental income at an assumed 4-6 jobs/month. Proposed take rate: 18%.
Capture ratio: not computable against demand-side value since that value was explicitly left
unquantified in Step 8 rather than forced into a number — stated honestly here rather than
backfilling a ratio that would rest on an invented dollar figure.

## Price point(s) / tiers
| Tier | Price | Who buys it | What's included | Differentiator |
|---|---|---|---|---|
| Standard per-property inspection | $175/property (demand pays), pilot receives $143.50 (82%), SkyClaim retains $31.50 (18%) | Any demand-side contractor | Aerial imagery + insurance-ready report | Matches Derek's existing, market-tested Osei Aerial rate |
| Surge/rush (same-day, storm-peak) | Not yet defined — flagged below | Contractors needing fastest possible turnaround during peak surge | — | Surge pricing could help balance thin supply during exactly the moments it's thinnest, but is untested and could also alienate early demand-side trust |

## Competitive anchor check
Derek's own $175/property rate has been market-tested for 3 years as a solo operator (a real,
if narrow, validation — stronger than most anchor points in this file). No direct competitor
pricing verified this session (see Step 11's flagged assumption on unverified competitor
positions) — the anchor is Derek's own operating history, not a competitor's published rate.

## Validation status
Tested with real prospects for the *marketplace* pricing specifically? No — the $175 anchor is
tested as Osei Aerial's direct-service price, not yet tested as a marketplace price where the
contractor knows a portion goes to SkyClaim rather than 100% to "the pilot who showed up." This
distinction is real and not yet addressed.

## Open assumptions
- `ka-016-take-rate-untested`: "The 18% take rate is anchored to the general 10-20% services-
  marketplace range cited in this step's own guidance, not tested with a real pilot or contractor
  reaction — pilots in particular have not been asked directly whether an 18% deduction from a
  familiar $175 rate feels fair." `step_ref`: `16_set_your_pricing_framework`, `confidence`: `low`,
  `test_plan`: "State the take rate explicitly to the next 5 supply-side conversations (Step 9
  prospects) and record reactions before treating 18% as final," `test_result`: `null`.
- `ka-016-surge-pricing-undefined`: "Surge/rush pricing is flagged as a real lever for the thin-
  supply problem but has no defined structure yet." `step_ref`: `16_set_your_pricing_framework`,
  `confidence`: `low`, `test_plan`: "Design and test a surge multiplier once enough real bookings
  exist to observe an actual supply crunch," `test_result`: `null`.

## Quantitative claims logged
```json
{ "id": "qc-016-price", "claim": "Beachhead per-property price and take rate", "value": "$175/property (demand pays); 18% take rate ($31.50 to SkyClaim, $143.50 to pilot)", "step_ref": "16_set_your_pricing_framework", "source": "price: Derek's own 3-year Osei Aerial invoiced average (founder's own operating history — stronger source than most figures in this plan); take rate: anchored to the 10-20% services-marketplace benchmark range cited in this step's own guidance, not independently verified or tested with real transactions", "confidence": "low", "ai_risk_flag": true }
```

## Mandatory AI-risk gate — before this step is reported done
Invoked `skills/risk/ai-risk-review` against this file plus the business-slug. **PASS** — the price
figure correctly distinguishes a real, historically-sourced input ($175) from an unvalidated one
(18% take rate), and the "Validation status" section explicitly names the gap between "tested as a
direct-service price" and "tested as a marketplace price" rather than conflating the two. No
blocking findings; no new `risk_log` entries this pass.
