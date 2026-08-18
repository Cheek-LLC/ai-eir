# Pricing Review — ShiftCover — 2026-08-28

*Planning aid for founder decision-making, not licensed financial, legal, or tax advice.*

## Trigger(s) that prompted this review
Founder-requested this session ("should we revisit our pricing?" — role-played per QA Round 10
Step 4 of the test plan). No automatic trigger from `operations-manager`, `growth-analyst`, or
`customer-success-lead` fired; this is a direct-ask invocation only.

## Precondition check — before running Step 1's trigger check at all
`business-state.json.stage` is **`approved`**, not `operating`. `gtm.status` is **`not_started`**
— there has been no launch, soft or otherwise; the MVBP pilot (Step 22, `ka-022-delivery`) has not
even started. This skill's own "Reads" section states its precondition plainly: confirm `stage` is
`operating`, "or the founder has explicitly asked for a pricing check mid-`gtm` after a soft
launch." Neither holds here — the founder's ask is not mid-GTM-after-a-soft-launch, it is
pre-launch, pre-pilot. That alone is enough to decline running a real review, before even
reaching Step 1's five trigger categories.

## Operating data reviewed
None exists. `.startup/shiftcover-t10-pricing/ops/` contains no `*-growth-metrics.md`,
`*-retention-metrics.md`, or `*-finance-metrics.md` snapshot files at all (confirmed by directory
listing before this review started), `business-state.json.ops.status` is `not_started`, and
`ops.cadence_metrics_files` is empty. No prior `ops/pricing-review-*.md` exists either, so there
is no trend to compare against.

## Trigger check against Step 1's five categories (run anyway, for completeness)
1. **Conversion-rate signal** — no `ops/*-growth-metrics.md` exists to compare against. No data.
2. **Segment paying above list without pushback** — no real sales conversations have occurred yet
   in which price was even stated out loud (`ka-016-price-point`'s `test_result` is still `null`).
   No data.
3. **High-value feature requests clustering outside packaging** — no customers exist yet to
   generate such requests. No data.
4. **Churn concentrated at a price point** — no customers exist yet, so no churn is possible. No
   data.
5. **Realized ARPU/LTV drifting from Step 17's figure** — Step 17's figure (`$52,503`) is itself
   an unmeasured, `confidence: low` projection with zero real customers behind it; there is no
   "realized" figure to compare it to yet.

None of the five has a concrete, cited data point behind it — literally none, not merely a weak
one.

## Decision
**No trigger present — no operating data exists to review pricing against.** This is not the
same finding as "no change warranted" (which implies real data was checked and came back clean);
it is the stronger, earlier finding this skill's own "Never fabricate" section names explicitly:
"there is no operating data to optimize pricing against yet, and this skill should not manufacture
a review out of the plan figures alone." Nothing here changes Step 16's or Step 17's figures, and
none should be touched.

**What would actually trigger a real review:** the Step 22 MVBP pilot needs to run first —
specifically, `ka-016-price-point`'s existing test plan ("state this price in the next 5 real
sales conversations, starting with Alex Torres, and record reactions") needs to actually execute,
and/or the first `ops/*-growth-metrics.md` snapshot needs to exist. Until then, a pricing review
invoked on this business is checking against nothing.

## Packaging / value-metric analysis
Not run. Step 2 of the skill is packaging/tiering analysis against *real usage clusters in the
actual customer base* — there is no customer base yet, so running this section would mean
inventing usage clusters from nothing, which is exactly the fabrication this plugin's AI-risk
discipline exists to prevent. Skipped deliberately, not by oversight.

## If a change is warranted: execution plan
N/A — no change is being considered; Step 3's execution-discipline content (grandfathering,
communication, phased rollout) does not apply to zero real customers.

## Feedback into the plan
None. No `quantitative_claims` or `key_assumptions` entries were touched.

## risk_log
None logged. This is an expected, correct state for a pre-launch business — not itself a drift
finding worth a `risk_log` entry (there is no plan-vs-reality gap to log; there is no reality yet).

## Mandatory AI-risk gate
Not invoked — per the skill's own carve-out, "A review that concludes 'no change warranted' and
touches no `quantitative_claims` entry does not need the gate." No `quantitative_claims` entry was
touched here either, for the same reason.
