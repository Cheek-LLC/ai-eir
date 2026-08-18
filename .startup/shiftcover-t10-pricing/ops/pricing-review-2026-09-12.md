# Pricing Review — ShiftCover — 2026-09-12

> **TEST-ONLY SYNTHETIC REVIEW — QA ROUND 10.** Every operating figure cited below traces to
> `ops/synthetic-test-signal.md`, a fabricated QA test artifact, NOT to real founder-reported
> conversations or real `ops/*-growth-metrics.md` snapshots. This review exists solely to exercise
> `skills/ops/pricing-and-monetization-optimization`'s packaging/execution/feedback-loop content
> in the isolated test copy `.startup/shiftcover-t10-pricing/`. See
> `docs/QA-FINDINGS-PRICING-ROUND10.md`. **Do not treat any number in this file as real ShiftCover
> data, and do not copy this file or its state-file effects into the real `.startup/shiftcover/`
> fixture.**

*Planning aid for founder decision-making, not licensed financial, legal, or tax advice.*

## Trigger(s) that prompted this review
Trigger #1's pattern (actual acceptance well below the price's implicit assumption), evidenced by
`ops/synthetic-test-signal.md` Periods 1-2: **1 of 10 (10%) price-acceptance rate** for
$149/location/month, stated out loud in 10 real sales conversations across two independent
batches (5 in Period 1, 5 in Period 2) — sustained across 2+ periods, not a single noisy batch,
and at 2x this skill's own 5-per-arm minimum-sample floor. This executes `ka-016-price-point`'s
own stated test plan ("state this price in the next 5 real sales conversations... and record
reactions") — extended here to 10 conversations across 2 batches for a sustained read.

Note on trigger-taxonomy fit: this pattern is closest to Step 1's Trigger #1 (conversion/
acceptance below assumption) but isn't a perfect fit — Trigger #1 as written expects a rate to
compare against an ops/*-growth-metrics.md conversion figure, and Step 16 itself states no
explicit assumed-acceptance-rate baseline (only a price point and a ~30% value-capture ratio).
Treated Trigger #1 as the closest analog rather than forcing an exact match; flagged as a real
gap in `docs/QA-FINDINGS-PRICING-ROUND10.md`.

## Plan baseline (step 16 / step 17)
| Item | Plan figure | Source |
|---|---|---|
| Pricing metric | Per-location, monthly | plan/16-set-your-pricing-framework.md |
| Price point(s)/tiers | $149/location/month standard; $129/location/month volume tier (11+ locations) | plan/16-... |
| Value-to-price ratio | ~30% capture of Step 8's ~$6,000/yr/location value estimate | plan/16-... |
| ARPU / LTV input | $2,838/mo blended ARPU (22-location avg group at $129/loc volume tier) → $52,503 LTV/group | plan/17-calculate-the-ltv-of-a-customer.md |

Step 16's own competitive-anchor check already flagged the tension this synthetic trigger now
gives evidence for: $149/location/month is materially higher than the founder's (unverified)
sense of incumbent tools (7shifts/HotSchedules) at an estimated $2-4/location/month.

## Operating data reviewed
`ops/synthetic-test-signal.md` (TEST-ONLY, dated as if 2026-08-29 through 2026-09-12) — the only
"operating data" in this test copy; no real `ops/*-growth-metrics.md`, `*-retention-metrics.md`,
or `*-finance-metrics.md` file exists here or in the real fixture. Prior review:
`ops/pricing-review-2026-08-28.md` (this test copy's own no-trigger review — no trend beyond
that single prior data point, itself a "no data" finding, so no real historical pattern to layer
in).

## Packaging / value-metric analysis
**`business_basics.business_type` = `saas`, hybrid self-serve/sales-led.** Per the skill's SaaS
guidance: pricing is per-location here — structurally the same shape as seat-based pricing (a
location is the metered unit, not a person, but the incentive/risk shape is the same). Seat-based
pricing risks under-provisioning-style gaming less directly here (a location can't easily be
"shared" the way a login can), but it does cap expansion revenue at the group's physical footprint
regardless of how heavily each location actually uses the product.

Step 17 already flags that ShiftCover's real marginal cost driver is **per-SMS volume**, not
per-location overhead — this is the value-metric-misalignment risk the skill's Step 2 explicitly
asks to check: is the billed metric (location count) the same thing that scales with real cost and
real value delivered (SMS broadcasts sent / shifts covered)? A high-call-out-volume location and a
low-call-out-volume location pay the same rate today. A **hybrid model (base per-location fee +
usage-tied overage on broadcast volume)** is the plugin's own stated mid-market resolution once
both a location-count pattern and a usage-volume pattern exist — but that requires **real usage
data this synthetic signal does not provide** (no customer has used the product yet; all 15
synthetic data points are pre-sale price reactions, not usage).

**What this analysis can and cannot honestly conclude:**
- **Can:** inform whether the *price level* is anchored too high relative to what this segment
  will accept (the synthetic evidence says yes, directionally).
- **Cannot:** redesign tier *boundaries* from real usage clusters (Step 2's stated method) — there
  are no real customers, so there is no usage distribution to cluster. Any tier-boundary change
  proposed here would be exactly the "invented without looking at real usage distribution" number
  this skill's own Step 2 warns against. **Deliberately not attempted.**
- **Cannot** yet resolve the per-SMS value-metric-misalignment question either — that also needs
  real per-customer usage-vs-value data that doesn't exist pre-launch. Flagged as a real open item
  for the first real pricing review once the MVBP pilot has usage data (Step 23's territory), not
  resolved here.

## Decision
**Change warranted — but only the standard price level, tested in a single new period so far, not
finalized.**

The 10% acceptance rate at $149/location/month across 2 sustained periods clears this skill's own
evidence bar for "priced above the value the segment perceives." Per Step 3's phased-test
discipline (new-customers-only first — trivially satisfied here since there is no existing paying
base at all to protect), a lower standard price of **$99/location/month** was tested in a third,
fresh batch of 5 conversations: **4 of 5 (80%) accepted without pushback** — a real, positive
early read, but **only one period at the new number**, not the 2-sustained-period bar this same
review is holding the original $149 price to. Treating $99 as fully validated already would be
the same discipline failure in the other direction.

**Volume tier not independently tested.** The $129/location/month (11+) tier was not restated at
the new price in this batch — only the standard rate was tested. Any volume-tier figure below is
an **extrapolation** (same ~13.4% discount ratio as the original $149→$129 spread applied to $99),
not a directly tested number: $99 × (129/149) ≈ **$85/location/month (11+ locations)**, stated as
an unvalidated extrapolation, not a tested figure.

## If a change is warranted: execution plan
**Grandfathering:** N/A — no existing paying customer exists yet at any price; there is no
installed base to grandfather. This will become a live decision the first time a *second* price
change touches an already-signed customer, not this one.

**Communication plan:** N/A for the same reason — no existing customer to notify. The relevant
communication is forward-looking: future Step 9 conversations should lead with the new $99 number
rather than presenting $149 first and then discounting, since a first-ask discount pattern trains
prospects to expect further negotiation.

**Rollout/test design:**
1. New-customers-only — already the case; no existing base exists to isolate from.
2. Phased by cohort, not all-at-once — continue testing $99 with the next batch of Step 9
   prospects (2 unfilled slots per `ka-009-prospect-count`, plus repeat conversations with prior
   non-closers) before treating it as the new baseline price in `plan/16-...`'s own prose (which
   this skill does not edit — see below).
3. Hold a control cohort at $149 if volume allows — realistically not feasible yet given the small
   total prospect pool (`ka-009-prospect-count`: only 7 of 10 target customers identified with a
   real access path); flag this constraint honestly rather than pretending a controlled test design
   is fully available at this sample size.
4. Minimum sample size: the $99 test (5 conversations, 1 period) is at this skill's own floor, not
   comfortably above it — treat as an early positive signal requiring a second period before
   being read as confirmed, exactly the same standard applied to the original $149 finding above.

## Feedback into the plan
**Updated (read-modify-write, `business-state.json`):**
- `qc-016-price` — value updated from `$149/location/month standard, $129/location/month volume
  tier` to `~$99/location/month standard (tested, 1 period, n=5, 80% acceptance — see caveat
  above), ~$85/location/month volume tier for 11+ locations (extrapolated, not independently
  tested)`. Confidence held at `low` (not raised) — one period at the new number does not meet
  this skill's own 2-period bar; raising confidence now would be exactly the overclaiming this
  plugin's discipline exists to prevent. Source updated to cite this synthetic-QA review by name.
- `qc-017-ltv` — recomputed blended LTV using the new standard rate at the same 22-location-avg
  group / 74% margin / 25-month-lifetime inputs (both still `ka-017-margin`/`ka-017-churn` open,
  untested — carried forward unchanged): new blended ARPU ≈ 22 × $85 ≈ $1,870/month → LTV ≈ $1,870
  × 74% × 25 ≈ **roughly $35,000 per group contract** (rounded — the original $52,503 figure's own
  false-precision problem should not be repeated here; margin and churn are still low-confidence
  inputs, so this is presented as a range-appropriate approximation, not a point figure to the
  dollar).
- `ka-016-price-point` — `test_result` filled in: "TEST-ONLY SYNTHETIC (QA round 10): $149 stated
  in 10 conversations across 2 periods, 10% acceptance; $99 tested in 1 further period, 80%
  acceptance. See ops/synthetic-test-signal.md and this file. NOT real founder data — do not treat
  as the real test result for the live `.startup/shiftcover/` business."

**Explicitly not updated (out of this skill's scope):**
- `qc-04-tam` (Step 4 TAM, priced at the old $149 rate) — already carried an acknowledged
  reconciliation gap against the $129 volume tier (`ka-017-step4-price-mismatch`); this pricing
  change widens that gap further but this skill does not edit Step 4's entry — flagged, not fixed.
- `qc-019-coca` / `qc-019-ltv-coca-ratio` — the ratio is now stale against the new LTV figure, but
  COCA is Step 19's/`skills/ops/scaling-readiness-check`-or-equivalent's territory, not this
  skill's — flagged for whoever owns that ratio next, not recomputed here.
- `plan/16-set-your-pricing-framework.md` and `plan/17-calculate-the-ltv-of-a-customer.md`
  themselves — untouched, per this skill's explicit scope boundary. A suggestion for
  `revise-business-plan` to bring the plan prose current is the appropriate next step, not
  something this skill does itself.

## risk_log
New entry logged (see business-state.json): `ops-shiftcover-t10-pricing-001`, `type: "business"`,
describing the synthetic trigger, the $149→$99 test, and the still-provisional nature of the new
figures. **Explicitly marked in its own description as QA-synthetic**, not a real operational
finding, so it cannot be mistaken for a real drift signal if this test copy is ever inspected
later.

## Mandatory AI-risk gate
Invoked per the skill's instruction (a `quantitative_claims` update occurred). See
`docs/QA-FINDINGS-PRICING-ROUND10.md` for the full gate transcript and result (**PASS**, one
advisory finding on false precision in an intermediate draft of this file, fixed same-pass by
rounding the LTV figure before finalizing).
