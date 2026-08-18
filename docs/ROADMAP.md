# Roadmap

This plugin is being built through iterative swarm rounds, not a single pass: **round 1** built
v0.1 end to end (a full but shallow lifecycle spine); **round 2** was a swarm of agents
adversarially reviewing and fixing every layer of that spine in parallel, plus one agent running a
live end-to-end dry run and logging what broke. Round 2 is now complete and integrated. **Round
3** — happening now — is a swarm of roughly seven agents deepening business-type branching across
all 24 DE steps, adding two new council personas, hardening CI and the validation script, adding
business-type instrumentation to the ops layer, auditing whether the connectors layer's
"check-before-assuming" promise is real in practice, and running a second live end-to-end dry run
against a marketplace business. Round 2's output fed directly into this roadmap's v0.2 priorities
below; round 3's output will do the same for round 4. Treat this document as a snapshot that gets
rewritten each round, not a static plan drafted once and executed against.

This document is honest about the gap between what the plugin actually is right now and the
long-term vision the spec describes — potentially hundreds of agents and thousands of skills
covering the full lifecycle of running a business, not just starting one. It exists so that gap
gets closed deliberately, in prioritized horizons, rather than by throwing volume at it.

## v0.1 — complete

Round 1 delivered one coherent, working pass through the whole lifecycle: a central Startup
Operator agent, onboarding + recurring check-in interviews, all 24 Disciplined Entrepreneurship
step skills, business-plan assembly/revision/review-council skills, a 7-persona review council,
AI-risk and privacy gates, GTM/ops/design/connector layers, QA agents and a structural validation
script (not yet wired into CI), and 5 slash commands. What v0.1 delivered, honestly, was **one
deep, working path** — first contact through an operating business with a check-in cadence — with
SaaS-flavored guidance dominating wherever a step skill needed a concrete example to anchor
questions. Industry-specific variants of each step were largely unwritten, the council persona
library was SaaS/B2B-leaning, ops/GTM tooling was generic rather than business-model-specific, and
none of it had been driven through a real end-to-end dry run or adversarial review.

## Round 2 — adversarial review and fix: complete and integrated

Round 2 was a swarm of roughly seven agents, each independently reviewing and fixing one layer of
what round 1 built, plus one agent driving a live, synthetic end-to-end business
(**ShiftCover**, a B2B SaaS shift-coverage tool) through the full lifecycle and logging every gap
it found to `docs/QA-FINDINGS-ROUND2.md` (cross-checked against a parallel, more exhaustive gate
sweep in `docs/QA-FINDINGS-GATES-ROUND2.md`). Its findings were fixed directly rather than left as
an open backlog, and the fixes are now verified present in the repo:

- **Mandatory AI-risk gates wired into the DE steps that produce fact-claims and into onboarding.**
  Steps `04-calculate-the-tam-for-the-beachhead-market`, `14-calculate-the-tam-for-follow-on-
  markets`, `16-set-your-pricing-framework`, `17-calculate-the-ltv-of-a-customer`, and
  `19-calculate-the-coca` each now carry a `## Mandatory AI-risk gate` section with a MANDATORY
  GATE banner that blocks a step from being marked `status: "drafted"` until the gate passes or a
  BLOCKED finding is resolved — closing the gap where an unsourced number could reach the assembled
  plan before any risk review saw it. `skills/interview/onboarding-interview` got the matching
  fix on the interview side.
- **"Confidence & Validation Status" is now a real, mandatory section**, not a gap between what the
  risk layer expected and what plan assembly produced. `agents/business-plan-editor.md` now states
  it explicitly as mandatory on every canonical plan and revision, positioned right after the
  executive summary; `skills/business-plan/assemble-business-plan/SKILL.md` instructs writing it
  and checks for its presence with all four required parts before considering assembly done.
- **The orchestrator's step-status bug is fixed.** `agents/orchestrator.md` is now explicit and
  repeated at multiple points that no DE step's `status` is ever promoted past `"drafted"` by
  anything in the plugin — `"approved"` was a stage-machine state (the whole plan, post-council),
  not a per-step status, and the confusion between the two is closed.
- **The council aggregation edge case is fixed.** `skills/business-plan/run-review-council/
  SKILL.md` §5–6 now has a precisely defined "harshest non-outlier" computation, including a
  documented rule for the specific cascade that could otherwise empty the blocking set and leave no
  defined aggregate, plus a floor rule on the outlier test and the new 5th-seat mechanics for
  `technical-feasibility-reviewer`.
- **`business_basics.funding_intent` is a real field.** `docs/DATA-CONTRACT.md` now declares it
  alongside `gtm.funding_strategy`, with the distinction spelled out: `funding_intent` is the
  earliest founder-stated signal (or `undecided`), set once by onboarding and never re-inferred;
  `gtm.funding_strategy` is the confirmed, operational decision made at GTM time.
- **A technical-feasibility review-council persona** (`agents/council/technical-feasibility-
  reviewer.md`) closed the gap where a technically unrealistic build plan could sail through every
  round-1 persona untouched — bringing the council to 8 personas.
- **A CI validation workflow** (`.github/workflows/validate-plugin.yml`) now runs
  `scripts/validate-plugin.sh` on every `push` and `pull_request`, making `docs/TESTING.md` Layer 1
  enforced automatically rather than dependent on a contributor remembering to run it locally.

## Round 3 — deepening breadth, in progress

Round 3 is a swarm of roughly seven agents actively closing v0.2 priorities 1 and 2 below (rather
than leaving them as open gaps for a future round to start), while also advancing priorities 3-5
in parallel:

- **Two agents deepening business-type branching** across the 24 DE step skills for
  `marketplace`, `services`, and `consumer_app` — the three types round 1's SaaS-leaning default
  under-served most.
- **Two new council personas** — `marketplace-liquidity-specialist` and `services-unit-economics-
  reviewer` — closing the two sharpest gaps in v0.2 priority 2's list (no persona could
  interrogate two-sided-liquidity claims or services delivery-capacity/utilization economics on
  their own terms).
- **CI and validation-script hardening** — two new checks added to `scripts/validate-plugin.sh` /
  the GitHub Actions workflow, addressing v0.2 priority 3.
- **Business-type instrumentation added to 4 ops skills** — addressing v0.2 priority 4.
- **An audit of whether the connectors layer's "check before assuming" promise is real** — walking
  every GTM/ops skill that would act through a connector and confirming (or finding gaps in)
  whether it actually checks `connectors.needed_not_installed` before assuming success, addressing
  v0.2 priority 5.
- **A second live end-to-end dry run**, this time against a marketplace business, logging findings
  to `docs/QA-FINDINGS-ROUND3.md` — deliberately choosing a business type round 2's dry run
  (B2B SaaS) didn't exercise, so the two dry runs together stress-test different parts of the
  business-type branching this round is building.

**Grounded current state, walked directly against the repo as this document was written** (a
snapshot mid-round — round 3 is still running as this is written, so treat the actual files as
more current than the specifics below):

- **Business-type branching**: 12 of 24 DE step skills (`01` through `12`) now have a real,
  developed `## Business-type branching` section with genuinely distinct treatment per type — not
  a one-line conditional. Spot-checking `01-market-segmentation` and
  `04-calculate-the-tam-for-the-beachhead-market` confirms the depth bar is real: `marketplace`
  gets its own counting/pricing logic (GMV × take rate, not a per-seat price; supply/demand sides
  segmented separately), `services` gets delivery-capacity framing distinct from a SaaS seat
  count, not a reskinned SaaS paragraph. Steps `13` through `24` do not yet have the section as of
  this snapshot — that's the concrete remaining scope for this round (and, if round 3 doesn't
  finish it, for round 4).
- **Council personas**: 8 personas present (`vc-panel`, `expert-entrepreneur-panel`,
  `customer-discovery-skeptic`, `product-market-fit-panel`, `financial-modeling-reviewer`,
  `competitive-strategy-reviewer`, `sales-motion-reviewer`, `technical-feasibility-reviewer`); the
  two new personas this round targets were not yet present as separate files as of this snapshot.
- **Ops instrumentation**: 1 of 5 `skills/ops/*` packages (`kpi-dashboard-setup`) branches by
  `business_type` as of this snapshot; `weekly-metrics-review`, `retention-and-churn-analysis`,
  `runway-and-burn-tracking`, and `scaling-readiness-check` do not yet.
- **CI**: the workflow already runs on both `push` and `pull_request` (not main-only) and fails
  the build on a non-zero exit rather than merely annotating — v0.2 priority 3's "confirm it's
  actually blocking" concern is resolved; what's left is the script's *coverage* (the
  data-contract-field and verdict-schema checks this round is adding).
- **Connectors**: `agents/connectors-liaison.md` itself correctly distinguishes `wired_up` from
  `needed_not_installed` and never silently deletes a needed-but-absent entry. What's still
  genuinely open, and is what this round's connector audit is checking directly rather than
  assuming: whether `skills/gtm/*` and `skills/ops/*` skills that would act through a connector
  actually route through that check before assuming success, as opposed to only the liaison agent
  itself enforcing it.

## v0.2 — deepen before widening

Priorities, sharpened against what round 3 is actually doing (not the original speculative list):

1. **Finish business-type branching across all 24 DE step skills, and check it for quality, not
   just presence.** Round 3 is actively closing this — 12 of 24 steps have a genuinely distinct,
   well-reasoned branch per type as of this snapshot (see "Grounded current state" above for the
   depth bar being met). The remaining scope is mechanical and known: steps `13` through `24` need
   the same treatment steps `01`-`12` already got, and `docs/UX-INTERVIEW-DESIGN.md` §4 remains
   the bar and the worked-example reference for it.
2. **Council persona coverage for the business types the interview layer now takes seriously.**
   Round 3 is actively closing this by adding `marketplace-liquidity-specialist` and
   `services-unit-economics-reviewer`. Once both land, remaining coverage gaps are a
   regulated-industry (health/fintech) compliance-minded reviewer and a hardware/physical-product
   operator persona — track persona coverage against `business_type` values directly in
   `docs/DATA-CONTRACT.md` so gaps stay visible, per `docs/ARCHITECTURE.md`'s "Why the review
   council varies" section.
3. **Confirm the CI validation workflow is actually blocking, and extend what it checks.** The
   "actually blocking" half of this is resolved (see "Grounded current state" above). Round 3 is
   extending the script's coverage with two new checks; once landed, re-verify they cover what
   `docs/TESTING.md` Layer 1 promises but the pre-round-3 script didn't yet mechanically check —
   that a new `business-state.json` field introduced anywhere is declared in
   `docs/DATA-CONTRACT.md` in the same change, and that council agents actually commit to the
   CONVENTIONS §6 verdict schema rather than approximating it.
4. **Business-model-specific ops/GTM instrumentation.** Round 3 is adding business-type
   instrumentation to 4 ops skills — as of this snapshot only `kpi-dashboard-setup` had it, so this
   is the round closing the exact gap v0.2 previously flagged: `weekly-metrics-review`,
   `retention-and-churn-analysis`, `runway-and-burn-tracking`, and `scaling-readiness-check`
   dispatching on `business_type` the same way `kpi-dashboard-setup` already does (MRR/NRR/churn-
   cohort for SaaS, liquidity/take-rate for marketplace, inventory-turn/contribution margin for
   physical product).
5. **Wire the connectors layer to what's already cataloged, rather than cataloging more.** Round 3
   is auditing this directly rather than assuming the liaison agent's own correct behavior means
   every caller routes through it — `docs/QA-FINDINGS-CONNECTORS-ROUND3.md`, once it lands, is the
   authoritative source for exactly which GTM/ops skills do and don't check
   `connectors.needed_not_installed` before assuming success, per `docs/ARCHITECTURE.md`'s "not
   assuming tools the founder hasn't installed" section.
6. **Fold round 2's and round 3's live dry-run findings into a concrete backlog.**
   `docs/QA-FINDINGS-ROUND2.md` (the ShiftCover B2B SaaS dry run) is resolved — its concrete
   findings were fixed directly this round rather than left as backlog (see the round 2 section
   above for the specifics). `docs/QA-FINDINGS-ROUND3.md` (a second dry run, this time against a
   marketplace business, deliberately covering the business-type gap the first dry run left
   untested) is being written concurrently with this document and did not yet exist at the time
   this roadmap was last checked against the repo. Once it lands, it — together with
   `docs/QA-FINDINGS-CONNECTORS-ROUND3.md` if that also lands — is the most grounded source of
   "what a real founder hits first" available for setting round 4's priorities, more grounded than
   anything in this list, because it comes from actually driving a synthetic business through the
   full state machine rather than reading the code and reasoning about where it's likely to break.
   The next roadmap revision should read both files and promote their findings above the items in
   this list wherever they conflict on priority.

### What a founder would hit first today, honestly

Some of what round 2 found is now fixed; some things a real founder would still notice are
unchanged by round 2 or round 3 so far:

1. **Fixed since round 2**: a founder whose plan contains an unsourced number no longer sails
   through unnoticed — the mandatory AI-risk gates in steps 04/14/16/17/19 and onboarding, plus the
   now-mandatory Confidence & Validation Status section, catch it structurally rather than relying
   on every agent's own instructions to remember to flag it.
2. **Still real, narrower than before**: the review council's rigor is still uneven across
   business types until round 3's two new personas land and steps 13-24 finish branching — a
   marketplace or services founder today gets a shallower adversarial review and a more
   generic-feeling interview than a SaaS founder does, though the gap is visibly closing rather
   than static (12/24 steps and 8/10 targeted personas in place as of this snapshot, up from a
   handful of steps and 7 personas at the start of round 2).
3. **Still open**: whether GTM/ops skills genuinely check `connectors.needed_not_installed` before
   assuming a connector-backed action succeeded is, as of this snapshot, an open question this
   round's audit is actively answering rather than a confirmed gap or a confirmed non-issue —
   treat `docs/QA-FINDINGS-CONNECTORS-ROUND3.md` as authoritative once it exists.
4. **Still open**: nothing in the repo has yet been driven through a real multi-session lifecycle
   by an actual person — every check so far (round 1's own review, round 2's SaaS dry run, round
   3's marketplace dry run) is still a simulated pass, and simulated passes reliably miss the
   specific ways real founders phrase vague answers, get confused about `/business-status` state,
   or stall out mid-interview. None of these are reasons not to use the plugin as a working spine
   — they're the reason this roadmap treats "one working pass" and "trustworthy at scale" as
   different milestones.

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
adversarially reviewing, dry-running, and rewriting the roadmap, the same shape this document
itself has now gone through twice.

## The constraint that doesn't loosen as this grows

Every horizon above is additive to the same contract, not a departure from it. `CONVENTIONS.md`
exists precisely because a swarm of independently-authored agents and skills only stays coherent
if they all write against one directory layout, one frontmatter shape, one data contract, and one
verdict schema. Growth from "hundreds" toward "thousands" of skills — and from round 3 toward
round 4 and beyond — is only survivable, for users and for the swarm of contributors building it,
if every new or revised skill or agent still:

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
validated against `CONVENTIONS.md` (via the CI validation workflow, now confirmed blocking on
every push and pull request) before it ships, the same way round 1's first pass was meant to be,
round 2 checked that it actually was, and round 3 is now extending what gets checked.
