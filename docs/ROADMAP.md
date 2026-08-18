# Roadmap

This document is honest about the gap between what v0.1 actually is and the long-term vision the
plugin's spec describes — potentially hundreds of agents and thousands of skills covering the
full lifecycle of running a business, not just starting one. It exists so that gap gets closed
deliberately, in prioritized horizons, rather than by throwing volume at it.

## Where v0.1 actually stands

This first build pass delivers one coherent, working pass through the whole lifecycle:

- A central Startup Operator agent (`agents/orchestrator.md`) that bootstraps a business, drives
  it through onboarding, and owns state transitions.
- An onboarding interview and a recurring check-in interview (`skills/interview/`).
- All 24 Disciplined Entrepreneurship step skills (`skills/disciplined-entrepreneurship/01-...`
  through `24-...`), each producing its own `plan/NN-slug.md` and state entry.
- A business-plan assembler and reviser (`skills/business-plan/`) that generates
  `plan/business-plan.md` from the 24 step files and versions it on revision.
- A review-council system: a VC panel, an expert-entrepreneur panel, and specialist reviewers
  (including AI-risk and privacy/legal risk) that gate approval, per the verdict schema in
  `CONVENTIONS.md`.
- Go-to-market agents, operations/analytics agents, a connectors layer that tracks what's wired
  up versus needed, and a design/brand layer.
- Plugin-engineering scaffolding: a validation script and supporting commands, plus the two
  founder-facing entry points, `/start-business` and `/business-status`.

What v0.1 is, honestly, is **one deep, working spine** — a single coherent path from first
contact to an operating business with a check-in cadence — implemented with enough coverage on
each theme (SaaS-flavored guidance dominates where the step skills need a concrete example to
anchor questions) that the framework holds together end-to-end. It is not yet the breadth the
long-term vision describes: industry-specific variants of each step, dozens of council personas
covering every plausible strategy, deep per-business-model operations tooling, or anything close
to "hundreds of agents." Treat v0.1 as proof that the architecture in `docs/ARCHITECTURE.md` and
the contract in `CONVENTIONS.md` actually hold up across a full lifecycle pass — not as a finished
product.

## v0.2 — deepen before widening

Priorities, in order:

1. **Industry-specific step variants.** Several DE steps currently give substantially different
   good answers depending on `business_basics.business_type` — a beachhead-market analysis for a
   SaaS product (market segmented by firmographic/technographic criteria, land-and-expand
   assumptions) looks nothing like one for a physical product (segmented by demographic/channel
   criteria, inventory and fulfillment assumptions baked into TAM math from the start). v0.1
   ships each step skill able to *read* `business_type` and adjust its questions, but the
   guidance depth behind that adjustment is uneven. v0.2 should bring at least
   `02-select-a-beachhead-market`, `04-calculate-the-tam-for-the-beachhead-market`,
   `15-design-a-business-model`, `16-set-your-pricing-framework`, and
   `19-calculate-the-coca` — the steps where SaaS and physical-product (and marketplace, and
   services) reasoning diverge most — up to genuinely distinct, well-developed variants rather
   than one generic skill with a conditional paragraph.
2. **More review-council personas.** Expand the persona library so panel selection
   (`docs/ARCHITECTURE.md`, "Why the review council varies") has real breadth to draw from per
   business type: a marketplace-liquidity specialist, a regulated-industry (health/fintech)
   compliance-minded VC, a hardware/physical-product operator, a services-business
   unit-economics reviewer, an early-employee/hiring-focused expert-entrepreneur persona. Track
   persona coverage against `business_type` values in `docs/DATA-CONTRACT.md` so gaps are visible
   rather than discovered ad hoc.
3. **A real CI-integrated `validate-plugin.sh` run.** v0.1 ships the validation script; v0.2
   should wire it into actual CI on this repo (GitHub Actions) so every contribution is checked
   against `CONVENTIONS.md` automatically — frontmatter shape, kebab-case naming, presence of
   required sections, and (where mechanically checkable) that new fields introduced in agents/
   skills are declared in `docs/DATA-CONTRACT.md` in the same change. This turns the contract
   from a document people are expected to read into one the repo enforces.
4. **Richer ops/analytics per business-model type.** v0.1's operations layer covers the general
   shape (metrics snapshots, retros) but not model-specific instrumentation — SaaS needs MRR/NRR/
   churn-cohort tracking, a marketplace needs liquidity and take-rate tracking, a physical-product
   business needs inventory-turn and contribution-margin tracking. This should build on the same
   `business_type` branching point as (1), reusing the same instinct rather than inventing a new
   dispatch mechanism.
5. **More connector integrations cataloged.** Expand the set of connectors the
   connectors-liaison layer knows how to check for and wire into GTM/ops workflows (email/CRM,
   analytics platforms, scheduling, payments), and make the `needed_not_installed` list in
   `connectors.json` genuinely useful — specific enough that a founder can act on it directly
   ("install X to unblock step Y") rather than a vague "connect more tools" nudge.

## v0.3 and beyond — the long tail

Once the v0.2 depth work has landed and been used on a handful of real businesses, the honest
long-term direction is breadth: more industry verticals per DE step (regulated industries,
hardware, B2B2C, nonprofit/social-enterprise variants), a genuinely large council-persona library
segmented by stage and geography as well as business type, deeper fundraising-specific agents
(pitch-deck iteration, cap-table sanity checks flagged clearly as non-legal-advice), and
operations agents that extend meaningfully past year one (scaling playbooks, hiring plans, board-
reporting assembly). This is where the "hundreds of agents, thousands of skills" scale of the
long-term vision actually starts to apply — but only some of it. Getting there is explicitly not
a matter of writing many more agents as fast as possible.

## The constraint that doesn't loosen as this grows

Every horizon above is additive to the same contract, not a departure from it. `CONVENTIONS.md`
exists precisely because a swarm of independently-authored agents and skills only stays coherent
if they all write against one directory layout, one frontmatter shape, one data contract, and one
verdict schema. Growth from "hundreds" toward "thousands" of skills is only survivable — for
users, and for the swarm of contributors building it — if every new skill or agent added at any
future horizon still:

- lives in the directory layout `CONVENTIONS.md` §1 defines, with kebab-case names;
- declares any new `business-state.json` field in `docs/DATA-CONTRACT.md` in the same change
  that introduces it, rather than inventing undocumented fields;
- for council agents, returns a verdict in the exact schema in `CONVENTIONS.md` §6, as one
  distinct persona in a panel of 3-5, never as a sole reviewer standing in for "the council";
- states concrete deliverables — a file, a decision, a score — never "general guidance";
- labels business/financial content once, plainly, as a planning aid rather than licensed advice,
  per `CONVENTIONS.md` §7, instead of stacking disclaimers everywhere.

A thousand skills that all violate this contract in slightly different ways would be worse than
the 24-step spine this repo ships today. The roadmap's job is to make sure volume never becomes
the goal in place of coherence — each horizon above is scoped so it can be validated against
`CONVENTIONS.md` (ideally by the CI validation in v0.2, item 3) before it ships, the same way this
first pass was.
