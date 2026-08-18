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
  plan-comparison figure, `cadence` for the period this review covers.
- `.startup/<slug>/plan/19-calculate-the-coca.md` — the plan's own COCA derivation, so the
  comparison cites method, not just the headline number.
- The most recent prior `.startup/<slug>/ops/*-growth-metrics.md`, if one exists — for
  period-over-period deltas.

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
