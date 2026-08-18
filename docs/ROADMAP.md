# Roadmap

This plugin is being built through iterative swarm rounds, not a single pass: **round 1** built
v0.1 end to end (a full but shallow lifecycle spine); **round 2** was a swarm of agents
adversarially reviewing and fixing every layer of that spine in parallel, plus one agent running a
live end-to-end dry run and logging what broke; **round 3** was a swarm of roughly seven agents
deepening business-type branching across all 24 DE steps, adding two new council personas,
hardening CI and the validation script, adding business-type instrumentation to the ops layer,
auditing whether the connectors layer's "check-before-assuming" promise is real in practice, and
running a second live end-to-end dry run against a marketplace business. Round 2 and round 3 are
both now **complete and integrated** — every finding either round's dry run or audit work
surfaced was fixed directly in the repo, not left as an open backlog; the "Round 3 — complete and
integrated" section below documents each fix confirmed present, file by file, the same way the
round 2 section already did. **Round 4** — happening now, concurrently with this revision — is a
swarm closing the two remaining council-persona gaps, running a third live dry run against a
services business, auditing `CONVENTIONS.md` itself for staleness against the repo it governs,
running the QA-tooling agents (the auditor/consistency-checker) for real at full-repo scale for
the first time, and seeding a first Layer 2 behavioral eval suite. Round 3's output fed directly
into this roadmap's v0.2 priorities; round 4's output will do the same for round 5. Treat this
document as a snapshot that gets rewritten each round, not a static plan drafted once and executed
against.

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

## Round 3 — deepening breadth: complete and integrated

Round 3 was a swarm of roughly seven agents closing v0.2 priorities 1 through 5 below and folding a
second live dry run's findings directly into fixes rather than an open backlog. This section was
rewritten after walking the actual repo, not carried forward from round 3's in-progress snapshot —
every item below was verified present in the current files as this revision was written:

- **Business-type branching is now present in all 24 DE step skills.** Steps `01` through `14`,
  `17`, `18`, and `20`, `21`, `23`, `24` carry a literal `## Business-type branching` heading;
  steps `15`, `16`, `19`, and `22` carry the same real, developed per-type content under
  differently-worded headings the individual step authors chose (`## Business-type starting
  points`, `## Business-type cost drivers`, `## Business-type MVBP shapes`) — confirmed by reading
  each file's actual section content, not by grepping for one exact heading string. All 24 steps
  give `marketplace`, `services`, and `consumer_app` genuinely distinct treatment, not a reskinned
  SaaS paragraph (e.g. step 4 sizes a marketplace by GMV × take rate and segments supply/demand
  separately; step 19 costs supply-side and demand-side acquisition separately rather than a
  blended "marketplace COCA").
- **Two new council personas landed**: `agents/council/marketplace-liquidity-specialist.md` and
  `agents/council/services-unit-economics-reviewer.md`, bringing the council to **10 personas**
  (confirmed by both a direct directory listing and `scripts/validate-plugin.sh`'s own count).
  `docs/DATA-CONTRACT.md`'s persona-coverage table documents both as unconditional dedicated seats
  for their respective `business_type` values.
- **CI and validation-script hardening — two new checks, both confirmed live**:
  `scripts/validate-plugin.sh` now cross-checks every `business-state.json` top-level field
  referenced anywhere in the corpus against `docs/DATA-CONTRACT.md`'s declared schema
  (warning-level), and separately checks that every `agents/council/*.md` file's own instructions
  commit to the exact CONVENTIONS.md §6 verdict schema (`## Verdict:` heading naming all four
  values) rather than approximating it (error-level). A live run against the current repo returns
  `PASS — no structural drift from CONVENTIONS.md detected` with 46 skills, 27 agents, 5 commands,
  10 council files, 0 warnings, 0 errors.
- **Business-type instrumentation landed in all 5 `skills/ops/*` packages** — `kpi-dashboard-
  setup`, `weekly-metrics-review`, `retention-and-churn-analysis`, `runway-and-burn-tracking`, and
  `scaling-readiness-check` all now read `business_basics.business_type` and dispatch their
  metric/KPI set accordingly (confirmed by grep across all five `SKILL.md` files).
- **The connectors-layer audit landed and found the round-2 fix holding.**
  `docs/QA-FINDINGS-CONNECTORS-ROUND3.md` audited all 19 `agents/gtm/*`, `agents/ops/*`,
  `skills/gtm/*`, and `skills/ops/*` files against `docs/CONNECTORS-CATALOG.md`: 5 REAL CHECK
  (the same five agents round 2 fixed), 0 ASSERTED-BUT-NOT-REAL, 14 correctly N/A (document-only
  skills that never touch a connector). The audit also found and fixed one real ambiguity in
  `agents/connectors-liaison.md` itself — its "report back to the calling agent" section now states
  explicitly that a not-safe-to-proceed connector status blocks only the connector-dependent piece
  of a caller's task, never the whole deliverable, and that the pending item must never be silently
  omitted.
- **A second live end-to-end dry run against a marketplace business** (`docs/QA-FINDINGS-
  ROUND3.md`, **SkyClaim**, a two-sided drone-inspection marketplace) surfaced four real findings,
  and all four were fixed directly, confirmed present in the current files:
  - **Blocking — steps 17/18 had zero marketplace branching**, producing a demonstrated
    incomplete-unit-economics gap in step 19 (a supply-side COCA with no comparable LTV to compare
    against). **Fixed:** step 17 now has an explicit "Marketplace" branch instructing LTV be
    computed per side, with a required explicit note when a side (e.g. one paid by the business)
    has no comparable LTV under the standard formula; step 18 now instructs costing both sides'
    acquisition funnels separately rather than blending them.
  - **Significant — step 4's beachhead-TAM sanity-check heuristic didn't specify GMV vs. take-rate
    revenue**, producing a spurious "too small" signal for correctly-sized marketplace businesses.
    **Fixed:** the sanity-check section now states explicitly that the heuristic is revenue-terms
    and applies directly to SaaS/physical-product/services; for a marketplace it must be checked
    against the GMV figure, with take-rate revenue reported separately and an order-of-magnitude
    gap between the two flagged as a marketplace-typical pattern, not a beachhead-choice problem.
  - **Blocking — a vacuous, unconditionally-true trigger clause** in `run-review-council/
    SKILL.md`'s seat-selection logic (`"whenever Steps 10/11 are not yet approved"`) — the same bug
    class round 2 found in the orchestrator, independently present here and confirmed to have
    survived a full round-3 rewrite of the surrounding section untouched. Because no step `status`
    is ever promoted past `"drafted"`, this clause silently overrode two legitimately-firing
    triggers (`sales-motion-reviewer`, `product-market-fit-panel`) for every business type other
    than `marketplace`/`services`. **Fixed:** replaced with a real, variable content signal (low-
    confidence `key_assumptions` on steps 10/11, or an explicit "no differentiated Core/position
    found yet" summary) in both the rule this dry run flagged and the parallel rule the same fix
    pattern applied to.
  - **Present but thin — step 3's marketplace template didn't scaffold the two-profile structure
    its own prose required.** **Fixed:** the output-file template block now explicitly reads "for a
    marketplace, complete one full table per side — supply-side profile and demand-side profile,"
    mirroring step 12's existing pattern.
  - One further significant finding (a softer-severity reviewer's single most consequential finding
    can be absent from the severity-gated Required Revisions checklist when it survives the outlier
    test via cross-severity tag corroboration rather than being discarded) was also fixed: §8.4 now
    includes an explicit `### Also flagging, regardless of severity` callout for exactly this case.

## Round 4 — closing the persona gap and stress-testing the tooling: in progress

Round 4 is running concurrently with this roadmap revision. Its scope, as described to the swarm:

- **Two more council personas** — `regulated-industry-compliance-reviewer` and `hardware-physical-
  product-operator` — closing the two persona gaps `docs/DATA-CONTRACT.md`'s coverage table has
  flagged as open since round 2 (no persona could interrogate a health/fintech regulatory posture
  or a hardware/physical-product build-and-ops plan on its own terms). **As of this snapshot,
  neither has landed**: `agents/council/` still lists exactly the same 10 personas round 3
  produced, confirmed by a direct directory walk immediately before writing this section. Treat
  this as live, not settled — re-walk `agents/council/` before quoting a persona count.
- **A third live end-to-end dry run**, this time against a services business, specifically testing
  whether round 3's services-specific work (`services-unit-economics-reviewer`, the services
  branches added across the 24 DE steps) holds up the way the marketplace dry run confirmed the
  marketplace-specific work did. Its findings will land in a `docs/QA-FINDINGS-ROUND4.md`-shaped
  file. **As of this snapshot, no such file exists yet** in `docs/` — confirmed by a direct
  directory listing, not assumed absent.
- **A `CONVENTIONS.md` staleness audit** — the contract file itself hasn't been re-checked against
  the repo it governs since round 1, despite three rounds of the repo growing and changing
  underneath it. This is a genuinely different kind of check than any prior round ran: every prior
  round checked the repo against `CONVENTIONS.md`; this one checks whether `CONVENTIONS.md` still
  accurately describes the repo (e.g. whether its directory-layout example, its verdict-schema
  example, or its data-contract pointer still match what 46 skills and 27 agents actually do).
- **A full-repo QA-tooling dogfood pass** — running `agents/qa/skill-quality-auditor.md` and
  `agents/qa/consistency-checker.md` for real, at full-repo scale, for the first time; prior rounds
  exercised these agents' *design* but not a real full-corpus run. Its findings will land in a
  `docs/QA-DOGFOOD-ROUND4.md`-shaped file. **As of this snapshot, no such file exists yet** in
  `docs/` — confirmed by a direct directory listing.
- **A first Layer 2 behavioral eval suite seed** — `docs/TESTING.md` has described a Layer 2
  (behavioral, not structural) testing layer since round 1 without the repo containing any actual
  eval suite for it. Round 4 seeds a first one. **As of this snapshot, no `evals/` directory exists
  yet** at the repo root — confirmed by a direct directory listing.

Because round 4 is still running as this document is written, none of the above is scored as
complete here — the round-3 section above earned its "complete and integrated" heading only after
every one of its claimed fixes was independently re-verified against the live files, and round 4's
items should get the same treatment in the next roadmap revision, not be marked done on the strength
of the plan alone.

## v0.2 — deepen before widening: nearly complete, one item open

Of the six v0.2 priorities this document has tracked since round 2, five are now fully closed,
confirmed against the live repo rather than assumed from either round's own report:

1. **Business-type branching across all 24 DE step skills — closed.** All 24 steps now carry real,
   distinct per-type content (see the round 3 section above for the verification method and the
   heading-naming caveat).
2. **Council persona coverage — partially closed, and this is the one open item.** Round 3 closed
   the two sharpest gaps (`marketplace-liquidity-specialist`, `services-unit-economics-reviewer`),
   bringing the council to 10 personas. What remains, per `docs/DATA-CONTRACT.md`'s coverage table,
   is exactly what round 4 is now building: a regulated-industry (health/fintech) compliance-minded
   reviewer and a hardware/physical-product operator reviewer. Neither has landed as of this
   revision. **This is the one v0.2 priority still genuinely open** — everything else below is
   closed.
3. **CI validation workflow, confirmed blocking and extended — closed.** The workflow runs on every
   `push` and `pull_request` with no branch filter and no `continue-on-error`; the script now also
   checks `business-state.json` field declarations against `docs/DATA-CONTRACT.md` and council
   verdict-schema commitment against `CONVENTIONS.md` §6, both confirmed live in a real run (see the
   round 3 section above for the exact output).
4. **Business-model-specific ops/GTM instrumentation — closed.** All 5 `skills/ops/*` packages
   dispatch by `business_type`, confirmed by direct inspection of all five files.
5. **Wiring the connectors layer to what's already cataloged — closed.** The round-3 audit
   (`docs/QA-FINDINGS-CONNECTORS-ROUND3.md`) confirmed the round-2 fix holds across all 19 relevant
   files (5 REAL CHECK, 0 ASSERTED-BUT-NOT-REAL, 14 correctly N/A) and fixed one further ambiguity
   in `connectors-liaison.md` itself.
6. **Folding round 2's and round 3's live dry-run findings into fixes rather than backlog —
   closed.** Every concrete finding in `docs/QA-FINDINGS-ROUND2.md`, `docs/QA-FINDINGS-ROUND3.md`,
   and `docs/QA-FINDINGS-CONNECTORS-ROUND3.md` was fixed directly (see the round 2 and round 3
   sections above); none of the three files carries an open, unaddressed blocking or significant
   finding as of this revision.

**Why this isn't yet a "v0.2 — complete" heading.** Priority 2's remaining half is a real, named,
concrete gap — not a hedge or a placeholder for "something might still be missing." The moment
`regulated-industry-compliance-reviewer` and `hardware-physical-product-operator` land and are
confirmed present the same way this revision confirmed round 3's personas, this section should be
retitled "v0.2 — complete" and folded into the same style the "v0.1 — complete" and "Round 2/3 —
complete and integrated" sections already use above. Whatever round 4's services dry run, the
`CONVENTIONS.md` staleness audit, and the QA-tooling dogfood pass surface in the meantime should be
triaged into a new v0.3-scoped list at that point — round 4's own findings aren't yet known as this
is written, so this document is structured to receive them rather than to guess their contents.

### What a founder would hit first today, honestly

1. **Fixed since round 2**: a founder whose plan contains an unsourced number no longer sails
   through unnoticed — the mandatory AI-risk gates in steps 04/14/16/17/19 and onboarding, plus the
   now-mandatory Confidence & Validation Status section, catch it structurally, confirmed working
   live (not just present) by a second independent dry run in round 3.
2. **Fixed since round 3**: a marketplace or services founder no longer gets a visibly shallower
   review than a SaaS founder does — business-type branching is complete across all 24 steps, both
   business types have a dedicated council seat, and the specific cross-step gap a marketplace
   founder would have hit (an LTV/COCA comparison that silently assumed a single-sided customer) is
   closed.
3. **Still open, narrower than before**: a founder in a regulated industry (health, fintech) or
   running a hardware/physical-product business still gets a review council without a persona built
   to interrogate their specific risk surface — the 4 core seats plus whichever contextual seat
   fires still cover them, but not with the same precision the marketplace/services fixes now give
   those two business types. This is exactly what round 4 is closing.
4. **Still open**: nothing in the repo has yet been driven through a real multi-session lifecycle
   by an actual person — every check so far (round 1's own review, round 2's SaaS dry run, round
   3's marketplace dry run, and round 4's services dry run once it lands) is still a simulated pass,
   and simulated passes reliably miss the specific ways real founders phrase vague answers, get
   confused about `/business-status` state, or stall out mid-interview. None of these are reasons
   not to use the plugin as a working spine — they're the reason this roadmap treats "one working
   pass" and "trustworthy at scale" as different milestones.
5. **Newly open as of this revision, not yet assessed**: whether `CONVENTIONS.md` itself still
   accurately describes the repo it governs, after three rounds of growth, is an open question
   round 4's staleness audit is actively answering. Likewise, whether the QA-tooling agents
   (`skill-quality-auditor`, `consistency-checker`) actually surface real problems when run at full-
   repo scale, rather than only being exercised in narrow demonstrations, has never been tested
   until round 4's dogfood pass. Treat both as open until their respective round-4 output files
   exist and have been read.

## v0.3 and beyond — the long tail

Once the v0.2 depth work has landed and been used on a handful of real businesses, the honest
long-term direction is breadth: more industry verticals per DE step (regulated industries,
hardware, B2B2C, nonprofit/social-enterprise variants — the first two of which round 4 is starting
at the council-persona layer now), a genuinely large council-persona library segmented by stage and
geography as well as business type, deeper fundraising-specific agents (pitch-deck iteration,
cap-table sanity checks flagged clearly as non-legal-advice), a real Layer 2 behavioral eval suite
beyond the seed round 4 is planting, and operations agents that extend meaningfully past year one
(scaling playbooks, hiring plans, board-reporting assembly). This is where the "hundreds of agents,
thousands of skills" scale of the long-term vision actually starts to apply — but only some of it.
Getting there is explicitly not a matter of writing many more agents as fast as possible, and it is
not a matter of running one more review round and calling the plugin finished — it's a standing
practice of building, adversarially reviewing, dry-running, and rewriting the roadmap, the same
shape this document itself has now gone through three times.

## The constraint that doesn't loosen as this grows

Every horizon above is additive to the same contract, not a departure from it. `CONVENTIONS.md`
exists precisely because a swarm of independently-authored agents and skills only stays coherent
if they all write against one directory layout, one frontmatter shape, one data contract, and one
verdict schema. Growth from "hundreds" toward "thousands" of skills — and from round 4 toward
round 5 and beyond — is only survivable, for users and for the swarm of contributors building it,
if every new or revised skill or agent still:

- lives in the directory layout `CONVENTIONS.md` §1 defines, with kebab-case names;
- declares any new `business-state.json` field in `docs/DATA-CONTRACT.md` in the same change
  that introduces it, rather than inventing undocumented fields — now checked mechanically, not
  just by convention, per round 3's CI hardening;
- for council agents, returns a verdict in the exact schema in `CONVENTIONS.md` §6, as one
  distinct persona in a panel of 3-5, never as a sole reviewer standing in for "the council" — also
  now checked mechanically;
- states concrete deliverables — a file, a decision, a score — never "general guidance";
- labels business/financial content once, plainly, as a planning aid rather than licensed advice,
  per `CONVENTIONS.md` §7, instead of stacking disclaimers everywhere.

A thousand skills that all violate this contract in slightly different ways would be worse than
the 24-step spine this repo shipped in round 1. The roadmap's job, every round, is to make sure
volume never becomes the goal in place of coherence — each horizon above is scoped so it can be
validated against `CONVENTIONS.md` (via the CI validation workflow, confirmed blocking on every
push and pull request, and now checking two more structural properties than it did at round 2)
before it ships, the same way round 1's first pass was meant to be, round 2 checked that it
actually was, round 3 extended what gets checked and confirmed it held under a second independent
dry run, and round 4 is now turning that same scrutiny on `CONVENTIONS.md` itself and on the
QA-tooling layer that's supposed to enforce all of this.
