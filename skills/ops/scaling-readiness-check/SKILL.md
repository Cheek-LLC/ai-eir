---
name: scaling-readiness-check
description: >
  Use when the founder asks "are we ready to scale," "should we raise/hire/spend more to grow
  faster," or on `scaling-strategist`'s own cadence (several consecutive healthy periods, or at
  most monthly regardless of a tighter check-in cadence — not every single check-in). Runs a
  concrete, falsifiable checklist against the plan's own step 17/19 unit economics holding across
  multiple periods (not one snapshot), the retention curve's trend, whether step 18's sales
  process is actually repeatable and costed in practice, whether the step 22/23 MVBP/dogfood
  validation signal still holds with real production customers, whether step 24's product plan
  supports the scale being considered, and the founder's real operational capacity. Produces
  `ops/<timestamp>-scaling-readiness.md` with an explicit not-ready / conditionally-ready / ready
  verdict and, for anything short of ready, the specific next milestone. Never rubber-stamps
  "ready" on optimism or momentum alone.
---

# Scaling Readiness Check

## What this skill is

A falsifiable checklist for the highest-stakes ops call a founder makes post-launch: whether to
convert working unit economics into a bet that they hold at meaningfully higher volume, usually
by spending real money ahead of proof. Every criterion below has an explicit evidence bar and
resolves to pass / fail / insufficient-data — never a vibe.

## Reads

- `.startup/<slug>/plan/17-calculate-the-ltv-of-a-customer.md`,
  `.startup/<slug>/plan/19-calculate-the-coca.md` — the plan's own unit-economics baseline and
  its stated reference band (the ~3:1-ish LTV:COCA framing used there).
- `.startup/<slug>/plan/18-map-the-sales-process-to-acquire-a-customer.md` — the costed process
  map reality is checked against.
- `.startup/<slug>/plan/22-define-the-mvbp.md`,
  `.startup/<slug>/plan/23-show-that-dogs-will-eat-the-dog-food.md` — what validation signal was
  actually collected pre-launch and what it was meant to prove.
- `.startup/<slug>/plan/24-develop-a-product-plan.md` — the roadmap and any scaling blockers it
  already names.
- The last 3+ (where they exist) `.startup/<slug>/ops/*-growth-metrics.md`,
  `.startup/<slug>/ops/*-finance-metrics.md`, `.startup/<slug>/ops/*-retention-metrics.md` — the
  checklist runs on trend across periods, not a single snapshot.
- `.startup/<slug>/business-state.json` — `business_basics.business_type` (which criterion 3 and
  6 evidence bar applies — see Business-type dispatch below), `key_assumptions`/
  `quantitative_claims` tagged step_ref 17/19/22/23/24, `risk_log` (open findings bearing on
  readiness).

## The checklist

For each criterion: state the evidence found, then mark **pass**, **fail**, or
**insufficient-data**. Insufficient-data is not a pass — it means don't claim readiness on this
criterion yet.

1. **Unit economics hold at current scale, and the path isn't widening.** Actual LTV:COCA (from
   the most recent growth/finance/retention snapshots) is at or above the plan's reference band
   (step 19's ~3:1-ish framing), **and** COCA hasn't been trending up faster than LTV across the
   last 3 periods. *Fail* if the ratio has dropped below the band or is closing period over
   period. *Insufficient-data* if fewer than 3 periods of tracked actuals exist.
2. **Retention curve is flattening, not still in free-fall.** Churn/retention rate (per
   `retention-and-churn-analysis` snapshots) is stable or improving across the last 3 periods.
   *Fail* if churn is still rising or hasn't stabilized. *Insufficient-data* if fewer than 3
   periods exist, or if customer volume is too small for the rate to be meaningful.
3. **Sales process is actually repeatable and costed (step 18), not founder-improvised.** Ask the
   founder directly: of the last several closed deals, how many followed the documented step-18
   process (stages, resources, conversion pattern) vs. were bespoke one-offs the founder
   personally engineered? *Pass* only if a real majority followed the documented process. *Fail*
   if most deals are still founder-led snowflakes with no repeatable pattern — scaling sales spend
   against a non-repeatable process multiplies an unproven motion, it doesn't scale a working one.
4. **MVBP/dogfood validation signal still holds in production (steps 22/23).** Ask the founder
   directly whether real paying customers are actually using the product the way the step 22/23
   validation assumed — not just buying it, but engaging with it the way that signal predicted.
   *Fail* if usage in production diverges materially from what steps 22/23 validated. *Pass* only
   with a specific, current example the founder can point to.
5. **Product plan (step 24) supports the scale being considered.** Re-read step 24 for any
   already-named scaling blocker (a manual step, a dependency, a capacity ceiling). Ask the
   founder whether anything currently works only because volume is still low. *Fail* if a known
   blocker hasn't been addressed and the plan is to scale volume past it anyway.
6. **Founder/team has real capacity to execute a scale-up.** Ask directly: does the founder have
   the time, cash (cross-check with the latest finance-metrics runway classification — do not mark
   this pass if runway is Warning/Critical), and team bandwidth to execute a scale-up without
   breaking something currently working (support quality, fulfillment, personal capacity)? This is
   a direct founder self-report, not an inference.

## Business-type dispatch: what criteria 3 and 6 actually check

Criteria 1, 2, 4, and 5 test whether the core thesis holds (unit economics, retention, the
validation signal, the product plan) and their evidence bar doesn't change by business type.
Criteria 3 and 6 are about *how this specific kind of business* actually scales, and forcing the
SaaS framing ("repeatable, costed sales process" / "founder time and cash") onto every type
produces a false read. Check `business_basics.business_type` and apply the matching bar below
before marking either criterion — state which type-specific bar was used in the Evidence column.

**Criterion 3 — the repeatable-acquisition-motion bar, by type:**
- `saas`: as written — a real majority of recently closed deals followed the documented step-18
  process (stages, resources, conversion pattern), not founder-improvised one-offs.
- `physical_product`: repeatable, costed acquisition/channel motion — is the same channel mix
  (paid, retail, wholesale) producing consistent COCA across the last several cohorts, or does
  revenue still trace mostly to non-repeatable founder-personal channels (one-off influencer
  favors, personal network sales)? Fail if it's mostly the latter.
- `marketplace`: readiness on this axis is **liquidity achieved in the beachhead, not a sales
  process**. Ask whether a typical buyer/seller on the beachhead side reliably finds a match (a
  real fill/match rate) without the founder manually intervening to make transactions happen, and
  without ongoing subsidy propping the match rate up. Fail if the founder is still manually
  matchmaking or subsidizing most transactions to make liquidity happen.
- `services`: ask whether new-client acquisition follows a repeatable pattern (referral engine,
  inbound pipeline) rather than being 100% founder-networked one-offs — same underlying question
  as SaaS, evidence bar adapted to how services businesses actually acquire clients (reputation/
  referral-driven, not necessarily a formal sales process).
- `consumer_app`: ask whether user acquisition runs through a repeatable channel (paid, organic/
  content, a genuine referral loop) producing consistent CAC and activation rate period over
  period, or whether growth to date traces to a non-repeatable spike (a single viral moment, a
  one-time press hit). Fail if it's mostly the latter.
- `other`: ask the founder what "repeatable acquisition" would even mean for this business before
  applying any template above; use their own framing and state it explicitly in the Evidence cell.

**Criterion 6 — the capacity bar, by type:**
- `services`: this is the load-bearing readiness question for a services business specifically —
  readiness = can the founder hire and train delivery capacity (new billable staff/contractors
  ramped to full productivity) faster than new client commitments are being made, since services
  scaling is capacity-constrained in a way product businesses aren't (each new client consumes
  real delivery hours, not marginal infra cost). Ask directly whether there's a credible hiring/
  training plan and timeline, and whether it out-paces the rate new business is being sold. Fail
  if new business is being sold faster than delivery capacity can be credibly added.
- `physical_product`: capacity includes fulfillment/production/supply-chain throughput, not just
  founder time — ask whether manufacturing lead time and fulfillment capacity can support the
  volume being considered without stockouts or lead-time blowups.
- `marketplace`: capacity includes whether trust & safety / support can keep pace with both sides
  at higher volume (dispute resolution, quality control, fraud) — a liquidity engine that holds at
  current volume can still break at higher volume if support/trust infrastructure doesn't scale
  with it.
- `saas`, `consumer_app`, `other`: as originally written — founder/team time, cash (cross-checked
  against the latest runway classification), and team bandwidth to execute without breaking
  something currently working.

## Verdict logic

- **Ready:** every criterion passes on real evidence. No criterion may be marked pass on
  "probably fine" — cite the specific evidence for each.
- **Conditionally ready:** no criterion fails outright, but one or more are insufficient-data.
  State exactly what data/time would resolve each one.
- **Not ready:** any single criterion fails outright. One credible blocking failure blocks the
  verdict — mirror CONVENTIONS.md §6's council rule (the harshest credible finding governs, it
  isn't averaged away by passing criteria elsewhere).

Never default to "ready" because the founder is eager or the conversation has momentum — every
criterion must be checked against its actual evidence bar.

## Output file: `ops/<timestamp>-scaling-readiness.md`

Timestamp format `YYYY-MM-DD`; append `-2`, `-3`... for a same-day rerun.

```markdown
# Scaling Readiness Check — <business name> — <date>

## Checklist
| # | Criterion | Evidence | Result |
|---|---|---|---|
| 1 | Unit economics hold, not widening | ... (cite source file/period) | pass/fail/insufficient-data |
| 2 | Retention curve flattening | ... | pass/fail/insufficient-data |
| 3 | Repeatable, costed sales process | ... | pass/fail/insufficient-data |
| 4 | MVBP/dogfood signal holds in production | ... | pass/fail/insufficient-data |
| 5 | Product plan supports this scale | ... | pass/fail/insufficient-data |
| 6 | Founder/team capacity | ... (cross-checked against latest runway classification) | pass/fail/insufficient-data |

## Verdict: <Not Ready | Conditionally Ready | Ready>

## What would change this
<For every non-pass criterion: the specific next milestone or data point needed before
re-checking. Never leave a non-pass criterion without a concrete next step.>
```

## Update `business-state.json`

Append `ops/<timestamp>-scaling-readiness.md` to `ops.cadence_metrics_files`. If the verdict is
Not Ready and the founder is already spending meaningfully against a scale-up despite it, append a
`risk_log` entry per the schema in `agents/ops/scaling-strategist.md` — read-modify-write the
whole file, preserve every other key.

## Never fabricate, never rubber-stamp

Every criterion's evidence traces to an actual snapshot file or a direct founder answer this
session. A criterion with no real evidence is insufficient-data, not a generous pass.

## Done means

- All six criteria evaluated with cited evidence and an explicit pass/fail/insufficient-data.
- An overall verdict stated plainly, following the one-fail-blocks rule.
- Every non-pass criterion has a specific, concrete next milestone attached.
- `ops/<timestamp>-scaling-readiness.md` is written and registered in `business-state.json`.
