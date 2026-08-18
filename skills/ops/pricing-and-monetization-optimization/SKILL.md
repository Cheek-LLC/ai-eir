---
name: pricing-and-monetization-optimization
description: >
  Use post-launch, during `stage: operating` (or late `gtm` after a soft launch), when real
  usage/conversion/willingness-to-pay data exists to check against the plan's original pricing.
  Triggers: "should we raise/lower our price," "revisit pricing," "are we leaving money on the
  table," "customers keep asking for a feature we don't have a tier for," "test a price
  increase," "pricing review," "our conversion rate doesn't match what we assumed," "should we
  add a tier." Not for initial pricing — that's
  `skills/disciplined-entrepreneurship/16-set-your-pricing-framework`, pre-launch, with no
  operating data yet. This skill is the ongoing optimization pass once real data exists: it
  checks concrete triggers (conversion drift, unpushed-back premium pricing, feature requests
  outside current packaging, churn concentrated at a price point), runs a packaging/tiering
  analysis, and — if a change is actually tested or adopted — feeds the new sourced figure back
  into `quantitative_claims`. Produces `ops/pricing-review-<timestamp>.md`. Never recommends a
  price change without a concrete evidence trigger.
---

# Pricing and Monetization Optimization

## What this skill is, and what it explicitly is not

Step 16 (`skills/disciplined-entrepreneurship/16-set-your-pricing-framework`) sets the **initial**
pricing framework during planning — a value-anchored price point, chosen with no real usage data,
carried into the plan as a `quantitative_claims` entry usually flagged low-confidence and
untested. This skill is the gap after that: once the business has real conversion, revenue-per-
customer, and willingness-to-pay data, pricing should be checked against that data periodically —
not left frozen at whatever step 16 assumed pre-launch, and not re-derived from scratch as if
step 16 never happened.

Do not re-run step 16's value-anchoring methodology here. Read what it produced, read what
actually happened, and report the gap between the two. This skill also never rewrites
`plan/16-set-your-pricing-framework.md` or `plan/17-calculate-the-ltv-of-a-customer.md` — those
are historical planning artifacts owned by their own step skills. If the founder wants the plan
prose itself rewritten to match a new reality, that's `revise-business-plan`'s job; this skill's
job is `business-state.json` and its own dated ops file.

## Reads

- `.startup/<slug>/business-state.json` (whole file). Confirm `stage` is `operating` (or the
  founder has explicitly asked for a pricing check mid-`gtm` after a soft launch, **or
  `ops.status: "active"`/`gtm.status: "launched"` even if `stage` currently reads
  `de_steps_in_progress` from a pivot reopening a subset of DE steps per `agents/orchestrator.md`
  Phase 6 — `stage` and ops/gtm liveness are independent signals**). Read
  `business_basics.business_type`, `quantitative_claims` entries tagged `step_ref`
  `16_set_your_pricing_framework` and `17_calculate_the_ltv_of_a_customer`, matching
  `key_assumptions` entries, and any open `risk_log` entries `type: "business"` already touching
  pricing.
- `.startup/<slug>/plan/16-set-your-pricing-framework.md` — required. The pricing metric, tier
  structure, price point(s), and value-to-price ratio being checked against reality.
- `.startup/<slug>/plan/17-calculate-the-ltv-of-a-customer.md` — required. ARPU is a direct LTV
  input; any price finding here has a direct LTV consequence.
- `.startup/<slug>/plan/08-quantify-the-value-proposition.md` — the value ceiling/anchor step 16
  used; still the reference point for judging whether a proposed change over- or under-captures
  value.
- `.startup/<slug>/ops/kpi-dashboard.md` and the most recent
  `.startup/<slug>/ops/*-growth-metrics.md`, `.startup/<slug>/ops/*-retention-metrics.md`,
  `.startup/<slug>/ops/*-finance-metrics.md` snapshots — the actual operating data this review
  runs on. Do not proceed on vibes if these don't exist yet; say so and stop (see "Never
  fabricate" below).
- Any prior `.startup/<slug>/ops/pricing-review-*.md` — for trend; a single snapshot proves less
  than a pattern across periods.

## Step 1: Name the concrete trigger — do not run this as a calendar ritual

State which trigger fired, with the actual numbers, before doing anything else. A pricing review
invoked because "it's been a while" with no evidence trigger below should conclude "no trigger
present, nothing to review" rather than manufacturing a rationale to justify having been invoked.

1. **Conversion-rate signal materially diverges from the plan's assumption**, sustained across
   2+ periods (one noisy period is not a trigger). Step 16 (for `consumer_app`/freemium
   especially) or the founder's sales process states an assumed conversion/close rate; compare
   the actual rate from `ops/*-growth-metrics.md`. Actual below roughly half the assumed rate →
   likely priced above the value the segment perceives, or packaging doesn't match how the
   segment wants to buy. Actual above roughly 1.5x the assumed rate, or deals closing with no
   negotiation/pushback at all → likely underpriced, money being left on the table.
2. **A segment paying meaningfully more than list price without pushback.** If the founder
   reports a real pattern — several of the last closed deals at a negotiated price above list,
   accepted without objection — that is a live willingness-to-pay signal outperforming the
   plan's value anchor. A single outlier deal is not a pattern; ask how many of the last N deals
   showed this before treating it as a trigger.
3. **High-value feature requests clustering outside current packaging.** Customer success or
   product-roadmap signals (cross-reference `skills/ops/customer-success-playbook` and, if it
   exists yet in this build, `skills/product/roadmap-and-prioritization` — check by name, don't
   assume its content) show a specific capability repeatedly requested by the business's
   higher-value customers that current tiers don't gate or reflect at all. This is a packaging
   gap, not merely a product-roadmap item — a feature valuable enough to drive repeat requests
   from paying customers is a candidate for a new tier boundary or an add-on price, not just a
   backlog ticket.
4. **Churn concentrated at a specific price point or tier.** Cross-reference
   `skills/ops/retention-and-churn-analysis`'s segment-fit data by tier, if tracked. If churn
   clusters heavily at one tier/price rather than spreading roughly proportional to that tier's
   customer share, that's a pricing-value mismatch signal for that tier specifically, distinct
   from the on-segment/off-segment PMF question that skill already answers.
5. **Realized ARPU or LTV drifting from step 17's figure for reasons traceable to price**, not
   just churn — heavy discounting at close, tier mix skewing toward the cheapest tier, expansion
   revenue not materializing the way step 16's SaaS expansion assumption implied.

If none of the above has a concrete, cited data point behind it, stop here and report "no
evidence-based trigger present this period" — do not proceed to a packaging or price-change
recommendation on eagerness or a fixed calendar cadence alone.

## Step 2: Packaging / tiering framework

**Good-better-best tiering.** Tier boundaries should come from real usage clusters in the actual
customer base, not evenly spaced guesses. Pull actual usage/consumption data (seats active,
volume processed, transactions run — whatever the business's real usage metric is) per customer
and look for natural breakpoints where usage/value received clusters, rather than dividing the
existing single price into three arbitrary bands. A tier structure invented without looking at
real usage distribution is exactly the kind of unsourced number this plugin's own AI-risk
discipline exists to catch.

**Usage-based vs. seat-based vs. flat pricing, by `business_basics.business_type`:**

- **`saas`:** Seat-based pricing penalizes multi-seat adoption and creates an incentive to under-
  provision seats (shared logins, seat-hoarding by a champion), which understates real usage and
  caps expansion revenue. Usage-based pricing tracks value better for tools with variable
  consumption but adds revenue unpredictability the customer's own budget process may resist, and
  requires metering infrastructure the business may not have built yet. A hybrid — a base seat
  fee plus usage overage, or a usage-based core with a seat-gated feature tier — is the common
  mid-market resolution once a SaaS business has enough data to see both a seat-growth pattern and
  a usage-growth pattern that don't move together.
- **`marketplace`:** The lever is the take rate, and take-rate changes have asymmetric elasticity
  in practice — a rate cut rarely recovers transaction volume one-for-one the way a rate hike
  loses it, because switching costs and habit dampen the upside of a cut faster than they dampen
  the downside of a hike. Any take-rate test should measure both sides' volume response
  separately (per step 17's LTV methodology, supply and demand sides are structurally different),
  not one blended transaction count.
- **`physical_product`:** Price changes can't be applied uniformly across channels without
  breaking channel-price harmony — a DTC price cut that undercuts an existing wholesale/retail
  price commitment (or violates a MAP agreement) creates channel conflict, not just a pricing
  change. Any packaging change here needs an explicit channel-by-channel read, mirroring step 16's
  own markup-chain discipline.
- **`services`:** The optimization opportunity is usually a shift from hourly/flat-project pricing
  toward value- or outcome-based pricing once real delivery-outcome data exists to price against —
  but only once effective realized hourly rate (revenue net of actual delivery time, including
  non-billable overhead) is being tracked accurately; repricing before that visibility exists is
  repricing blind.
- **`consumer_app`:** The optimization lever is as often paywall placement and tier-boundary
  design (what triggers the upgrade prompt, what's gated vs. free) as it is the price number
  itself — test placement and boundary changes as a distinct variable from price level, since
  conflating the two makes it impossible to tell which one moved the conversion number.

**Value-metric misalignment — the risk to check explicitly.** A value metric is misaligned when
the thing being billed doesn't move in the same direction as the value the customer says they're
getting — e.g., billing per seat when value scales with data volume processed (so a small team
processing huge volume is underpriced, and a large team using it lightly is overpriced relative
to value received), or billing per API call when the value is the outcome, punishing a customer
who becomes more efficient. Diagnostic: for a sample of customers, does usage of the billed metric
move the same direction as their self-reported ROI/value over time? If billed usage is flat or
declining while expressed value is rising (or the reverse), the value metric itself — not just the
price level — needs to change, and a price-level-only fix will not resolve the underlying
mismatch.

## Step 3: Price-change execution discipline

**Grandfathering.** Grandfather existing customers at their current price when the change is a
genuine increase and the installed base has real switching cost or is small enough that a churn
spike would be materially damaging (most SMB/mid-market SaaS with meaningful expected LTV per
step 17). Do not grandfather when the change corrects a structure that was clearly broken or
badly underpriced very early, against a still-small and typically still-negotiable customer base
— the cost of two permanent price tiers indefinitely usually exceeds the goodwill saved. State
which case applies and why; "grandfather everyone" and "grandfather no one" are both defaults to
avoid stating a reason for.

**Communicating a price increase without a churn spike.** Real practices, not platitudes:
advance notice (roughly 30-60 days is typical for SMB SaaS renewal cycles — check against this
business's actual billing/renewal cadence rather than assuming monthly); lead the communication
with what changed or was added, not just the new number; tie the increase to a stated, credible
reason (cost increase, meaningfully expanded capability, demonstrated value delivered) rather than
presenting it as unexplained; offer a lock-in-at-current-price window before the increase takes
effect for customers who act by a date, which both softens the reaction and pulls forward
renewals; personally reach out to the highest-value accounts before the mass communication goes
out, so no top account is surprised by a mass email.

**Testing a price change safely — a phased approach, not a flip of the switch:**
1. **New-customers-only first.** Test the new price on new-cohort acquisition before touching the
   existing base at all — this isolates the conversion-rate effect from any existing-customer
   reaction and carries far lower risk.
2. **Phased rollout by segment/cohort/geography** rather than an all-at-once change, if the
   existing base does need to move — lets a bad read get caught and reversed before it's applied
   business-wide.
3. **Hold out a control cohort** at the old price where volume allows, so the review measures an
   actual conversion/revenue delta against a comparison group, not an uncontrolled before/after
   that a seasonal or channel-mix shift could equally explain.
4. **Respect a minimum sample size before declaring a result.** Mirror this plugin's own
   false-precision discipline: don't declare a price test won or lost on fewer than roughly 5
   customers/deals per arm — say "insufficient data to read yet" and state what volume or time
   window would resolve it, the same pattern `skills/ops/scaling-readiness-check` uses for its own
   trend criteria.

For general experimentation/rollout mechanics beyond pricing specifically (sample sizing,
statistical read, rollout tooling), cross-reference `skills/ops/experimentation-and-optimization`
by path as the general-purpose reference — this skill does not duplicate that methodology, and
that skill may not exist yet in this build; if it isn't present, the phased-rollout discipline
above stands on its own.

## Step 4: Decide — is a change actually warranted?

State the trigger(s) from Step 1, the evidence behind each, and reach one explicit conclusion:

- **No change warranted.** The data doesn't support one even though this skill was invoked —
  state why plainly rather than silently dropping the review. (E.g., "conversion rate is within
  normal variance of the plan's assumption; no packaging gap or churn concentration found.")
- **Change warranted**, with a specific recommended action: raise/lower the price point by a
  stated amount, add or restructure a tier at a stated boundary, or change the value metric being
  billed on. Every recommendation traces to the specific trigger evidence from Step 1 and the
  packaging analysis from Step 2 — never a recommendation justified only by "prices have been flat
  for a while."
- **Insufficient data.** Name exactly what data or time window would resolve it (mirrors the
  `insufficient-data` verdict pattern in `skills/ops/scaling-readiness-check`) rather than forcing
  a call on a small sample.

Never recommend a price change to satisfy founder eagerness or because a review was requested and
a recommendation feels expected — an honest "no change warranted" is a complete, useful outcome.

## Step 5: If a price change is tested or adopted — feed it back into the plan

A tested or changed price is a new sourced number, not a private ops fact that quietly makes the
plan's original figures stale. Close the loop explicitly:

- **Update the relevant `quantitative_claims[]` entries** — the pricing entry from step 16
  (`step_ref: "16_set_your_pricing_framework"`) and, because ARPU is a direct LTV input, the LTV
  entry from step 17 (`step_ref: "17_calculate_the_ltv_of_a_customer"`). Read-modify-write in
  place: keep the existing `id`, update `value` to the new tested/adopted figure, update
  `confidence` upward if the new figure is now backed by real operating data (a tested price with
  real conversion data is no longer `low` confidence the way an untested pre-launch guess was),
  and set `source` to `"operating data, see ops/pricing-review-<date>.md"` — preserve the prior
  planning-stage figure inline in the same string rather than deleting the trail, e.g.
  `"operating data, see ops/pricing-review-2026-08-18.md; supersedes original plan estimate of
  $499/mo from step 16, untested at the time"`.
- **Close the loop on any matching `key_assumptions` entry.** If an entry like
  `ka-016-price-point` exists with a `test_plan` this review just executed (e.g., "state this
  price in the next 5 sales conversations"), fill in its `test_result` field now — this is
  literally the test that assumption specified; don't leave it `null` once the test has actually
  run.
- **Do not edit `plan/16-...md` or `plan/17-...md` themselves.** Those are the historical planning
  record; this skill updates the live state and its own dated ops file. If the founder wants the
  plan prose itself brought current, note that as a suggestion for `revise-business-plan` — don't
  do it here.
- **Log material drift to `risk_log`** when the Step 1 trigger represents a real gap from plan
  (conversion far below assumption, churn concentrated at a price point) — this is exactly the
  `type: "business"` pattern `docs/DATA-CONTRACT.md` documents for post-launch operational
  drift raised by the `agents/ops/*` layer. Schema:

```json
{
  "id": "ops-<slug>-<sequential-number>",
  "type": "business",
  "raised_by": "pricing-strategist",
  "description": "string — the trigger, the actual vs. plan numbers, and the recommended action or 'no change warranted'",
  "status": "open"
}
```

Increment from the highest existing `ops-<slug>-*` id. Read-modify-write the whole
`business-state.json`; never set `status` to anything but `open` yourself.

## Mandatory AI-risk gate — before this review is reported done

Pricing and LTV are two of the numeric-claim categories `skills/risk/ai-risk-review` exists
specifically to guard (its scope names DE steps 16 and 17 explicitly). Any update this skill
makes to `quantitative_claims` under Step 5 is a new numeric claim being presented to the founder
as ready to act on, carrying the same risk the pre-launch gate exists to catch (false precision,
an assumed-rather-than-measured input laundered as fact). Before finalizing a review that changed
any `quantitative_claims` entry, invoke `skills/risk/ai-risk-review` against
`ops/pricing-review-<timestamp>.md` (the whole file) plus the business slug.

- **PASS** → proceed to the `business-state.json` update.
- **BLOCKED** → do not update `quantitative_claims`. Fix the finding and re-run the gate, or route
  to the orchestrator for an explicit founder override (`agents/orchestrator.md` Non-negotiable
  #3) — this skill does not accept an override itself.

A review that concludes "no change warranted" and touches no `quantitative_claims` entry does not
need the gate — there is no new numeric claim to check.

## Output file: `ops/pricing-review-<timestamp>.md`

Timestamp format `YYYY-MM-DD`; append `-2`, `-3`... for a same-day rerun.

```markdown
# Pricing Review — <business name> — <date>

## Trigger(s) that prompted this review
<Which of Step 1's trigger categories fired, with the actual cited numbers — or "founder-
requested, no automatic trigger" if invoked directly on a founder question.>

## Plan baseline (step 16 / step 17)
| Item | Plan figure | Source |
|---|---|---|
| Pricing metric | ... | plan/16-... |
| Price point(s)/tiers | ... | plan/16-... |
| Value-to-price ratio | ... | plan/16-... |
| ARPU / LTV input | ... | plan/17-... |

## Operating data reviewed
<Which ops/*-growth-metrics.md, *-retention-metrics.md, *-finance-metrics.md snapshots, date
range covered, and the actual figures pulled from them.>

## Packaging / value-metric analysis
<Tiering read from real usage clusters if applicable; value-metric alignment check; business-
type-specific tradeoff considered.>

## Decision
**<No change warranted | Change warranted | Insufficient data>**
<The specific recommendation, or the specific data/timeframe needed, stated plainly.>

## If a change is warranted: execution plan
Grandfathering: <decision + why>
Communication plan: <notice window, framing, top-account outreach>
Rollout/test design: <new-customers-only / phased / control cohort, sample-size caveat>

## Feedback into the plan
<Which quantitative_claims ids were updated, old value -> new value, new source string. Which
key_assumptions test_result was filled in, if any. "None — no change adopted this review" if
applicable.>

## risk_log
<Entry id and description if one was logged, or "none — no material drift trigger this review.">
```

## Never fabricate

Every trigger cited in Step 1 traces to an actual figure in a dated `ops/*` snapshot file or a
direct founder-reported statement this session — never infer a conversion rate, a willingness-to-
pay pattern, or a churn concentration from impression or momentum. If the underlying ops snapshots
don't exist yet (no `growth-metrics`/`retention-metrics` files at all), say so and stop — there is
no operating data to optimize pricing against yet, and this skill should not manufacture a
review out of the plan figures alone.

## Done means

- The specific trigger(s) that prompted this review are named with real cited numbers, not a
  generic "time for a pricing check."
- The packaging/tiering analysis addresses this business's actual `business_type` tradeoff, not a
  generic good-better-best template.
- An explicit decision was reached (no change / change warranted / insufficient data) — never a
  vague "worth thinking about."
- For any adopted or tested change: grandfathering decision, communication plan, and a phased/
  controlled test design are all stated concretely, not left as "TBD."
- If any `quantitative_claims` entry was updated, the mandatory AI-risk gate returned PASS (or a
  BLOCKED finding was resolved/overridden) before it was finalized.
- `ops/pricing-review-<timestamp>.md` is written, registered in
  `business-state.json.ops.cadence_metrics_files`, and any `quantitative_claims`/
  `key_assumptions`/`risk_log` updates from Step 5 are applied via read-modify-write.
