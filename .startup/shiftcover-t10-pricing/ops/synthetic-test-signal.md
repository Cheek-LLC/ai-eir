# TEST-ONLY SYNTHETIC SIGNAL — QA Round 10 Pricing Test

**This file is a fabricated test artifact, created by a QA dry run (round 10) solely to exercise
`skills/ops/pricing-and-monetization-optimization`'s packaging/execution/feedback-loop content in
a copy of the fixture (`.startup/shiftcover-t10-pricing/`). It is NOT real founder-reported data,
was not produced by any real sales conversation, and must never be read as authoritative outside
this test copy. It does not exist in, and must never be copied into, the real
`.startup/shiftcover/` fixture. See `docs/QA-FINDINGS-PRICING-ROUND10.md` for the full method.**

## Synthetic scenario being role-played
Maria Chen has (hypothetically, for this test only) run the MVBP pilot conversations Step 22/
`ka-016-price-point` call for, and stated the $149/location/month price out loud to Step 9
prospects — the exact test `ka-016-price-point` specifies ("state this price in the next 5 real
sales conversations, starting with Alex Torres, and record reactions").

## Synthetic data point (dated as if logged across two sessions, so the skill's own "sustained
across 2+ periods" bar is cleanly met, not marginal)
- **Period 1 (synthetic, w/o 2026-08-29):** 5 of 5 real sales conversations where the
  $149/location/month price was stated out loud (Step 9 prospects #1-5). Price-acceptance rate
  observed: **0 of 5 (0%)** accepted the number without pushback; all 5 raised the incumbent-tool
  price gap (7shifts/HotSchedules, Step 16's own competitive-anchor concern) unprompted and asked
  for a lower number or a pilot discount before continuing.
- **Period 2 (synthetic, w/o 2026-09-05):** 5 more conversations (Step 9 prospects #6-7 plus 3
  re-approached from Period 1 with a revised pitch, same price). Price-acceptance rate observed:
  **1 of 5 (20%)** accepted without pushback; 4 of 5 again raised the incumbent-price gap.
- **Combined: 1 of 10 (10%) acceptance across two independent periods** — sustained, not a single
  noisy period, and well above the skill's own 5-per-arm floor (10 total, 5 per period).
- Framed against the skill's Step 1 Trigger #1 pattern (actual acceptance well below assumed
  acceptance → likely priced above the value the segment perceives): 10% observed acceptance is
  roughly 40%+ below any reasonable pre-launch expectation that a price anchored at ~30% value
  capture (Step 16's own stated ratio) would land with only occasional pushback, not near-uniform
  pushback.
- **Explicitly still missing:** no real usage-volume data exists per prospect (no one has signed
  yet), so this signal only supports a price-*level* read, not a real usage-cluster-based
  tier-boundary redesign (Step 2's tiering method needs real usage data this synthetic signal does
  not manufacture).

## Synthetic Period 3 — a tested price change (added to exercise Step 5's feedback loop)
- **Period 3 (synthetic, w/o 2026-09-12):** per the skill's own phased-test discipline (Step 3:
  new-customers-only first, since there is no existing base to protect here), founder
  (role-played) tests a lower standard price of **$99/location/month** in 5 more Step 9
  conversations (a fresh batch, not re-asking Period 1/2 prospects the same question twice).
  Result: **4 of 5 (80%) accepted without pushback**, 1 of 5 still asked about a further discount
  for a pilot.
- This is a single period at the new price (not yet 2 sustained periods) — a real positive early
  read, not yet a fully validated number by this skill's own "sustained across 2+ periods" bar.
  The review this signal feeds should say so explicitly rather than treating $99 as settled.
- The volume tier (11+ locations) was **not** independently tested in this batch — only the
  standard rate was stated. Any volume-tier figure derived from this test is an extrapolation,
  not a directly tested number.

## Why this exists
`shiftcover-t10-pricing` is `stage: approved`, pre-GTM, with zero real `ops/*-growth-metrics.md`
snapshots — under real conditions (see `ops/pricing-review-2026-08-28.md`) there is no trigger to
review. This file exists only so QA round 10 can also confirm the skill's packaging/tiering
content, price-change execution discipline, and `quantitative_claims`/`key_assumptions` feedback
loop actually work once a real trigger exists — content that round 10's honest no-data scenario
cannot exercise at all.
