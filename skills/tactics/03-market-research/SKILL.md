---
name: 03-market-research
description: >
  Use once a business's plan is approved and the founder is about to spend real money on
  marketing (Tactic 5) or product (Tactic 7+) — runs Tactic 3, Advanced Primary & Secondary
  Market Research, deepening DE Steps 1/3/4/5's plan-stage research with real customer
  interviews, a scaled survey, and sourced industry/competitor data. Starts qualitative, shifts
  to quantitative once patterns emerge. Triggers: "validate our market before we spend," "run
  real customer research," "test our assumptions with real data," "deeper market research,"
  "survey our target customers." Distinct from Steps 1-5: this tests what the plan assumed, it
  does not re-derive the beachhead, TAM, or persona from scratch.
---

# Tactic 3: Market Research — Advanced Primary & Secondary Market Research

## Role in the 15 tactics

Second of four Market Testing tactics (3-6), and the one that comes first among them: before a
founder spends real budget on Tactic 5's advertising test or Tactic 6's demand generation, this
tactic checks whether the plan-stage research (DE Steps 1-5) actually holds up under rigor
heavier than a handful of founder conversations. Steps 1 (`market-segmentation`), 3
(`build-an-end-user-profile`), 4 (`calculate-the-tam-for-the-beachhead-market`), and 5
(`profile-the-persona-for-the-beachhead-market`) built the plan's working model of the customer
and the market. This tactic does not re-derive any of that — it tests it, with primary research
(customer interviews, then a survey) and secondary research (industry data, competitor
analysis), and reports back exactly which assumptions held, which didn't, and which numbers now
have real evidence behind them instead of a founder's best guess.

## What you read

- `.startup/<slug>/business-state.json` — whole file. Read `business_basics.business_type` (see
  business-type branching below), `key_assumptions` (your research backlog — see §1), and
  `quantitative_claims` (flag any entry sourced only "founder estimate" tied to steps 1/3/4/5 —
  those are upgrade candidates for this tactic's secondary research).
- `.startup/<slug>/plan/01-market-segmentation.md` and
  `.startup/<slug>/plan/02-select-a-beachhead-market.md` — the beachhead this research should
  stay scoped to. Do not let interview/survey recruiting drift into the broader TAM; a founder
  under time pressure will want to talk to anyone who'll answer, and that dilutes the test.
- `.startup/<slug>/plan/03-build-an-end-user-profile.md` — the aggregate filter your interview
  and survey recruiting criteria must match.
- `.startup/<slug>/plan/04-calculate-the-tam-for-the-beachhead-market.md` — the sizing math and
  its sourced/unsourced inputs; secondary research's job includes replacing weak inputs here with
  sourced ones.
- `.startup/<slug>/plan/05-profile-the-persona-for-the-beachhead-market.md` — the specific
  behavioral predictions (goals, frustrations, trusted sources, decision-making style) this
  tactic's interviews and survey are built to confirm or break.

If steps 1, 3, 4, and 5 aren't at least `drafted`, stop and say so — there is nothing concrete
here yet to test.

## 1. Build the research backlog before designing a single question

Pull every `key_assumptions` entry whose `step_ref` points at 01-05, plus any low-confidence
`quantitative_claims` sourced only as "founder estimate" from the same steps. This list — not a
generic market-research checklist — is what this tactic exists to work through. For each entry,
write one line: what specifically would confirm it, what would break it, and whether that's best
tested qualitatively (a belief, a stated preference, a workflow description) or quantitatively (a
number: willingness to pay, market size, frequency of the problem). Assumptions with no realistic
way to test them within this tactic's scope (e.g. a claim only a live product could settle) get
flagged and handed to a later tactic (Tactic 9, User Testing) rather than forced into an interview
question that can't actually answer it.

## 2. Phase 1 — qualitative primary research (interviews)

This goes beyond Step 3/5's interviews, which were about *defining* the profile and persona. Here
the questions are about *testing specific claims* already on the backlog.

- **Sample target**: 10-15 people matching the Step 3 profile, recruited through the persona's
  actual trusted channels/sources named in Step 5 — not a generic outreach blast. If the founder
  can only reach 5-6 in a reasonable window, proceed and say so plainly rather than padding the
  count with people who don't match the profile.
- **Guide design**: one question per backlog item, written open-ended and non-leading. Never ask
  "would you pay $X for this" (a hypothetical yes is nearly worthless evidence) — ask about
  current behavior instead: what do they use today, what does it cost them (time, money,
  workaround pain), what would make them switch, what have they already tried and rejected.
  Behavior and past spend are real signal; hypothetical intent is not.
- **What "done" looks like for this phase**: you can state, for each backlog item, whether the
  interviews corroborated it, contradicted it, or surfaced something the plan hadn't considered —
  with at least one direct quote or paraphrase per item as evidence, not a vague "most people
  agreed."

## 3. Phase 2 — quantitative primary research (survey)

Shift to a survey once the interviews have converged on specific, falsifiable patterns (not
before — a survey built on unconverged qualitative signal just measures noise at scale).

- **Sample size**: give the founder the real math, not a round number pulled from nowhere. For a
  simple yes/no or preference question at roughly 90% confidence and a ±10-point margin, ~68
  responses; tightening to ±5 points takes ~270. State which margin this survey is aiming for and
  why (a directional gut-check before Tactic 5 spend can tolerate ±10 points; a number that will
  appear in `quantitative_claims` and feed a financial model should aim tighter).
- **Question design**: closed-ended, scaled, or forced-choice questions built directly from what
  Phase 1 surfaced — never introduce a new open-ended exploration question here, that belongs in
  Phase 1. Avoid double-barreled questions and leading framing ("how much do you love X" is not
  a question).
- **Distribution**: use the channels Step 2 already identified as where this beachhead actually
  spends attention — don't default to a generic panel service if the plan names a specific
  community, publication, or vertical channel; a generic panel answers questions about "people in
  general," not this beachhead.
- **What "done" looks like for this phase**: a response count that meets the stated margin (or an
  honest note that it fell short and by how much), with results broken out per backlog item.

## 4. Secondary research — industry data and competitor analysis

- **Industry/market data**: pull from real, named, citable sources appropriate to the business —
  trade-association reports and vertical trade press, industry research firms (Gartner, Forrester,
  IBISWorld, Statista) where the category is covered, SEC filings/10-Ks for public comparables,
  Crunchbase/PitchBook-style funding data for private comparables, and government/census data for
  demographic sizing. Every figure pulled this way gets a `quantitative_claims` entry with the
  actual source cited (publication, date, URL) — never restate a number from memory as if sourced.
- **Competitor analysis**: pricing pages (actual current pricing, not remembered pricing), review
  site sentiment (G2, Capterra, Trustpilot, app-store reviews — read the 1-2 star reviews for
  where the alternative is actually failing customers, that's often the sharpest positioning
  signal), hiring signals (a competitor's open roles on LinkedIn often reveal strategic direction
  months before it's public), and funding/growth signals. This deepens — it does not replace —
  the competitive work in DE Step 11 (`chart-your-competitive-position`); hand any finding that
  changes a plotted position or axis back to that step's owner rather than silently redrawing it
  here.
- Use WebSearch where available and cite what you find; where a claim can't be verified, say so
  explicitly rather than presenting an unsourced figure as researched.

## 5. Business-type notes

- **SaaS**: secondary research should include competitor pricing-page tier structure and
  feature-gating, not just headline price.
- **Physical product**: primary research benefits from an actual product/prototype reaction, not
  just a described concept — an in-person intercept or a photo/mockup shown during the interview
  beats a purely verbal description.
- **Marketplace**: run the interview and survey phases separately for supply-side and demand-side
  respondents per Step 3's split if it produced two profiles — pooling both sides into one survey
  hides which side is actually the harder constraint.
- **Services**: distinguish, as Step 3/5 did, between the person who experiences the problem and
  the person who commissions the engagement — interview both if the plan named both.
- **Consumer app**: secondary research on usage/engagement benchmarks (App Annie/Sensor Tower-
  style data, category retention benchmarks) matters more here than industry trade-press sizing.

## What you write

Write `.startup/<slug>/tactics/03-market-research.md`:

```markdown
# Tactic 3: Market Research — Advanced Primary & Secondary Research

## Research backlog (from key_assumptions / quantitative_claims, steps 1-5)
| id | statement | test type | 

## Phase 1 — Qualitative interviews
### Method (sample, recruiting channel, guide)
### Findings (per backlog item)

## Phase 2 — Quantitative survey
### Method (sample size + margin target, distribution channel)
### Findings (per backlog item)

## Secondary research
### Industry/market data (sourced)
### Competitor analysis

## Recommended writebacks
| key_assumptions id | test_result (verbatim text to write) | confidence: before -> after |
| quantitative_claims id/new | value | source |

## What this changes in the plan
(flag anything Steps 4/11 should revisit given what was found)

## Done means
```

This skill does not write to `business-state.json` itself — not the `tactics.03_market_research`
entry, and not the `key_assumptions`/`quantitative_claims` writebacks this research produces.
State plainly in your report to whoever invoked you: the recommended `tactics.03_market_research`
status/summary, and the exact `key_assumptions`/`quantitative_claims` entries (id, field, new
value) to write. The orchestrator applies these to `business-state.json` after confirming
`tactics/03-market-research.md` exists and is complete — the same handoff pattern the Disciplined
Entrepreneurship step skills use for their own plan files.

## Done means

- Every `key_assumptions`/weak `quantitative_claims` entry tied to Steps 1-5 has a stated,
  evidenced disposition (confirmed / contradicted / inconclusive), not silence.
- At least one qualitative interview round and one quantitative survey round were actually run (or
  their shortfall stated honestly — fewer interviews than targeted, survey under the margin aimed
  for), never presented as complete when they weren't attempted.
- Every secondary-research figure has a real, named source — no figure stated as fact without one.
- The report names the specific writebacks (assumption id + new `test_result`, claim id + sourced
  value) for the orchestrator to apply, not just a narrative summary.
