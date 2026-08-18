# Roadmap

This plugin is being built through iterative swarm rounds, not a single pass: **round 1** built
v0.1 end to end (a full but shallow lifecycle spine); **round 2** — happening now — is a swarm of
agents adversarially reviewing and fixing every layer of that spine in parallel, plus one agent
running a live end-to-end dry run and logging what breaks. Round 2's output feeds directly into
this roadmap's v0.2 priorities below, and future rounds will keep doing the same: review, fix,
log findings, sharpen the roadmap, repeat. Treat this document as a snapshot that gets rewritten
each round, not a static plan drafted once and executed against.

This document is honest about the gap between what the plugin actually is right now and the
long-term vision the spec describes — potentially hundreds of agents and thousands of skills
covering the full lifecycle of running a business, not just starting one. It exists so that gap
gets closed deliberately, in prioritized horizons, rather than by throwing volume at it.

## v0.1 — complete

Round 1 delivered one coherent, working pass through the whole lifecycle. As of this round, the
repo actually contains:

- A central Startup Operator agent (`agents/orchestrator.md`) that bootstraps a business, drives
  it through onboarding, and owns state transitions.
- An onboarding interview and a recurring check-in interview (`skills/interview/`, 2 skills).
- All 24 Disciplined Entrepreneurship step skills (`skills/disciplined-entrepreneurship/01-...`
  through `24-...`), each producing its own `plan/NN-slug.md` and state entry.
- A business-plan assembler, reviser, and review-council runner (`skills/business-plan/`, 3
  skills) plus `agents/business-plan-editor.md`.
- A review-council system of 7 distinct personas under `agents/council/` (VC panel,
  expert-entrepreneur panel, product-market-fit panel, customer-discovery skeptic,
  competitive-strategy reviewer, financial-modeling reviewer, sales-motion reviewer), plus the
  AI-risk and privacy/compliance gates (`agents/risk/`) that sit inside the approval path per
  `docs/ARCHITECTURE.md`.
- Go-to-market agents and skills (`agents/gtm/`, `skills/gtm/` — 4 agents, 5 skills), operations
  agents and skills (`agents/ops/`, `skills/ops/` — 5 agents, 5 skills), a connectors layer
  (`agents/connectors-liaison.md`, `skills/connectors/`, and a 9-category `docs/CONNECTORS-
  CATALOG.md`), and a design/brand layer (`agents/design/brand-designer.md`, `skills/design/` —
  3 skills).
- QA agents (`agents/qa/`, 2 agents + `skills/qa/eval-a-skill`) and a structural validation
  script (`scripts/validate-plugin.sh`) implementing Layer 1 of `docs/TESTING.md`'s three-layer
  strategy — written, runnable locally, but **not yet wired into CI** (see v0.2 below).
- Plugin-engineering scaffolding: 5 slash commands, with `/start-business` and
  `/business-status` as the two founder-facing entry points.

That's 24 agent files and 46 skill packages in total — a real, working spine, not a stub. What
v0.1 delivered, honestly, is **one deep, working path** — first contact through an operating
business with a check-in cadence — with enough coverage on each theme (SaaS-flavored guidance
dominated where step skills needed a concrete example to anchor questions) that the framework
held together end-to-end. It was not, at the end of round 1, the breadth the long-term vision
describes: industry-specific variants of each step were largely unwritten, the council persona
library was SaaS/B2B-leaning, ops/GTM tooling was generic rather than business-model-specific,
and none of it had been driven through a real end-to-end dry run or adversarial review. That gap
is exactly what round 2 exists to close a first layer of.

## Round 2 — adversarial review and fix (the bridge to v0.2)

Round 2 is a swarm of roughly seven agents, each independently reviewing and fixing one layer of
what round 1 built — DE step skills, review councils, GTM/ops agents, the risk and connector
gates, business-plan assembly, the design layer, and the orchestrator/interview/QA layer — plus
one agent driving a live, synthetic end-to-end business through the full lifecycle and logging
every gap it finds to `docs/QA-FINDINGS-ROUND2.md` (the dry-run checklist it's executing against
is `docs/TESTING.md` §3.1–3.3). Two structural additions are part of this round rather than
deferred to v0.2 planning:

- **A technical-feasibility review-council persona** — round 1's 7-persona council covered
  market, product-market-fit, competitive, financial, and sales-motion angles, but nothing
  interrogated whether the product as specified (Step 7) is buildable in the stated timeline with
  the stated resources. That gap let a plan with a technically unrealistic build plan sail through
  every existing persona untouched; round 2 adds the persona that catches it.
- **A CI validation workflow** — wiring `scripts/validate-plugin.sh` into GitHub Actions so
  `docs/TESTING.md` Layer 1 runs automatically on every contribution instead of depending on a
  contributor remembering to run it locally. (Previously slated as a v0.2 item; pulled forward
  into round 2 because it's what makes round 2's own fixes — and every round after it — actually
  enforced rather than trusted.)

This document does not summarize round 2's specific diffs — it's being written concurrently with
round 2, not after it, so most of what round 2 changes isn't visible from here yet. What follows
is grounded in what was true in the repo as this pass was written (spot-checked directly against
current agent/skill files, not just round 1's plan for them) and in what round 2 is scoped to
produce; a reader after round 2 lands should treat `docs/QA-FINDINGS-ROUND2.md` and the actual
files as more current than the specifics below, and should expect this roadmap to be rewritten
again once round 2's findings are in.

One concrete, already-visible signal of round 2 in motion: several DE step skills
(`01-market-segmentation` through at least `04-calculate-the-tam-for-the-beachhead-market`) have
already grown real `## Business-type branching` sections mid-round, in the exact structural
position `docs/UX-INTERVIEW-DESIGN.md` §4 now documents as the convention. That's the pattern
v0.2 priority 1 below expects to see finished across all 24 steps, not just the first few.

## v0.2 — deepen before widening

Priorities, in order, sharpened against what the repo actually contains rather than the original
speculative list:

1. **Finish business-type branching across all 24 DE step skills, and check it for quality, not
   just presence.** Round 1 shipped every step skill able to *read* `business_basics.business_type`
   in principle, but as of this pass only a handful of steps (`01`, `02`, `03`, `04`, and partial
   treatment in `12`, `13`, `15`, `16`, `18`) had a real, developed `## Business-type branching`
   section — the rest still asked a type-blind version of their questions. Round 2 is actively
   extending this; v0.2's job is to (a) confirm all 24 steps have it, (b) confirm each one is a
   genuinely distinct, well-reasoned branch per type (see `docs/UX-INTERVIEW-DESIGN.md` §4 for the
   bar and the worked examples), not a one-line conditional bolted on to satisfy a checklist, and
   (c) confirm the four business-type values that show up least in round 1's examples —
   `marketplace`, `services`, and `consumer_app` — got the same depth as `saas` and
   `physical_product`, which is where round 1's SaaS-leaning default naturally concentrated.
2. **Council persona coverage for the business types the interview layer now takes seriously.**
   Round 1's 7 personas plus round 2's technical-feasibility addition (8 total) still lean
   general-B2B/SaaS: there is no marketplace-liquidity specialist, no regulated-industry
   (health/fintech) compliance-minded reviewer, no hardware/physical-product operator, and no
   services-business unit-economics reviewer. This matters more now than it did at the start of
   round 1: if DE steps genuinely branch by business type (priority 1) but the review layer that
   gates approval doesn't have a persona equipped to interrogate a marketplace or physical-product
   plan on its own terms, the plan sails through a panel that isn't actually adversarial to its
   specific claims — exactly the failure mode `docs/ARCHITECTURE.md`'s "Why the review council
   varies" section warns against. Track persona coverage against `business_type` values directly
   in `docs/DATA-CONTRACT.md` so gaps stay visible.
3. **Confirm the CI validation workflow round 2 adds is actually blocking, and extend what it
   checks.** Getting `scripts/validate-plugin.sh` into GitHub Actions (round 2) is necessary but
   not sufficient — v0.2 should confirm the workflow runs on every PR (not just main), fails the
   build rather than just annotating it, and extend the script's coverage toward what
   `docs/TESTING.md` Layer 1 promises but the script doesn't yet mechanically check: that a new
   `business-state.json` field introduced anywhere is declared in `docs/DATA-CONTRACT.md` in the
   same change, and that council agents actually commit to the CONVENTIONS §6 verdict schema
   rather than approximating it.
4. **Business-model-specific ops/GTM instrumentation.** Of the 5 `skills/ops/*` packages, only
   `kpi-dashboard-setup` currently branches by `business_type`; `weekly-metrics-review`,
   `retention-and-churn-analysis`, `runway-and-burn-tracking`, and `scaling-readiness-check` still
   ask the same questions regardless of whether the business is SaaS (MRR/NRR/churn-cohort),
   marketplace (liquidity, take-rate), or physical-product (inventory-turn, contribution margin) —
   the same gap priority 1 addresses for DE steps exists one layer downstream in ops, and reuses
   the same `business_type` dispatch point rather than inventing a new mechanism.
5. **Wire the connectors layer to what's already cataloged, rather than cataloging more.**
   `docs/CONNECTORS-CATALOG.md` is already substantive — 9 connector categories with canonical
   ids, real product examples, and a privacy consideration for each — so the original "expand the
   catalog" item was solving a problem that's largely already solved. The actual gap is thinner
   and sharper: confirm every GTM/ops skill that would act through a connector (per the catalog's
   own "DE step / GTM-ops task that creates the need" column) genuinely checks
   `connectors.needed_not_installed` before assuming success, per `docs/ARCHITECTURE.md`'s "not
   assuming tools the founder hasn't installed" section — that behavior is easy to assert in an
   agent's prompt and easy to silently skip in practice, and it's exactly the kind of thing Layer
   2 behavioral eval (`docs/TESTING.md`) needs to actually test, not just Layer 1 structural QA.
6. **Fold round 2's live dry-run findings (`docs/QA-FINDINGS-ROUND2.md`) into a concrete backlog.**
   That file is being written concurrently with this one; once round 2 lands, its findings are the
   most grounded source of "what a real founder hits first" available — more grounded than
   anything in this list, because it comes from actually driving a synthetic business through the
   full state machine rather than reading the code and reasoning about where it's likely to break.
   The next roadmap revision should read that file and promote its findings above the items in
   this list wherever they conflict on priority.

### What a founder would hit first today, honestly

Independent of round 2's specific fixes, three things a real founder would notice immediately if
they ran this end to end right now: (1) the review council's rigor is uneven across business
types for the reason priority 2 above describes — a physical-product or marketplace founder gets
a shallower adversarial review than a SaaS founder gets, even post-round-2's technical-feasibility
addition; (2) the AI-risk gate (`ai_risk_flag` on unsourced `quantitative_claims`) is enforced by
every agent's own instructions, not by any mechanical check outside `scripts/validate-plugin.sh`'s
narrower structural scope — an agent that forgets to flag a fabricated number has nothing else in
the system catching it before council review, which is a real gap between the architecture's
stated intent and what's actually enforced; and (3) nothing in the repo has yet been driven through
a real multi-session lifecycle by an actual person — every check so far (round 1's own review,
round 2's dry run) is still a simulated pass, and simulated passes reliably miss the specific ways
real founders phrase vague answers, get confused about `/business-status` state, or stall out
mid-interview. None of these are reasons not to ship v0.1 as a working spine — they're the reason
this roadmap treats "one working pass" and "trustworthy at scale" as different milestones.

## v0.3 and beyond — the long tail

Once the v0.2 depth work has landed and been used on a handful of real businesses, the honest
long-term direction is breadth: more industry verticals per DE step (regulated industries,
hardware, B2B2C, nonprofit/social-enterprise variants), a genuinely large council-persona library
segmented by stage and geography as well as business type, deeper fundraising-specific agents
(pitch-deck iteration, cap-table sanity checks flagged clearly as non-legal-advice), and
operations agents that extend meaningfully past year one (scaling playbooks, hiring plans, board-
reporting assembly). This is where the "hundreds of agents, thousands of skills" scale of the
long-term vision actually starts to apply — but only some of it. Getting there is explicitly not
a matter of writing many more agents as fast as possible, and it is not a matter of running one
more review round and calling the plugin finished — it's a standing practice of building,
adversarially reviewing, dry-running, and rewriting the roadmap, the same three-round shape this
document itself has now gone through once.

## The constraint that doesn't loosen as this grows

Every horizon above is additive to the same contract, not a departure from it. `CONVENTIONS.md`
exists precisely because a swarm of independently-authored agents and skills only stays coherent
if they all write against one directory layout, one frontmatter shape, one data contract, and one
verdict schema. Growth from "hundreds" toward "thousands" of skills — and from round 2 toward
round 3, 4, and beyond — is only survivable, for users and for the swarm of contributors building
it, if every new or revised skill or agent still:

- lives in the directory layout `CONVENTIONS.md` §1 defines, with kebab-case names;
- declares any new `business-state.json` field in `docs/DATA-CONTRACT.md` in the same change
  that introduces it, rather than inventing undocumented fields;
- for council agents, returns a verdict in the exact schema in `CONVENTIONS.md` §6, as one
  distinct persona in a panel of 3-5, never as a sole reviewer standing in for "the council";
- states concrete deliverables — a file, a decision, a score — never "general guidance";
- labels business/financial content once, plainly, as a planning aid rather than licensed advice,
  per `CONVENTIONS.md` §7, instead of stacking disclaimers everywhere.

A thousand skills that all violate this contract in slightly different ways would be worse than
the 24-step spine this repo shipped in round 1. The roadmap's job, every round, is to make sure
volume never becomes the goal in place of coherence — each horizon above is scoped so it can be
validated against `CONVENTIONS.md` (via the CI validation round 2 adds, once v0.2 confirms it's
actually blocking) before it ships, the same way round 1's first pass was meant to be and round 2
is now checking that it actually was.
