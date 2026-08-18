# Changelog — 30-Minute Startup

This is the single chronological ledger of what got built, what broke, and what got fixed, across
every round of this plugin's build. It exists because the QA history now spans seven separate
`docs/QA-FINDINGS-*.md` reports plus a dogfood pass and a first real Layer 3 regression pass, each a
standalone, never-overwritten record of one round's audit (per `CONVENTIONS.md`'s own naming rule)
— accurate on its own, but not skimmable as a set. For the full file-by-file catalog of what exists
today, see `docs/MASTER_INDEX.md`; this document is a summary and an index into the findings docs,
not a replacement for either.

Each round below covers what was built, the real bugs an independent audit found, and whether a
later round's independent dry run actually re-confirmed the fix — not just that a fix was written.
Where a later round did not re-test a fix, that's stated plainly rather than implied.

---

## Round 1 — initial build (v0.1, 15 parallel builders)

**Commits:** `44c7fc1` through `ae54d41`.

The plugin's full skeleton went in during this round: the `.claude-plugin/plugin.json` manifest,
`CONVENTIONS.md` and the shared data contract, all 24 Disciplined Entrepreneurship step skills, the
orchestrator agent and entry commands, the business-plan assembly/revision skills, the first cut of
the review council (7 personas), the AI-risk and privacy/legal risk agents and their gate skills,
the connectors layer and catalog, the full GTM layer (launch/marketing/sales/fundraising), the full
ops layer (finance, operations, growth, retention, scaling), the design/brand skills, and the QA
framework itself (`skill-quality-auditor`, `consistency-checker`, `eval-a-skill`) — built by 15
agents working in parallel with no shared view of each other's work. The round closed with a
self-integration pass (`ae54d41`) that reconciled the `business-state.json` key convention across
files and produced the first `docs/MASTER_INDEX.md`.

**No live end-to-end dry run happened this round**, and no `docs/QA-FINDINGS-*.md` file exists for
it — the QA agents that would run one didn't exist until partway through the round itself. Round 1
should be read as "the pieces exist and are individually well-specified," not as "the system was
exercised end to end." Round 2 was the first round to actually run a fake founder through the real
flow, and it is where the first real bugs surface in this changelog.

---

## Round 2 — first live dry run, gate-wiring audit, and integration fixes

**Commits:** `231a9db` through `a9e2242`. **Findings:** `docs/QA-FINDINGS-ROUND2.md` (end-to-end
dry run against ShiftCover, a B2B SaaS fixture), `docs/QA-FINDINGS-GATES-ROUND2.md` (a dedicated,
exhaustive caller-by-caller audit of whether the two mandatory risk gates and the connectors
mechanism are actually wired into the files required to call them).

This round deepened `business_type` branching across the 24 DE steps, tightened the risk/privacy
gates, added the `technical-feasibility-reviewer` council persona, wired `connectors-liaison` and
the privacy gate into the GTM/ops agents, and then, for the first time, ran a real founder
(ShiftCover) through the entire flow — onboarding, all 24 DE steps, plan assembly, the AI-risk
gate, and a real 5-seat council review — producing a worked fixture still on disk at
`.startup/shiftcover/`.

**Real bugs found and fixed:**

- **The two mandatory risk gates were specified but almost entirely unreachable.** The dedicated
  gates audit checked 21 expected-caller pairs across `ai-risk-review`, `privacy-check`, and
  `connectors-liaison`, and found only 2 were real, blocking calls — 19 were either a vague mention
  or missing entirely. Concretely: none of DE steps 04/14/16/17/19 (the exact steps that produce
  the plan's headline TAM/LTV/COCA figures) ever called the AI-risk gate, and the onboarding
  interview never delivered the mandatory one-time privacy notice. A founder following the plugin
  exactly as written would never hit either gate before reaching plan assembly. **Fixed**: the gate
  call was added to all five DE steps and to onboarding (commit `a9e2242`).
- **No mechanism anywhere ever promoted a DE step's status to `approved`**, even though the
  orchestrator's own state-machine diagram said steps must be `approved` before the plan assembles
  — a documented promise nothing in the system could fulfill. **Fixed**: the orchestrator's diagram
  and prose were corrected to state that `drafted` is the real, sufficient gate.
- **`docs/DATA-CONTRACT.md`'s `plan.version: "starts at 1"` language was a skeleton-creation trap**
  — read literally, it would make a brand-new business's very first `assemble-business-plan` call
  believe a plan already existed, deadlocking plan assembly permanently. **Fixed**: the contract
  now states `null`/absent is the correct pre-assembly default.
- **`agents/business-plan-editor.md` never instructed writing the required "Confidence &
  Validation Status" section**, even though the AI-risk framework treats its absence as an
  automatic block — meaning every business's first plan assembly, followed exactly as specified,
  would fail the mandatory gate on the first attempt. Confirmed as a live bug, not a theoretical
  one: the dry run produced a real v1 plan missing the section, ran the real gate, and it correctly
  BLOCKED. **Fixed**: the section is now instructed in both `business-plan-editor.md` and
  `assemble-business-plan/SKILL.md`.
- **The council's discarded-outlier findings vanished from the one checklist a founder is most
  likely to actually read** — a REJECT correctly discarded as a non-corroborated outlier meant its
  three required revisions never appeared in the synthesized Aggregate Verdict checklist, only in
  its own full verdict earlier in the file. **Fixed**: a "discarded-but-real concerns" subsection
  was added.
- **The council's shared tag vocabulary had no tag for "false precision,"** even though flagging it
  is a named, required check for `financial-modeling-reviewer` — forcing false-precision findings
  to get tagged `[FINANCIAL-ARITHMETIC]`, which risked corrupting the tag-overlap corroboration
  check the aggregation algorithm depends on. **Fixed**: `[FALSE-PRECISION]` added to the
  vocabulary.
- **`agents/connectors-liaison.md` called the privacy officer subagent directly, bypassing the
  documented `skills/risk/privacy-check` entry point** — the one real caller of the privacy gate
  was calling it through the wrong door. **Fixed** in the same pass.

**What worked well, confirmed by a real run, not just read:** the reconciliation logic in
`assemble-business-plan` caught a real, deliberately planted Step 4/Step 16 pricing inconsistency
three layers deep (the step file, the assembled plan, and an independent council persona all
surfaced it without being told where to look); the AI-risk gate genuinely discriminated (it blocked
on the one truly unsourced figure and passed the many honestly-low-confidence ones); the council's
outlier-discard and aggregation algorithm was mechanically followable by hand on a real worked
example; and the GTM/ops handoff layer had zero dead cross-references against what the upstream
layers actually produced.

---

## Round 3 — second dry run (marketplace), connectors caller re-audit, and integration fixes

**Commits:** `4f6a9ae` through `b11447f`. **Findings:** `docs/QA-FINDINGS-ROUND3.md` (end-to-end
dry run against SkyClaim, a two-sided marketplace fixture), `docs/QA-FINDINGS-CONNECTORS-ROUND3.md`
(a re-audit of all `agents/gtm/*`, `agents/ops/*`, and their skills against
`docs/CONNECTORS-CATALOG.md`, checking whether round 2's connector fix actually held).

This round completed business-type branching for DE steps 13-24, added two new council personas
(`marketplace-liquidity-specialist`, `services-unit-economics-reviewer`) with a persona-coverage
tracking table, deepened business-type instrumentation across all 5 ops skills, hardened
`validate-plugin.sh`/CI, and ran a second live dry run — this time against a two-sided marketplace,
`pivoting` from prior operating history, chosen specifically to stress the new business-type
branching and the new marketplace persona.

**Confirmed still holding from round 2:** the orchestrator's `drafted`-vs-`approved` fix, the
`plan.version` skeleton default, the "Confidence & Validation Status" section, and — the most
consequential confirmation — the AI-risk gate wiring on DE steps 04/14/16/17/19 and the onboarding
privacy notice. The gate was called live three separate times this round (twice on individual
steps, once at plan assembly) and correctly BLOCKED, then PASSED after a fix, each time. The
connectors re-audit independently confirmed round 2's fix to `connectors-liaison`'s five named
callers held with zero regressions (5 real checks, 0 asserted-but-not-real, across 19 files).

**Real bugs found and fixed:**

- **Steps 17 (LTV) and 18 (sales-process costing) had zero marketplace branching**, even though
  Step 19 (COCA) explicitly requires comparing "Step 17's LTV" (singular) against per-side COCA
  figures. This produced a real, demonstrated three-step-deep gap: the dry run computed a clean
  demand-side LTV:COCA ratio but had no way to represent a supply-side participant's LTV at all (a
  marketplace side that's paid by the business, not paying it, has no positive LTV under the
  standard formula), and nothing caught this except the drafter's own improvisation. **Fixed**:
  explicit marketplace branching was added to both steps.
- **The council's seat-selection trigger logic had a status-check condition that could never
  evaluate false** — rule #5's "whenever Steps 10/11 are not yet `approved`" clause was
  unconditionally true for every business the plugin will ever review, since (per round 2's own
  confirmed fix) no DE step is ever promoted past `drafted` by any skill in the system. This
  silently overrode `sales-motion-reviewer` and `product-market-fit-panel`'s legitimately-firing
  triggers for the majority of business types, and had survived a full rewrite of the surrounding
  logic untouched. **Fixed**: replaced with a real content-based signal (thin Step 10/11 content —
  a low-confidence assumption count or an explicit "no Core yet" finding — rather than a status
  value the state machine had already ruled out).
- **Step 4's beachhead-TAM sanity-check heuristic didn't distinguish GMV from take-rate revenue**
  for marketplaces, producing a spurious "market too small" false signal — a take-rate business's
  revenue is structurally a fraction of its GMV in a way a SaaS ACV figure isn't, so applying the
  same dollar-range heuristic to both made a correctly-computed marketplace TAM look disqualifying
  regardless of whether the market was actually healthy. **Fixed**.
- **Step 3's dual end-user-profile template had no second slot**, even though its own prose
  requires writing two profiles for a marketplace — unlike Step 12, which already had the "one
  table per side" scaffold. **Fixed**: Step 3 now has the same scaffold.
- **The council's Aggregate Verdict checklist could still bury a panel's most consequential
  finding**, in a new shape round 2 hadn't hit: a verdict that *survives* the outlier test via
  cross-severity tag corroboration still didn't get its own required-revisions items into the
  synthesized checklist, because that union only includes reviewers *at* the final aggregate
  severity. **Fixed**: a severity-independent "most consequential finding" callout was added,
  extending round 2's discarded-outlier fix to cover survivors, not just discards.

**No fixes owed from the connectors re-audit** — it found the round-2 fix genuinely held with zero
gaps, and instead surfaced (and fixed in the same pass) one real ambiguity in
`connectors-liaison.md` itself: it told a caller a connector wasn't safe to use but never specified
what "continue with a different part of the task" was supposed to mean in practice, risking either
a silently-skipped deliverable or an over-broad full-task block.

**What worked well, confirmed by a real run:** the new `marketplace-liquidity-specialist` persona
caught a genuine, consequential finding (disintermediation risk) that the persona it replaced for
marketplace businesses never raised, confirmed by direct side-by-side verdict comparison; the
seat-selection and aggregation logic survived a second real hand-execution on a genuinely different
worked case than round 2 hit; and the plugin absorbed a second round of live concurrent editing
(two new personas landing mid-session) without producing a broken session.

---

## Round 4 — third dry run (services), full-repo dogfood pass, and integration fixes

**Commits:** `dd1f825` through `6918355`. **Findings:** `docs/QA-FINDINGS-ROUND4.md` (end-to-end
dry run against Vantage Point Search, a services fixture), `docs/QA-DOGFOOD-ROUND4.md` (the first
repo-wide application of the QA layer's own checklists — `skill-quality-auditor` and
`consistency-checker` — at scale, rather than 2-3-file spot checks).

This round fixed accumulated `CONVENTIONS.md`/`ARCHITECTURE-IMPLEMENTATION.md` drift from rounds
1-3, seeded the first Layer 2 behavioral eval suite, ran a third live dry run against a services
business (the one business type not yet live-tested despite round 3 having just added deep services
branching), and ran the QA-tooling dogfood pass across a representative, budgeted sample of the
whole repo (all 10 council personas, all 4 GTM agents, all 5 ops agents, both risk agents, 6 DE
steps, plus a full, unsampled repo-wide duplicate-name and cross-reference sweep).

**Confirmed still holding from rounds 2-3:** the orchestrator's stage-diagram fix, the
`plan.version` default, the "Confidence & Validation Status" section, the five-step gate wiring
plus onboarding privacy notice (one real BLOCKED→fix→PASS cycle this round), and — the headline
generalization check — round 3's Steps 17-19 marketplace fix and Step 4's TAM heuristic fix both
turned out to have been written generally enough to give **services** businesses a full, distinct,
independently-followable treatment too, not just a patch for the one case round 3 reported. Round
3's "unconditionally true" status-check fix in the council's seat-selection logic also held,
unregressed, even after that section was substantially rewritten mid-round around two brand-new
personas.

**Real bugs found and fixed:**

- **Step 18's costed-process template had no place for referral-driven "background relationship
  maintenance" time** — a real, demonstrated gap specifically for the business shape (referral-
  driven services) the step's own guidance names as the default case. The dry run's fixture showed
  roughly 29 of 45 hours per engagement living in exactly this uncounted category, invisible to the
  template's discrete-stage rows. **Fixed**: an explicit template subsection was added.
- **The new `regulated-industry-compliance-reviewer` trigger, added mid-round, would misfire on a
  business's own explicit denial of a regulated attribute** — a literal keyword scan on
  `business_type_notes` would fire on the substring "licensed" inside the sentence "No licensing
  requirement," and on "HIPAA" inside a description of a surveyed-and-rejected candidate segment,
  not the business's own pursued activity. Demonstrated on real fixture text, not hypothetically.
  **Fixed**: the trigger now requires the keyword match to describe the business's own actual or
  pursued activity, not a rejected segment or an explicit negation.
- **The council's outlier tag-overlap check was syntactic, not semantic** — two independent
  reviewers converging on the same real concern (whether a hiring-based scaling plan can actually
  be executed) under two different, legitimately-scoped tags (`[EXECUTION-RISK]` vs.
  `[DELIVERY-CAPACITY]`) produced no detected overlap, so a REVISE that was substantively
  corroborated was discarded as an "uncorroborated" outlier — changing the real `stage` outcome
  from `revising` to `approved`. **Fixed**: a semantic corroboration check was added on top of the
  mechanical tag match.
- **§8.4's synthesized "Required revisions" checklist instruction had no defined content when the
  aggregate verdict itself was `APPROVE_WITH_NOTES`** — per the verdict schema, that severity has
  no Required Revisions section to union in the first place, so the instruction's literal content
  was empty the first time a dry run actually landed at that severity. **Fixed**: an explicit
  APPROVE/APPROVE_WITH_NOTES branch was added, built from the union of Risks/gaps bullets instead.
- **`assemble-business-plan`'s LTV:COCA reconciliation instruction was silent on a healthy ratio
  that still needs a services-specific capacity caveat** — it only told the writer what to do for
  an *unhealthy* ratio, missing the case a strong-looking ratio for a capacity-constrained services
  business needs the same honesty treatment. **Fixed**.
- **A cross-cutting `connectors.json`/`cadence.json` staleness, spanning 7 files**: the dogfood
  pass found that a concurrent mid-round fix to `CONVENTIONS.md` §5 (correctly establishing that
  connector status and cadence live as keys *inside* `business-state.json`, never as separate
  files) had left `agents/connectors-liaison.md`, `agents/orchestrator.md`,
  `agents/risk/privacy-compliance-officer.md`, `skills/risk/privacy-check/SKILL.md`, and two
  architecture docs still describing or maintaining standalone mirror files. **Fixed** in the
  round's integration pass, across all 7 files at once.
- **`agents/qa/consistency-checker.md`'s own reference data had drifted** — it still listed a
  `connectors/` agent subfolder that doesn't exist, was missing the real `design/` subfolder, and
  still listed the two stale connector/cadence files as expected. **Fixed** directly during the
  dogfood pass itself (a mechanical correction against an already-updated source of truth, not a
  judgment call).

**Flagged but not fixed, by explicit scope decision:** all 10 `agents/council/*` files are missing
an explicit "you write nothing to disk" body statement (the `tools:` field already makes this
mechanically true, but the checklist treats the missing sentence as a real gap regardless) — left
for whoever owns the council layer, since it was out of this round's assigned scope.

**What worked well, confirmed by a real run:** the founder-capacity stress test this round was
designed to answer landed cleanly — Steps 17/19/24 and the dedicated
`services-unit-economics-reviewer` persona all converged on the same honest picture (strong
per-engagement unit economics that say nothing about growth, because growth is gated by delivery
hours, not customer acquisition) without needing a reviewer to infer it; the Track A
`vc-panel`-downgrade-to-informational mechanism was exercised live for the first time across all
three dry runs and worked exactly as specified; and the plugin absorbed its largest mid-session
change yet (two new council personas, a rewritten seat-selection tier structure) without regressing
an already-working business type's seat-selection outcome.

---

## Round 5 — fourth dry run (consumer app), first real Layer 3 regression pass, and a latent revision-loop bug

**Findings:** `docs/QA-FINDINGS-ROUND5.md` (end-to-end dry run against Kindling, a freemium
consumer-app fixture), `docs/QA-LAYER3-REGRESSION-ROUND5.md` (the first real, checkbox-by-checkbox
execution of `docs/TESTING.md` §3.1–§3.6 against the three existing dry-run fixtures).

This round closed the one systemic gap round 4's QA dogfood pass flagged and deliberately left
unfixed (the council write-scope statement), ran a fourth live dry run against the last untested
`business_basics.business_type` value, and — for the first time — actually executed
`docs/TESTING.md`'s Layer 3 pre-release regression checklist as a real pass/fail exercise rather
than leaving it as a document nobody had run. That checklist run is what surfaced this round's
single most consequential fix.

**The council write-scope mechanical fix.** All 12 `agents/council/*.md` files (the original 10
plus round 4's `hardware-physical-product-operator` and `regulated-industry-compliance-reviewer`)
now carry an explicit `## What you write` section stating plainly that the persona writes nothing
to disk and returns its verdict to the calling skill instead — confirmed by a direct
case-insensitive grep, 12 of 12 files match. This closes the gap `docs/QA-DOGFOOD-ROUND4.md`
flagged as systemic but out of scope for that round.

**The fourth live dry run (Kindling, `consumer_app`, `idea_only`, freemium — the last of the six
`business_type` enum values never yet exercised by a real fixture) surfaced real findings, and the
consequential ones were fixed directly:**

- **Blocking — Steps 1, 2, and 4 had zero `consumer_app` branching, and Step 4's gap was
  load-bearing, not cosmetic.** Step 4's formula ("annual revenue per user = price × purchase
  frequency") has no answer for a freemium app, where most users generate ad revenue only and a
  small minority pay. Drafting Kindling's real TAM against the unmodified step produced a naive,
  100%-conversion figure roughly 20x the realistic blended-ARPU figure, with nothing in the step or
  downstream to catch a less careful drafter from reporting the inflated number — and Step 4 is one
  of the five steps the mandatory AI-risk gate covers, meaning a founder who stops right there (a
  named risk in the step's own gate section) would walk away with a materially wrong headline
  number. **Fixed:** Step 4 now has an explicit `**Consumer app:**` branch instructing the blended
  ad-plus-subscription-revenue method as the number of record, with the naive full-conversion figure
  reported only as an explicitly-labeled non-representative ceiling; Step 2 gained a generic B2C
  fallback question so "reach" and "competitive intensity" aren't left completely undefined for a
  consumer-facing business.
- **Significant — Steps 16 and 18 could silently produce two different numbers for the same
  freemium-to-paid conversion rate**, with neither step's own text instructing a cross-check against
  the other. This is the fourth independent instance of the "two related steps can diverge without
  either checking against the other" bug class (after round 2's finding 2.2 and round 3's finding
  1.3). **Fixed:** Step 18 now instructs cross-checking its chained funnel conversion rate against
  Step 16's stated assumption and flagging explicitly if they disagree by a material amount.
- **Significant — `competitive-strategy-reviewer`'s "Calibrate by business type" section had no
  `consumer_app` bullet**, discovered by hand-working `run-review-council`'s seat-selection logic
  against Kindling's real `business-state.json`: `product-market-fit-panel`'s own trigger (meant to
  be the most load-bearing seat for exactly this business type) did not fire, because Kindling's
  real weak points clustered in unit economics (Steps 4/16-19) and Core (Step 10), not the PMF-range
  steps the trigger counts — a realistic pattern for an idea-stage app with some pilot signal, not a
  contrived one. The seat instead went to `competitive-strategy-reviewer` via a different, legitimate
  trigger, and that persona's file had no type-specific scrutiny for consumer apps to fall back on.
  **Fixed:** added a `consumer_app` calibration bullet (network/social effects, retention-curve and
  freemium-conversion credibility, platform-policy dependency). A genuinely dedicated `consumer_app`
  contextual persona remains an open, future-round scoping question, not fixed this round.
- **Polish — `assemble-business-plan`'s LTV:COCA reconciliation instruction had a services-specific
  caveat (round 4) but no consumer_app-specific one for the opposite case**: a weak ratio built
  entirely from pre-launch, zero-real-data placeholders needs an explicit statement that it reflects
  current-assumption risk, not a proven-unviable business. **Fixed** with a parallel caveat.
- **Confirmed a fourth consecutive time, on a fourth business type: the AI-risk gate's false-precision
  catch keeps landing at the same specific step (19, COCA)** — three of four rounds now, at the
  step furthest downstream in the TAM→LTV→funnel-costing→COCA estimate chain, and therefore the one
  accumulating the most compounded uncertainty. Round 4 asked whether a fourth recurrence would
  justify a structural fix rather than continued reliance on the gate; this round's answer is yes.
  **Fixed:** added a standing "round explicitly before writing the headline figure" reminder to
  Step 19 (the specific step hit four times), rather than relying on the gate to catch it
  indefinitely.

**The Layer 3 regression pass's most important result: it exercised a code path no live dry run had
ever reached, and found a real, latent bug in `revise-business-plan`'s stage-transition logic that
would have stalled the revision loop the very first time anyone actually ran it.**

Two of the three existing fixtures (`shiftcover`, `skyclaim`) sit at `stage: "revising"` — the exact
point where a REVISE/REJECT verdict hands off to `revise-business-plan` — but neither had ever
actually been driven through a revision cycle by a live run. Checking `docs/TESTING.md` §3.2's
checklist for real meant reading `revise-business-plan/SKILL.md` against its two collaborators
(`agents/orchestrator.md` and `run-review-council/SKILL.md`) rather than reading each file in
isolation, and that cross-read surfaced a three-way contradiction:

- `run-review-council/SKILL.md` §0.2's precondition requires `stage` to be exactly
  `"plan_assembled"` or `"revising"` before it will run — anything else, it stops and reports.
- `agents/orchestrator.md`'s own state-machine notes independently confirm the same thing:
  `run-review-council` "never persists `council_review` as an on-disk value," and any caller handing
  off to it must leave `stage` at `"revising"`.
- **But `revise-business-plan/SKILL.md`, before this round's fix, instructed the opposite** — its
  old §6 ("Advance stage for re-review") and its old §7 final-write list both told the skill to write
  `stage = "council_review"` once revision work finished.

No fixture had ever exercised this handoff, so the contradiction had never been caught: the two
skills' contracts had silently diverged, each internally consistent and correctly documented on its
own, but incompatible with each other at the exact seam a real revision cycle depends on. Had any
prior dry run actually gotten a REVISE/REJECT verdict through a revision and back to a second
council review, `revise-business-plan` would have written a `stage` value `run-review-council`'s own
precondition rejects, and the loop `docs/ARCHITECTURE.md` explicitly requires (revise, never straight
to `approved`, always back through council review) would have stalled at that handoff with no
fixture ever having existed at that point in the lifecycle to reveal it. This is the reason the bug
had never been caught before: it lives entirely inside a seam between two skills that only a real
multi-step revision cycle exercises, and every one of the four live dry runs to date (rounds 2-5)
either never reached `"revising"` or stopped exactly there without continuing through it.

**Fixed:** `skills/business-plan/revise-business-plan/SKILL.md` — §6, §7, and the frontmatter
description now instruct leaving `stage` at `"revising"` (as already set in the skill's own §2)
rather than writing `"council_review"`, matching what `run-review-council` and the orchestrator both
already expected. This is a one-file fix confined to the skill that owns the value; it does not
touch `run-review-council`, the orchestrator, or any fixture. **The fix is unverified by a live
run** — it resolves a real, demonstrated contract contradiction between three files' own stated
text, but no fixture has yet exercised the corrected path end to end. Round 6, running concurrently
with this document, is the first attempt to do exactly that (see `docs/ROADMAP.md`).

**The Layer 3 pass's other headline result, honestly scored rather than glossed:** 6 PASS, 9 GAP,
2 FAIL (the `revise-business-plan` bug above, fixed; and `vantage-point-search`'s review left with
`resolved: false` at `stage: "approved"`, logged but not fixed since fixture edits were off-limits
this round). The single largest gap restated plainly: **nothing in this repo's live-testing history
has ever driven a business from `approved` into `gtm`/`operating`** — `agents/gtm/*`, every
`skills/gtm/*` and `skills/ops/*` skill, and Phases 5-6 of the orchestrator's state machine are
structurally reviewed and read correctly, but carry zero real-run evidence. See
`docs/QA-LAYER3-REGRESSION-ROUND5.md`'s full summary table for all 17 checked items and its closing
"what a future round needs to do" list, which is exactly what round 6 is now attempting.

---

## Patterns worth knowing

These are the things that only become visible by reading the findings docs together, not from any
one of them alone.

- **The exact same "unconditionally true forever" status-check bug appeared independently in two
  different subsystems, one round apart.** Round 2 found it in the orchestrator's stage diagram
  (steps gated on an `approved` status nothing ever writes). Round 3 found the identical shape of
  bug, independently, in the review council's seat-selection triggers (rules gated on "Steps 10/11
  not yet `approved`," which — given round 2's own fix — is unconditionally true for every business
  forever). Both were checks against a status value the state machine had already ruled out as
  reachable. This is worth watching for as a class, not just as two isolated incidents: any future
  gate condition phrased as "status is not yet X" is worth asking, explicitly, whether X is a value
  anything in the system actually writes.
- **The AI-risk gate caught the same false-precision failure mode independently across three
  different businesses, at three different specific steps, across three consecutive rounds** — a
  SaaS TAM in round 2's fixture, then a marketplace TAM and LTV in round 3, then a services COCA in
  round 4. Every instance was the same underlying shape: a chain of several low-confidence inputs
  multiplied together produces an artificially precise-looking output unless a drafter deliberately
  rounds at the end. This reads as strong evidence of a real, structurally-expected drafting failure
  mode the gate reliably catches — not a fluke, and not evidence of a persistent bug in any one step
  file — but round 4's own findings note that a fourth recurrence would be worth asking whether a
  standing "round your final output" reminder belongs in the shared unit-economics step template,
  rather than relying on the gate to catch it indefinitely.
- **The cross-step reconciliation requirement in `assemble-business-plan` caught a different real,
  mostly-unplanted inconsistency in every single dry run**, without being told what to look for: a
  stale Step 4 beachhead price left behind by a Step 16 volume-tier refinement (round 2, this one
  deliberately planted to stress-test the mechanism); a marketplace supply-side LTV gap surfaced
  only by writing the Step 17-vs-19 comparison out explicitly (round 3, not planted); and a Step
  4/Step 14/Step 17 TAM-vs-LTV double-count of the same future client relationships (round 4, also
  not planted). Three different problem shapes, one mechanism, doing genuine diagnostic work each
  time rather than replaying a known-good pattern.
- **The council's "findable but not concealed" gap kept recurring in new mechanisms, not just new
  instances.** Round 2 found discarded outliers' required-revisions disappearing from the
  synthesized checklist. Round 3 found a related but distinct case — a verdict that *survives* via
  cross-severity tag corroboration still lost its own checklist entries. Round 4 found two more,
  structurally different again: a syntactic (not semantic) tag-overlap check missing real
  corroboration between differently-tagged findings, and an aggregate-severity branch
  (`APPROVE_WITH_NOTES`) the synthesis instruction had literally never defined content for. Nothing
  in any of these four instances was ever actually hidden — every full verdict stayed visible in the
  file each time, per the skill's own "never hidden or truncated" rule — but four independent dry
  runs finding four different ways for the *synthesized* section to under-represent a real finding
  suggests the aggregation/synthesis layer is a structurally leaky abstraction, worth a dedicated
  design pass rather than continuing to patch one newly-discovered shape per round.
- **Fixes generalizing beyond the one case that was reported is itself something rounds have had to
  check for, not assume.** Round 4 explicitly re-verified that round 3's Steps 17-19 marketplace fix
  and Step 4's TAM-heuristic fix were written generally enough to also cover services correctly, not
  just patched for the marketplace case — and confirmed both did. That confirmation is itself a
  finding, not a given: a narrower fix that only addressed the reported business type would have
  silently left the same gap for the next business type to hit.
- **Not every fix has been independently re-tested by a live dry run — this changelog does not
  imply otherwise.** The "use WebSearch before falling back" enforcement gap (round 2, finding 1.4)
  was never specifically re-probed by rounds 3 or 4; both rounds note they followed the same
  honest-fallback discipline without attempting WebSearch, which is not the same as testing whether
  the gap itself has closed. Similarly, the round 3 connectors audit found zero live gaps to fix
  (the round 2 fix held completely) — a clean result, but one specific to the 19 files audited at
  that time, not a claim about every future extension.
- **Round 5 found the first bug of a genuinely different category: not a business-type gap, but an
  unexercised code path.** Every headline bug in rounds 2 through 5's own dry-run sections above
  shares one shape — a real business type or business shape hits a step, template, or trigger that
  was never written (or written wrong) for it, and a live drafting session is what surfaces the gap.
  The `revise-business-plan`/`run-review-council` stage-value contradiction round 5's Layer 3 pass
  found is a different animal: both files were individually well-specified and internally
  consistent, business-type branching had nothing to do with it, and no amount of running the
  onboarding-through-council-review path on a fifth or sixth business type would ever have surfaced
  it — the bug lives entirely in a seam between two skills that only a *second* pass through
  council review exercises, and no dry run (rounds 2-5) had ever continued a fixture past the point
  where a REVISE/REJECT verdict first lands. This is worth naming as its own category going
  forward, distinct from "one more business type": some gaps aren't about breadth of coverage at
  all, they're about depth of exercise — a code path nobody has ever actually walked, however well
  it reads. Round 6, running concurrently with this document, is the first attempt to walk that
  specific path for real.

