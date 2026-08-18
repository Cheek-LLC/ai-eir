# Step 18: Map the Sales Process to Acquire a Customer

> Extends Step 13's qualitative acquisition map with time, resource cost, and conversion data. See
> `plan/13-map-the-process-to-acquire-a-paying-customer.md` for the stage rationale; this file does
> not repeat that reasoning.

Business-type branching used: **Consumer app.** Correctly reframed this as "a pure
marketing/conversion funnel with no rep time at all," measured in days-from-install rather than a
sales-cycle-in-calendar-days framing — a real, useful reframe versus a generic enterprise-sale
template.

## Costed process map

| Stage (from Step 13) | Time in stage | Resources/cost consumed | Conversion to next stage | Source / assumption |
|---|---|---|---|---|
| 1. Discovery | N/A (marketing funnel, not calendar time) | Founder time: community seeding (Discord, Reddit, meetup mentions), ~10 hrs/week for 8 pre-launch weeks = 80 hrs total | ~55% of people who see a mention install (founder estimate from informal reactions during the pilot recruitment, not measured at scale) | `ka-018-discovery-conversion`, low confidence |
| 2. Install | Instant | App Store listing (no marginal cost) | ~70% of installs open the app and reach the first prompt (App Store install abandonment is real and typical) | Category placeholder, not measured |
| 3. First prompt (pre-signup) | Hours (same session, typically) | No marginal cost | ~55% complete and submit the first prompt (this is the step's own named highest-drop-off moment) | Category placeholder for creative/habit apps, not measured |
| 4. Circle formation | Days (typically within the first week if it happens at all) | No marginal cost beyond product engineering already built | ~35% of first-prompt completers actually form/join a circle (founder estimate — **the single least-grounded conversion rate in this whole funnel**, since the pilot never tested a cold in-app invite) | `ka-006-circle-join-rate`, low confidence |
| 5. Paid conversion | Weeks to months (typically after hitting the free-tier discipline limit or wanting to remove ads) | No marginal per-user cost | 4% of the full install base eventually converts (`qc-016-conversion-assumption`) | Category placeholder, unvalidated |

## Roll-up

- **Overall funnel conversion (install → paying user):** 0.70 (opens app) × 0.55 (completes first
  prompt) × ~1.0 (paid conversion is measured off the full install base per Step 16's assumption,
  not off circle-formers specifically — see note below) × 0.04 (pays) ≈ **~1.5% of installs
  eventually pay** — stated here for transparency in the funnel math, distinct from the flatter 4%
  figure Step 16 uses as its headline assumption. **This is a real internal inconsistency, flagged
  explicitly rather than silently smoothed over:** Step 16's 4% conversion assumption was stated as
  a flat percentage of installs without being derived from this funnel's own stage-by-stage
  conversion chain, which independently implies something closer to 1.5-2% once discovery→install
  friction and the two intermediate funnel stages are actually chained. Both numbers are carried
  forward (see `ka-018-conversion-inconsistency` below) rather than one silently overriding the
  other.
- **Total resource cost per closed customer, discrete stages only:** dominated by the 80 hours of
  pre-launch founder community-seeding time (see Step 19 for the loaded-cost buildup) — no paid
  acquisition spend budgeted at this stage.
- **No background-relationship-maintenance section** — this funnel is a discrete-stage
  marketing/conversion funnel per this step's own consumer-app guidance, not a referral-driven
  services relationship; that section is correctly omitted.

## Open assumptions

- `ka-018-discovery-conversion` — statement: "Discovery-to-install (~55%) and install-to-first-
  prompt (~70%) conversion rates are founder guesses calibrated loosely against the informal
  pilot's reactions, not measured at any real scale." `step_ref:
  18_map_the_sales_process_to_acquire_a_customer`, `confidence: low`, `test_plan: "instrument real
  funnel analytics from the first day of the MVBP beta"`, `test_result: null`.
- `ka-018-conversion-inconsistency` — statement: "Step 16's flat 4% install-to-paid assumption and
  this step's chained funnel math (which implies ~1.5-2%) disagree by roughly 2x; both are carried
  forward rather than silently reconciled, since resolving the disagreement requires real data
  neither step has." `step_ref: 18_map_the_sales_process_to_acquire_a_customer`, `confidence: low`,
  `test_plan: "resolve directly from MVBP beta funnel data; until then, Step 19's COCA-per-paying-
  user figure should be read as optimistic if the lower, chained-funnel conversion rate turns out
  to be the real one"`, `test_result: null`.
