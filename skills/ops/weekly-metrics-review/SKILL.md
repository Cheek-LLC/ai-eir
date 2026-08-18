---
name: weekly-metrics-review
description: >
  Use for a recurring (weekly/biweekly/monthly, per `cadence.check_in_frequency`) review of
  top-of-funnel and acquisition metrics on an operating business, when the founder asks "how are
  we doing on growth," "what's our funnel look like this period," or when `growth-analyst`/
  `operations-manager` needs a fresh actuals snapshot for a check-in. Requires
  `ops/kpi-dashboard.md` to already exist (run `skills/ops/kpi-dashboard-setup` first if it
  doesn't) — asks the founder for real period actuals against that dashboard's KPI set, computes
  derived metrics and period-over-period deltas, and states an explicit comparison of actual
  COCA against the plan's step-19 figure. Produces `ops/<timestamp>-growth-metrics.md`. Never
  fills in a metric the founder hasn't reported.
---

# Weekly Metrics Review

## What this skill is

The recurring pulse-check on acquisition: what actually happened this period, reported by the
founder, checked against the dashboard set up in `kpi-dashboard-setup` and against the plan's own
COCA assumption. "Weekly" names the default cadence this skill is usually invoked at; it runs on
whatever `cadence.check_in_frequency` the founder actually chose, not literally every week
regardless of that setting.

## Reads

- `.startup/<slug>/ops/kpi-dashboard.md` — required. If missing, stop here and report back that
  `kpi-dashboard-setup` needs to run first; do not improvise a generic KPI list to fill the gap.
- `.startup/<slug>/business-state.json` — `quantitative_claims` tagged step_ref 19 (COCA) for the
  plan-comparison figure, `cadence` for the period this review covers, and `business_basics.
  business_type` (plus `business_type_notes`) — read before Step 1 to determine which type-specific
  metrics to ask about in addition to the acquisition/COCA questions below.
- `.startup/<slug>/plan/19-calculate-the-coca.md` — the plan's own COCA derivation, so the
  comparison cites method, not just the headline number.
- The most recent prior `.startup/<slug>/ops/*-growth-metrics.md`, if one exists — for
  period-over-period deltas.

## Business-type dispatch: what "the metrics that matter this week" actually means

Acquisition/COCA (Step 1 below) matters for every business, but a founder checking in on "how are
we doing this week" is also thinking about type-specific numbers acquisition alone doesn't
capture. Check `business_basics.business_type` and ask for these too, this period, alongside
Step 1's questions — mark "not tracked" per the same discipline if the founder doesn't have a
number, never estimate one:

- **`saas`**: new MRR added this period, churned/contracted MRR this period (cancellations and
  downgrades — keep these two apart, don't blend them into one "churn" line), and activation rate
  (new signups this period who reached the product's defined activation event, ÷ new signups this
  period).
- **`marketplace`**: GMV this period, take-rate revenue (GMV × take rate), and growth on **both
  sides tracked separately** — new/active supply-side participants and new/active demand-side
  participants as two distinct numbers, never blended into one "users" figure. This is the same
  supply/demand-separation convention used elsewhere in this plugin's marketplace guidance (see
  `skills/ops/kpi-dashboard-setup`'s marketplace archetype row and the DE step-01/02/03/04
  branching in `docs/UX-INTERVIEW-DESIGN.md` §4). A period where supply grew and demand didn't (or
  vice versa) is a materially different finding than "users grew 12%" would suggest.
- **`physical_product`**: units sold this period, sell-through rate (units sold ÷ units
  available/stocked this period), and inventory turns (COGS this period ÷ average inventory
  value). If the founder doesn't track average inventory value precisely, mark inventory turns
  "recommended, not yet trackable" rather than approximating an average.
- **`services`**: billable utilization (billable hours delivered ÷ available capacity hours this
  period), pipeline value (open, not-yet-closed opportunity value currently being worked), and
  project/engagement completion rate (engagements completed on time and in scope this period ÷
  engagements scheduled to complete this period).
- **`consumer_app`**: DAU/MAU this period (and the DAU:MAU ratio as a stickiness read), plus a
  pointer to the current cohort-retention read from `retention-and-churn-analysis` if one exists
  this period — don't recompute the full cohort curve here, that skill owns it. Ask about viral
  coefficient only if this app actually has a referral/invite mechanic; if it doesn't, record "not
  applicable — no viral loop in this product" rather than asking for a number that doesn't exist
  for this business's growth model.
- **`other`**: don't force any of the above templates onto a business they don't fit. Ask the
  founder directly what number(s) they actually watch week to week to know whether the business is
  doing well, and use exactly those going forward. Record the founder's own metric set in this
  file's Notes so future periods reuse the same set rather than re-litigating it each check-in.

These are in addition to — never a replacement for — the acquisition/COCA questions in Step 1
below, which apply the same way across every business type.

## Step 1: Ask the founder for real actuals

For every KPI in `ops/kpi-dashboard.md` marked "Yes" (currently trackable), ask for this period's
actual number. Concretely, at minimum:

- Traffic/leads/inbound volume this period (however this business's funnel top actually starts).
- New signups / trials / qualified prospects this period.
- New paying customers closed this period.
- Total acquisition spend this period (paid channels, tools, and — per step 18/19's own
  discipline — loaded founder/team time if that's how COCA was computed in the plan).
- Channel breakdown, if the founder tracks it (which channel(s) actually produced the new
  customers).

If the founder doesn't have a number for something on the dashboard, record **"not tracked"** —
never substitute a plausible estimate. Log it under Data Gaps in the output file as a concrete,
actionable item (what to start tracking, and how), not a silent omission.

## Step 2: Compute derived metrics

- Stage-to-stage conversion rates wherever consecutive funnel numbers exist (e.g. leads →
  signups, signups → paying).
- **Actual COCA this period** = period acquisition spend / new paying customers this period. If
  new paying customers this period is small (fewer than ~5), state the number but flag it
  explicitly as too small a sample to treat as a stable COCA read — don't present it with false
  precision.
- If 2+ periods of history exist, also compute a **rolling COCA** (trailing periods combined) —
  this is the more stable figure to compare against the plan and to hand to
  `operations-manager`'s drift check.

## Step 3: Compare explicitly to plan (step 19)

State, in an unmissable "Plan comparison" section: the plan's COCA figure (with its
`quantitative_claims` id), this period's (or rolling) actual COCA, the dollar and percent gap,
and which direction it's moving relative to the prior snapshot. This is not optional narrative —
`operations-manager` reads this section directly for its own material-drift check, and it should
not have to re-derive the comparison from raw numbers.

## Step 4: Compute period-over-period deltas

Compare every metric to the prior snapshot file, where one exists. State direction and magnitude
plainly ("+18% new signups vs. last period," not just "signups grew").

## Output file: `ops/<timestamp>-growth-metrics.md`

Timestamp format `YYYY-MM-DD`; append `-2`, `-3`... if a second review genuinely runs the same
calendar day.

```markdown
# Growth Metrics — <business name> — <date>

## Period covered
<start> to <end>, per cadence.check_in_frequency: <weekly|biweekly|monthly|manual>

## Founder-reported inputs
| Metric | This period | Source |
|---|---|---|
| ... | ... | founder-reported <date> (or "not tracked") |

## Derived metrics
| Metric | Value | Note |
|---|---|---|
| Conversion rate(s) | ... | ... |
| Actual COCA (this period) | $... | flagged low-sample if <5 new customers |
| Actual COCA (rolling, N periods) | $... | ... (omit if <2 periods of history) |

## Plan comparison
Plan COCA (step 19, qc-...-coca): $... | Actual (rolling if available, else this period): $... |
Gap: $... (...%) | Trend vs. prior snapshot: <widening/narrowing/stable>

## Trend vs. prior period
<Period-over-period deltas, stated plainly.>

## Data gaps
<Every "not tracked" item, with what would need to change to start tracking it.>

## Flags for operations-manager
<Anything that looks like material drift per operations-manager's own thresholds — named here so
it isn't missed, though the risk_log entry itself is operations-manager's to write.>
```

## Update `business-state.json`

Append `ops/<timestamp>-growth-metrics.md` to `ops.cadence_metrics_files`. Preserve every other
key — this skill does not touch `stage`, `plan`, `reviews`, or `risk_log` directly (flags for
`risk_log` route through `operations-manager` or `growth-analyst`, per their own agent files).

## Never fabricate

Every number here is founder-reported this period or explicitly carried from a cited plan figure.
A metric the founder can't supply is a gap to name, never a number to invent.

## Done means

- `ops/kpi-dashboard.md` existed and was used (or the skill halted and said so).
- Every dashboard KPI has a founder-reported value or an explicit "not tracked."
- The plan-comparison section states plan COCA, actual COCA, and the gap explicitly.
- `ops/<timestamp>-growth-metrics.md` is written and registered in `business-state.json`.
