# Architecture

This is the system-level narrative: why the plugin is shaped the way it is, and how its parts
move a business from a founder's first sentence to an operating company with a standing check-in
cadence. For the mechanical/file-level view — which agent file calls which skill, exact tool
lists, prompt-engineering detail — see `docs/ARCHITECTURE-IMPLEMENTATION.md`. For the schema this
whole system is built on, see `docs/DATA-CONTRACT.md`. This document assumes you've read both.

## The core design decision: state lives on disk, not in conversation

Every agent in this plugin is stateless between invocations by design. The Startup Operator does
not "remember" your business from one session to the next — it re-reads
`.startup/<slug>/business-state.json` in full at the start of every session, along with recent
`interview-log.md` entries and anything new under `reviews/`, `gtm/`, and `ops/`. This is not an
implementation detail; it's the reason a swarm of independently-authored agents and skills can
interoperate at all. A council reviewer, a GTM agent, and an ops agent invoked weeks apart, in
different sessions, possibly on different machines, all get the same ground truth because there
is exactly one ground truth: the JSON file and the markdown artifacts it points to. Nothing about
this business is allowed to exist only in a transcript.

The single field that drives everything downstream is `stage` in `business-state.json`. It is the
plugin's state machine.

## The lifecycle state machine

```
stage values (business-state.json):

  interview
      │  onboarding-interview skill: capture business_basics, founder info,
      │  refine the one-liner until it names a real customer and a real problem
      ▼
  de_steps_in_progress
      │  24 Disciplined Entrepreneurship step skills, run in Aulet's sequence
      │  (steps within a theme may parallelize; themes build on each other and
      │  do not). Each step writes plan/NN-slug.md and updates its own entry
      │  under disciplined_entrepreneurship in business-state.json.
      ▼
  plan_assembled
      │  business-plan skill assembles plan/business-plan.md from all 24 step
      │  files (generated, never hand-edited) — plan.version increments
      ▼
  council_review ──────────────┐
      │  a tailored panel of 3-5 reviewer personas runs in parallel           │
      │  (see "Why the council varies" below); each writes reviews/*.md       │
      ▼                                                                       │
  [aggregate verdict = harshest non-outlier verdict on the panel]             │
      │                                                                       │
      ├─ REVISE or REJECT ─▶  revising                                       │
      │                          │ business-plan-editor + affected step      │
      │                          │ skills address required revisions,        │
      │                          │ plan.version increments again              │
      │                          └──────────────────────────────────────────▶┘
      │                                          (back to council_review)
      │
      └─ APPROVE or APPROVE_WITH_NOTES ─▶  approved
                                                │
                                                ▼
                                              gtm
                                                │  go-to-market agents produce
                                                │  launch_plan_file + artifacts
                                                │  (pitch deck, landing page,
                                                │  content calendar, etc.)
                                                ▼
                                            operating
                                                │  ops/analytics/finance agents
                                                │  produce cadence_metrics_files,
                                                │  run retros, revisit GTM and
                                                │  even earlier DE steps as the
                                                │  business learns
                                                ▼
                                    (recurring check-ins on cadence.check_in_frequency
                                     — weekly/biweekly/monthly/manual — each one re-enters
                                     this diagram at whatever stage is current: an ops
                                     check-in might surface a pivot that sends a specific
                                     DE step back to de_steps_in_progress, or a GTM miss
                                     that sends the plan back to council_review)

  (paused — any stage can transition here; a check-in that finds the founder
   stepping away sets this explicitly rather than leaving cadence fields stale)
```

Two properties of this diagram matter more than the happy-path arrows:

- **The graph is not strictly forward.** `operating` is not a terminal state that closes the
  loop — it's a state that keeps re-opening earlier ones. A metrics snapshot showing the
  beachhead market was wrong doesn't get silently patched in `ops/`; it sends the business back
  through the relevant DE step (`02-select-a-beachhead-market`), which propagates to plan
  reassembly and, if the change is material, back to `council_review`. The state machine models
  a business that keeps learning, not a pipeline that runs once.
- **`revising` always returns to `council_review`, never to `approved` directly.** A revision is
  not self-certifying. Whatever agent made the revision does not get to also decide it now
  satisfies the panel that raised the objection — the same council (or the relevant subset of it)
  re-reviews.

Every `stage` transition is a write to `business-state.json`, made by the agent that owns the
transition, preserving every key it doesn't own (per the Data Contract's no-blind-overwrite
rule). `/business-status` is, mechanically, "read `stage`, read what's changed since
`cadence.last_check_in`, report, and resume the diagram from there."

## Why the review council varies by business strategy, not a fixed panel

`CONVENTIONS.md` requires every council to be a panel of 3-5 *distinct* reviewer personas run in
parallel, with the aggregate verdict being the harshest non-outlier verdict, not an average. That
rule alone forces variation: a single fixed panel of generic personas would either be too shallow
to catch strategy-specific failure modes, or so broad that no individual persona has enough
context to give a sharp, falsifiable verdict.

Concretely, the panel composition is a function of `business_basics.business_type` and
`business_basics.business_type_notes` from `business-state.json`:

- A **B2B SaaS with usage-based pricing** business plan should face a panel with a seed-stage
  SaaS VC (unit economics, net-revenue-retention math), a pricing specialist, and an
  enterprise-sales-motion skeptic asking about the DMU from step 12.
- A **DTC physical product** plan should instead face a panel with a consumer-goods operator
  (COGS, fulfillment, working-capital cycles), a retail/channel specialist, and a brand/marketing
  reviewer — the SaaS panel's questions about net-revenue-retention are close to meaningless
  here, and the physical-goods panel's questions about unit COGS and channel margin would be
  meaningless for a pure-software business.
- A **marketplace** plan needs a panel member fluent in two-sided liquidity and chicken-and-egg
  bootstrapping, which neither of the above panels is built to interrogate.

This is why the council system is a *design*, not a static roster: the orchestrator and
council-selection logic read the business's actual strategy out of `business-state.json` and
`plan/business-plan.md` and assemble (or select from a growing library of) personas whose
expertise is actually adversarial to the specific claims this specific business is making. A
generic panel that could plausibly approve any business plan isn't doing review — it's theater.
The specialist-reviewer layer (beyond the core VC panel and expert-entrepreneur panel) exists for
the same reason: an AI-risk reviewer, a legal/privacy-risk reviewer, and others each interrogate
one axis deeply rather than diluting a general panel's attention across everything at once.

## AI-risk and privacy-risk as gates, not afterthoughts

Two review layers sit structurally *inside* the approval path rather than beside it, and that
placement is deliberate:

- **AI-risk analysis** reads every entry in `quantitative_claims`. Per the Data Contract, any
  number presented as fact in `plan/business-plan.md` — market size, LTV, COCA, pricing, and so
  on — must carry a `source` (a founder estimate, cited research, or a cited benchmark). A claim
  without a source is not a stylistic nit; it is an AI-risk finding that **blocks council
  approval outright**. This exists because the single most likely failure mode of an LLM-driven
  planning tool is confidently fabricated numbers wearing the authority of a "rigorous business
  plan" — the gate is placed before the VC/expert panels ever score the plan, not as a disclaimer
  appended after they approve it.
- **Privacy/legal risk review** interrogates the plan and any connector wiring for real exposure:
  founder or customer PII handling, data-retention claims, regulated-industry triggers, and
  claims that read like legal or compliance advice the plan is not licensed to give. Findings
  land in `risk_log` with `type: "ai_risk" | "privacy" | "legal"` and a `status`. Per the Data
  Contract, `risk_log` entries are never silently deleted — an item can only move to `mitigated`
  or `accepted`, each with a note in the relevant review file, so a founder (or a later reviewer)
  can always see what was flagged and how it was resolved, not just that it's currently quiet.

Both layers run as gates *within* `council_review`/`revising`, not as a downstream audit of an
already-approved plan. A plan cannot reach `approved` carrying an open, unmitigated AI-risk or
privacy finding — the state machine has no edge from `council_review` to `approved` that skips
them.

## The connectors layer: not assuming tools the founder hasn't installed

Go-to-market and operations agents naturally want to *do* things — send an email campaign, post
to a scheduling tool, pull real analytics, sync a CRM. The plugin cannot assume any of that
tooling exists in a given founder's environment, and guessing wrong (silently failing, or worse,
silently fabricating what a real integration would have returned) is worse than not attempting
it.

`business-state.json.connectors` is the single place that distinguishes `wired_up` connectors from
`needed_not_installed` ones, where each needed-but-absent connector records *why* it's needed and
*which step* needs it — there is no separate `connectors.json` file, this lives inline in
`business-state.json`. `agents/connectors-liaison.md` owns keeping this list accurate; every GTM or
ops skill that would want to
act through a connector checks this list first rather than assuming success. When a needed
connector isn't installed, the correct behavior is to say so plainly, produce the artifact that
would have been sent (a drafted email, a content-calendar entry, a metrics query) as a file the
founder can act on manually, and log the gap — not to pretend the action happened. This keeps the
plugin honest about the difference between "planned" and "done," which matters enormously once a
business reaches `operating` and its stated metrics are supposed to reflect the real world.

## Recurring check-ins close the loop

`cadence` in `business-state.json` (`check_in_frequency`, `last_check_in`, `next_check_in`,
`scheduling_mechanism`) is what turns this from a one-time planning exercise into an ongoing
relationship. `scheduling_mechanism` is explicit about *how* re-activation actually happens in a
given environment (a harness-level scheduled trigger vs. a manual reminder the founder acts on) —
the state machine's recurring edges are only real if something outside the conversation itself
causes the founder to come back. Every check-in, whether trigger-fired or founder-initiated via
`/business-status`, re-enters the lifecycle diagram at the business's current `stage`, reports
what changed, and drives the next concrete action per the rules above.
