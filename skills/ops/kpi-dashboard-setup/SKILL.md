---
name: kpi-dashboard-setup
description: >
  Use once a business first reaches `stage: operating` (or is nearing launch and wants metrics
  ready in advance), and again any time the business model or pricing changes materially — a
  pivot, a new pricing tier, a switch from subscription to usage-based, etc. Triggers: "set up
  our KPI dashboard," "what should we even be tracking," "what metrics matter for us," "our
  metrics don't fit a generic SaaS dashboard," "step up our analytics." Reads the plan's actual
  business model (step 15) and pricing framework (step 16) — plus TAM (steps 4/14), LTV (step
  17), and COCA (step 19) for target bands — to derive a specific KPI set fit to *this*
  business's real revenue model, not an assumed generic SaaS metrics list. Produces
  `ops/kpi-dashboard.md`, the standing reference every other ops skill reads before asking the
  founder for numbers.
---

# KPI Dashboard Setup

## What this skill is

Most "startup metrics" advice defaults to SaaS metrics (MRR, churn, LTV:CAC) whether or not the
business is actually a SaaS. A marketplace, a physical-product DTC business, a services firm, and
a subscription app are not tracking the same things, and forcing one KPI template onto all of
them produces a dashboard that looks rigorous but asks the founder for numbers that don't mean
anything for how their business actually makes money. This skill classifies the business's real
model first, then builds the KPI set from that classification — never the reverse.

## Reads

- `.startup/<slug>/business-state.json` — `business_basics.business_type` and
  `business_type_notes` (the primary classification signal), `quantitative_claims` tagged
  step_ref 04, 14, 17, 19 (TAM, LTV, COCA — for target bands where a basis exists).
- `.startup/<slug>/plan/15-design-a-business-model.md` — required. The selected archetype(s)
  (subscription, usage-based, consumables, fee-for-service, licensing, freemium,
  advertising/marketplace take-rate, reseller/channel, franchise) and its rationale.
- `.startup/<slug>/plan/16-set-your-pricing-framework.md` — required. The actual pricing metric
  and price point(s)/tiers — this determines the *units* your KPIs are denominated in (per seat,
  per transaction, per GB, flat, % of value).
- `.startup/<slug>/ops/kpi-dashboard.md` if it already exists — you're revising it, not starting
  from nothing; preserve any KPI the founder has said is genuinely useful even if it's not in your
  default set for this archetype.

## Step 1: Classify the business, concretely

Combine `business_basics.business_type` with step 15's selected model to land on the actual
shape — a business can blend more than one (e.g. a marketplace with a subscription layer on top).
Do not stop at the coarse `business_type` category alone; step 15's archetype is what actually
determines the KPI list.

## Step 2: Build the KPI set from the matched archetype(s)

Use this table as the starting set, then narrow/extend it using the pricing metric from step 16
(e.g. if pricing is per-seat, MRR should be stated per-seat and blended; if tiered, track
mix-by-tier). Every KPI in the final dashboard must be something a founder can plausibly report
without instrumentation they don't have — flag any KPI that requires analytics/billing tooling
not yet wired up as "recommended, not yet trackable" rather than silently listing it as if data
exists for it.

| Archetype | Core KPI set |
|---|---|
| Subscription / SaaS (recurring, seat- or usage-based access) | MRR/ARR, net new MRR, expansion MRR, contraction MRR, logo churn %, revenue churn % / net revenue retention, trial→paid or signup→paid conversion %, activation rate, actual COCA (vs. step 19), LTV:COCA (vs. step 17/19) |
| Marketplace / two-sided (take rate on transactions between two sides) | Active supply-side participants, active demand-side participants, match/fill rate, GMV, take rate %, repeat-transaction rate (each side), supply:demand liquidity ratio |
| Transactional / e-commerce (one-time or infrequent purchase) | Units sold, average order value, gross margin %, repeat-purchase rate, contribution margin per order, actual COCA per order/customer |
| Usage-based / metered (pay per unit consumed) | Active usage volume, revenue per unit consumed, overage/upsell rate, usage-driven expansion revenue, actual COCA (vs. step 19) |
| Fee-for-service / project-based | Utilization rate (billable time / available time), realized project margin, pipeline coverage ratio, client renewal/repeat-engagement rate, referral rate |
| Licensing | Number of active licenses, license renewal rate, royalty/licensing revenue run-rate, sales-cycle length for new license deals (vs. step 18) |
| Freemium (free tier drives adoption, paid tier captures value) | Free signups, activation rate, free→paid conversion %, time-to-convert, paid-tier churn (once paid users exist, treat as subscription above for that layer) |
| Consumables / "razor and blades" | Core-unit sell-through, recurring-consumable repeat-purchase rate/frequency, consumable revenue per active core-unit owner |
| Reseller / channel | Channel partner count, sell-through rate per channel, channel-attributed revenue, partner-acquisition cost |
| Advertising / attention-based | Active users (DAU/MAU as relevant), engagement depth (time/sessions), ad revenue per active user or per impression, fill rate |
| Franchise (license the whole operating model) | Active franchise unit count, new-unit opening rate, franchise fee revenue (one-time), royalty revenue (% of unit sales, run-rate), average unit-level sales/profitability, same-unit sales growth, franchisee renewal/retention rate |

For every business, regardless of archetype, always include (these are universal, not
archetype-specific): actual COCA vs. plan (step 19), and — once retention data exists — actual
LTV vs. plan (step 17). These are what `operations-manager`'s drift comparison and
`scaling-strategist`'s readiness check both depend on; never drop them even for an archetype
where they're not the headline metric.

## Step 3: Set target bands only where a real basis exists

Where step 17/19 give a documented LTV or COCA figure, carry the reference band those steps
themselves used (e.g. the ~3:1 LTV:COCA band, stated there as a planning reference, not a
universal rule) into the dashboard as the comparison target. Do not invent an industry-benchmark
target for a KPI where no such figure exists in the plan or from the founder — leave the target
column blank and marked "no plan baseline yet" rather than filling it with a plausible-sounding
number.

## Output file: `ops/kpi-dashboard.md`

```markdown
# KPI Dashboard — <business name>

_Last revised: <date>. Revise this file (re-run this skill) whenever the business model or
pricing changes materially — do not let it go stale against plan/15-*/plan/16-*._

## Business model classification
Business type: <business_basics.business_type> | Step 15 archetype(s): <...> | Pricing metric
(step 16): <...>

## KPI set
| KPI | Definition / formula | Data source (who/what reports it) | Target / reference band | Currently trackable? |
|---|---|---|---|---|
| ... | ... | ... | ... (or "no plan baseline yet") | Yes / Recommended, not yet trackable |

## Universal (every business tracks these)
- Actual COCA vs. plan (step 19: $<plan figure>)
- Actual LTV vs. plan (step 17: $<plan figure>), once retention data exists

## Notes
<Anything blended/hybrid about the model, anything the founder specifically asked to track beyond
the default set, anything flagged as not-yet-trackable and what would need to change that.>
```

## Update `business-state.json`

This file is a standing reference, not a dated snapshot, so it is not itself added to
`ops.cadence_metrics_files` (that field is for periodic dated metrics files). No `business-state.json`
key changes are required beyond the normal `updated_at` bump if you also touch the file for any
other reason in the same session.

## Never fabricate

Do not invent a benchmark target, a "typical" conversion rate, or a plausible-sounding KPI value
to make the dashboard look complete. An honest, partially-filled dashboard with gaps marked is
more useful — and more truthful — than one that quietly launders assumed numbers into what looks
like measured reality.

## Done means

- The business's actual model (not a generic template) is named explicitly and the KPI set is
  visibly derived from it.
- Every KPI has a real data source (who reports it / what tool it comes from) or is marked
  not-yet-trackable.
- `ops/kpi-dashboard.md` is written (or revised in place) with a current revision date.
