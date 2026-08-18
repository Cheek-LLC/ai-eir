# Step 24: Product Plan

Business-type branching used: **Consumer app** — "spending on user-acquisition-heavy expansion
before retention is stable is the single most common consumer-app roadmap mistake this step exists
to catch." Directly load-bearing below: the near-term roadmap explicitly rules out any paid
user-acquisition spend before the beta's real retention curve is observed, even though Step 19's
weak unit economics might otherwise tempt a "just get more installs and see" response.

## Near-term roadmap (next 1-2 quarters)

| Item | Justification (Step 22 trigger / Step 23 evidence / spec gap) | Priority |
|---|---|---|
| Launch the closed TestFlight beta (150 users) with full analytics instrumentation | Step 23 has zero usage data — this is the prerequisite for everything else on this roadmap | 1 |
| Resolve `ka-019-founder-rate` (real freelance-comp research) and `ka-017-margin` (real hosting/CDN quote) before finalizing any COCA/LTV claim shown outside this document | Both are resolvable pre-launch without needing beta data; cheap to fix now | 2 |
| Instrument and observe D1/D7/D30 retention and circle-formation rate specifically | The two highest-impact leap-of-faith assumptions (`ka-017-retention-curve`, `ka-013-circle-invite-friction`) per Step 20/21 | 1 (parallel to launch) |
| **Do not** budget any paid user-acquisition spend this window | Per this step's consumer-app branch — spending into an unobserved (and, per Step 19, currently modeled as badly negative) retention/economics picture would accelerate burn on an unproven funnel | Explicit deprioritization |
| Automate pod-matching | **Not yet** — gated on the automation trigger stated in Step 22 (200+ users AND matching quality shown to correlate with retention) | Deferred, not this window |
| Writing discipline (pin 2 product work) | **Not yet** — gated on Step 14's stated trigger (stable beachhead retention + circle mechanic proven with strangers, not just friends) | Deferred, not this window |

## Follow-on market readiness (Step 14 bowling pins)

Pin 2 (daily creative writers) trigger condition: stable, non-decaying beachhead retention curve
**and** confirmed circle-formation with cold/stranger-matched users, not just the founder's
pre-existing network. **Current distance to trigger: not yet measurable** — the beta hasn't
launched, so there is no retention curve to check for stability yet.

## Sequencing rationale

Everything before the beta launch is either free-to-resolve-now (the founder-rate and margin
research) or literally cannot be sequenced earlier (retention/conversion/circle-formation all
require real users). Nothing is deprioritized for lack of ambition — pod-matching automation and
pin 2 are both explicitly named as real future work, just correctly gated behind evidence this
plan does not yet have, per the branch's own warning against the single most common consumer-app
roadmap mistake.

## Resourcing reality check

This roadmap assumes exactly one person (Priya, part-time around a full-time job, per
`ka-020-founder-bandwidth`'s accepted disposition in Step 21) plus one contracted freelance iOS
developer for the MVBP build (named, already engaged informally, not yet under contract). It
explicitly does **not** assume a hire, a co-founder, or any paid marketing budget — if the beta
results are promising enough to justify either, that becomes a new roadmap item at that point, not
a hidden assumption baked into this one.

## Handoff briefs

### To GTM
Not applicable yet — this business has not reached `stage: approved`. When it does: GTM's first
job would be operationalizing the community-seeding plan from Step 18/19 (Discord, Reddit,
Product Hunt) into a real launch sequence, and confirming whether the App Store listing itself
needs its own positioning pass separate from this plan's internal framing.

### To Ops/Scaling
Not applicable yet, same reason. When it does: the manual pod-matching process (Step 22) and the
manual support inbox both need a documented runbook before any handoff beyond the founder herself
— neither is written down anywhere yet beyond this plan's own description of them.

## Open assumptions

- `ka-024-roadmap-bet` — statement: "Assumes the two highest-priority beta questions (retention
  curve, circle-formation rate) can both be meaningfully read within a single 30-90 day beta window
  rather than needing a second cohort or a longer observation period." `step_ref:
  24_develop_a_product_plan`, `confidence: low`, `test_plan: "reassess the observation window
  itself once the beta is 30 days in, based on how noisy the early data actually looks"`,
  `test_result: null`.
