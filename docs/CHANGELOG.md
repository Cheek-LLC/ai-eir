# Changelog — 30-Minute Startup

This is the single chronological ledger of what got built, what broke, and what got fixed, across
every round of this plugin's build. It exists because the QA history now spans ten separate
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

## Round 6 — first completed revision cycle, first post-approval run, and a revision-routing gap

**Findings:** `docs/QA-FINDINGS-ROUND6.md` (the first real revision cycle, driven live against
`shiftcover`'s standing `stage: "revising"` REVISE verdict), `docs/QA-FINDINGS-POSTAPPROVAL-ROUND6.md`
(the first real GTM → ops → recurring-check-in run, driven live against `vantage-point-search`'s
standing `stage: "approved"`). Both are exactly the two gaps round 5's Layer 3 pass named, in its own
closing section, as the highest-value next tests — not a new business type, not a new persona, but
the first live exercise of two code paths every prior round had only read.

This round ran no new onboarding session and created no new fixture; it picked up the two existing
fixtures the plugin's live-testing history had left stalled at exactly the two points round 5 flagged,
and drove each through real, on-disk work for the first time.

**Headline 1 — the revision loop works end to end, live, for the first time, and round 5's stage-value
fix holds under real execution, not just inspection.** `revise-business-plan/SKILL.md` kept `stage` at
`"revising"` through a full revision cycle (routing 5 real required-revision items to DE-step rework
or synthesis-level fixes, producing a real `plan/business-plan-v2.md`, running the mandatory AI-risk
gate live against the new content), and `run-review-council/SKILL.md`'s precondition accepted the
handoff cleanly with no workaround — the stall round 5 predicted under the pre-fix
`stage = "council_review"` bug did not happen. The re-review landed REJECT again, on real, defensible
grounds (worked by hand through the aggregation algorithm's semantic-overlap check, confirmed
load-bearing on a real outcome for the first time), not a rubber-stamped approval.

That REJECT surfaced this round's one significant, previously-undetected gap: **a discarded outlier's
required revisions were never routed to by `revise-business-plan`, so they resurfaced identically on
re-review.** `customer-discovery-skeptic`'s REJECT in v1 was correctly discarded as a
non-corroborated outlier by the aggregation algorithm — but `revise-business-plan` §0.3 only ever
extracted the synthesized aggregate checklist, which by construction never contained a discarded
persona's items. The revision genuinely, substantively addressed 4 of 5 aggregate items, but never
touched the discarded persona's 3 concerns at all, because nothing in the skill's instructions pointed
at them — and on re-review that persona reconvened, found its concerns untouched, and REJECTed again,
this time surviving the outlier test via semantic (not literal) tag corroboration with a second
reviewer. **Fixed:** `revise-business-plan/SKILL.md` §0 now explicitly instructs extracting and
carrying forward (never dropping) both the `### Discarded-but-real concerns` and `### Also flagging,
regardless of severity` sections alongside the aggregate checklist as in-scope work, so a discarded
concern's substance gets worked even though the outlier-discard rule correctly kept it from dictating
the aggregate verdict on its own. A related, smaller finding from the same live run was fixed in the
same file: §1's routing guidance conflated "blocked on a founder decision" with "blocked on real
calendar time passing" under one "blocked" bucket, risking pressure to fabricate progress on a
time-gated item (e.g. recomputing a sales-cycle funnel before enough real prospects have moved through
it) — now reported explicitly and distinctly as "open, time-gated."

**Headline 2 — the first live run past `stage: "approved"` found a real 2-4.3x runway-overstatement
bug, plus a real, previously-undocumented ambiguity in the connectors gate's scope.**
`vantage-point-search` was driven through `launch-director`'s full GTM sequencing, a live
`connectors-liaison` invocation (confirmed, not assumed, that no CRM connector exists in this
environment), `operations-manager`'s first-ever real check-in, and a full `recurring-check-in` pass —
the entire back half of the lifecycle diagram, exercised live for the first time.

`skills/ops/runway-and-burn-tracking/SKILL.md`'s formula (`runway_months = cash_on_hand / net_burn`)
had no period-normalization step, and this was the first time it had ever run against a non-monthly
check-in cadence. Applied literally to a real biweekly (14-day) first check-in, the un-normalized
formula would have reported roughly **28.3 months of runway against a correct, monthized figure of
about 13.2** — a 2.1x overstatement at biweekly cadence, and a projected ~4.3x overstatement at a
weekly cadence, on exactly the single number `agents/ops/finance-controller.md` names as the one
whose staleness or fabrication is "actively dangerous" because a founder can make a real payroll
decision off it. The gap survived every prior round only because the ops layer had never run live
before this round. **Fixed:** the skill now instructs normalizing any non-monthly period's burn to a
monthly-equivalent figure before computing runway, and reporting both the raw period figure and the
monthized figure so the normalization itself is visible in the output, not just the final number.

The same run also surfaced a real, previously-undocumented ambiguity in the connectors gate's
scope: neither `docs/CONNECTORS-CATALOG.md` nor `agents/connectors-liaison.md` specified whether a
task like "send the launch announcement" meant an agent automating a send through a wired tool, or a
founder personally sending an email from their own inbox on the agent's recommendation — a real
distinction, since reading it too broadly risks blocking a founder from using their own tools
unnecessarily, and reading it too narrowly risks letting an agent-automated bulk send bypass the
privacy gate. **Fixed:** `agents/connectors-liaison.md`'s MANDATORY GATE callout now states explicitly
that the gate applies when the agent itself initiates or automates an action through a connector it
operates, not when the plan simply recommends the founder personally take an action through their own
already-existing tools.

**What worked well, confirmed live for the first time:** the connectors-liaison gate's full chain
(identify → live-check → surface → record → report) held under real pressure on a real CRM need, with
round 4's "don't silently drop the pending piece" fix confirmed intact; `launch-director`'s
funding-strategy determination and its GTM/ops state-machine boundary with the orchestrator both held
exactly as documented; `operations-manager`'s "insufficient data" discipline produced honest output
rather than a forced read from too little real history; and the AI-risk gate held on the revision path
specifically (not just first assembly), catching a real fresh unsourced figure introduced mid-revision.

**Round 6 is now complete and integrated** — every fix named above is confirmed present in the current
files, not left as an open backlog: `skills/business-plan/revise-business-plan/SKILL.md` (§0 discarded-
concerns routing, §1 decision-gated vs. time-gated distinction), `skills/ops/runway-and-burn-
tracking/SKILL.md` (period-normalization step), and `agents/connectors-liaison.md` (agent-automated vs.
founder-personal gate scope).

---

## Round 7 — the founder-override path and a second check-in cycle with a real mid-lifecycle pivot

**Findings:** `docs/QA-FINDINGS-OVERRIDE-ROUND7.md` (the first live exercise of the founder-override
mechanism, driven against `shiftcover`'s standing REJECT verdict), `docs/QA-FINDINGS-PIVOT-ROUND7.md`
(the first live second recurring check-in cycle, and the first live mid-lifecycle pivot, both driven
against `vantage-point-search`). Both are exactly the two of three items round 6's own roadmap update
named as the next frontier once the revision loop and the post-approval half were closed (the third,
a founder overriding mid-GTM sequencing rather than post-approval, remains untested — see the round 7
roadmap section).

This round ran no new onboarding session and created no new fixture; like round 6, it picked up two
existing fixtures and drove each through a code path every prior round had only read, never executed.

**Headline 1 — the founder-override mechanism works, and exercising it live found a genuine
silent-failure risk in the one place it would have mattered most: downstream GTM visibility.**
`agents/orchestrator.md` Non-negotiable #3 specifies an explicit override — a `risk_log` entry with
`raised_by: "startup-operator (founder override)"`, `status: "accepted"`, the review file marked
noted-but-overridden — for a founder who wants to proceed against a standing REVISE/REJECT rather than
revise further. Playing founder Maria Chen through a real decision on `shiftcover`'s second-cycle
REJECT (a reasoned partial agreement — accepting 2 of 4 risks outright, disputing one on its own
terms, naming the one she takes most seriously) confirmed the mechanism's own "not a shrug" bar is
genuinely enforceable, not just aspirational prose, and that round 6's "Also flagging, regardless of
severity" review-file section did exactly the job it was built for on its first founder-facing use —
surfacing the one corroborating fact (a 2-of-7 sales-cycle conversion figure) that mattered most to
an informed override decision.

But driving the override through to its actual downstream consequence — would `agents/gtm/
launch-director.md` notice a plan proceeded over a blocking verdict? — found a real bug, not a
hypothetical one: **`launch-director` would have silently proceeded as if the plan had cleared review
cleanly.** Two independent, compounding reasons: its Gate check only read `stage`, with nothing
distinguishing an `approved` reached via a clean verdict from one reached via override; and its own
"What you read" instruction for `risk_log` was scoped to "anything **open**" — but Non-negotiable #3's
required value for an override entry is `status: "accepted"`, so the instruction, taken literally,
filtered out exactly the entries the override mechanism produces, by construction, every time. A
founder who overrode a REJECT and proceeded to GTM would have gotten a `gtm/launch-plan.md` — the
artifact most likely to be shown to a contractor, early hire, or investor — with zero mention that it
proceeded over a blocking verdict. **Fixed:** `launch-director`'s Gate section now re-reads the most
recent `reviews[]` verdict whenever `stage` is `approved`; if it's REVISE/REJECT, it confirms via the
review file's override mark and the matching `accepted` risk_log entries, states the override plainly
to the founder, and carries it into `gtm/launch-plan.md`'s risk section by name before any sequencing
work — verified by walking the patched gate logic against `shiftcover`'s real current state and
confirming it fires correctly. A second, related bug was found and fixed in the same pass: the
orchestrator's own state-machine diagram had described the override path as looping back through
*another* council re-run — backwards, since the entire point of an override is that it substitutes
for a clean re-pass. **Fixed:** the diagram now shows the override branch going straight to `approved`
with no re-run, distinct from the "revisions addressed" branch. Two smaller items were logged rather
than fixed, both explicitly out of this round's edit scope: `docs/DATA-CONTRACT.md`'s `risk_log[].type`
enum has no clean fit for "a review-council verdict was overridden" (a real taxonomy gap, `business`
used as the least-wrong fit), and `reviews[].resolved`'s meaning on the override path required a
judgment call (resolved to `true`, reasoned and stated explicitly rather than silently assumed).

**Headline 2 — a second check-in cycle and a real mid-lifecycle pivot both ran live for the first
time, and found the DE-step reopening protocol was a single unspecified sentence with no real
mechanics, plus two related handoff gaps.** `vantage-point-search` was driven through a second
biweekly check-in and then a genuine, evidence-based pivot: two real prospect losses at the low end of
the beachhead's employee-count band, both stalling at the exact stage the plan itself already named as
the single biggest drop-off point — a plausible, foreseeable consequence of risks the plan had already
flagged, not a contrived edge case.

`agents/orchestrator.md` Phase 6's entire specification for reopening DE steps after a pivot was one
clause — "return to `de_steps_in_progress` if a pivot reopens earlier steps" — with no partial-
reopening mechanic (Phase 2's sequencing instruction is written for a first pass through all 24, not a
targeted reopening of 4), no status semantics for a step whose content is probably still valid but
hasn't been formally re-confirmed (the schema's four-value status enum has no state for this), and no
transitive-impact guidance for the other 19 steps. Trying to follow it literally for this round's real
pivot (steps 01/02/04 clearly implicated, step 05 probably still valid but unconfirmed) required
inventing a subset-reopening approach from scratch, with no basis in written text for the specific
calls made. **Fixed:** `agents/orchestrator.md` Phase 6 now has a real "Reopening a subset of DE steps
after a pivot" procedure — only the specifically-implicated steps revert to `not_started`; every other
step keeps its `drafted` status unless separately flagged; a step that's probably still valid but
unconfirmed gets a new `NEEDS RE-CONFIRMATION:` summary-prefix convention (now also documented in
`docs/DATA-CONTRACT.md`'s Conventions section) rather than an invented ad hoc marker; and re-assembly
is preceded by a cheap skim-check of every step file for content naming the specific thing that
changed, not a full re-derivation. Two related, smaller handoff gaps were found and fixed in the same
pass: `skills/interview/recurring-check-in/SKILL.md` correctly anticipated a pivot signal surfacing in
Phase 2 conversation but gave its executor no next step once one did — no instruction to flag it, hand
it to the orchestrator, or route to `agents/ops/operations-manager.md`'s pivot section, despite
`docs/DATA-CONTRACT.md` explicitly assigning this write to `recurring-check-in` by name (**fixed**:
Phase 2 now names the handoff explicitly); and `agents/gtm/launch-director.md`'s existing mid-GTM pivot
section only covered a pivot signal firing while GTM sequencing was still active, with nothing for one
firing after `gtm.status: "launched"` — a real gap, since no fixture had ever pivoted post-launch
before this round (**fixed**: the section now states explicitly that already-shipped GTM artifacts get
flagged as targeting the pre-pivot band rather than "parked," and `launch-director` re-enters once the
DE steps are re-drafted and re-cleared).

**What worked well, confirmed live for the first time:** `operations-manager`'s pivot-signal discipline
correctly did *not* escalate a suggestive-but-thin numeric pattern (2 prospect losses) to a pivot on
its own — it took the founder's own explicit statement to cross that line, exactly per the file's own
rule against manufacturing a pivot from one period's data, and once that statement came in, the
pivot section's own instructions were followable to the letter (in sharp contrast to the orchestrator's
reopening protocol immediately downstream of it). Round 6's runway-normalization fix held correctly a
second time, on the opposite edge case (net cash-generative, not burn-heavy) from the one that found
it. `scaling-strategist`'s "≥3 periods" bar correctly stayed un-invoked even under a plausible-looking
trigger (2 nominally "Healthy" finance periods). And the cadence mechanism itself advanced correctly a
second time (`cadence.last_check_in`/`next_check_in` both moved forward across two real cycles),
answering round 6's own open question about whether it would.

**Round 7 is now complete and integrated** — every fix named above is confirmed present in the current
files, not left as an open backlog: `agents/orchestrator.md` (the override branch in the state-machine
diagram, the "Reopening a subset of DE steps after a pivot" procedure in Phase 6), `agents/gtm/
launch-director.md` (the override-detection Gate check, the post-launch pivot clause), and
`skills/interview/recurring-check-in/SKILL.md` (the pivot-handoff instruction in Phase 2).
`docs/DATA-CONTRACT.md`'s Conventions section documents the new `NEEDS RE-CONFIRMATION:` summary-prefix
convention. `scripts/validate-plugin.sh` still reports 46 skills, 29 agents, 5 commands, 12 council
files, 0 warnings, 0 errors — round 7 deepened existing agent/skill files rather than adding new ones.

---

## Round 8 — consolidation: findings-backlog sweep and real-use readiness, not a fifth dry run

Round 7's own roadmap update named the judgment call directly: seven rounds of simulated dry runs
had reached diminishing returns for this category of bug, and the next qualitatively different test
this project needs is a real human's multi-session use, not another simulated business. Round 8 is
the swarm's own direct response — three agents ran a consolidation round instead of a fifth fixture:

- **A findings-backlog sweep** (`docs/QA-BACKLOG-SWEEP-ROUND8.md`) re-audited all 34 deferred items
  across the seven prior rounds' `docs/QA-FINDINGS-*.md` documents against *current* file state, not
  each document's own now-possibly-stale "not fixed" language — several items had in fact already
  been resolved by a later round's unrelated edit and were confirmed, not re-fixed. 5 items were
  genuinely still open and small enough to fix directly this round: a privacy-check gate forward-note
  wired into `skills/gtm/outbound-sales-playbook` and `skills/ops/kpi-dashboard-setup` for any future
  live-send/live-pull extension, and a structured "Funnel losses this period" field added to
  `skills/ops/weekly-metrics-review`. 20 were confirmed already resolved by later rounds' work. 9
  remain genuinely open, restated verbatim in that document, each blocked on a `DATA-CONTRACT.md`/
  `CONVENTIONS.md` edit or a real maintainer judgment call rather than a quick fix.
- **Real-use readiness polish**: `README.md` gained a "Before you start — what to actually expect"
  section and an honest "Recurring check-ins" section explaining the scheduling-capability caveat
  plainly, and corrected a stale claim about the command count; `.claude-plugin/plugin.json`'s
  version was bumped to `0.2.0`; `skills/interview/onboarding-interview/SKILL.md`'s opening message
  was tightened for a genuine first-time human founder rather than a simulated one — mechanics
  (the vague-answer playbook, the "I don't know" protocol) were left untouched, only the spoken
  opening.

**Round 8 is complete and integrated.** `scripts/validate-plugin.sh` reported 46 skills, 29 agents, 5
commands, 12 council files, 0 warnings, 0 errors at the end of this round — a consolidation round by
design, touching no new skill/agent/command files. **Note for this document's own integrity:** this
"Round 8" section itself was written retroactively during round 9's integration pass, after round 9's
own audit noticed the changelog had gone straight from a "Round 7" section to "Patterns worth
knowing" with no "Round 8" heading in between, even though `docs/ROADMAP.md` and `docs/MASTER_INDEX.md`
had both been updated for round 8 at the time — the round-8 changelog agent's own report described
writing a "Round 7" entry (round 7's own entry had been the actual gap at that time) and evidently
never circled back to add round 8's own section once that was done. Recorded here so this document's
own history is honest about the gap and how it was closed, not just about the plugin's.

---

## Round 9 — an autonomous recurring-routine skill, and 10 functional-specialist "expert
   entrepreneur" agents building advanced-level skills, a new council persona, and optimization agents

Two distinct pieces of work, run together: infrastructure for genuinely unattended operation, and a
broad specialist-depth expansion explicitly requested to make this "the most effective entrepreneur
agent overall" rather than another simulated-business dry run.

**New unattended-firing infrastructure**, built directly rather than by a swarm agent (cross-cutting,
contract-adjacent, same treatment `agents/orchestrator.md` and `CONVENTIONS.md` get every round):
`skills/autonomous-continuation/SKILL.md` is the entry point for a scheduled Routine/cron firing with
no live founder necessarily present — it classifies each stage's next action into
autonomous-safe / founder-required / gated-never-cross-unattended (a council override, a real launch,
a connector spend, anything requiring a fact only the founder has), does the first bucket, never
fabricates the second, never crosses the third, and produces one scannable async digest rather than an
interview nobody's there to answer. `commands/continue-business.md` is the Routine-safe counterpart to
`/check-in` and `/business-status`, routing to that skill. `agents/orchestrator.md`'s existing
self-scheduling logic (present since round 1, "look for a scheduling capability before assuming there
isn't one") now points a scheduled firing's prompt at `/continue-business` specifically, instead of a
generic resume command that assumes someone's there to answer its questions. `README.md` gained a
"Setting up a fully automated recurring routine" section with literal, concrete setup instructions
(the exact phrasing to ask Claude, why `/continue-business` and not `/check-in`/`/business-status` is
the right target, and a plain statement of what it will and will never do unattended).

**10 parallel functional-specialist agents**, each an "expert entrepreneur" in one functional area,
each scoped to strictly disjoint files, built the advanced-level skills, optimization agents, and one
new council persona the roadmap's long tail had named but nothing had built yet:

- **Product** — `skills/product/roadmap-and-prioritization` (RICE-scored, Core/beachhead-drift-aware
  roadmapping) + `agents/product/product-lead.md`, the plugin's first dedicated product-management
  coverage (new `agents/product/`/`skills/product/` categories, pre-registered in `CONVENTIONS.md`).
- **Legal** — `skills/risk/legal-structure-and-ip-basics` (entity choice tied to `funding_intent`,
  vesting/IP-assignment mechanics, contract hygiene, explicit "when this needs a real lawyer"
  boundary).
- **HR/People** — `skills/ops/hiring-and-org-design` (runway-gated should-we-hire decision, per-type
  first-hire sequencing, comp/equity bands) + `agents/ops/people-lead.md`.
- **Customer Success** — `skills/ops/customer-success-playbook` (health-scoring, per-type onboarding,
  expansion motion, save-play discipline) + an append to `agents/ops/customer-success-lead.md` giving
  it a self-correcting practice: comparing the health model's predictions against real outcomes and
  flagging when its own thresholds need recalibrating.
- **Growth/CRO** — `skills/ops/experimentation-and-optimization` (ICE-prioritized experiments, and a
  genuinely rigorous statistical-significance section sized for early-stage traffic — the single most
  differentiated piece of content this round produced) + an append to `agents/ops/growth-analyst.md`.
- **Pricing** — `skills/ops/pricing-and-monetization-optimization` (evidence-gated triggers for
  revisiting DE step 16's pricing, packaging/tiering frameworks, a `quantitative_claims[]` feedback
  loop for a tested price change) + `agents/ops/pricing-strategist.md`.
- **Fundraising/IR** — `skills/gtm/investor-updates-and-cap-table-basics` (the five-part investor
  update format, worked cap-table/SAFE-conversion numeric examples) + an append to
  `agents/gtm/fundraising-advisor.md`.
- **Operations/Fulfillment** — `skills/ops/operations-and-fulfillment-playbook` (real, type-specific
  SOPs for `physical_product`/`marketplace`/`services`) + an append to `agents/ops/operations-manager.md`.
- **Competitive Intelligence** — `skills/ops/competitive-intelligence-monitoring` (monitoring cadence,
  win/loss taxonomy, positioning-drift-detection thresholds) + `agents/ops/competitive-intelligence-lead.md`.
- **Council — Operational Execution** — `agents/council/operational-execution-reviewer.md`, the
  plugin's 13th review-council persona: an ex-COO lens asking not whether the strategy is sound but
  whether *this specific team, at this size,* can actually execute it — summing Steps 13/18/22's
  concurrent load against a realistic weekly-hours ceiling and checking for a credible first-90-days
  operating sequence, a genuinely new axis no existing persona owned. Registered as a new contextual
  5th-seat candidate in `skills/business-plan/run-review-council/SKILL.md` §3 at priority tier #3
  (between `technical-feasibility-reviewer` and the business-type-match tier), gated on a demanding
  **two-of-three** independent execution-complexity signal specifically so the existing type-matched
  seats stay unconditional for the ordinary single-axis case — every downstream numeric
  cross-reference in that file's tie-break rules and "Why 5 seats stays fixed" reasoning was
  renumbered and re-verified by grep for staleness. `docs/DATA-CONTRACT.md`'s "Council persona
  coverage" table was updated to describe the new trigger and its (partial, not closing) reach into
  the `saas`/`consumer_app`/`other` gap that table has tracked since round 4.

**Integration-pass work done directly, after the 10 agents landed:** `docs/DATA-CONTRACT.md` gained
`ops.last_roadmap_file` (mirroring `ops.last_retro_file`'s role, per `product-lead`'s explicit
recommendation rather than an agent inventing a new field itself) and the council-persona-coverage
table update above. Two agents (legal, product) each explicitly deferred a schema/wiring decision to
this pass rather than making it themselves, per their brief — this is the same discipline every prior
round's parallel agents have followed around `CONVENTIONS.md`/`docs/DATA-CONTRACT.md` since round 1,
holding under a materially larger fan-out (10 concurrent agents, the widest of any round) with zero
file-collision incidents.

**Round 9 is complete and integrated.** `scripts/validate-plugin.sh` reports 56 skills, 34 agents, 6
commands, 13 council files, 0 warnings, 0 errors.

---

## Round 10 — live dry-run validation of every round-9 skill, on real user request

Round 9 built 9 new skills, 8 new/extended agents, and a new council persona — none of it had ever
been executed live. Round 10, explicitly requested by the human maintainer, fixed that: **11
parallel agents**, each isolated on its own throwaway copy of an existing canonical fixture
(`shiftcover`, `skyclaim`, `vantage-point-search`, or `kindling` — never mutating the originals),
each live-executed exactly one round-9 skill/agent/persona as literal instructions against real
fixture data, and each produced a `docs/QA-FINDINGS-*-ROUND10.md` report. Zero write collisions
across all 11 concurrent copies. The throwaway copies themselves were deleted after their findings
were extracted — unlike the 4 canonical fixtures, they were disposable test doubles, not ongoing
history.

**The two highest-value results:**

- **`skills/autonomous-continuation`'s first-ever live firing** (`docs/QA-FINDINGS-AUTONOMOUS-
  ROUND10.md`), against round 7's real mid-pivot fixture (`stage: de_steps_in_progress` while
  `gtm.status: launched`/`ops.status: active`), found three real gaps. **Fixed:** (1) the
  autonomous-safe-work table was single-axis (`stage` only) and could have silently skipped real
  ops/gtm work sitting on disk during exactly the period a founder needs visibility most — the
  table now states explicitly that `stage` and ops/gtm liveness are independent signals to be read
  together, not one gating the other; (2) the skill's own mechanical cross-step skim caught two
  stale DE steps (09, 14) that `operations-manager`'s original pivot-signal write had missed —
  the skill now has explicit authority to apply the `NEEDS RE-CONFIRMATION:` marker to what its
  own skim finds, rather than only reporting it and waiting; (3) Phase 4's "if a scheduling
  capability exists, use it" had no guard against silently creating a real, persistent Routine the
  first time anyone ran the command in an environment where a scheduling tool happened to be
  available — now gated on a prior, on-record opt-in (`cadence.scheduling_mechanism` already set)
  before creating a new one, versus freely re-arming an existing one. The core "never fabricate,
  never cross a gate" disciplines held cleanly under real pressure with no fix needed.
- **`skills/ops/experimentation-and-optimization`**, tested against `vantage-point-search`'s real
  low-volume B2B services funnel (`docs/QA-FINDINGS-GROWTH-ROUND10.md`): running the skill's own
  sample-size formula against the fixture's real traffic showed a valid A/B test would take
  **~29-35 years** to reach statistical significance — a genuinely important result showing the
  skill's rigor works, but exposing that the skill let you design a full test before that math
  said it wasn't runnable. **Fixed:** a new Step 1.5 viability check runs the rough arithmetic
  against real business-scale volume *before* any hypothesis/variant gets designed, routing to
  qualitative signal immediately when a test isn't viable at current scale; the experiment-log
  status enum gained a `not-quantitatively-testable` value, since that's a real, complete,
  correctly-reasoned outcome of doing this skill's job properly, not an incomplete entry.

**Real, fixed findings across the rest of the round:**

- **Cross-cutting stage-gate bug, confirmed independently by 3 different test agents**
  (product-lead, hiring, and autonomous-continuation): five round-9 skills
  (`product/roadmap-and-prioritization`, `ops/pricing-and-monetization-optimization`,
  `ops/competitive-intelligence-monitoring`, `ops/hiring-and-org-design`,
  `ops/operations-and-fulfillment-playbook`) gated their own "when to run" precondition on a
  literal `stage: "operating"` read, which doesn't match a real, legitimate combined state (mid-
  pivot, `stage: de_steps_in_progress`, while `ops.status`/`gtm.status` show the business is still
  live). **Fixed** in all five: each now explicitly treats `ops.status`/`gtm.status` as
  independent-of-`stage` liveness signals.
- **`docs/DATA-CONTRACT.md`'s three-kind `quantitative_claims[].source` taxonomy didn't cover a
  tested/measured number** (`docs/QA-FINDINGS-PRICING-ROUND10.md`'s finding, also implicit in the
  growth findings) — the `pricing-and-monetization-optimization` and `experimentation-and-
  optimization` skills' own `quantitative_claims`-feedback-loop mechanic writes a source string
  ("operating data, see ops/...") that matched none of the three documented kinds. **Fixed:** a
  fourth canonical source kind was added to `docs/DATA-CONTRACT.md` — a business's own real
  operating data or a shipped, statistically-valid internal experiment is at least as strong a
  source as a web citation, not an informal fourth-class one.
- **`skills/ops/operations-and-fulfillment-playbook`'s marketplace branch never operationalized
  `marketplace-liquidity-specialist`'s own plan-stage-flagged "most consequential finding"**
  (disintermediation — repeat transactions moving off-platform after the first match) into any
  tracked ops metric (`docs/QA-FINDINGS-OPSFULFILLMENT-ROUND10.md`). **Fixed:** a new "§4
  Disintermediation / off-platform leakage" subsection, explicit about the signal being harder to
  observe directly than the other liquidity metrics, and routed to a business-model/council
  re-review recommendation when material, not just a routine ops note.

**Findings read, understood, and deliberately deferred** (not silently dropped — each is a real,
smaller, or more judgment-dependent item than the ones above):
`docs/QA-FINDINGS-LEGAL-ROUND10.md`'s `risk_log[].id` format divergence from the `ar-`/`ov-` style
(non-blocking per `docs/DATA-CONTRACT.md`'s own note that id format is a readability convention,
not a schema requirement) and its missing entity-formation-status field;
`docs/QA-FINDINGS-PRODUCT-ROUND10.md`'s finding that RICE scoring is structurally unscorable (not
just weak-evidence) for internal-capability roadmap items, and its missing Effort-estimate fallback
for asynchronous execution; `docs/QA-FINDINGS-CUSTOMERSUCCESS-ROUND10.md`'s gap in
`customer-success-lead`'s self-correction section for a business's first-ever health-scoring cycle
(no prior prediction exists yet to check); `docs/QA-FINDINGS-INVESTORRELATIONS-ROUND10.md`'s minor
template gap (the zero-ops-data "don't invent a metric" rule isn't locally restated at the Key
Metrics table); `docs/QA-FINDINGS-COMPETITIVEINTEL-ROUND10.md`'s applicability-scope gap (the
skill silently proceeds when invoked on a pre-operating fixture rather than stating the mismatch
plainly) and its drift-threshold criterion that breaks down when a plan's differentiation spans
both axes at once. `docs/QA-FINDINGS-COUNCIL-ROUND10.md` found no defect at all —
`operational-execution-reviewer`'s trigger logic worked correctly by hand in both a real-fixture
test (correctly did not fire) and a synthetic compound-signal test (correctly fired and correctly
displaced the type-matched seat).

**Round 10 is complete and integrated.** `scripts/validate-plugin.sh` still reports 56 skills, 34
agents, 6 commands, 13 council files, 0 warnings, 0 errors — round 10 deepened existing round-9
files rather than adding new ones, the same "confirmed complete, not just claimed" treatment every
prior round's dry-run pass has gotten since round 2.

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
- **Round 6 confirmed round 5's new category, and then repeated it a second and third time in the
  same round, on two entirely different subsystems — this is now a pattern, not a one-off.** Both
  of round 6's headline findings are unexercised-code-path bugs, not business-type gaps: the
  discarded-outlier revision-routing gap lives in a seam between `revise-business-plan` and
  `run-review-council` that only a real *second* pass through revision (not just a second pass
  through council review) exercises, and the runway-normalization bug lives in a formula that was
  always wrong for any non-monthly cadence but had simply never been run against one, because the
  ops layer had never run live at all before this round. Neither bug involved a business type, an
  industry vertical, or a step template — both were sitting, fully formed, in code every prior round
  had read and judged correct. Read together with round 5's finding, the pattern across rounds 5 and
  6 is now explicit: **the most consequential findings in this build have shifted from "a business
  type or shape the code was never written for" (rounds 2-4, and still present but secondary in round
  5) to "a code path nobody has ever actually executed, however well it reads"** — the revision loop,
  the post-approval GTM/ops layer, and (within round 6 itself) a *second* pass through revision. This
  is worth stating plainly for future rounds: once every DE step and every council persona has real
  business-type coverage (true since round 4), the highest-yield place to look next is not a seventh
  business type, it's the next code path nothing has ever actually walked — see `docs/ROADMAP.md`'s
  framing of round 7 and what stays open after it.
- **Round 7 found the same "unexercised code path" shape a fourth and fifth time, in the exact two
  places round 6's roadmap update named — and then, once found, closed the specific question of
  whether the swarm-dry-run method itself was reaching diminishing returns, rather than leaving that
  question implicit for a future round to notice on its own.** The override-mechanism gap in
  `launch-director` and the DE-step reopening protocol's missing mechanics in the orchestrator are
  both, structurally, the same animal as round 6's two findings: well-specified-looking code that had
  simply never been walked by anything before this round. But round 7's own roadmap update is itself
  worth naming as a pattern, not just a finding about the plugin: for the first time across seven
  rounds, this document made explicit, as a judgment call rather than an implicit drift, that further
  simulated dry runs are hitting diminishing returns for this category of bug, and that a real human's
  multi-session use is the next qualitatively different test this project needs — not a claim that
  simulated dry runs stop being useful, but an explicit statement of when a method that has reliably
  produced real findings for six consecutive rounds should stop being the presumptive next move by
  default. That is a pattern about the swarm's own method, worth watching for in any future project
  built this way: a technique that keeps working is not, by itself, evidence that it's still the
  highest-value technique available, and naming the point where it stops being so is a deliverable in
  its own right, not a failure to keep finding bugs. Round 8, running concurrently with this entry, is
  the swarm's own direct response to that judgment call — see `docs/ROADMAP.md`.

