# Step 15: Design a Business Model

Business-type branching used: **Consumer app.** The branch's requirement to name the engagement
pattern before picking a model (not "which model would you prefer") was applied directly.

## Value capture logic (from Step 8)

Value metric: streak length / sustained active practice (a behavioral proxy, not a dollar figure).
Value quantified: ~3x longer active streak with circle accountability vs. solo (self-selected
pilot data, low confidence).

## Archetypes considered

| Archetype | Fits? | Why / why not | Effect on COCA | Effect on LTV | Operational requirement |
|---|---|---|---|---|---|
| Subscription | Yes — primary | Recurring value delivered daily; matches a "high-frequency utility the user depends on regularly" if the habit actually forms | Neutral | Direct driver — the whole payer-side LTV depends on this | Apple/Google in-app purchase billing (a real platform requirement, not optional) |
| Advertising | Yes — secondary, free tier only | Broad free-tier reach with daily sessions supports meaningful impression volume even at modest per-user value | Lowers effective COCA slightly by monetizing users who'd never pay | Adds a small, real revenue line on top of subscription (per Step 17's blended figure) | Ad SDK integration, ad-serving revenue share |
| In-app purchase (one-time unlock) | Considered, not selected — flagged as a real open alternative | Could replace the subscription for price-sensitive hobbyists who'd rather pay once per discipline than subscribe | Could lower COCA (lower price point, easier first "yes") | Materially lowers LTV per user if it replaces rather than supplements subscription | Simpler billing than subscription, but caps long-run revenue per user |
| Freemium hybrid (ads + subscription) | **Selected** | Matches the stated engagement pattern (occasional-to-daily, not yet proven high-frequency-dependency) — low-risk free entry point given the real risk (Step 6/13) that circle formation doesn't happen and engagement fades before any payment decision | Free tier lowers the bar to first use, which should lower effective COCA per install even though COCA per paying user stays the harder number (see Step 19) | Blended LTV depends on both ad and subscription lines — computed explicitly in Step 17, not assumed | Both ad SDK and platform billing required simultaneously |

## Selected model

**Freemium: ad-supported free tier (single discipline, banner + occasional interstitial) +
$6.99/mo or $49.99/yr subscription** (removes ads, unlocks all disciplines, unlocks premium
challenges, adds streak-freeze tokens). Rationale: the engagement pattern is genuinely unproven at
"high-frequency dependency" (the pilot showed real but modest daily engagement, not
Duolingo-level compulsive use), so a hard paywall before any free trial would likely kill the
top-of-funnel before the circle-formation mechanic even gets a chance to work — freemium lets the
product prove its differentiated value (Step 8) before asking for money.

The **one-time-IAP alternative was seriously considered and not resolved** — see the flagged
assumption below. This is named as a genuinely open question, not a settled decision, per this
step's own instruction not to present a chosen model as validated when buyer preference is
untested.

## Open assumptions

- `ka-015-model-fit` — statement: "Subscription (vs. a simpler one-time-purchase-per-discipline
  model) is unvalidated with real prospects — Priya chose it because 'that's what comparable apps
  do,' not because any pilot participant expressed a preference." `step_ref:
  15_design_a_business_model`, `confidence: low`, `test_plan: "ask the Step 9 prospects directly
  which pricing shape they'd actually prefer before finalizing Step 16's price point"`,
  `test_result: null`.

## Dependencies flagged for Step 22 (MVBP)

- Apple in-app purchase integration is a hard platform requirement, not a build choice — flagged
  explicitly for Step 22's scope.
- Ad SDK integration (for the free tier) is required even at MVBP scale if the free tier is to be
  tested as designed, not deferred to "later."
