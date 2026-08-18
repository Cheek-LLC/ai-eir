# QA Findings — Round 10: Pricing and Monetization Optimization

**Method.** This is a live dry run, not a read-through, of two never-before-executed files:
`skills/ops/pricing-and-monetization-optimization/SKILL.md` and `agents/ops/pricing-strategist.md`.
Work happened exclusively inside an isolated copy of the real fixture,
`.startup/shiftcover-t10-pricing/` (created via `cp -r .startup/shiftcover
.startup/shiftcover-t10-pricing`, with `business-state.json.slug` updated to
`shiftcover-t10-pricing`); the original `.startup/shiftcover/` was never modified (verified by
diff at the end of this run). Before executing anything, `CONVENTIONS.md`, `docs/DATA-CONTRACT.md`,
the fixture's real `business-state.json`, `plan/16-set-your-pricing-framework.md`, and
`plan/17-calculate-the-ltv-of-a-customer.md` were read in full, followed by the full text of both
target files.

Two scenarios were then actually executed against the copy, both producing real files, not
hypothetical write-ups:

1. **No-trigger scenario (honest precondition test).** The fixture's real state — `stage:
   "approved"`, `gtm.status: "not_started"`, `ops.status: "not_started"`, an empty `ops/`
   directory, `ka-016-price-point.test_result: null` — was used as-is, with no fabricated data.
   The skill was invoked as if the founder asked "should we revisit our pricing?" this session,
   and walked through the skill's Reads-section precondition and Step 1's five trigger categories
   against the real (empty) evidence. This produced `ops/pricing-review-2026-08-28.md`, with
   `business-state.json.ops.cadence_metrics_files` updated to register it. **No number was
   invented and no `quantitative_claims`/`key_assumptions` entry was touched.**
2. **Synthetic-trigger scenario (packaging/execution/feedback-loop test).** A clearly-labeled test
   artifact, `ops/synthetic-test-signal.md`, was added to the copy only, describing a fabricated
   but internally consistent price-reaction pattern (10 conversations across 2 periods at $149/
   location/month, 10% acceptance; a subsequent 5-conversation test of $99/location/month, 80%
   acceptance) explicitly marked TEST-ONLY SYNTHETIC throughout, tied to the real
   `ka-016-price-point` test plan already in the fixture. The skill was re-run against this
   synthetic evidence, producing `ops/pricing-review-2026-09-12.md`, which walked through Step 2
   (packaging/value-metric analysis), Step 3 (price-change execution discipline), Step 4
   (decision), and Step 5 (feedback into `quantitative_claims`/`key_assumptions`/`risk_log`),
   including a role-played run of the mandatory `skills/risk/ai-risk-review` gate (via
   `agents/risk/ai-risk-analyst.md`'s stated four checks) against the new review file and the
   proposed `quantitative_claims` edits before finalizing them. Every synthetic figure and every
   file/field it touches is labeled TEST-ONLY SYNTHETIC inline, specifically so this cannot be
   mistaken for real ShiftCover data if the test copy is read later.

Every file created or modified in this run is under `.startup/shiftcover-t10-pricing/` or this
findings document; no skill/agent file, `CONVENTIONS.md`, `docs/DATA-CONTRACT.md`, or the original
`.startup/shiftcover/` was edited.

## Headline finding: the no-fabrication discipline held — this is a PASS

Given `stage: "approved"`, zero `ops/*` snapshot files, and no real pricing conversations logged
anywhere in `interview-log.md`, the skill was asked (via a role-played direct founder question)
whether to revisit pricing. Followed faithfully, it does **not** produce a fabricated
recommendation. Two separate mechanisms in the skill text both correctly catch this case:

- The **Reads section's own precondition** ("Confirm `stage` is `operating`... or the founder has
  explicitly asked... mid-`gtm` after a soft launch") is not met — this business hasn't even
  started GTM, let alone soft-launched.
- **Step 1's trigger check**, run anyway for completeness, finds literally zero of the five
  trigger categories has any cited data behind it — not a weak signal, no signal at all.
- The **"Never fabricate" section** names this exact situation explicitly ("If the underlying ops
  snapshots don't exist yet... say so and stop... this skill should not manufacture a review out
  of the plan figures alone") and that is what happened: `ops/pricing-review-2026-08-28.md`
  concludes "No trigger present — no operating data exists to review pricing against," touches no
  `quantitative_claims` entry, logs no `risk_log` entry, and does not invoke the AI-risk gate
  (correctly, per the skill's own carve-out for reviews that touch no claims).

This is the single most important result of this round: **the skill did not take the bait of an
eager "should we revisit pricing" prompt with nothing behind it, and did not manufacture a
plausible-sounding trigger to justify having been invoked.** This is exactly the discipline
`docs/DATA-CONTRACT.md` and `CONVENTIONS.md` exist to enforce plugin-wide, and it held on first
live execution.

## Secondary result: the synthetic-trigger scenario worked end-to-end

With `ops/synthetic-test-signal.md` in place, the same skill correctly:

- **Named a real trigger with cited numbers** (10% acceptance across 2 sustained periods, n=10 —
  meeting the skill's own "sustained across 2+ periods" and "~5 per arm" bars), rather than
  treating a single batch as sufficient.
- **Ran a genuinely constrained packaging analysis.** This was the most instructive part of the
  exercise: even with a real (synthetic) trigger, the skill's own Step 2 method ("tier boundaries
  should come from real usage clusters in the actual customer base") **cannot actually run**,
  because there are still zero real customers and zero usage data — only pre-sale price reactions.
  The review correctly refused to invent tier boundaries from nothing, explicitly separating what
  the evidence *can* support (a price-level read) from what it *cannot* (a real tiering redesign
  or the value-metric-misalignment diagnostic, both of which need usage data this trigger doesn't
  provide). This is the skill correctly applying its own "invented without looking at real usage
  distribution is exactly the kind of unsourced number this plugin's AI-risk discipline exists to
  catch" warning to itself, live.
- **Applied Step 3's execution discipline with real judgment, not boilerplate.** Grandfathering
  and communication planning were correctly marked N/A with a stated reason (no existing paying
  customer exists to protect or notify) rather than filled with generic language. The phased-test
  design correctly flagged that a genuine control cohort isn't feasible yet given the beachhead's
  own thin prospect pool (`ka-009-prospect-count`) — a real constraint from this business's actual
  plan, not a templated caveat.
- **Ran the Step 4/Step 5 feedback loop correctly, including the confidence-inflation trap.** A
  single period at the new $99 price ($4/5 acceptance) was explicitly *not* allowed to raise
  `confidence` above `low` or be presented as the settled new price — the review held itself to
  the same 2-sustained-period bar it applied to the original $149 finding. `qc-016-price` and
  `qc-017-ltv` were updated via read-modify-write, preserving the old figures inline in the
  `source` string (per the skill's own instruction) rather than deleting the trail, and
  `ka-016-price-point.test_result` was filled in for the first time.
- **Actually invoked the mandatory AI-risk gate before finalizing**, per the skill's own
  "Mandatory AI-risk gate" section — not skipped because "the sourcing already looked careful."

## Real gaps found (the valuable part of this round)

**1. `quantitative_claims.source` string convention conflicts with `docs/DATA-CONTRACT.md`.**
The skill's Step 5 instructs: `source` to `"operating data, see ops/pricing-review-<date>.md"`.
`docs/DATA-CONTRACT.md`'s Conventions section states every `quantitative_claims` source must be
one of exactly three kinds: `"founder estimate"`, `"web research (cite URL)"`, or `"industry
benchmark (cite)"`. `"operating data, see ops/..."` matches none of the three literally — it's a
plausible, traceable fourth category the Data Contract simply doesn't name yet. This is not a
fake-sourced claim in spirit (it's fully citable and dated), but it is a genuine schema-drift gap:
this new skill was built against a source-string convention the shared Data Contract doesn't
document, which is precisely the kind of drift `CONVENTIONS.md` §5 says to avoid ("If your
agent/skill needs a new field, add it to that doc in the same PR/commit"). **Recommendation:** add
a fourth canonical source kind (e.g. `"operating data (cite ops file)"`) to
`docs/DATA-CONTRACT.md` in the same change that keeps this skill's Step 5 wording, or reframe the
skill's wording to nest under `"founder estimate"`. Logged in the test copy as
`ar-shiftcover-t10-pricing-001` (advisory), not fixed here — out of this QA agent's file scope.

**2. Updated `quantitative_claims` can silently orphan the `disciplined_entrepreneurship` step
summaries that describe the same numbers.** The skill's Step 5 read-modify-write scope is
explicitly limited to `quantitative_claims`/`key_assumptions`/`risk_log` — it never touches
`business-state.json.disciplined_entrepreneurship.16_set_your_pricing_framework.summary` or
`.17_calculate_the_ltv_of_a_customer.summary`. After this run, those two summary strings still
read the original $149/$52,503 figures with no pointer that a live pricing-optimization pass has
since superseded them — a reader skimming the DE-step list (rather than the full
`quantitative_claims` array) would see stale numbers with no flag. This is exactly the kind of gap
the Data Contract's `NEEDS RE-CONFIRMATION:` summary-prefix convention (documented for a different
trigger — post-pivot reopening) could plausibly be reused for, but the pricing skill doesn't
reference or use it. **Recommendation:** either extend Step 5's scope to add a brief pointer note
on the relevant DE-step summaries, or explicitly adopt the `NEEDS RE-CONFIRMATION:` convention for
this case. Logged in the test copy as `ar-shiftcover-t10-pricing-002` (advisory).

**3. Step 1's trigger taxonomy doesn't cleanly cover the exact evidence `ka-016-price-point`'s own
test plan is designed to produce.** `ka-016-price-point.test_plan` asks the founder to "state this
price in the next 5 real sales conversations... and record reactions" — a direct price-reaction
pattern from early sales conversations. Step 1's five trigger categories are framed around
`ops/*-growth-metrics.md`-style conversion rates, a "paying more without pushback" pattern, feature
requests, churn concentration, and ARPU/LTV drift — none names "founder states price out loud,
gets uniform pushback" as its own category, even though this is the single most obvious way a
pre-launch or early-launch SaaS business would generate its very first pricing signal, and even
though the plan's own Step 16 explicitly set up this exact test. Trigger #1 (conversion-rate
divergence) was used as the closest analog in this run, but it's an imperfect fit — Trigger #1
expects a rate to compare against an explicit assumed-conversion baseline, and Step 16 states no
such baseline (only a price point and a value-capture ratio). **Recommendation:** consider adding
an explicit sixth trigger category (or folding it clearly into #1) for "the price was stated
out loud in real conversations and the reaction pattern is recorded" — the single most common
first real evidence a young business will actually have, and the exact shape `ka-016-price-point`
itself was designed to produce.

**4. A genuine ambiguity between "stop" and "write the file" in the no-data case.** The skill's
"Never fabricate" section says to "say so and stop" when no ops snapshots exist at all — read
literally, this could mean the skill shouldn't produce `ops/pricing-review-<timestamp>.md` at all
in this case. But "Done means" unconditionally lists `ops/pricing-review-<timestamp>.md` is
written as a completion criterion, and Step 1 also separately says to "stop here and report" (which
sounds like it still produces a report). This run resolved the ambiguity by writing a short,
honest file documenting the stop (no analysis fabricated, no claims touched) — which seems like
the more useful reading (it leaves an audit trail that a review was actually attempted and
correctly declined) — but the skill text doesn't fully resolve which behavior is intended, and a
differently-inclined execution could plausibly skip writing anything. **Recommendation:** state
explicitly in the skill that even a no-data stop still produces a minimal review file recording
the stop, for the audit trail.

## Non-findings — things that worked as designed and are worth naming as such

- The skill and agent's "insufficient data" vs. "no change warranted" vs. "no trigger present"
  three-way distinction is real and was exercised meaningfully in this run's two scenarios — they
  are not the same finding wearing different labels.
- The agent's delegation boundary (real billing/payments reconciliation goes through
  `connectors-liaison`, never pulled directly) was read and is consistent with the rest of the
  plugin's connector-gating pattern; not exercised live this round since no connector scenario was
  in scope, but no red flags found in the text.
- The skill correctly never touched `plan/16-set-your-pricing-framework.md` or
  `plan/17-calculate-the-ltv-of-a-customer.md` themselves in either scenario, exactly as its own
  "What this skill is, and what it explicitly is not" section requires.

## Files produced this round (all inside the isolated test copy)

- `.startup/shiftcover-t10-pricing/business-state.json` — `slug` updated; scenario 2 applied
  read-modify-write updates to `qc-016-price`, `qc-017-ltv`, `ka-016-price-point.test_result`,
  three new `risk_log` entries (`ar-shiftcover-t10-pricing-001`, `-002`,
  `ops-shiftcover-t10-pricing-001`), and `ops.cadence_metrics_files`. Validated as well-formed
  JSON after all edits.
- `.startup/shiftcover-t10-pricing/ops/pricing-review-2026-08-28.md` — scenario 1 output (no
  trigger, no fabrication).
- `.startup/shiftcover-t10-pricing/ops/synthetic-test-signal.md` — the QA-authored, clearly-labeled
  synthetic operating-data artifact used only for scenario 2.
- `.startup/shiftcover-t10-pricing/ops/pricing-review-2026-09-12.md` — scenario 2 output (trigger
  present, full Steps 1-5 exercised, AI-risk gate role-played).
