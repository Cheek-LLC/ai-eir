---
name: experimentation-and-optimization
description: >
  Use when `growth-analyst` or the founder wants to systematically test a change instead of
  guessing at it — "should we test this," "what should we experiment on next," "is this A/B test
  result actually real," "how long do we need to run this before we know," or after
  `weekly-metrics-review` surfaces a funnel stage that's underperforming. Ranks candidate
  experiments against that skill's actual funnel/conversion data using an ICE (Impact/Confidence/
  Ease) score, sets a minimum sample size and run duration before any result is allowed to be
  called, and logs every test in an append-only `ops/experiments-log.md`. A shipped, statistically
  valid result is the one legitimate way to update `quantitative_claims[]` with a tested number
  instead of the plan's original estimate. Trigger also on "our funnel is leaking," "prioritize
  our growth experiments," or "did that pricing test actually work."
---

# Experimentation and Optimization

You are running this business's experimentation function: the discipline that turns "I think
changing the headline would help" into either a shipped, measured improvement or a documented
kill — never into a permanent vibe. The single most common failure mode this skill exists to
prevent is a founder calling a test "won" on 40 visits because the variant happened to have 2
more conversions than the control. That is noise, not a result, and treating it as one is worse
than not testing at all, because it launders a coin flip into false confidence that then
contaminates `quantitative_claims[]`.

This is a planning and analysis aid, not a statistics course or a substitute for a real
experimentation platform once the business has the traffic to justify one — but within that
scope it must be rigorous, not a gesture at "try A/B testing."

## What you read

- `.startup/<slug>/business-state.json` in full — `quantitative_claims` (every entry tagged
  step_ref 08, 16, 17, 19 in particular, since those are the ones this skill's shipped results
  feed back into), `business_basics.business_type`.
- `.startup/<slug>/ops/kpi-dashboard.md` — the KPI set and target bands experiments should move.
- Every `.startup/<slug>/ops/*-growth-metrics.md`, most recent first — this is where real funnel
  numbers, stage-to-stage conversion rates, and the **funnel losses** table
  (`weekly-metrics-review`'s Step 1 field: prospect/company, stage lost at, reason) actually live.
  Candidate experiments are sourced from this data, not brainstormed in the abstract.
- `.startup/<slug>/gtm/positioning.md`, if it exists — messaging pillars, tagline options, and
  objection-handling content are a direct source of messaging experiments (see below).
- `.startup/<slug>/plan/16-set-your-pricing-framework.md`, `plan/17-calculate-the-ltv-of-a-customer.md`,
  `plan/19-calculate-the-coca.md` — the pricing, LTV, and COCA figures an experiment might test
  or eventually supersede.
- `.startup/<slug>/ops/experiments-log.md`, if it exists — the full running history. Read it
  before proposing new experiments so you don't re-run something already tried, and so ICE
  scoring for "Confidence" can use a prior real result on a related change, not just a guess.

## What you write

- `.startup/<slug>/ops/experiments-log.md` — **append-only**. Every experiment ever designed or
  run lives in this one file, oldest first; you never create a new per-experiment file and you
  never delete or rewrite a past entry (a killed or superseded experiment stays in the log with
  its own decision — the log's value is the accumulated history, including the losses).
- `.startup/<slug>/business-state.json` — `quantitative_claims[]`, only the specific entries a
  shipped, statistically valid experiment result actually supersedes (see "Closing the loop"
  below). Never touch any other top-level key.

## Step 1: Source and rank candidate experiments (ICE)

Pull candidates from real data, not intuition, in this priority order:

1. **The biggest stage-to-stage drop** in the most recent `growth-metrics.md`'s derived
   conversion rates — the stage losing the most people is where a fixed percentage-point gain is
   worth the most in absolute customers.
2. **The funnel losses table's stated reasons** — a repeated reason ("too expensive," "didn't
   understand what it does," "no reply after demo") is a pre-validated hypothesis source; you
   don't have to guess why people are dropping when founders have already told you in their own
   words across several logged losses.
3. **`gtm/positioning.md`'s messaging pillars and tagline options**, if a pillar or tagline was
   flagged as a tradeoff rather than a clear winner — that's a candidate headline/copy test.
4. **`plan/16-set-your-pricing-framework.md`'s "Sensitivity read"** — if pricing was never
   actually tested with real prospects (the plan says so honestly), that's a live candidate, not
   settled fact.
5. **Onboarding/activation** — for any business type, the signup-to-activated step
   (`weekly-metrics-review`'s `saas` activation rate, or the equivalent first-value moment for
   other types) is almost always under-optimized in an early business and worth a standing slot
   on the candidate list even without a single dramatic funnel-loss reason.

Score every candidate on **ICE** — Impact, Confidence, Ease, each 1–10, averaged:

- **Impact**: the realistic effect on the target metric if the hypothesis is right, weighted by
  how many people pass through that stage. A 2x improvement on a stage 3% of visitors reach
  scores lower than a 20% improvement on a stage 80% of visitors reach — compute this from the
  actual stage volumes in the metrics file, don't eyeball it.
- **Confidence**: evidence quality behind the hypothesis. A repeated, specific reason from the
  funnel losses table or a prior related experiment result scores high; a hunch with no backing
  data scores low (2–3, honestly, not padded to make the candidate look better).
- **Ease**: inverse of effort *and* — this is the part founders skip — inverse of how long this
  stage's current traffic will take to reach the minimum sample size from Step 2 below. A trivial
  one-line copy change on a stage with almost no traffic is not "easy" in the sense that matters;
  it will sit unresolved for months. Fold expected time-to-valid-result into this score, not just
  implementation effort.

Rank by average ICE score. **Surface the top 3, not just the winner** — when reporting to the
founder or to `growth-analyst`, always present a ranked shortlist with each score's components
shown, not a single silently-chosen pick. The founder may reasonably override the ranking (e.g.
they have a strategic reason to test pricing now regardless of ICE) — that's a legitimate
decision, but log it as a deliberate override in the experiment's Notes field, not as if ICE
picked it.

## Step 1.5: Check viability BEFORE designing anything (round 10 fix)

Before investing effort in Step 2's hypothesis/variant design, do a rough viability check for the
top-ranked candidate using the business's own real, current volume at that funnel stage (from
`weekly-metrics-review`/`kpi-dashboard.md` — actual entries-per-period, not a hypothetical):

1. Take the candidate's real baseline rate and a plausible relative lift (even a bold, generous
   one — 30-50%), and look up (or compute via Step 3's formula) the required sample size per
   variant.
2. Divide that by the business's real per-period volume at that stage to get a rough
   **periods-to-valid-sample** figure.
3. **If that figure is wildly impractical for this business's actual scale** (many months or
   years, not a handful of check-in cycles) — this is common and expected for early-stage,
   low-volume, or B2B/high-touch funnels, not a failure of the candidate idea — do not proceed to
   Step 2's test design at all. Route the underlying question through qualitative signal instead
   (funnel-loss reasons already on file, a direct founder conversation, a small number of
   structured prospect interviews) and say so plainly in your report to the founder, including the
   actual arithmetic that shows why. This is very often the right, honest answer for a real
   early-stage business — treat it as a legitimate outcome of this skill, not a failure to find
   something testable.
4. Only candidates that clear this rough check move on to Step 2's full design — don't build a
   hypothesis and variant for something the arithmetic already rules out; that wastes the
   founder's time reading a plan for a test that was never going to be runnable. (Step 3 repeats
   this arithmetic more rigorously once a test is actually designed — this step is a cheap,
   early filter, not a replacement for Step 3's full check before calling a result.)

## Step 2: Design a single-variable test

- One hypothesis, one changed variable, one target metric. "Redesign the landing page" is not a
  test; "change the hero headline from X to Y" is.
- State the hypothesis in the form: "If we change **[X]**, then **[metric]** will
  **[improve/decrease]** by roughly **[magnitude]**, because **[reasoning/evidence from Step 1]**."
- Name the exact target metric using the **same field name** `weekly-metrics-review` or
  `kpi-dashboard.md` already uses for it (e.g. "signup → paying conversion %," not a new
  ad hoc name) — this is what lets a shipped result map cleanly back into the KPI set and into
  `quantitative_claims[]` later.

## Step 3: Statistical rigor — how much data before a result means anything

This is the discipline most early-stage tests skip entirely. Apply it every time, without
exception, before calling any result.

### The core rule of thumb (sample size)

For a simple conversion-rate test (control vs. one variant), use this approximation for 80%
power at 95% confidence (the standard planning approximation used by most A/B test calculators):

```
n per variant ≈ 16 × p × (1 − p) / d²
```

where **p** is the baseline conversion rate (as a decimal) and **d** is the *absolute*
minimum difference you want to reliably detect (also as a decimal — e.g. detecting 5%→6% is
d = 0.01, not d = 0.20). This is computable in any spreadsheet; you don't need a stats package.

**Worked reference table** — sample size needed *per variant* (round up), by baseline rate and
the *relative* lift you want to be able to detect:

| Baseline rate | Detect 50% relative lift | Detect 30% | Detect 20% | Detect 10% |
|---|---|---|---|---|
| 2% | ~3,150 | ~8,700 | ~19,600 | ~78,400 |
| 5% | ~1,220 | ~3,380 | ~7,600 | ~30,400 |
| 10% | ~580 | ~1,600 | ~3,600 | ~14,400 |
| 20% | ~260 | ~710 | ~1,600 | ~6,400 |

Read this table plainly with the founder: **the smaller the effect you're hoping for, and the
lower the baseline rate, the more traffic you need — often far more than an early-stage business
has in a month.** If a stage gets 200 visits a period, do not design a test hoping to detect a
10% relative lift on a 5% baseline rate (that needs ~30,400 per variant, i.e. over a hundred
periods) — either pick a bigger, bolder variant that could plausibly move the needle 30–50%
relatively, or accept up front that this stage can't be validly A/B tested at current traffic
and route the change through qualitative signal (funnel-loss reasons, direct founder
conversations) instead of a numbers-based test you can't actually power.

### The minimum-conversions floor (not just visitors)

Independent of the formula above: **never trust a result with fewer than roughly 100 conversions
(not 100 visitors — 100 completed conversions/signups/purchases) in the *smaller* of the two
arms.** This is a blunt but load-bearing industry heuristic. A test with a 40%-vs-25% conversion
split that "won" on 12 conversions vs. 7 is not a result — it's within the range two fair coins
would produce by chance. If the sample-size formula above and this floor disagree, use whichever
is larger.

### Duration, not just count

Hitting the sample-size number early (e.g. from a weekend traffic spike) is **not** a green
light to call the test. Run every test for a **minimum of one full week, and ideally two full
business cycles**, regardless of how fast the sample accumulates — day-of-week and
time-of-month effects (weekday B2B traffic vs. weekend consumer traffic, pay-period timing for
purchases, etc.) will bias a short window even at "enough" raw sample size. State both the
sample-size target and the minimum-duration target before the test starts, and require both to
be satisfied before reading a result — whichever binds later.

### Don't peek and stop early

Pre-commit to the sample size and duration *before* looking at interim results. Checking the
numbers daily and stopping the moment the variant looks ahead inflates the false-positive rate
substantially (this is the well-documented "peeking problem") — an interim lead that looks
exciting on day 2 routinely evaporates by day 10. The only legitimate reason to stop a test
early is a clear operational or revenue-harm signal (the variant is visibly breaking something),
not an early lead you're excited about.

### The actual significance check

Once both the sample-size and duration minimums are met, compute:

```
p_pool = (conversions_control + conversions_variant) / (n_control + n_variant)
z = (rate_variant − rate_control) / sqrt( p_pool × (1 − p_pool) × (1/n_control + 1/n_variant) )
```

- **|z| ≥ 1.96** → statistically significant at ~95% confidence. Trustworthy in the direction
  the sign of z indicates.
- **|z| < 1.96** → not distinguishable from noise, *no matter how large the raw percentage gap
  looks*. A variant reading "38% vs 31%" on small-enough n can still fail this check — report
  the z-score alongside the raw numbers every time so this isn't hidden.
- A |z| between roughly 1.0 and 1.96 with both minimums met is a genuinely inconclusive result,
  not a lean — treat it as Step 5's "inconclusive/retest" outcome, not a soft ship.

Also distinguish **statistical significance from practical significance**: a significant result
on a 0.3-percentage-point lift may be real but too small to be worth the implementation/maintenance
cost of shipping it. State both — is it real, and is it big enough to matter — before deciding.

## Step 4: The experiment log (append-only)

Output file: `.startup/<slug>/ops/experiments-log.md`. Append a new entry per experiment; never
edit or delete a past entry's outcome. If an experiment is later revisited (a retest), it gets a
new entry that references the earlier one's id, not an edit to the original.

```markdown
# Experiments Log — <business name>

## EXP-<NN> — <short title>
**Started:** <date> | **Concluded:** <date, or "running"> | **Status:** running | shipped | killed | inconclusive-retest | not-quantitatively-testable

(`not-quantitatively-testable` — round 10 addition — is the correct status when Step 1.5 or Step 3's
arithmetic, run honestly against this business's real volume, shows no plausible variant reaches a
valid sample size in a usable timeframe. This is a real, complete outcome of doing this skill's job
rigorously, not an incomplete or failed entry — log it with the arithmetic shown, same as any other
status, and route the underlying question to qualitative signal per Step 1.5.)

**Hypothesis:** If we change [X], then [target metric] will [improve/decrease] by roughly
[magnitude], because [reasoning/evidence].

**Target metric:** <exact field name as used in weekly-metrics-review / kpi-dashboard.md>
**Sourced from:** <funnel-loss reason | stage drop-off | positioning.md pillar | pricing sensitivity gap | onboarding>

**ICE score:** Impact <n>/10, Confidence <n>/10, Ease <n>/10 → Average <n>/10
(Ranked #<n> of <n> candidates considered this cycle — see shortlist below if this is a fresh
prioritization entry.)

**What changed (variant vs. control):** <single-variable description>

**Baseline (control) rate:** <p>
**Minimum detectable effect targeted:** <d, absolute and relative>
**Required sample size per variant (formula):** <n>
**Required minimum duration:** <days/weeks>

**Sample reached:** control n=<...>, conversions=<...> | variant n=<...>, conversions=<...>
**Duration actually run:** <days>
**z-score:** <value> | **Significant (|z|≥1.96)?** yes/no | **Direction:** <control/variant favored>
**Practically significant?** <yes/no — is the effect size, if real, big enough to matter>

**Decision:** SHIP | KILL | INCONCLUSIVE — RETEST
**Reasoning:** <one or two sentences tying the decision directly to the numbers above>

**quantitative_claims update (if SHIPPED and this changes a plan figure):** entry id
`<qc-...>` updated from `<old value>` (source: <old source>) to `<new value>` (source: internal
experiment, see ops/experiments-log.md#EXP-<NN>).

**Notes:** <anything else — including if the founder overrode the ICE ranking to run this>
```

## Step 5: Decision rules (ship / kill / inconclusive-retest)

- **SHIP**: both minimums met, |z| ≥ 1.96 in the hypothesized direction, and the effect is
  practically significant (worth the cost to implement permanently). Update
  `quantitative_claims[]` per Step 6 if the result touches a plan figure.
- **KILL**: either minimums met and |z| ≥ 1.96 against the hypothesis (variant made it worse),
  or minimums met and the confidence interval sits tightly around zero (a real, precise
  "no effect" read) — a clean kill is a valid, useful result, not a failure of the test.
- **INCONCLUSIVE — RETEST**: minimums not yet met and the test is still running (not yet a
  decision point), or minimums met but |z| lands in the ambiguous 1.0–1.96 band. A retest means
  either running longer for more sample, or redesigning with a bigger, bolder variant that could
  plausibly clear the detectable-effect bar from Step 3's table — not repeating the identical
  test hoping for a different roll.

Never let an experiment sit at "running" indefinitely without a next check-in date — note the
date the sample/duration minimums are expected to be reached when you log the experiment as
started, so `growth-analyst` knows when to come back to it.

## Step 6: Closing the loop — updating `quantitative_claims[]`

The Data Contract requires every number presented as fact in the plan to have a sourced entry in
`quantitative_claims[]`, with "no invented numbers" as the governing rule. A **completed,
statistically valid experiment result is itself a valid source** — arguably the strongest one
available, since it's tested reality rather than an estimate. This is the explicit exception
that closes the optimization loop:

- When a SHIPPED experiment's result is a number that already has (or should have) a
  `quantitative_claims[]` entry — a conversion rate feeding step 19's COCA, a validated price
  point from step 16, an LTV-relevant retention/expansion number from step 17, a value-prop claim
  from step 08 — update that entry:
  - `value`: the new, tested number.
  - `source`: `"internal experiment, see ops/experiments-log.md#EXP-<NN>"`.
  - `confidence`: raise to `"high"` — it is now measured, not estimated, as long as Step 3's
    minimums were genuinely met (never raise confidence on a result that skipped the sample-size
    or duration gate).
  - `ai_risk_flag`: `false`, since this is now a sourced, tested figure.
  - Keep the entry's `id` and `step_ref` unchanged — you are updating the value of an existing
    claim with better evidence, not creating a new claim or reassigning it to a different step.
  - If no matching entry exists yet (the plan never had a `quantitative_claims` entry for this
    number), add a new one with a fresh id, the correct `step_ref`, and the same source/confidence
    convention above.
- **Never** update a `quantitative_claims[]` entry from an experiment that didn't clear Step 3's
  minimums, and never backfill a plausible-sounding number into the log to justify an update —
  the log and the state file must stay in lockstep with what was actually run.
- This update is `growth-analyst`'s to make (via this skill), not any other agent's — note it
  explicitly in the experiment log entry itself so the change is traceable to the exact
  experiment that justified it, not a silent edit.

## Never fabricate

Every rate, sample size, and z-score in the log traces to real counts the founder reported or
that came from a connected analytics tool via `connectors-liaison` (per `growth-analyst`'s own
connector discipline — this skill does not pull data itself). An experiment the founder describes
from memory without real numbers is a hypothesis worth logging as a *candidate*, not a concluded
result — log it as "running" or "not yet started" and say so, never backfill a plausible outcome.

## Done means

- Candidate experiments are sourced from real funnel/loss data, ICE-scored, and the top 3 are
  presented as a ranked shortlist with visible score components — not a single silent pick.
- Every logged experiment states its hypothesis, target metric, required sample size and
  duration *before* claiming a result, and the actual z-score behind any ship/kill call.
- No result is called "won" or "lost" below the sample-size floor, the ~100-conversions-per-arm
  floor, or the minimum-duration floor — whichever binds.
- `ops/experiments-log.md` is append-only and growing, never rewritten.
- Any `quantitative_claims[]` update traces to a specific, statistically valid experiment id in
  the log, with source, confidence, and risk flag all updated consistently.
