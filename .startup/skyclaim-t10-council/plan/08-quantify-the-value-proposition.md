# Step 8: Quantified Value Proposition

Per the marketplace branching rule, each side is quantified separately below and never averaged
into one blended figure.

## Persona's top priority metric
Supply (Marcus): paid flight hours/month outside his core real-estate work. Demand (Ray): time to
document a roof inside the insurance claim window, and crew-hours not spent on ladders.

## As-is state
**Supply:** Marcus estimates he currently picks up roughly 2-3 informal overflow jobs per month
via word of mouth, worth ~$400-525/month, with real idle capacity beyond that. Source: founder-
reported, from Marcus's own conversation with Derek.
**Demand:** Ray's crew currently documents roughly 8 roofs/day per available drone-certified
estimator (himself, effectively, since he has only one) during a storm surge, creating a hard
ceiling — jobs beyond that queue or get ladder-inspected manually at roughly 2x the time per roof
and real fall-risk exposure. Source: founder-reported from Ray's own operating experience.

## Possible state with product
**Supply:** if SkyClaim delivers even 4-6 jobs/month to Marcus at $175/job, that's $700-1,050/month
in incremental income — roughly double his current informal volume.
**Demand:** with access to a pool of pilots instead of one, Ray's effective daily inspection
capacity during a surge could scale with however many pilots SkyClaim can actually put in the
field nearby — the ceiling shifts from "1 pilot" to "however many are available," which is exactly
the capacity problem the pivot exists to solve.

## Quantified value proposition
**Supply:** ≈$300-525/month incremental income for an active pilot like Marcus (possible minus
as-is), i.e., roughly doubling his current informal overflow income — not a life-changing sum, an
honest read given this is explicitly supplementary income, not a full-time livelihood pitch.
**Demand:** value is capacity-unlock, not time-savings-per-roof — the quantified benefit is "go
from a hard 1-pilot ceiling to an elastic pool," which doesn't reduce to a single clean dollar
figure without knowing how many jobs Ray would actually book beyond his current 1-pilot ceiling.
Directionally: each additional roof documented inside the claim window that would otherwise have
been ladder-inspected or missed is worth the full job value to Ray's business (a documented,
claim-eligible roof vs. one that misses the window entirely) — this is closer to "unlocks revenue
that otherwise wouldn't happen" than "saves cost on revenue that would happen anyway."

## Comparison to next best alternative / status quo
**Supply:** next best alternative for Marcus is doing nothing with his open Saturdays, or
continuing informal word-of-mouth gigs at the current ~2-3/month rate — SkyClaim's switching cost
is low (no exclusivity required, no upfront cost) but so is the current alternative's cost (free,
zero commitment), so the value has to show up in real job volume, not platform polish.
**Demand:** next best alternative for Ray is his current in-house-pilot bottleneck or manual
ladder inspection — genuinely painful during a surge, but "free" in the sense that it's already
sunk cost/habit; the switching cost is trust (will a marketplace pilot's work hold up with a
carrier the way Derek's personally-vetted work has for 3 years) more than money.

## Judgment: is the gap big enough?
**Supply: marginal-to-sufficient.** Doubling a supplementary-income pilot's overflow volume is
real but not overwhelming — retention risk is real if job volume doesn't stay consistent (ties to
Step 6's "renewal/disposal" drop-off risk during quiet stretches).
**Demand: potentially large, but unproven and highly variable** — depends entirely on how much
storm-surge business Ray is currently leaving on the table versus how much he's already
capturing with his single pilot. Flagged as unquantified pending real booking data, not
overstated as proven.

## Quantitative claims logged
```json
{ "id": "qc-08-supply-value", "claim": "Quantified incremental monthly income for an active supply-side pilot", "value": "≈$300-525/month (roughly doubling ~$400-525/month current informal overflow income)", "step_ref": "08_quantify_the_value_proposition", "source": "founder-reported estimate from Marcus Webb's own stated current job volume, extrapolated to a hypothesized 4-6 jobs/month via SkyClaim", "confidence": "low", "ai_risk_flag": true }
```
```json
{ "id": "qc-08-demand-capacity", "claim": "Current single-pilot inspection ceiling for a beachhead demand-side contractor", "value": "≈8 roofs/day per available drone-certified estimator during a storm surge", "step_ref": "08_quantify_the_value_proposition", "source": "founder-reported, Ray Delgado's own operating experience at Copperhead Roofing & Restoration", "confidence": "low", "ai_risk_flag": true }
```

## Assumptions flagged
- `ka-008-demand-value-unquantified`: "Demand-side value is described directionally
  ('capacity unlock') but not reduced to a single dollar figure, because the actual volume of
  currently-missed business is unknown — treating this as a real gap rather than forcing a number
  that would be invented." `step_ref`: `08_quantify_the_value_proposition`, `confidence`: `low`,
  `test_plan`: "Track actual booked-vs-turned-away job counts for Ray's business during the first
  real storm season on the MVBP (Step 22/23)," `test_result`: `null`.

*This is a planning aid, not financial, legal, or tax advice.*
