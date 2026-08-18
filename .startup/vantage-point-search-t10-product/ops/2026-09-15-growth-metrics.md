# Growth Metrics — Vantage Point Search — 2026-09-15

Produced by `skills/ops/weekly-metrics-review`, delegated from `agents/ops/growth-analyst.md`, as
part of `agents/ops/operations-manager.md`'s first post-launch check-in. `ops/kpi-dashboard.md`
confirmed current (revised same day) before this review ran.

## Period covered

2026-09-01 to 2026-09-15 (first check-in period; `cadence.check_in_frequency` was `manual` at
launch, being set for real this session — see the recurring check-in log for the founder's chosen
going-forward cadence).

## Founder-reported inputs

| Metric | This period | Source |
|---|---|---|
| Outbound touches sent (Day-1 emails, new prospects) | 3 | founder-reported 2026-09-15 |
| Existing next-10 prospects actively worked (tracker next-actions) | 5 (#1, #2, #3, #4, #7) | founder-reported 2026-09-15 |
| New discovery calls held this period | 1 (prospect #3, already in-flight pre-period) | founder-reported 2026-09-15 |
| New qualified prospects entering the funnel (first conversation) | 2 | founder-reported 2026-09-15 |
| New paying customers closed this period | 0 | founder-reported 2026-09-15 — expected, given the 5-9 week cycle length (`qc-018-cycle-length`); no prospect contacted at or after launch has had time to reach signing yet |
| Total acquisition spend this period | $90 (LinkedIn Recruiter subscription, prorated 2 weeks; no paid ads) | founder-reported 2026-09-15 |
| Channel breakdown | 3 new touches: 2 direct outbound (LinkedIn), 1 referral follow-up | founder-reported 2026-09-15 |

## Business-type follow-up (services)

| Metric | This period | Source |
|---|---|---|
| Billable utilization | ~18 delivery hours this period ÷ ~80 available capacity hours (excl. BD time) ≈ **22%** | founder-reported 2026-09-15 — delivery hours spent on the #5 engagement (signed 2026-08-20, mid-search) |
| Pipeline value (open, not-yet-closed) | 5 active prospects (#1, #2, #3, #4, #7) × $70,500 avg fee = $352,500 gross; risk-adjusted at the 23% overall historical conversion rate ≈ **~$81,000** | founder-reported tracker (`gtm/outbound-sales-playbook.md` §1) + `qc-016-price`, conversion rate from Step 13 |
| Engagement completion rate | N/A — 0 engagements scheduled to complete this period (the #5 engagement's ~30-day slate-delivery milestone lands ~2026-09-19, after this period closes) | founder-reported 2026-09-15 |

## Derived metrics

| Metric | Value | Note |
|---|---|---|
| Stage 1→2 conversion (this period) | Too small a sample to compute meaningfully (2 new first-conversations, 0 have had time to advance) | Sample size note, not a real rate yet |
| Actual COCA (this period) | **Insufficient data — 0 new paying customers this period.** Cannot divide $90 spend by 0 closes into a meaningful figure. | Flagged explicitly per this skill's own false-precision discipline, not stated as $0 or infinite |
| Actual COCA (rolling, N periods) | Omitted — this is the first period of tracked data, no prior period to roll with | — |

## Plan comparison

Plan COCA (Step 19, `qc-019-coca`): ~$5,200 (range $4,900-$5,400) | Actual (this period): **not
computable — 0 new paying customers closed**. This is expected, not a red flag: the 5-9 week sales
cycle (`qc-018-cycle-length`) means no prospect who entered the funnel at or after the 2026-09-01
launch could plausibly have closed by 2026-09-15 regardless of how well outbound performed. Will
reassess once the first launch-era close happens, expected no earlier than mid-October given the
cycle length. | Trend vs. prior snapshot: n/a (first snapshot).

## Trend vs. prior period

N/A — first growth-metrics snapshot for this business's ops loop.

## Data gaps

- Billable utilization is founder-estimated, not logged from real time-tracking — same open gap as
  `ka-016-delivery-hours-estimate`. Recommend Jordan start a simple time log for the #5 engagement
  now, while it's active, rather than backing out an estimate after the fact.
- Channel-level spend tracking is informal (a single LinkedIn Recruiter subscription line, no
  per-channel attribution tool) — consistent with the CRM gap logged in
  `business-state.json.connectors.needed_not_installed`; not a new gap, same root cause.

## Flags for operations-manager

Nothing material this period — the "0 new customers, 0 computable COCA" result is expected given
the real sales-cycle length, not a funnel problem. The one thing worth carrying into the retro's
Watch List rather than the risk log: only 3 of the pre-launch plan's target new-outbound-touch
volume were sent this period (`gtm/launch-plan.md` §3 flagged the founder skipped the 08-21
pre-launch outreach batch entirely due to delivery-work priority on the #5 engagement) — this is
the capacity constraint showing up in practice, worth naming to Jordan directly rather than only in
this file.
