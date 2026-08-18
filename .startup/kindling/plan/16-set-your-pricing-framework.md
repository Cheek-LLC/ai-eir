# Step 16: Pricing Framework

Business-type branching used: **Consumer app.** Asked directly about the annual-discount purpose,
the freemium conversion trigger, the untested payer-conversion-rate assumption, and the eCPM
sourcing for ad revenue — all four questions this branch specifically calls out.

## Pricing metric

Subscription tier: $6.99/month or $49.99/year (a ~40% discount vs. paying monthly for 12 months,
meant to pull undecided users toward annual commitment once they've decided to pay at all — not
yet tested for whether that discount size actually shifts behavior).

## Value anchor (from Step 8)

Quantified value is a behavioral proxy (streak-length multiplier), not a dollar figure — per this
step's own consumer-app guidance, willingness-to-pay must be signaled by conversion to a paid tier
rather than computed as a percentage of a dollar value. No willingness-to-pay signal exists yet
(no one has been asked to pay real money); this price is anchored to **comparable apps' pricing**
(Priya's own familiarity with what habit/creative apps in this range charge), explicitly labeled as
an anchor, not a tested figure.

## Price point(s) / tiers

| Tier | Price | Who buys it | What's included | Differentiator |
|---|---|---|---|---|
| Free | $0 (ad-supported) | Anyone | Sketching discipline only, basic streak tracking, circle formation | Full core mechanic, single discipline |
| Premium (monthly) | $6.99/mo | Users who convert without committing annually | All disciplines, no ads, premium challenges, 2 streak-freeze tokens/mo | — |
| Premium (annual) | $49.99/yr | Users confident enough to commit annually | Same as monthly | ~40% cheaper than 12x monthly |

## Competitive anchor check

Duolingo Plus and comparable habit-app subscriptions commonly run $4.99-$12.99/mo (founder's own
recollection, not independently verified this session). $6.99/mo sits mid-range. No specific
competitor price was independently confirmed via search.

## Validation status

**Tested with real prospects? No.** This is the single most consequential untested number in the
whole plan below the TAM figures — the entire subscription-revenue side of Step 17's LTV rests on
both this price point and the payer-conversion-rate assumption holding, and neither has been
checked against a single real prospect's actual reaction to a real price.

## Freemium conversion assumption (required by this step's consumer-app branch)

**Assumed freemium-to-paid conversion rate: 4%** — stated explicitly as an assumption, not
measured. This sits within the "commonly low single digits" range this branch names as typical,
chosen as a middle-of-that-range placeholder rather than an optimistic outlier, but it is still
entirely unvalidated and materially load-bearing (see Step 17/19).

## Ad revenue assumption (required by this step's consumer-app branch)

**Assumed eCPM-derived ad revenue: ~$0.60/free-user/year** (~$0.05/month) — a low placeholder
consistent with a niche hobbyist app with modest daily session volume (not a high-frequency,
high-impression app like a game). This is a founder/category-benchmark placeholder, not sourced
from a specific cited eCPM figure — no external search attempted this session.

## Quantitative claims logged

```json
{ "id": "qc-016-price", "claim": "Premium subscription price point", "value": "$6.99/month or $49.99/year", "step_ref": "16_set_your_pricing_framework", "source": "founder estimate, anchored to comparable habit-app pricing from memory; not yet tested with any real prospect", "confidence": "low", "ai_risk_flag": true }
```
```json
{ "id": "qc-016-conversion-assumption", "claim": "Freemium-to-paid conversion rate assumption", "value": "4%", "step_ref": "16_set_your_pricing_framework", "source": "founder placeholder, chosen from the 'commonly low single digits' industry-pattern range this step's own guidance names; not benchmarked to a specific cited source", "confidence": "low", "ai_risk_flag": true }
```
```json
{ "id": "qc-016-ecpm-assumption", "claim": "Free-tier ad revenue per user per year", "value": "~$0.60/year", "step_ref": "16_set_your_pricing_framework", "source": "founder/category-benchmark placeholder; no external search attempted this session", "confidence": "low", "ai_risk_flag": true }
```

## Open assumptions

- `ka-016-price-point` — statement: "The $6.99/mo / $49.99/yr price is untested with prospects,
  anchored only to comparable apps' pricing from the founder's memory." `step_ref:
  16_set_your_pricing_framework`, `confidence: low`, `test_plan: "state this real price in the App
  Store listing during the MVBP beta (Step 22) and observe actual conversion — this doubles as the
  MVBP's own core test"`, `test_result: null`.
- `ka-016-conversion-rate` — statement: "4% freemium-to-paid conversion is an unvalidated
  placeholder, materially load-bearing for Step 17's LTV and Step 4's realistic TAM figure."
  `step_ref: 16_set_your_pricing_framework`, `confidence: low`, `test_plan: "measure real
  conversion during the MVBP beta once at least 150 free installs have had 30+ days to convert or
  not"`, `test_result: null`.

## Mandatory AI-risk gate

Invoked `skills/risk/ai-risk-review` against this file plus `kindling` on completion. **Result:
PASS.** All three placeholder figures are honestly labeled as unvalidated founder/category
placeholders (not laundered as research), none carries false precision, and the "validation
status: no" section states plainly that this is untested. No blocking finding, and no advisory
finding either — a clean pass, stated explicitly (no `risk_log` entry written, consistent with the
analyst's own contract of only logging actual issues found).
