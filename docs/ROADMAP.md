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
first Layer 2 behavioral eval suite. **Rounds 2, 3, and 4 are all now complete and integrated** —
every finding any round's dry run or audit work surfaced was fixed directly in the repo, not left
as an open backlog; each "complete and integrated" section below documents each fix confirmed
present, file by file, the same way every prior round's section has. **Round 5** — happening now,
concurrently with this revision — is a swarm running a fourth live dry run against a
`consumer_app` business (the last of the six `business_basics.business_type` values never yet
tested live), doing a small mechanical fix adding an explicit "what you write" statement to all 12
council personas (closing the one systemic gap round 4's QA dogfood pass found and flagged as
off-limits for that round), executing `docs/TESTING.md`'s Layer 3 pre-release regression checklist
for real against the three existing dry-run fixtures, and consolidating a `docs/CHANGELOG.md`
summarizing the whole build's history. Round 4's output fed directly into this revision's v0.2
assessment below; round 5's output will do the same for round 6's revision of this document. Treat
this document as a snapshot that gets rewritten each round, not a static plan drafted once and
executed against.

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
3. **The genuinely open frontier now, and it is not another persona or another business-type
   pass**: nothing in the repo has yet been driven through a real, multi-session lifecycle by an
   actual person — every check so far, across all four live dry runs (round 2's ShiftCover, round
   3's SkyClaim, round 4's Vantage Point Search, and round 5's consumer_app business once it
   lands), has been a simulated, single-session pass, and simulated passes reliably miss the
   specific ways real founders phrase vague answers, get confused about `/business-status` state,
   or stall out mid-interview across a real gap of days or weeks. More concretely, and worth
   naming plainly: **not one of the three real fixtures under `.startup/` has ever exercised the
   revision loop or anything past plan approval.** `shiftcover` and `skyclaim` both sit at
   `stage: "revising"` — the point where a REVISE/REJECT verdict hands off to
   `revise-business-plan` — and neither fixture shows that skill actually running a revision cycle
   back through a second `council_review`. `vantage-point-search` is the first fixture to reach
   `stage: "approved"`, and stops exactly there — GTM, operations, and the recurring check-in
   cadence machinery (`agents/gtm/*`, `agents/ops/*`, `/check-in`, the whole back half of
   `docs/ARCHITECTURE.md`'s lifecycle diagram) have never been exercised by a live run at all, only
   designed and structurally audited. This is a different, deeper kind of gap than "one more
   business type" or "one more persona" — it's the entire second half of the product's own
   lifecycle diagram, untested by anything but reading the code. See v0.3 below for why this is now
   the roadmap's top priority rather than a footnote.

## Round 5 — closing the last dogfood gap and testing the last mile: in progress

Round 5 is running concurrently with this roadmap revision. Its scope, as described to the swarm:
a fourth live end-to-end dry run against a `consumer_app` business (the last of the six
`business_basics.business_type` enum values never yet exercised by a real fixture — round 2 was
`saas`/`idea_only`, round 3 was `marketplace`/`pivoting`, round 4 was `services`/
`already_operating`), a small mechanical fix adding an explicit "what you write" statement to all
12 council personas (closing the one systemic, explicitly-out-of-scope gap round 4's QA dogfood
pass flagged in `docs/QA-DOGFOOD-ROUND4.md`), a real execution of `docs/TESTING.md`'s Layer 3
pre-release regression checklist against the three existing dry-run fixtures (the first time that
checklist has been run for real rather than only existing as a document), and a consolidated
`docs/CHANGELOG.md` summarizing the whole build's history across all five rounds.

**As of this snapshot, walked directly rather than assumed:**

- **The council write-statement fix has landed.** All 12 `agents/council/*.md` files now carry an
  explicit "## What you write" section (confirmed by a direct case-insensitive grep across every
  file — 12 of 12 match), each stating plainly that the persona writes nothing to disk and returns
  its verdict to the calling skill instead. This closes exactly the gap `docs/QA-DOGFOOD-ROUND4.md`
  flagged and deliberately left unfixed as out-of-scope for that round.
- **The fourth live dry run's findings file does not yet exist** in `docs/` — no
  `docs/QA-FINDINGS-ROUND5.md`-shaped file is present, and no fourth business appears under
  `.startup/` alongside `shiftcover`, `skyclaim`, and `vantage-point-search` — confirmed by a
  direct directory listing, not assumed absent.
- **No output from a real Layer 3 regression-checklist run exists yet** in `docs/` as of this
  snapshot — `docs/TESTING.md` §3.1's checklist itself is unchanged and still describes what to
  check, not the result of having checked it.
- **`docs/CHANGELOG.md` does not yet exist** at this path — confirmed by a direct file-existence
  check, not assumed absent.

Because round 5 is still running as this document is written, only the persona write-statement fix
is scored as landed above; the rest should get the same re-verification treatment in the next
roadmap revision that every prior round's claimed fixes got here, not be marked done on the
strength of the plan alone.

## v0.3 and beyond — the real frontier: exercising the second half of the lifecycle

With v0.2's depth work now closed, the honest next horizon is not primarily more breadth. The four
live dry runs this build has run so far (round 2 SaaS, round 3 marketplace, round 4 services, round
5 consumer app once it lands) have been extraordinarily effective at finding and fixing real gaps —
but every one of them is a single, unbroken session that starts at onboarding and stops at or
before `council_review`/`revising`. **That is the actual frontier for round 6 and beyond, ahead of
any further persona or business-type work:**

- **A real, multi-session lifecycle exercise.** Nothing in this repo has been driven by an actual
  human across a real gap of time — the specific failure modes that only show up across sessions
  (a founder who forgets what they said last time, `/business-status` resuming correctly after a
  real multi-day gap, a scheduling mechanism actually firing a check-in) have never been tested by
  anything, simulated or real.
- **The revision loop, exercised for real.** `revise-business-plan` — the skill that takes a
  REVISE/REJECT verdict and produces the next plan version, then routes back through
  `council_review` per `docs/ARCHITECTURE.md`'s explicit "never straight to `approved`" rule — has
  never been driven end-to-end by a live dry run. Two of the three existing fixtures
  (`shiftcover`, `skyclaim`) sit exactly at the point where this would happen and stop there.
- **Everything past `stage: "approved"`, exercised for real.** GTM (`agents/gtm/*`,
  `launch-director`'s coordination, the funding-strategy gate), operations
  (`agents/ops/*`, drift detection against the plan, proactive runway escalation), and the
  recurring check-in cadence that's supposed to close the loop back to earlier DE steps or a new
  council review — all of it is designed, and all of it was checked structurally by round 4's QA
  dogfood pass, but none of it has been exercised by a single live run. `vantage-point-search` is
  the first fixture to even reach `stage: "approved"`, and it stops exactly there.

Only once that gap is closed does further breadth become the priority again: more industry
verticals per DE step (regulated industries and hardware now have a dedicated council seat, but
their DE-step branching depth hasn't been dry-run tested the way marketplace/services/SaaS have;
B2B2C and nonprofit/social-enterprise variants remain entirely unwritten), a genuinely large
council-persona library segmented by stage and geography as well as business type, deeper
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
through four times.

## The constraint that doesn't loosen as this grows

Every horizon above is additive to the same contract, not a departure from it. `CONVENTIONS.md`
exists precisely because a swarm of independently-authored agents and skills only stays coherent
if they all write against one directory layout, one frontmatter shape, one data contract, and one
verdict schema. Growth from "hundreds" toward "thousands" of skills — and from round 5 toward round
6 and beyond — is only survivable, for users and for the swarm of contributors building it, if
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
cross-cutting drift it found, and round 5 is closing the QA layer's own last flagged gap while
testing, for the first time, the mechanical checklist meant to catch a whole-lifecycle regression
rather than a single-file or single-behavior one.
