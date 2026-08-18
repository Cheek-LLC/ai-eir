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
drove a business through it. **Round 6** was two agents each driving a real existing fixture
through exactly the territory round 5's Layer 3 pass identified as the biggest untested gap: one
drove `.startup/shiftcover/` through an actual revision cycle for the first time, confirming live
that round 5's `revise-business-plan` fix actually holds — and finding a real revision-routing gap
of its own (a discarded outlier's required revisions were never carried forward for rework, so they
resurfaced identically on re-review); the other drove `.startup/vantage-point-search/` through GTM
and operations for the first time, since nothing in this repo's live-testing history had ever taken
a business past `stage: "approved"` — and found a real 2-4.3x runway-overstatement bug (a missing
period-normalization step for non-monthly check-in cadences) plus a real, previously-undocumented
ambiguity in the connectors gate's scope. **Rounds 2 through 6 are all now complete and
integrated** — every finding any round's dry run or audit work surfaced was fixed directly in the
repo, not left as an open backlog; each "complete and integrated" section below documents each fix
confirmed present, file by file, the same way every prior round's section has. **Round 7 is now also
complete and integrated** — two agents each exercised one of the three specific gaps round 6's own
roadmap update named as the next frontier: the founder-override path against `shiftcover`'s standing
REJECT verdict, and a second recurring check-in cycle plus a mid-lifecycle pivot against
`vantage-point-search`, neither of which any fixture had ever exercised before. **Round 8 — a
findings-backlog sweep across all seven prior rounds' documents, plus real-use-readiness polish — is
running now, concurrently with this revision**, and is described in its own section below. Round 5's
output fed directly into round 6's revision of this document; round 6's output fed directly into round
7's; round 7's output is feeding directly into this revision; round 8's will do the same for round 9's.
Treat this document as a snapshot that gets rewritten each round, not a static plan drafted once and
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

## Round 6 — testing the revision loop and the post-approval half: complete and integrated

Round 6 was a direct, deliberate response to round 5's Layer 3 pass naming this exact gap as the
single largest untested surface in the plugin's live-testing history. Two agents each drove a real
existing fixture through territory no live dry run had ever reached, and this section was rewritten
after reading both findings docs and re-confirming every fix directly in the current files, the same
"confirmed present" treatment every prior round's section has gotten:

- **`.startup/shiftcover/` was driven through an actual revision cycle for the first time**
  (`docs/QA-FINDINGS-ROUND6.md`) — `shiftcover` had sat at `stage: "revising"` since round 2, never
  once continued through `revise-business-plan` and back to a second council review. This was also
  the first live test of round 5's fix to `revise-business-plan`'s stage-transition logic, and it
  **held**: `run-review-council` accepted the handoff cleanly, with `stage` staying `"revising"`
  throughout, exactly as round 5 predicted it would once fixed. The run went further than a bare
  confirmation, though — it drove a full, real revision (5 required-revision items routed to DE-step
  rework or a synthesis-level fix, a real `plan/business-plan-v2.md`, the mandatory AI-risk gate run
  live against the new content) and a full, real re-review (the funding track re-derived live, a
  genuinely new 5-persona panel run, the aggregation algorithm's semantic-overlap check worked by
  hand and confirmed load-bearing on a real outcome for the first time). The re-review's real result
  was REJECT again — and *why* is this round's one significant new finding: **a discarded outlier's
  required revisions were never routed to by `revise-business-plan`, so they resurfaced identically
  on re-review.** `customer-discovery-skeptic`'s v1 REJECT was correctly discarded as a
  non-corroborated outlier by the aggregation algorithm, but `revise-business-plan` only ever read
  the synthesized aggregate checklist — which, by construction, never contains a discarded persona's
  items — so that persona's 3 concerns were never worked at all, and resurfaced as a fresh-looking
  REJECT on re-review even though 4 of the other 5 items had been genuinely, substantively fixed.
  **Fixed:** `revise-business-plan/SKILL.md` §0 now explicitly instructs carrying forward — never
  dropping — the review file's `### Discarded-but-real concerns` and `### Also flagging, regardless
  of severity` sections as in-scope work alongside the aggregate checklist, so a discarded concern's
  *substance* still gets worked even though the outlier-discard rule correctly keeps it from
  dictating the aggregate verdict on its own. A smaller, related finding from the same live run was
  fixed in the same file: §1 conflated "blocked on a founder decision" with "blocked on real calendar
  time passing" under one "blocked" bucket; time-gated items (e.g. a sales-cycle funnel that needs
  more real prospects to move through the pipeline before it can be honestly recomputed) are now
  reported explicitly and distinctly as "open, time-gated," rather than risking pressure to fabricate
  progress on them.
- **`.startup/vantage-point-search/` was driven through GTM and operations for the first time**
  (`docs/QA-FINDINGS-POSTAPPROVAL-ROUND6.md`) — the only fixture to ever reach `stage: "approved"`,
  and it had never continued into `agents/gtm/*`, `agents/ops/*`, or the recurring check-in cadence
  machinery. This was the first live test of the entire back half of `docs/ARCHITECTURE.md`'s
  lifecycle diagram, and it surfaced a real, significant bug: **`skills/ops/runway-and-burn-
  tracking/SKILL.md`'s formula had no period-normalization step**, and this was the first time it
  had ever run against a non-monthly check-in cadence. Applied literally to a real biweekly first
  check-in, the un-normalized formula would have reported roughly 28.3 months of runway against a
  correct, monthized figure of about 13.2 — a 2.1x overstatement at biweekly cadence, and a
  projected ~4.3x overstatement at weekly cadence — on exactly the one number
  `agents/ops/finance-controller.md` names as "actively dangerous" when wrong, since a founder can
  make a real payroll decision off it. The gap survived every prior round only because the ops layer
  had never run live before round 6. **Fixed:** the skill now instructs normalizing any non-monthly
  period's burn to a monthly-equivalent figure before computing runway, and reporting both the raw
  period figure and the monthized figure so the normalization itself stays visible. The same run also
  found and fixed a real, previously-undocumented ambiguity in the connectors gate's scope: neither
  `docs/CONNECTORS-CATALOG.md` nor `agents/connectors-liaison.md` specified whether a task like
  "send the launch announcement" meant an agent automating a send through a wired tool, or a founder
  personally sending an email from their own inbox — a real distinction, since either misreading has
  a real cost (an unnecessary UX block, or a privacy-gate bypass). **Fixed:**
  `agents/connectors-liaison.md`'s MANDATORY GATE callout now states explicitly that the gate applies
  when the agent itself initiates or automates an action through a connector it operates, not when
  the plan simply recommends the founder personally use their own already-existing tools.

**Every fix named above is confirmed present in the current files, not left as an open backlog** —
verified directly while writing this revision, not carried forward from either findings doc's own
description of an intended fix: `skills/business-plan/revise-business-plan/SKILL.md` (§0 discarded-
concerns routing, §1 decision-gated vs. time-gated distinction), `skills/ops/runway-and-burn-
tracking/SKILL.md` (period-normalization step), and `agents/connectors-liaison.md` (agent-automated
vs. founder-personal gate scope). `scripts/validate-plugin.sh` still reports 46 skills, 29 agents, 5
commands, 12 council files, 0 warnings, 0 errors as of this revision — round 6 deepened existing
skill/agent files rather than adding new ones.

## Round 7 — the founder-override path, a second check-in cycle, and a mid-lifecycle pivot: complete and integrated

Round 7 picked up exactly the two of three items round 6's own roadmap update named as the next
frontier once the revision loop and the post-approval half were closed (the third — a founder
overriding mid-GTM, rather than post-approval — remains untested, see below). This section was
rewritten after reading both findings docs and re-confirming every fix directly in the current files,
the same "confirmed present" treatment every prior round's section has gotten:

- **The founder-override path was driven live for the first time, against `shiftcover`'s standing
  REJECT verdict** (`docs/QA-FINDINGS-OVERRIDE-ROUND7.md`) — `agents/orchestrator.md`'s Non-negotiable
  #3 specifies an explicit override mechanism (a `risk_log` entry with `raised_by: "startup-operator
  (founder override)"`, `status: "accepted"`, the review file marked noted-but-overridden) for a
  founder who wants to proceed against a council's REVISE/REJECT rather than revise further, and no
  fixture had ever exercised it. Playing founder Maria Chen through a real, reasoned decision (partial
  agreement, not a shrug) confirmed the mechanism's own "not a shrug" bar holds under real use, and
  that round 6's "Also flagging, regardless of severity" review-file section did exactly the job it was
  built for on its first founder-facing use. Driving the override through to its actual downstream
  consequence found a real, previously-undetected bug: **`agents/gtm/launch-director.md` would have
  proceeded as if the plan had cleared review cleanly**, since its Gate check read only `stage` (not
  distinguishing an override-reached `approved` from a clean one) and its own "What you read"
  instruction filtered `risk_log` down to "anything open" — but an override's entries are `accepted`
  by design, so they were silently invisible to that read, by construction, every time. A founder who
  overrode a REJECT and proceeded to GTM would have gotten a `gtm/launch-plan.md`, the artifact most
  likely to reach a contractor, early hire, or investor, with zero mention it proceeded over a blocking
  verdict. **Fixed:** `launch-director`'s Gate section now re-reads the most recent `reviews[]` verdict
  whenever `stage` is `approved`, confirms an override via the review file's mark and the matching
  `accepted` risk_log entries, and carries it into the launch plan's risk section by name — verified by
  walking the patched logic against `shiftcover`'s real state. A related bug in the orchestrator's own
  state-machine diagram (which had described the override path as looping back through *another*
  council re-run, backwards from the mechanism's actual purpose) was fixed in the same pass.
- **A second recurring check-in cycle and a real mid-lifecycle pivot both ran live for the first
  time, against `vantage-point-search`** (`docs/QA-FINDINGS-PIVOT-ROUND7.md`) — round 6's GTM/ops run
  produced only the *first* check-in any fixture had ever had; this round drove a second, and then a
  genuine, evidence-based pivot (two real prospect losses at the low end of the beachhead's employee
  band, both stalling at the exact stage the plan itself already named as the biggest drop-off point —
  a plausible consequence of risks the plan had already flagged, not a contrived edge case). The
  pivot exposed a real, significant gap: **`agents/orchestrator.md` Phase 6's entire specification for
  reopening DE steps after a pivot was one unspecified sentence**, with no partial-reopening mechanic,
  no status semantics for a step that's probably still valid but unconfirmed, and no transitive-impact
  guidance for the other steps — following it literally required inventing a subset-reopening approach
  from scratch. **Fixed:** Phase 6 now has a real "Reopening a subset of DE steps after a pivot"
  procedure (only implicated steps revert to `not_started`; a new `NEEDS RE-CONFIRMATION:`
  summary-prefix convention, now also in `docs/DATA-CONTRACT.md`'s Conventions section, covers the
  probably-still-valid-but-unconfirmed case; re-assembly is preceded by a cheap skim-check rather than
  a full re-derivation). Two related handoff gaps were found and fixed in the same pass:
  `skills/interview/recurring-check-in/SKILL.md` anticipated a pivot signal surfacing in conversation
  but gave its executor no instruction for what to do once one did, despite `docs/DATA-CONTRACT.md`
  explicitly assigning this write to it by name (**fixed**, Phase 2 now names the handoff); and
  `agents/gtm/launch-director.md`'s mid-GTM pivot section had nothing for a pivot signal firing
  *after* launch (`gtm.status: "launched"`), a case no fixture had ever hit before (**fixed**, the
  section now states already-shipped artifacts get flagged as targeting the pre-pivot band rather than
  "parked").

**Every fix named above is confirmed present in the current files, not left as an open backlog** —
verified directly while writing this revision: `agents/orchestrator.md` (the override branch in the
state-machine diagram, the DE-step reopening procedure in Phase 6), `agents/gtm/launch-director.md`
(the override-detection Gate check, the post-launch pivot clause), `skills/interview/recurring-check-
in/SKILL.md` (the pivot-handoff instruction in Phase 2), and `docs/DATA-CONTRACT.md` (the
`NEEDS RE-CONFIRMATION:` convention). `scripts/validate-plugin.sh` still reports 46 skills, 29 agents,
5 commands, 12 council files, 0 warnings, 0 errors — round 7 deepened existing agent/skill files
rather than adding new ones.

**What round 7 did not close, named plainly so a future round doesn't rediscover it as new:** a
founder overriding a standing objection *mid-GTM sequencing* (rather than post-approval, before GTM
ever starts) remains untested; a founder changing their mind *after* an override (an accepted risk
later materializing for real) remains untested; `launch-director`'s full sequencing pass producing a
real, complete GTM artifact set *against* an overridden plan remains untested (round 7 confirmed only
that the gate detects and flags the override, not that the flag survives intact through a full
`marketing-strategist`/`sales-lead` pass); and the transitive-impact question the pivot's reopening
protocol still leaves informal — whether steps *downstream* of a reopened step (e.g. a next-10 list
naming a now-out-of-band prospect) are stale in a plan-assembly-blocking way — was documented as an
open item, not resolved.

## Round 8 — findings-backlog sweep and real-use-readiness polish: complete and integrated

Round 8 was the swarm's own direct response to the judgment call round 7's roadmap revision made
explicit for the first time: that further simulated dry runs were hitting diminishing returns for the
category of bug they'd reliably found across six rounds running, and that a real founder's real,
multi-session use of this plugin is the next qualitatively different validation this project needs —
not another simulated business. Consistent with that finding, round 8 deliberately ran **no** seventh
simulated dry run. Three agents worked concurrently on consolidation and readiness instead:

- **A findings-backlog sweep** (`docs/QA-BACKLOG-SWEEP-ROUND8.md`) re-audited all 34 deferred items
  across the seven prior rounds' findings documents against current file state, not each document's
  own possibly-stale language. 5 were fixed directly, 20 were confirmed already resolved by later
  rounds' work, and 9 remain genuinely open — each blocked on a `CONVENTIONS.md`/`docs/DATA-CONTRACT.md`
  edit or a real maintainer judgment call, restated verbatim in that document rather than silently
  dropped.
- **Real-use-readiness polish** — `README.md`'s "Before you start" and honest "Recurring check-ins"
  sections, a `plugin.json` version bump to `0.2.0`, and `onboarding-interview`'s opening tightened for
  a genuine first-time human founder — this roadmap's own explicit recommendation put into practice.
- **Changelog/roadmap/master-index update** — closed out round 7 as complete and integrated in all
  three documents.

**Round 8 is confirmed complete and integrated**, checked directly rather than assumed at the time of
this round-9 revision: `docs/QA-BACKLOG-SWEEP-ROUND8.md` exists on disk with the 34-item accounting
above; `README.md`, `plugin.json`, and `onboarding-interview/SKILL.md` all carry the described changes.
One process gap surfaced during round 9's integration pass and is worth naming plainly rather than
quietly fixing without a record: `docs/CHANGELOG.md` had gone straight from a "Round 7" section to
"Patterns worth knowing" with no "Round 8" section at all, even though this document and
`docs/MASTER_INDEX.md` had both been correctly updated for round 8 at the time — round 9's integration
pass added the missing changelog section retroactively. `scripts/validate-plugin.sh` reported 46
skills, 29 agents, 5 commands, 12 council files, 0 warnings, 0 errors at the close of round 8 — a
consolidation round by design, touching no new skill/agent/command files.

## Round 9 — a human-directed pivot back to breadth: 10 functional-expert agents and an autonomous
   recurring-routine skill

**Read this section honestly, not as a continuation of round 8's own logic.** Round 7 and round 8 both
argued, independently and then in practice, that the swarm should stop scoping more simulated-business
breadth and wait for a real human trial instead. Round 9 did not happen because the swarm decided that
judgment call was wrong — **it happened because the human maintainer gave a new, explicit instruction**:
build a genuinely advanced expert-level bench of functional specialists, plus the concrete
infrastructure for a founder to actually run this plugin unattended on a recurring cadence, rather than
wait indefinitely for a live multi-session trial before doing more depth work. That is a legitimate,
different kind of input than anything the swarm can generate on its own — a real person's direct
judgment about what the project needs next — and this document records it as exactly that, not as the
swarm quietly reversing its own round-7/8 position. The "real human trial is the next frontier" finding
from rounds 7-8 still holds and is restated, unchanged, below; round 9 is additive breadth work done in
parallel with that finding still being true, not a replacement for it.

**Two pieces of work:**

1. **`skills/autonomous-continuation/SKILL.md` + `commands/continue-business.md`** — the concrete
   mechanism for the "scheduling mechanism actually firing a check-in unattended, with no one driving"
   gap round 6 and round 8 both named as untested (see "What round 8 did not close" below — it still
   isn't *tested* by this round, but it is now *possible* in a disciplined way, which it wasn't before).
   `agents/orchestrator.md`'s self-scheduling logic now targets this command specifically. Full detail
   in `docs/CHANGELOG.md`'s round 9 entry.
2. **10 parallel functional-specialist "expert entrepreneur" agents**, each building advanced-level
   skill content, an optimization-focused ops agent, or (one of them) a new review-council persona:
   product management, legal/entity structure, HR/hiring, customer success, growth/CRO experimentation,
   pricing optimization, fundraising/investor-relations, operations/fulfillment, competitive
   intelligence, and a new `operational-execution-reviewer` council seat. Full detail, including the
   new council persona's exact trigger and priority placement, in `docs/CHANGELOG.md`'s round 9 entry
   and `docs/DATA-CONTRACT.md`'s persona-coverage table.

**Round 9 is complete and integrated.** `scripts/validate-plugin.sh` reports 56 skills, 34 agents, 6
commands, 13 council files, 0 warnings, 0 errors — the largest single-round growth in skill/agent count
since round 1, and (10 concurrently-running agents) the widest fan-out of any round, with zero
file-collision incidents, confirmed by every agent's own `git status` check in its final report.

## Round 10 — live dry-run validation of every round-9 skill: complete and integrated

Round 9 built 9 new skills, extended/added 8 agents, and added a council persona, but none of it
had ever been executed live — every prior round's own discipline says a skill that's only been
read and reasoned about, never run, is unverified. Round 10, on explicit human request, closed that
gap directly rather than waiting for it to surface naturally in a future round: **11 parallel
agents**, each isolated on its own disposable copy of a canonical fixture, each live-executed
exactly one round-9 skill/agent/persona as literal instructions against real data. This is the same
"live dry run, not a read-through" methodology every round since round 2 has used, applied for the
first time to a batch of skills rather than a single business's full lifecycle.

**Nine real, concrete gaps were found; six are fixed as of this revision** (full detail in
`docs/CHANGELOG.md`'s round 10 entry): `autonomous-continuation`'s stage table was single-axis and
could silently skip real ops/gtm work mid-pivot (fixed); its own mechanical skim caught two stale
DE steps a prior round's pivot-signal write missed, and the skill now has explicit authority to
flag them (fixed); its rescheduling logic had no guard against silently creating an unwanted real
Routine (fixed); `experimentation-and-optimization` let you design a full test before checking
whether the business's real traffic could ever reach statistical validity — against
`vantage-point-search`'s real funnel, the honest answer was ~29-35 years — so a viability check now
runs first (fixed); five skills' stage-gating didn't recognize a legitimate mid-pivot combined
state, confirmed independently by three different test agents (fixed across all five);
`docs/DATA-CONTRACT.md`'s source-kind taxonomy didn't cover a tested/measured number, which two
round-9 skills' own feedback-loop mechanic needed (fixed, a fourth canonical source kind added);
`operations-and-fulfillment-playbook`'s marketplace branch never operationalized
`marketplace-liquidity-specialist`'s own flagged disintermediation risk into a tracked metric
(fixed). Three smaller, more judgment-dependent findings were read, understood, and deliberately
left open rather than fixed under this round's own scope — see the changelog entry for exactly
which and why. One test (the council persona) found no defect at all, which is itself a real,
useful result: the newest, most complex piece of round 9's work — a compound two-of-three trigger
competing for a shared panel seat — worked correctly by hand in both a real-fixture and a
synthetic-scenario test on its first live exercise.

**Round 10 is complete and integrated.** `scripts/validate-plugin.sh` still reports 56 skills, 34
agents, 6 commands, 13 council files, 0 warnings, 0 errors — round 10 deepened round 9's own files
rather than adding new ones. The 11 disposable test-fixture copies used to produce these findings
were deleted after their findings were extracted into `docs/QA-FINDINGS-*-ROUND10.md`; unlike the 4
canonical fixtures (`shiftcover`, `skyclaim`, `vantage-point-search`, `kindling`), they were
one-off test doubles, not ongoing project history.

## v0.3 and beyond — the real frontier, restated, and what round 9 did and didn't change about it

With v0.2's depth work closed since round 4, and the revision loop and post-approval half both
closed live since round 6, the honest next horizon narrowed further still once round 7 landed, and
round 8 was the swarm's own direct response to that narrowing. Round 9, as its own section above
states plainly, was a different kind of event — a direct human instruction to build functional-expert
breadth and unattended-operation infrastructure, not the swarm's own continuation of the round-7/8
diminishing-returns logic. Both things are true at once and this section holds both: the frontier
described below is unchanged by round 9, and round 9's actual output (cataloged in its own section
above and in `docs/CHANGELOG.md`) is real, additive value that happened alongside it, not instead of
addressing it.

**After round 7, most of what a *swarm of simulated dry runs* can find in this plugin has now been
found.** Seven rounds of live exercise (six full dry runs plus round 6's and round 7's targeted
post-approval/revision/override/pivot runs) have independently, repeatedly demonstrated the same
thing: a fresh pair of simulated eyes driving a real fixture through real code finds real bugs, every
single time. But the *shape* of what's left to exercise narrowed steadily across the last three
rounds specifically — round 5 found the first bug that wasn't a business-type gap at all, round 6
found two more of that same new kind (an unexercised revision-loop seam, an unexercised
non-monthly-cadence formula) in a single round on two different subsystems, and round 7 found two
more still (an unexercised founder-override downstream-visibility gap, an unexercised DE-step
reopening protocol) in the exact two places round 6's own roadmap update predicted they'd be. That is
not a coincidence three rounds running — it's a pattern this document is now treating as settled
rather than provisional: **the swarm-dry-run method has reached diminishing returns for this category
of bug, in this repo, as of round 7.**

That finding has one honest answer, restated from round 7's own revision of this document and now
acted on directly rather than just argued for: **a real, multi-session lifecycle exercise driven by
an actual human — not a role-played dry run — is the next qualitatively different kind of testing
this project needs, not just another simulated business or another simulated branch.** Every one of
rounds 2 through 7 shares one structural limit no amount of swarm volume can close on its own: a
single operator, in a single session, deciding what a founder would plausibly say next. That produces
real, valuable findings (seven rounds of evidence for this, now), but it cannot produce the specific
failure modes that only show up across real elapsed time and a real, un-scripted human: a founder who
genuinely forgets what they said last session and gives an answer that contradicts
`business-state.json`; `/business-status` resuming correctly (or not) after a real multi-day or
multi-week gap, not a same-session simulated one; a scheduling mechanism actually firing a check-in
unattended, with no one driving; a founder phrasing a vague, evasive, or overconfident answer in the
genuinely unpredictable way real people do rather than the way a role-playing agent, however careful,
tends to phrase one. Round 6's own `docs/QA-FINDINGS-POSTAPPROVAL-ROUND6.md` (§6) hit the edge of
this limit directly and named it honestly: a real scheduling capability existed in that session's
environment, and the agent correctly declined to actually fire it against a real account for a
fictional business, rather than fake a demonstration — which is the right call for a dry run, but it
also means the one live-firing test that would matter most has still never happened, by design, and
cannot happen inside another simulated round.

**Round 8 was that answer put into practice, not just argued for a second time; round 9 is genuinely
additive breadth on top, not a reversal of it.** Round 8 ran a findings-backlog sweep and
real-use-readiness polish instead of a seventh live dry run. Round 9, on explicit human instruction,
then built real depth — 10 functional-specialist skills/agents and unattended-firing infrastructure —
while the "real human trial is the frontier" finding from rounds 7-8 stayed true throughout; nothing
about round 9's work substitutes for that trial, and the roadmap has not quietly gone back to treating
"build more agents" as the presumptive default move on its own initiative. Naming what stays genuinely
untested, updated for what round 9 did and didn't touch, so a future round doesn't rediscover any of
this as new:

- **A real, multi-session lifecycle exercise driven by an actual human is still the single biggest
  structural gap, and no further swarm round can close it by itself.** Unchanged by round 9. Round 8's
  real-use-readiness work and round 9's `skills/autonomous-continuation` infrastructure are both
  preconditions for this trial being possible and well-supported — polished onboarding and a working
  unattended-firing mechanism make a real human trial *feasible*, neither one *is* one.
- **The four specific items round 7 named as still open, restated here rather than left only in that
  section above:** a founder overriding a standing objection mid-GTM sequencing (rather than
  post-approval, before GTM starts); a founder changing their mind after an override, once an accepted
  risk materializes for real; `launch-director`'s full sequencing pass producing a real, complete GTM
  artifact set against an overridden plan; and the transitive-impact question the pivot-reopening
  protocol still leaves informal. None of these were round 8's or round 9's scope; a future round
  returning to live-dry-run territory should look here first before scoping a new business type.
- **`skills/autonomous-continuation` and `/continue-business` have now been live-executed once
  (round 10), but still never against a genuinely real scheduled Routine with no one watching.**
  Round 10 role-played a real unattended firing against a real, copied fixture (round 7's
  mid-pivot `vantage-point-search` state) and drove the skill's own instructions literally — this
  found and fixed three real gaps (see `docs/CHANGELOG.md`'s round 10 entry) and confirmed the
  core "never fabricate, never cross a gate" disciplines hold under real pressure. What this still
  has not tested: an actual Claude Code Routine firing this command on its own schedule, with a
  real elapsed gap and a real human genuinely not present to answer anything in real time — round
  10's agent deliberately declined to wire up a real persistent Routine against a disposable QA
  fixture (see Finding 3 in its findings doc), which was the right call for a test but means this
  specific gap — real automated scheduling infrastructure actually firing this skill unattended —
  is still squarely inside the "real human trial" frontier above, one layer more specific than it
  was before round 10.
- **More industry verticals per DE step remain unwritten.** Regulated industries and hardware now
  have a dedicated council seat, and execution-complexity now has one too (round 9); their DE-step
  branching depth hasn't been dry-run tested the way marketplace/services/SaaS/consumer-app have;
  B2B2C and nonprofit/social-enterprise variants remain entirely unwritten.
- **A genuinely large council-persona library segmented by stage and geography, as well as business
  type, remains open** — the `saas`/`consumer_app`/`other` dedicated-persona question round 5
  sharpened is now partially, not fully, reached by round 9's `operational-execution-reviewer` (see
  `docs/DATA-CONTRACT.md`'s persona-coverage table) — real, content-triggered, partial coverage, still
  not a dedicated type-match seat for those three types.
- **Deeper fundraising-specific agents** — round 9 closed a real piece of this (`skills/gtm/
  investor-updates-and-cap-table-basics`); pitch-deck *iteration* (as opposed to first-draft prep,
  already covered by `fundraising-deck-prep`) remains unwritten.
- **A Layer 2 behavioral eval suite** grown well beyond the 7-case seed round 4 planted remains open —
  and is worth weighing directly against the "real human" frontier above: a larger eval suite is
  still simulated, automatable validation, not a substitute for it.
- **Operations agents that extend meaningfully past year one** — round 9 closed the hiring-plan piece
  (`agents/ops/people-lead.md`) and the pricing/growth-optimization piece; scaling playbooks and
  board-reporting assembly remain unwritten.

This is where the "hundreds of agents, thousands of skills" scale of the long-term vision actually
starts to apply — but only some of it, and only once it's weighed honestly against the fact that the
single highest-value thing this project can do next is still not "simulate one more business," it's
"get a real founder to actually use it and see what breaks." Round 9 is real evidence that targeted,
human-directed breadth work can happen productively *alongside* that finding without contradicting it
— the two are not in tension as long as each round is honest about which kind of work it's doing and
why, which is the entire discipline this document exists to enforce on itself, now nine times running.

## The constraint that doesn't loosen as this grows

Every horizon above is additive to the same contract, not a departure from it. `CONVENTIONS.md`
exists precisely because a swarm of independently-authored agents and skills only stays coherent
if they all write against one directory layout, one frontmatter shape, one data contract, and one
verdict schema. Growth from "hundreds" toward "thousands" of skills — and from round 9 toward round
10 and beyond — is only survivable, for users and for the swarm of contributors building it, if
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
contradiction between two skills' contracts before any live run ever hit it, round 6 confirmed live
that fix — and the entire back half of the lifecycle diagram alongside it — actually holds when a
real revision cycle and a real GTM/ops run are driven through it, round 7 closed the two of three
branches still open once that back half was closed (a founder overriding a standing council
objection, and a second recurring check-in cycle paired with a mid-lifecycle pivot) — finding, and
fixing, a genuine silent-failure risk in `launch-director` and an unspecified DE-step reopening
protocol in the process — and round 8 is now consolidating that work: sweeping every prior round's
findings documents for what's still safely closeable, and preparing the plugin for the real human
trial this document has now twice named as the frontier everything else stays secondary to.
