---
name: 05-marketing
description: >
  Use once brand/landing-page assets exist (Tactic 4) and the founder is ready to run real paid
  digital advertising as a validation test — runs Tactic 5, Proving Persona Assumptions with
  Digital Advertising, treating ad spend as an instrument to confirm or break DE Step 5's persona
  predictions, not as ordinary lead-gen. Triggers: "run an ad test," "validate our persona with
  ads," "should we start paid marketing," "test our targeting." Every test maps back to a
  specific `key_assumptions` entry's `test_result` — a good CTR alone is not the deliverable.
  Cross-references `skills/gtm/positioning-and-messaging` for copy and `skills/gtm/
  content-calendar` for organic scheduling rather than duplicating either.
---

# Tactic 5: Marketing — Proving Persona Assumptions with Digital Advertising

## Role in the 15 tactics

Third of four Market Testing tactics. This is not a growth-marketing playbook and not a repeat
of `skills/gtm/content-calendar`'s organic scheduling. It is specifically about spending real
advertising budget as a scientific instrument: does DE Step 5's persona actually exist, spend
attention where the plan said, and respond to the message the way predicted? Every dollar spent
here should either confirm or break a specific claim already sitting in `key_assumptions` — if a
campaign runs and nothing in `business-state.json` changes as a result, the test didn't do its
job, no matter how good the metrics looked.

## What you read

- `.startup/<slug>/plan/05-profile-the-persona-for-the-beachhead-market.md` — **required**. The
  source of every hypothesis this tactic tests: where they spend attention, what they trust,
  what frustrates them, their decision-making style.
- `.startup/<slug>/plan/08-quantify-the-value-proposition.md` — the claim being advertised.
- `.startup/<slug>/plan/12-determine-the-dmu.md`, if present — for B2B businesses, which DMU role
  is being targeted matters as much as the persona itself.
- `.startup/<slug>/business-state.json` `key_assumptions` — **required**. Pull every entry with
  `step_ref` pointing at Step 5 (or a channel/behavior claim from Step 3/8). These, not a generic
  ad-testing checklist, are what this tactic exists to resolve. If none exist yet, create the
  needed ones as part of this tactic's write-up rather than testing something nobody flagged as
  uncertain.
- `.startup/<slug>/gtm/positioning.md`, if it exists — **required input for copy**. Pull ad angles
  and headlines directly from its messaging pillars and taglines; do not draft new positioning
  language here. If it doesn't exist, say so and proceed only with plan-grounded copy, flagging
  that running `positioning-and-messaging` first would tighten the test.
- `.startup/<slug>/gtm/content-calendar.md`, if it exists — read only to coordinate timing (don't
  launch a paid test the same week as an unrelated organic push that would contaminate the read
  on which channel drove response) — this tactic does not plan organic content itself.
- `.startup/<slug>/design/landing-page-brief.md` and `.startup/<slug>/design/brand-identity.md`,
  if they exist — the destination and creative direction for any ad that isn't a pure awareness
  play; if no landing page exists yet, flag Tactic 4 as a precondition for any test with a
  conversion goal (not for an awareness-only test, which can still run).

## 1. Turn the persona into falsifiable ad hypotheses

For each relevant `key_assumptions` entry (or each newly identified persona claim worth testing),
write it as: "If the persona is [specific Step 5 claim], an ad on [channel] with [angle] targeting
[criteria] should out-perform a control angle on [specific metric], versus [category benchmark]."
Vague hypotheses ("see if ads work") aren't testable — insist on the specific channel/angle/metric
triad before spending anything.

## 2. Channel selection — grounded in Step 5, not trend

Choose the channel because Step 5 said the persona is actually there, not because it's the
default platform to start with:

- **LinkedIn**: B2B persona with a named job title/role (cross-check against Step 12's DMU roles
  if present) evaluating on professional/ROI criteria.
- **Meta/Instagram**: consumer persona with a visual, lifestyle, or interest-based targeting
  signal; also strong for a physical-product persona shopping visually.
- **Google Search**: a persona actively searching a known problem phrase — best for testing
  bottom-funnel, high-intent language rather than top-of-funnel persona discovery.
- **TikTok / short-form video platforms**: a consumer persona whose Step 5 "day in the life" is
  attention/habit-driven (per the DE Step 5 consumer-app branching) rather than workflow-driven.
- **Vertical/trade publications or niche ad networks**: a persona whose Step 5 "trusted sources"
  explicitly name a specific publication or community — often a stronger, cheaper signal test
  than a mass platform for a narrow B2B or professional beachhead.

State the choice and the specific Step 5 line it's grounded in. If the plan gives no clear channel
signal, say so and pick the most defensible option from partial evidence, same discipline
`content-calendar` uses for the same situation.

## 3. Ad format and creative variants

Match format to what's being tested, and run a genuine comparison, not one best-guess creative:

- **Single-image/static** — tests one headline/value-prop claim cleanly.
- **Carousel** — tests which of several pain points or benefits resonates most.
- **Short video** — tests an emotional or demonstration angle; only build this if Tactic 4 has
  actually produced video creative, don't invent a video test around an asset that doesn't exist.
- **Search ad copy** — tests problem-language match (does the persona describe the problem the
  way the plan assumes they do).

Run at least 2-3 distinct angles/variants per hypothesis, each pulling its actual copy from
`gtm/positioning.md`'s pillars (a different pillar or proof point per variant) — a single "best
guess" ad produces an opinion, not a comparison.

## 4. Targeting — built from Step 5's real traits

Build targeting criteria directly from the persona's demonstrated traits: title/seniority/
industry for B2B, named interests/behaviors/demographics for consumer. Where the ad platform
can't represent the actual criterion the plan describes (a common gap — e.g. "reads a specific
trade newsletter" isn't a targetable field on most platforms), name the closest available proxy
and flag it explicitly as an approximation, not a clean test of the original claim.

## 5. Budget and duration — enough to be evidence, not noise

Give a concrete floor, not a vague "spend what you can": a validation test (not a scaled
campaign) needs enough spend and duration to reach roughly 1,000+ impressions and a meaningful
click sample per variant — commonly on the order of $500-1,500 over 1-2 weeks depending on
channel CPMs, stated explicitly as an estimate to confirm against the actual platform's live
CPM once the campaign is set up. A $50 weekend test is not evidence either way; say this plainly
if the founder proposes a token budget, and let them decide with that tradeoff stated.

## 6. Set the read-thresholds before launch, not after

For each hypothesis, write down in advance what result counts as confirmed, disconfirmed, or
inconclusive — a specific CTR/conversion/cost-per-click benchmark for the channel and format
chosen, sourced from the channel's own published benchmarks or Tactic 3's secondary research where
available. Deciding this after seeing results invites reading whatever happened as a win.

## 7. Close the loop — map results back to key_assumptions, not just a metrics report

This is the step that distinguishes this tactic from ordinary marketing reporting. For every
hypothesis, write the literal `test_result` text and the confidence change for its
`key_assumptions` entry — e.g. `test_result`: "LinkedIn ads targeting [title] achieved 1.8% CTR
vs. a 0.4% platform benchmark, and 22 landing-page signups from 400 clicks against the step-9
CTA — Step 5's stated channel and message resonance confirmed," `confidence`: low → high. A test
that produced a metric but no corresponding assumption update is incomplete — say so if that
happens, don't file it as done.

## Cross-references — do not duplicate

- Ad copy and angle language come from `skills/gtm/positioning-and-messaging`'s messaging
  pillars and taglines. Do not draft new positioning inside this tactic.
- Any organic/social scheduling coordination is `skills/gtm/content-calendar`'s job. This tactic
  only checks timing doesn't collide with it; it doesn't plan organic content.
- The landing page the ad drives to is Tactic 4's / `skills/design/landing-page`'s deliverable.
  This tactic doesn't redesign it, only points the ad at its existing CTA.

## What you write

Write `.startup/<slug>/tactics/05-marketing.md`:

```markdown
# Tactic 5: Marketing — Proving Persona Assumptions with Digital Advertising

## Hypotheses under test
| key_assumptions id | Step 5 claim | Hypothesis (channel/angle/metric) |

## Channel & format selection
(with the Step 5 line each choice is grounded in)

## Targeting
(criteria + any approximation flagged)

## Creative variants
| Variant | Angle / pillar used | Format |

## Budget, duration, and read-thresholds (set before launch)
| Hypothesis | Confirmed if | Disconfirmed if | Inconclusive if |

## Results
(actual metrics once run — or "not yet launched" if this is a pre-launch plan)

## Recommended assumption writebacks
| key_assumptions id | test_result (verbatim) | confidence: before -> after |

## Done means
```

This skill does not write to `business-state.json` itself — not the `tactics.05_marketing` entry,
and not the `key_assumptions` `test_result` writebacks this test produces. State plainly in your
report to whoever invoked you: the recommended `tactics.05_marketing` status/summary and the
exact `key_assumptions` writebacks (id, new `test_result`, new `confidence`). The orchestrator
applies these to `business-state.json` after confirming `tactics/05-marketing.md` exists and is
complete — the same handoff pattern the Disciplined Entrepreneurship step skills use for their
own plan files.

## Done means

- Every hypothesis traces to a specific `key_assumptions` entry (existing or newly created) tied
  to Step 5, not a generic marketing-metrics goal.
- Channel, format, and targeting choices are each justified by a specific line from Step 5, not
  by platform convention.
- Read-thresholds were set before results existed, and the file shows them as set in advance.
- Every result — run or not-yet-run — maps to a stated `key_assumptions` writeback; a CTR number
  with no corresponding assumption update is flagged as incomplete, not reported as done.
- Copy and organic scheduling were pulled from, not duplicated from, `positioning-and-messaging`
  and `content-calendar`.
