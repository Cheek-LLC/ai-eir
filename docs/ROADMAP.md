# Roadmap

This plugin is being built through iterative swarm rounds, not a single pass: **round 1** built
v0.1 end to end (a full but shallow lifecycle spine); **round 2** was a swarm of agents
adversarially reviewing and fixing every layer of that spine in parallel, plus one agent running a
live end-to-end dry run and logging what broke; **round 3** was a swarm of roughly seven agents
deepening business-type branching across all 24 DE steps, adding two new council personas,
hardening CI and the validation script, adding business-type instrumentation to the ops layer,
auditing whether the connectors layer's "check-before-assuming" promise is real in practice, and
running a second live end-to-end dry run against a marketplace business; **round 4** closed the
last two council-persona gaps, ran a third live dry run against a services business, audited
`CONVENTIONS.md` itself for staleness against the repo it governs, ran the QA-tooling agents
(the auditor/consistency-checker) for real at full-repo scale for the first time, and seeded a
first Layer 2 behavioral eval suite; **round 5** closed the last systemic QA-dogfood gap (an
explicit "what you write" statement on all 12 council personas), ran a fourth live dry run against
a `consumer_app` business (the last of the six `business_basics.business_type` values never yet
tested live), and — for the first time — actually executed `docs/TESTING.md`'s Layer 3 pre-release
regression checklist against the three existing dry-run fixtures, which is where round 5's single
most consequential finding came from: a real, latent bug in `revise-business-plan`'s
stage-transition logic that would have stalled the revision loop the first time anyone actually
drove a business through it. **Rounds 2, 3, 4, and 5 are all now complete and integrated** — every
finding any round's dry run or audit work surfaced was fixed directly in the repo, not left as an
open backlog; each "complete and integrated" section below documents each fix confirmed present,
file by file, the same way every prior round's section has. **Round 6** — happening now,
concurrently with this revision — is two agents each driving a real fixture through exactly the
territory round 5's Layer 3 pass identified as the biggest untested gap: one is driving
`.startup/shiftcover/` through an actual revision cycle for the first time, live-testing whether
round 5's `revise-business-plan` fix actually holds; the other is driving
`.startup/vantage-point-search/` through GTM and operations for the first time, since nothing in
this repo's live-testing history has ever taken a business past `stage: "approved"`. Round 5's
output fed directly into this revision's roadmap; round 6's output will do the same for round 7's
revision of this document. Treat this document as a snapshot that gets rewritten each round, not a
static plan drafted once and executed against.

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
  at the time (confirmed by both a direct directory listing and `scripts/validate-plugin.sh`'s own
  count). `docs/DATA-CONTRACT.md`'s persona-coverage table documents both as unconditional
  dedicated seats for their respective `business_type` values.
- **CI and validation-script hardening — two new checks, both confirmed live**:
  `scripts/validate-plugin.sh` now cross-checks every `business-state.json` top-level field
  referenced anywhere in the corpus against `docs/DATA-CONTRACT.md`'s declared schema
  (warning-level), and separately checks that every `agents/council/*.md` file's own instructions
  commit to the exact CONVENTIONS.md §6 verdict schema (`## Verdict:` heading naming all four
  values) rather than approximating it (error-level).
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

## Round 4 — closing the persona gap and stress-testing the tooling: complete and integrated

Round 4 closed the last v0.2 persona gap, ran a third live dry run, audited `CONVENTIONS.md`
itself, ran the QA-tooling layer at real full-repo scale for the first time, and seeded a first
Layer 2 eval suite. This section was rewritten after walking the actual repo — every item below
was re-confirmed present in the current files, not carried forward from round 4's in-progress
snapshot:

- **Two more council personas landed**, bringing the council to **12 personas** — confirmed by a
  direct `agents/council/` directory listing (`competitive-strategy-reviewer`,
  `customer-discovery-skeptic`, `expert-entrepreneur-panel`, `financial-modeling-reviewer`,
  `hardware-physical-product-operator`, `marketplace-liquidity-specialist`,
  `product-market-fit-panel`, `regulated-industry-compliance-reviewer`, `sales-motion-reviewer`,
  `services-unit-economics-reviewer`, `technical-feasibility-reviewer`, `vc-panel`) and by
  `scripts/validate-plugin.sh`'s own live count (12 council files checked). `docs/DATA-CONTRACT.md`'s
  persona-coverage table documents both new personas: `hardware-physical-product-operator` as the
  unconditional dedicated seat for `physical_product`, and `regulated-industry-compliance-reviewer`
  as the highest-priority *content-signal* trigger (not tied to any single `business_type` value),
  checked ahead of `technical-feasibility-reviewer` per the seat-selection tie-break rule.
- **A third live end-to-end dry run against a services business** (`docs/QA-FINDINGS-ROUND4.md`,
  **Vantage Point Search**, a retained executive-search practice, `already_operating`) confirmed
  round 3's services-specific work holds up completely independently, and surfaced five real
  findings, all fixed directly, confirmed present in the current files:
  - **Significant — step 18's costed-process template had no place for referral-driven
    "background relationship maintenance" time**, a real, demonstrated gap for the exact
    referral-driven services shape the step's own guidance names as the default case. **Fixed:**
    `skills/disciplined-entrepreneurship/18-map-the-sales-process-to-acquire-a-customer/SKILL.md`
    now has an explicit "## Background relationship/network maintenance (referral-driven
    businesses — see note below)" subsection outside the per-stage table.
  - **Polish — `assemble-business-plan`'s LTV:COCA reconciliation instruction was silent on a
    *healthy* ratio that still needs a services-specific capacity caveat.** **Fixed:**
    `skills/business-plan/assemble-business-plan/SKILL.md` §3 now instructs explicitly not to let a
    strong ratio alone read as a growth signal for a `services` business without stating whether it
    reflects real scalability or is orthogonal to a delivery-capacity constraint.
  - **Significant — the new `regulated-industry-compliance-reviewer` trigger, evaluated literally,
    would misfire on a business's own explicit *denial* of a regulated attribute** (a literal
    keyword match on "licensed" inside a sentence stating the business is *not* licensed; a literal
    match on "HIPAA" inside a surveyed-and-rejected Step 1 segment). **Fixed:**
    `skills/business-plan/run-review-council/SKILL.md`'s trigger specification now requires the
    keyword match to describe "the business's own actual or pursued activity," explicitly excluding
    a surveyed-and-rejected Step 1 segment and a sentence that negates rather than asserts the
    regulated attribute.
  - **Significant — the outlier tag-overlap check was syntactic (exact tag match), missing a real
    case where two reviewers substantively corroborated the same underlying concern under
    different tags**, discarding a REVISE that should have survived. **Fixed:**
    `run-review-council/SKILL.md` §6 now instructs a semantic check on top of the mechanical one —
    "don't just note 'tag overlap: none' when a semantic [overlap exists]" — and §8.4's
    Discarded-but-real-concerns write-up must name the specific cross-reference.
  - **Significant — §8.4's synthesized "Required revisions" checklist had no defined content when
    the aggregate verdict itself is `APPROVE_WITH_NOTES`** (a case neither round 2's REVISE
    aggregate nor round 3's REJECT aggregate had exercised). **Fixed:** §8.4 now heads the
    checklist `### Notes to consider` instead when the aggregate severity is APPROVE/
    APPROVE_WITH_NOTES, built from the union of surviving reviewers' Risks/gaps bullets.
- **A `CONVENTIONS.md` staleness audit landed and found (then fixed) a real, cross-cutting drift**:
  `CONVENTIONS.md` §5 had described `connectors.json` and `cadence.json` as separate mirror files
  on disk, contradicting `docs/DATA-CONTRACT.md`'s (and the actual data-flow's) design of
  `connectors`/`cadence` as keys *inside* `business-state.json`. The fix was not confined to
  `CONVENTIONS.md` itself — `docs/QA-DOGFOOD-ROUND4.md`'s cross-file consistency pass traced the
  same stale assumption into six more files describing "mirror" behavior, and all seven are now
  confirmed consistent: `CONVENTIONS.md` §5, `agents/orchestrator.md`, `agents/connectors-
  liaison.md`, `agents/risk/privacy-compliance-officer.md`, `skills/risk/privacy-check/SKILL.md`,
  `docs/ARCHITECTURE.md`, and `agents/qa/consistency-checker.md` (which additionally gained an
  explicit standing check for this exact drift pattern recurring in the future).
- **A full-repo QA-tooling dogfood pass landed** (`docs/QA-DOGFOOD-ROUND4.md`) — `skill-quality-
  auditor` and `consistency-checker` run for real against 29 files in full (all 10 then-current
  council files, all 4 GTM agents, all 5 ops agents, both risk agents, 6 sampled DE steps, the QA
  layer itself) plus a repo-wide duplicate-name and cross-reference sweep across the entire corpus.
  Result: the connectors.json/cadence.json drift above (fixed), one now-stale reference list inside
  `consistency-checker.md` itself (fixed same-pass), and one systemic-but-explicitly-out-of-scope
  finding — all 10 (now 12) council files were missing an explicit "## What you write" body
  statement, flagged for round 5 to fix mechanically rather than touched here since
  `agents/council/*` was off-limits to that round's own scope discipline. **This is exactly the fix
  round 5 is making** (see below) — confirmed landed as of this revision, see the round 5 section.
- **A first Layer 2 behavioral eval suite seed landed.** An `evals/` directory now exists at the
  repo root with 7 eval cases (`01-ai-risk-gate-unsourced-claim`,
  `02-council-verdict-aggregation`, `03-onboarding-vague-answer-pushback`,
  `04a-de-step04-branching-saas`, `04b-de-step04-branching-marketplace`,
  `05-connectors-liaison-fail-closed`, `06-revise-routes-through-revise-business-plan`), a
  `run-evals.sh` harness, a shared `lib/`, and a `README.md` — confirmed present by direct
  directory listing, closing the gap `docs/TESTING.md` had described without a real suite behind it
  since round 1.

## v0.2 — deepen before widening: complete

All six v0.2 priorities this document has tracked since round 2 are now closed, confirmed against
the live repo (not assumed from any round's own report) as this revision was written:

1. **Business-type branching across all 24 DE step skills — closed.** All 24 steps carry real,
   distinct per-type content (see the round 3 section above for the verification method and the
   heading-naming caveat), and round 4's services dry run independently re-confirmed the depth held
   for a fourth business type on a real fixture.
2. **Council persona coverage — closed.** Round 3 closed the marketplace/services gaps
   (`marketplace-liquidity-specialist`, `services-unit-economics-reviewer`); round 4 closed the
   last two — `regulated-industry-compliance-reviewer` and `hardware-physical-product-operator` —
   bringing the council to **12 personas**, confirmed present by a direct directory walk and by
   `scripts/validate-plugin.sh`'s live count as this revision was written. `docs/DATA-CONTRACT.md`'s
   coverage table's only remaining open note (`saas`/`consumer_app`/`other` have no *type-matched*
   dedicated seat, only content-triggered generalist coverage) was a deliberate, documented design
   choice reaffirmed by round 4, not an unfinished item — see that table for the reasoning.
3. **CI validation workflow, confirmed blocking and extended — closed.** The workflow runs on every
   `push` and `pull_request` with no branch filter and no `continue-on-error`; the script now also
   checks `business-state.json` field declarations against `docs/DATA-CONTRACT.md` and council
   verdict-schema commitment against `CONVENTIONS.md` §6, both confirmed live in a real run against
   the current repo (46 skills, 29 agents, 5 commands, 12 council files, 0 warnings, 0 errors, as
   this revision was written).
4. **Business-model-specific ops/GTM instrumentation — closed.** All 5 `skills/ops/*` packages
   dispatch by `business_type`, confirmed by direct inspection of all five files.
5. **Wiring the connectors layer to what's already cataloged — closed.** The round-3 audit
   (`docs/QA-FINDINGS-CONNECTORS-ROUND3.md`) confirmed the round-2 fix holds across all 19 relevant
   files, and round 4's `CONVENTIONS.md` staleness audit closed the one remaining piece of drift
   (the `connectors.json`/`cadence.json` mirror-file description) across all seven files it touched.
6. **Folding round 2's, round 3's, and round 4's live dry-run findings into fixes rather than
   backlog — closed.** Every concrete finding in `docs/QA-FINDINGS-ROUND2.md`,
   `docs/QA-FINDINGS-ROUND3.md`, `docs/QA-FINDINGS-CONNECTORS-ROUND3.md`, and
   `docs/QA-FINDINGS-ROUND4.md` was fixed directly (see the round 2, 3, and 4 sections above,
   each confirmed by re-reading the actual current file content, not the finding's own description
   of an intended fix); none of the four files carries an open, unaddressed blocking or significant
   finding as of this revision.

**Why this is now titled "v0.2 — complete."** Every priority above was re-verified directly
against the live repo while writing this revision — not declared complete because four rounds have
now passed and it feels due. The one item that kept this section open through round 4
(`regulated-industry-compliance-reviewer` and `hardware-physical-product-operator` not yet landed)
is now closed and independently confirmed: both personas exist as real files, both are documented
correctly in `docs/DATA-CONTRACT.md`'s coverage table, both were exercised (indirectly, via the
seat-selection logic they extend) by round 4's live dry run, and `scripts/validate-plugin.sh`
counts 12 council files, not 10. **This does not mean the plugin is "done"** — see "What a founder
would hit first today" and the v0.3 section below for what's genuinely still open. It means the
specific, six-item punch list this document has tracked since round 2 — the *depth* work
(business-type coverage, the persona library, CI enforcement, ops/GTM instrumentation, the
connectors layer, and turning dry-run findings into real fixes) — is finished, and the forward-
looking energy of this document now belongs to v0.3.

### What a founder would hit first today, honestly

1. **Fixed since round 2**: a founder whose plan contains an unsourced number no longer sails
   through unnoticed — the mandatory AI-risk gates in steps 04/14/16/17/19 and onboarding, plus the
   now-mandatory Confidence & Validation Status section, catch it structurally, confirmed working
   live across three independent dry runs on three different business types (round 3's marketplace
   run, round 4's services run — a fourth, false-precision instance of the exact same failure
   pattern, on Step 19's COCA figure, caught and fixed live in that session).
2. **Fixed since round 3, and independently re-confirmed by round 4**: a marketplace, services, or
   regulated-industry founder no longer gets a visibly shallower review than a SaaS founder does —
   business-type branching is complete across all 24 steps, every business type with a sharp
   failure mode now has a dedicated council seat (or, for regulated content, the highest-priority
   contextual trigger of any kind), and round 4's live services dry run demonstrated the whole
   chain — DE steps, plan assembly, and the dedicated council persona — catching a real,
   services-specific delivery-capacity gap no generic panelist's rubric would have owned.
3. **Fixed since round 5, though unverified by a live run yet**: the revision loop had a real,
   latent bug — `revise-business-plan` instructed writing a `stage` value
   (`"council_review"`) that `run-review-council`'s own precondition never reads or expects, which
   would have stalled the loop the first time anyone actually drove a business through a revision
   cycle. Round 5's Layer 3 regression pass found this by reading the two skills' contracts against
   each other rather than in isolation, and fixed it in the one file that owns the value. No fixture
   has yet exercised the corrected path — that is exactly what round 6 (below) is now attempting.
4. **The genuinely open frontier now, and it is not another persona or another business-type
   pass**: nothing in the repo has yet been driven through a real, multi-session lifecycle by an
   actual person — every check so far, across all five live dry runs (round 2's ShiftCover, round
   3's SkyClaim, round 4's Vantage Point Search, round 5's Kindling), has been a simulated,
   single-session pass, and simulated passes reliably miss the specific ways real founders phrase
   vague answers, get confused about `/business-status` state, or stall out mid-interview across a
   real gap of days or weeks. More concretely, and worth naming plainly, restated from round 5's own
   Layer 3 pass (`docs/QA-LAYER3-REGRESSION-ROUND5.md`): **not one of the four real fixtures under
   `.startup/` has ever exercised the revision loop or anything past plan approval.** `shiftcover`
   and `skyclaim` (now joined by `kindling`) sit at `stage: "revising"` — the point where a
   REVISE/REJECT verdict hands off to `revise-business-plan` — and none of the three fixtures shows
   that skill actually running a revision cycle back through a second council review.
   `vantage-point-search` is the only fixture to reach `stage: "approved"`, and stops exactly
   there — GTM, operations, and the recurring check-in cadence machinery (`agents/gtm/*`,
   `agents/ops/*`, `/check-in`, the whole back half of `docs/ARCHITECTURE.md`'s lifecycle diagram)
   have never been exercised by a live run at all, only designed and structurally audited. This is a
   different, deeper kind of gap than "one more business type" or "one more persona" — it's the
   entire second half of the product's own lifecycle diagram, untested by anything but reading the
   code, and it is exactly what round 6 (below) is now attempting to close.

## Round 5 — closing the last dogfood gap and testing the last mile: complete and integrated

Round 5's scope, as described to the swarm: a fourth live end-to-end dry run against a
`consumer_app` business (the last of the six `business_basics.business_type` enum values never yet
exercised by a real fixture — round 2 was `saas`/`idea_only`, round 3 was `marketplace`/`pivoting`,
round 4 was `services`/`already_operating`), a small mechanical fix adding an explicit "what you
write" statement to all 12 council personas (closing the one systemic, explicitly-out-of-scope gap
round 4's QA dogfood pass flagged in `docs/QA-DOGFOOD-ROUND4.md`), a real execution of
`docs/TESTING.md`'s Layer 3 pre-release regression checklist against the three existing dry-run
fixtures (the first time that checklist has been run for real rather than only existing as a
document), and a consolidated `docs/CHANGELOG.md` summarizing the whole build's history across all
five rounds. This section was rewritten after walking the actual repo — every item below was
re-confirmed present in the current files, not carried forward from round 5's in-progress snapshot:

- **The council write-statement fix landed and is confirmed present.** All 12
  `agents/council/*.md` files carry an explicit `## What you write` section (confirmed by a direct
  case-insensitive grep across every file — 12 of 12 match), each stating plainly that the persona
  writes nothing to disk and returns its verdict to the calling skill instead. This closes exactly
  the gap `docs/QA-DOGFOOD-ROUND4.md` flagged and deliberately left unfixed as out-of-scope for that
  round.
- **A fourth live end-to-end dry run against a `consumer_app` business landed**
  (`docs/QA-FINDINGS-ROUND5.md`, **Kindling**, a freemium daily-practice app for hobbyist creatives,
  `idea_only`), and surfaced real findings, all fixed directly, confirmed present in the current
  files:
  - **Blocking — Steps 1, 2, and 4 had zero `consumer_app` branching, and Step 4's gap was
    load-bearing.** Step 4's formula (price × purchase frequency) has no answer for a freemium app;
    drafting a real TAM against it produced a naive figure roughly 20x a realistic blended-ARPU
    figure, with nothing downstream to catch a less careful drafter reporting the inflated one —
    and Step 4 is one of the five AI-risk-gated steps, so a founder who stops there gets this
    failure mode with no safety net. **Fixed:** Step 4 now has an explicit `**Consumer app:**`
    branch instructing the blended ad-plus-subscription method as the number of record, with the
    naive figure reported only as a labeled non-representative ceiling; Step 2 gained a generic B2C
    fallback question.
  - **Significant — Steps 16 and 18 could silently diverge on the same freemium-to-paid conversion
    rate**, the fourth independent instance of the "two related steps can diverge without either
    checking against the other" bug class (after round 2's finding 2.2, round 3's finding 1.3).
    **Fixed:** Step 18 now instructs cross-checking its chained funnel rate against Step 16's stated
    assumption.
  - **Significant — `competitive-strategy-reviewer` had no `consumer_app` calibration**, discovered
    by hand-working the council's seat-selection logic against Kindling's real
    `business-state.json`: `product-market-fit-panel`'s own trigger did not fire (Kindling's real
    weak points clustered in unit economics and Core, not the PMF-range steps the trigger counts),
    so the seat fell to a persona with no type-specific scrutiny to offer. **Fixed:** added a
    `consumer_app` calibration bullet. A genuinely dedicated `consumer_app` contextual persona
    remains open (see `docs/DATA-CONTRACT.md`'s coverage table), not fixed this round.
  - **Polish — `assemble-business-plan`'s LTV:COCA reconciliation had a services-specific caveat
    (round 4) but no consumer_app-specific one for a weak, zero-real-data ratio.** **Fixed** with a
    parallel caveat.
  - **Confirmed a fourth consecutive time: the AI-risk gate's false-precision catch lands at Step
    19 (COCA) more often than any other step**, three of four rounds now — the step furthest
    downstream in the estimate chain, and therefore the one accumulating the most compounded
    uncertainty. **Fixed:** added a standing "round explicitly before writing the headline figure"
    reminder directly to Step 19, rather than continuing to rely on the gate catching it
    indefinitely.
- **`docs/TESTING.md`'s Layer 3 pre-release regression checklist was executed for real for the
  first time** (`docs/QA-LAYER3-REGRESSION-ROUND5.md`), checked against all three then-existing
  fixtures item by item: **6 PASS, 9 GAP, 2 FAIL** (one fixed this round, one logged as fixture data
  this round was barred from editing). **The single most consequential result:** cross-reading
  `revise-business-plan/SKILL.md` against `run-review-council/SKILL.md` and `agents/orchestrator.md`
  (rather than reading each in isolation) surfaced a genuine, three-way contradiction —
  `revise-business-plan` instructed writing `stage = "council_review"`, a value
  `run-review-council`'s own precondition never reads or expects and would reject outright. No
  fixture had ever exercised this handoff, so the contradiction had never been caught; it lives
  entirely in a seam between two skills that only a real second pass through council review
  exercises. **Fixed** directly in `revise-business-plan/SKILL.md` (§6, §7, frontmatter) — the skill
  now leaves `stage` at `"revising"`, matching what its two collaborators already expected. **This
  fix is unverified by a live run** — see round 6 below, which is the first attempt to exercise the
  corrected path for real. The pass's other headline result, restated plainly rather than glossed:
  **nothing in this repo's live-testing history has ever driven a business from `approved` into
  `gtm`/`operating`** — the single largest, most explicit gap the checklist found.
- **`docs/CHANGELOG.md` landed**, consolidating rounds 1-5's build history, real bugs found and
  fixed, and cross-round patterns into one chronological ledger, confirmed present at
  `docs/CHANGELOG.md`.

## Round 6 — testing the revision loop and the post-approval half: in progress

Round 6 is running concurrently with this roadmap revision, and is a direct, deliberate response to
round 5's Layer 3 pass naming this exact gap as the single largest untested surface in the plugin's
live-testing history. Two agents are each driving a real existing fixture through territory no live
dry run has ever reached:

- **One agent is driving `.startup/shiftcover/` through an actual revision cycle for the first
  time** — `shiftcover` has sat at `stage: "revising"` since round 2, never once continued through
  `revise-business-plan` and back to a second council review. This is also the first live test of
  round 5's fix to `revise-business-plan`'s stage-transition logic: does `run-review-council`
  actually accept the handoff now that the skill leaves `stage` at `"revising"` instead of writing
  the `"council_review"` value its precondition would have rejected.
- **The other agent is driving `.startup/vantage-point-search/` through GTM and operations for the
  first time** — `vantage-point-search` is the only fixture to ever reach `stage: "approved"`, and
  it has never continued into `agents/gtm/*`, `agents/ops/*`, or the recurring check-in cadence
  machinery. This is the first live test of the entire back half of `docs/ARCHITECTURE.md`'s
  lifecycle diagram.

**As of this snapshot, checked directly rather than assumed:** neither `docs/QA-FINDINGS-ROUND6.md`
nor `docs/QA-FINDINGS-POSTAPPROVAL-ROUND6.md` exists yet in `docs/` — confirmed by a direct
file-existence check, not assumed absent, since both agents are still running concurrently with
this revision. This section should be rewritten once both land, with the same "confirmed present in
the current files" treatment every prior round's section above got, rather than left as this
in-progress snapshot.

## v0.3 and beyond — the real frontier, and what stays open even after round 6

With v0.2's depth work closed since round 4, the honest next horizon has not been primarily more
breadth since round 5. The five live dry runs this build has run so far (round 2 SaaS, round 3
marketplace, round 4 services, round 5 consumer app) have been extraordinarily effective at finding
and fixing real gaps — but every one of them is a single, unbroken session that starts at onboarding
and stops at or before `council_review`/`revising`, and round 5's Layer 3 pass confirmed this
plainly rather than leaving it inferred: not one fixture has ever exercised the revision loop or
anything past plan approval. **Round 6 is the first live attempt to close that gap, and once its
two findings docs land, this section needs the same "confirmed present" re-verification treatment
every prior round's work has gotten here — not marked done on the strength of the plan alone.**

Even a fully successful round 6 will not close every corner of this frontier. Naming what stays
genuinely untested afterward, plainly, so a future round doesn't rediscover it as if it were new:

- **A REJECT-and-founder-override path has still never been tested.** `agents/orchestrator.md`'s
  Non-negotiable #3 specifies an explicit founder-override mechanism (a `risk_log` entry with
  `raised_by: "startup-operator (founder override)"`, the review file marked noted-but-overridden)
  for exactly the case where a founder wants to proceed against a council's REVISE/REJECT — round
  6's revision-loop test is about the plan actually improving and re-passing, not about a founder
  choosing to override a standing objection. No fixture has ever exercised this branch.
- **A second or third recurring check-in cycle has never been tested.** Round 6's GTM/ops run, if it
  reaches a check-in at all, will be the *first* one any fixture has ever had — it cannot, by
  itself, test whether the cadence mechanism, drift detection, and check-in interview hold up across
  *multiple* cycles (a founder's numbers changing check-in to check-in, an escalation from one
  check-in's finding carrying forward correctly into the next, `cadence.next_check_in` actually
  advancing correctly a second time).
- **A pivot mid-lifecycle has never been tested.** `business_basics` is explicitly designed to be
  updatable by `skills/interview/recurring-check-in` handing a change to the orchestrator (per
  `docs/DATA-CONTRACT.md`'s ownership note) — a founder whose `venture_stage` moves from
  `idea_only`/`already_operating` to `pivoting`, or whose `business_type` changes, mid-flight. No
  fixture has ever exercised this, and it's a materially different test than round 3's SkyClaim
  fixture, which started as `pivoting` rather than becoming so partway through.
- **A real, multi-session lifecycle exercise driven by an actual human, not a role-played dry
  run.** Nothing in this repo has been driven by an actual person across a real gap of time — the
  specific failure modes that only show up across sessions (a founder who forgets what they said
  last time, `/business-status` resuming correctly after a real multi-day gap, a scheduling
  mechanism actually firing a check-in) have never been tested by anything, simulated or real, and
  round 6's two dry runs are still simulated, single-operator sessions.

Only once round 6 lands and these remaining corners are named honestly against what it actually
covered does further breadth become the priority again: more industry verticals per DE step
(regulated industries and hardware now have a dedicated council seat, but their DE-step branching
depth hasn't been dry-run tested the way marketplace/services/SaaS/consumer-app have; B2B2C and
nonprofit/social-enterprise variants remain entirely unwritten), a genuinely large council-persona
library segmented by stage and geography as well as business type (starting with the still-open
`saas`/`consumer_app`/`other` dedicated-persona question round 5 sharpened but didn't close), deeper
fundraising-specific agents (pitch-deck iteration, cap-table sanity checks flagged clearly as
non-legal-advice), a Layer 2 behavioral eval suite grown well beyond the 7-case seed round 4
planted, and operations agents that extend meaningfully past year one (scaling playbooks, hiring
plans, board-reporting assembly). This is where the "hundreds of agents, thousands of skills" scale
of the long-term vision actually starts to apply — but only some of it, and only after the
lifecycle this plugin already claims to support has actually been run start to finish, more than
once, including the revision loop and the post-approval half. Getting there is explicitly not a
matter of writing many more agents as fast as possible, and it is not a matter of running one more
review round and calling the plugin finished — it's a standing practice of building, adversarially
reviewing, dry-running, and rewriting the roadmap, the same shape this document has now gone
through five times.

## The constraint that doesn't loosen as this grows

Every horizon above is additive to the same contract, not a departure from it. `CONVENTIONS.md`
exists precisely because a swarm of independently-authored agents and skills only stays coherent
if they all write against one directory layout, one frontmatter shape, one data contract, and one
verdict schema. Growth from "hundreds" toward "thousands" of skills — and from round 6 toward round
7 and beyond — is only survivable, for users and for the swarm of contributors building it, if
every new or revised skill or agent still:

- lives in the directory layout `CONVENTIONS.md` §1 defines, with kebab-case names;
- declares any new `business-state.json` field in `docs/DATA-CONTRACT.md` in the same change
  that introduces it, rather than inventing undocumented fields — checked mechanically by
  `scripts/validate-plugin.sh`, not just by convention, since round 3;
- for council agents, returns a verdict in the exact schema in `CONVENTIONS.md` §6, as one
  distinct persona in a panel of 3-5, never as a sole reviewer standing in for "the council" — also
  checked mechanically, and (as of round 5) states in its own body, not just its frontmatter, what
  it writes (which for every council persona today is: nothing);
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
dry run, round 4 turned that same scrutiny on `CONVENTIONS.md` itself and closed a real
cross-cutting drift it found, round 5 closed the QA layer's own last flagged gap and, running the
mechanical checklist meant to catch a whole-lifecycle regression for the first time, found a real
contradiction between two skills' contracts before any live run ever hit it, and round 6 is now
testing whether that fix — and the entire back half of the lifecycle diagram alongside it — actually
holds when a real revision cycle and a real GTM/ops run are driven through it live.
