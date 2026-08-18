# Retention Metrics — Vantage Point Search — 2026-09-15

Produced by `skills/ops/retention-and-churn-analysis`, delegated from
`agents/ops/customer-success-lead.md`. Business has a real completed-placement history (6
placements, 14 months), so this is not skipped as pre-revenue — but this specific period has no new
completion or churn events to analyze, reported honestly below rather than padded.

## Retention frame used

**Project completion rate + repeat-engagement rate** (one-off, project-based engagements) — per
`ops/kpi-dashboard.md`'s business-model classification, Vantage Point Search's engagements are
fee-for-service/project-based, not recurring retainers (Step 15 explicitly considered and deferred
a retainer model). "Churn" in the subscription sense does not apply; renewal doesn't either, since
there's no ongoing contract to renew — repeat-engagement (a past client returning for a *new,
separate* search) is the right frame, and it is tracked as a distinct metric from renewal, per
`skills/ops/retention-and-churn-analysis/SKILL.md`'s services guidance.

## Founder-reported inputs

| Metric | Value | Source |
|---|---|---|
| Engagements completed this period | 0 | founder-reported 2026-09-15 — the #5 engagement is mid-search, no completion milestone fell inside this period |
| New engagements signed this period | 0 (the #5 engagement was signed 2026-08-20, before this period opened) | founder-reported 2026-09-15 |
| Repeat clients (2+ distinct engagements) this period | 0 new — but the #5 engagement itself *is* a repeat engagement (this client's 2nd search, first was 8 months prior per Step 9) | founder-reported 2026-09-15 |

## Headline retention metric

**Repeat-engagement rate (cumulative, unchanged this period): 1.33** (8 signed engagements / 6
distinct clients, per `qc-017-ltv`'s underlying figure — Step 17). This period contributed no new
data point to this rate (no engagement concluded), so the figure is carried forward unchanged, not
recomputed on stale logic.

## Segment-fit split (churned this period)

Not applicable — no churn concept applies to a one-off project-based engagement (see frame note
above), and no engagement concluded (successfully or otherwise) this period to assess either way.

## Churn reasons (where known)

Not applicable this period — no completions or departures to explain.

## Trend vs. prior period

N/A — first retention-metrics snapshot for this business's post-launch ops loop. (The 1.33 repeat-
engagement rate itself is a pre-existing historical figure, not new this period.)

## Flags

None this period. Worth naming as a forward-looking watch item, not a flag: the #5 engagement's
candidate-slate-delivery milestone (~2026-09-19) is the next real data point for both this file and
`ops/2026-09-15-finance-metrics.md`'s next snapshot — the next check-in should specifically ask
whether that milestone landed on time relative to Step 7's ~30-day spec.
