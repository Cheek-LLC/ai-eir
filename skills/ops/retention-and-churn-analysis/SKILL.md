---
name: retention-and-churn-analysis
description: >
  Use at ops check-ins once the business has at least one paying customer or active-user cohort,
  or any time the founder mentions a customer leaving, a renewal, engagement drop-off, or asks
  "are we retaining people." Computes churn/retention from founder-provided customer counts, using
  the retention frame that actually fits this business's model (logo/revenue churn for
  subscription, repeat-transaction rate for marketplace/usage-based, repeat-purchase rate for
  one-time-purchase businesses — read from `ops/kpi-dashboard.md`), and — its core job — checks
  every churned customer against the step-3 end user profile and step-5 persona to determine
  whether churn is concentrated on-segment (a product-market-fit red flag) or off-segment (a GTM
  targeting issue). Produces `ops/<timestamp>-retention-metrics.md`. Never fabricates a churn
  reason or a segment-fit judgment the founder hasn't actually given.
---

# Retention and Churn Analysis

## What this skill is

A single blended churn percentage hides the question that actually matters for an early-stage
business: is the intended beachhead customer sticking, or is the business losing customers who
were never really the target in the first place? This skill always splits churn by segment fit
against the plan's own step-3/5 definition of the beachhead customer, not just reports a rate.

## Reads

- `.startup/<slug>/plan/03-build-an-end-user-profile.md` — required. The concrete attributes
  (role, context, need/trigger, behavior) defining the intended beachhead end user.
- `.startup/<slug>/plan/05-profile-the-persona-for-the-beachhead-market.md` — required. The named
  persona's fuller detail, useful when the profile alone is too abstract for a real comparison.
- `.startup/<slug>/ops/kpi-dashboard.md` if present — tells you which retention frame (logo
  churn, revenue churn/NRR, repeat-purchase rate) fits this business's model. If absent, fall back
  to `.startup/<slug>/plan/15-design-a-business-model.md` directly.
- The most recent prior `.startup/<slug>/ops/*-retention-metrics.md`, if one exists — for trend.

## Step 1: Determine the right retention frame, by business type

What "churn" even means is not the same question across business types — check
`business_basics.business_type` (falling back to `plan/15-design-a-business-model.md` if
`ops/kpi-dashboard.md` doesn't exist yet) before picking a frame:

- **`saas`**: subscription cancellation and downgrade. Logo churn rate (accounts that cancel
  outright), and — kept as a *separate* number, not blended into logo churn — revenue
  churn/downgrade rate if pricing varies materially by account and the founder tracks per-account
  revenue. A cancellation and a downgrade are different severities of the same underlying signal;
  report both.
- **`marketplace`**: supply-side churn and demand-side churn are different problems with different
  fixes, and must be computed and reported **separately** — never blended into one "marketplace
  churn" number. Supply-side churn = active sellers/providers who stop listing/transacting;
  demand-side churn = active buyers who stop transacting. A period where supply-side churn spikes
  while demand-side is stable (or vice versa) is a materially different finding than a single
  blended rate would show, and calls for a different fix (seller economics/support vs. buyer
  experience/pricing).
- **`physical_product`**: "churn" in the subscription sense doesn't apply — there's no
  subscription to cancel — so reframe the question entirely rather than forcing a churn-%
  headline. Track repeat-purchase rate (customers who purchase again within a defined window) and
  customer lifetime (average span between a customer's first and most recent purchase, or purchase
  frequency over a trailing period) instead. State the reframe explicitly in the output file.
- **`services`**: which frame applies depends on the engagement model, and a services business can
  have both — ask the founder which segment this covers, or split the analysis if it's genuinely
  both:
  - *Recurring engagements* (retainers, ongoing contracts): client retention/renewal rate — did
    the client renew or continue past the current term.
  - *One-off, project-based engagements*: renewal doesn't apply — there's no ongoing relationship
    to lose. Track project completion rate (delivered on time and in scope) and repeat-engagement
    rate (a past client returning for a new, separate project) instead; repeat-engagement is a
    different metric from renewal and shouldn't be reported as if it were the same thing.
- **`consumer_app`**: cohort retention curves, not a single blended churn %. Ask for retained-user
  counts at D1/D7/D30 for the most recent cohort(s) old enough to report each checkpoint — a
  cohort younger than 30 days can only report D1/D7 so far; mark D30 "not yet elapsed" rather than
  forcing a number that doesn't exist yet.
- **`other`**: ask the founder directly what "a customer leaving" or "losing engagement" actually
  means for this business before picking any frame above — don't default to subscription churn or
  repeat-purchase by assumption. Use whatever definition the founder gives, and record it
  explicitly in the output file so future periods reuse the same definition instead of
  re-litigating it each check-in.

## Step 2: Ask the founder for real numbers

- Customers/users at the start of this period.
- New customers/users added this period.
- Customers/users lost (churned / lapsed / non-repeat, per the frame above) this period.
- For each churned customer (or, above a handful, a representative sample the founder can speak
  to): did they match the step-3/5 beachhead profile — yes / no / unsure? Ask about the specific
  defining attributes (role, context, the need/trigger the profile names), not a vague "were they
  a good fit."
- Why they left, in the founder's own words or the customer's, if known (support tickets, exit
  conversation, direct feedback). If genuinely unknown, record **"unknown / not asked"** — this is
  itself a finding (a process gap worth naming), not something to infer.

Never guess a segment-fit judgment or a churn reason the founder hasn't actually given.

## Step 3: Compute the retention metric and the segment-fit split

- Compute the period's headline retention/churn number per the frame from Step 1.
- Compute the segment-fit split among this period's churned customers: fraction matching the
  beachhead profile ("on-segment") vs. meaningfully not ("off-segment") vs. "unsure."
- Read the split correctly, explicitly, and state which case applies:
  - **Churn concentrated off-segment**: reassuring about the beachhead thesis itself — flag as a
    GTM-targeting issue (marketing/sales pulling in the wrong customers), not a PMF alarm.
  - **Churn concentrated on-segment**: the urgent case — the intended beachhead itself isn't
    sticking, which questions the plan's core PMF thesis. Flag this more urgently and say so in
    those terms, don't let it read the same as the off-segment case.
  - State the actual off-segment fraction; ~30%+ is worth naming as material regardless of which
    direction the majority skews, since it changes what the founder should act on.

## Output file: `ops/<timestamp>-retention-metrics.md`

Timestamp format `YYYY-MM-DD`; append `-2`, `-3`... for a same-day rerun.

```markdown
# Retention Metrics — <business name> — <date>

## Retention frame used
<logo churn | revenue churn/downgrade | supply-side churn + demand-side churn (marketplace,
reported separately) | repeat-purchase rate + customer lifetime (physical_product) | client
renewal rate and/or project completion + repeat-engagement rate (services) | D1/D7/D30 cohort
retention (consumer_app) | founder-defined frame (other)>, because <business type and model
reason>.

## Founder-reported inputs
| Metric | Value | Source |
|---|---|---|
| Customers/users, start of period | ... | founder-reported <date> |
| New this period | ... | founder-reported <date> |
| Lost this period | ... | founder-reported <date> |

_For marketplace, repeat this table once for supply-side and once for demand-side rather than one
blended row. For services covering both recurring and one-off engagements, repeat it once per
segment. For consumer_app, replace this table with retained-user counts per cohort at D1/D7/D30._

## Headline retention metric
<Rate, with the formula shown.>

## Segment-fit split (churned this period)
| Segment fit | Count | % of churned |
|---|---|---|
| On-segment (matches step-3/5 profile) | ... | ...% |
| Off-segment | ... | ...% |
| Unsure / not assessed | ... | ...% |

**Read:** <"Churn concentrated on-segment — urgent PMF signal" | "Churn concentrated off-segment —
GTM-targeting issue, not a PMF alarm" | "Mixed / insufficient churned customers to read a
pattern">

## Churn reasons (where known)
<Founder/customer's own words, per churned customer or aggregated theme. "Unknown / not asked"
where genuinely not captured — named as a process gap, not glossed over.>

## Trend vs. prior period
<Retention metric and segment-fit split vs. last snapshot.>

## Flags
<Anything crossing the ~30% off-segment threshold, or any on-segment concentration, named
plainly for operations-manager's synthesis or logged directly if invoked standalone — see
agents/ops/customer-success-lead.md for the risk_log schema.>
```

## Update `business-state.json`

Append `ops/<timestamp>-retention-metrics.md` to `ops.cadence_metrics_files`. If a red flag was
found (on-segment concentration, or off-segment share ≥ ~30%) and this skill was invoked
standalone (not inside an `operations-manager`-coordinated check-in), append a `risk_log` entry
per the schema in `agents/ops/customer-success-lead.md` — read-modify-write the whole file,
preserve every other key.

## Never fabricate

Segment-fit judgments and churn reasons are the founder's actual answers this period, or
"unsure"/"unknown." Do not infer fit from a customer's name, company size guess, or general
impression — ask, or record that it wasn't assessed.

## Done means

- The right retention frame for this business's model was used, not a default assumed one.
- Every churned customer (or representative sample) has an explicit segment-fit judgment sourced
  from the founder, or "unsure."
- The on-segment-vs-off-segment read is stated explicitly, not left as a raw split for the reader
  to interpret.
- `ops/<timestamp>-retention-metrics.md` is written and registered in `business-state.json`.
