# QA Dogfood — Round 4: Running the QA Layer for Real

**Method.** Round 1 built `agents/qa/skill-quality-auditor.md`, `agents/qa/consistency-checker.md`,
and `skills/qa/eval-a-skill/SKILL.md`, but until now they'd only ever been spot-checked against
2-3 files at a time. This round applies `skill-quality-auditor`'s per-file checklist by hand to a
representative, budgeted sample — all 10 `agents/council/*` files, all 4 `agents/gtm/*` files, all
5 `agents/ops/*` files, both `agents/risk/*` files, and 6 DE-step skills spread across the range
(06, 09, 13, 17, 20, 23) — plus `agents/qa/*` and `skills/qa/eval-a-skill` themselves, then applies
`consistency-checker`'s cross-file checks across everything touched, plus a repo-wide duplicate-name
sweep (all 27 agents, all 46 skills, full corpus, not sampled) and a cross-reference sweep grepping
every `plan/NN-slug.md`, `skills/...`, and `agents/...` path mentioned anywhere in `agents/**/*.md`
and `skills/**/SKILL.md` against what actually exists on disk. Every file named below was read in
full; every path checked was tested against the actual filesystem, not assumed. Run 2026-08-18.

**Scope correction, stated up front.** The brief assumed "5 GTM agents" and "3 risk-layer agents."
The repo actually has 4 `agents/gtm/*` files (`fundraising-advisor`, `launch-director`,
`marketing-strategist`, `sales-lead`) and 2 `agents/risk/*` files (`ai-risk-analyst`,
`privacy-compliance-officer`). This is not a defect — all four and both were audited in full — it's
a correction to the task's assumed counts; nothing in `docs/ROADMAP.md` suggests a 5th GTM or 3rd
risk agent is planned-but-missing.

**Headline finding, found mid-run.** `CONVENTIONS.md` §5 was edited by a concurrent round-4 agent
*during this session* to fix a real, pre-existing conflict with `docs/DATA-CONTRACT.md`: the old
§5 listed `connectors.json` and `cadence.json` as separate files under `.startup/<slug>/`, while
`DATA-CONTRACT.md` has always defined `connectors` and `cadence` as keys *inside*
`business-state.json`, not standalone files. That fix is good and correct — but it leaves several
operational agents describing a "mirror file" design that no longer matches the corrected contract.
See **Cross-file consistency → Blocking #1** below; this is the single most consequential finding
in this pass.

---

## Council (`agents/council/*`, 10 files, all read in full)

All 10: `competitive-strategy-reviewer`, `customer-discovery-skeptic`, `expert-entrepreneur-panel`,
`financial-modeling-reviewer`, `marketplace-liquidity-specialist`, `product-market-fit-panel`,
`sales-motion-reviewer`, `services-unit-economics-reviewer`, `technical-feasibility-reviewer`,
`vc-panel`.

**PASS on almost everything, at real depth.** Every file: correct location/naming; frontmatter
`name`/`description`/`tools` (`Read, Grep, Glob` — correctly excludes `Write`/`Edit`, since none of
them write) all valid, no unjustified `model:` override anywhere; every `plan/NN-slug.md` and
`business-state.json` field reference checked character-for-character against `docs/DE-24-STEPS.md`
and `docs/DATA-CONTRACT.md` — zero mismatches found across all 10 files' read-lists; single
disclosed-bias statement per file, no stacked hedging, no praise-padding; each commits to the exact
CONVENTIONS §6 verdict schema; all 10 personas are genuinely distinct (far more than the 3-file
minimum `consistency-checker` requires) — no generic "an investor" persona anywhere.

**FLAGGED — systematic, not fixed (agents/council/* is off-limits this round).**

- **Item 3 (concrete deliverables) — body missing an explicit "what you write" statement, all 10
  files.** `skill-quality-auditor`'s checklist is explicit that the body must carry its own write
  statement "even if that statement is a one-line 'writes nothing — reports findings back to the
  caller,'" and that this is a `FAIL` even when the deliverable is implied or stated only in the
  frontmatter. All 10 council files have a `## What you read` section but no equivalent `## What
  you write` (or "writes nothing") sentence in the body — only the frontmatter description says
  "Does not modify plan files or business-state.json itself," and the body's `## Output format`
  section describes the verdict shape without ever stating in words that nothing is written to
  disk. Mitigating context worth noting: the `tools:` field itself (`Read, Grep, Glob`, no
  `Write`/`Edit`) makes the "writes nothing" fact mechanically true and checkable — but per the
  checklist's own reasoning (frontmatter and tools are parsed differently than the body, by
  different audiences), this is a real, repo-wide gap across the entire council layer, not a
  one-off. **Suggested fix for whoever owns `agents/council/*` this round:** one line under `##
  What you read` in each file — "You write nothing to disk; you return your verdict, in the schema
  below, to the calling skill." Mechanical, identical across all 10, low risk.

No other findings in this group — this is the most consistently well-built layer in the repo.

---

## GTM (`agents/gtm/*`, all 4 files, all read in full)

`fundraising-advisor`, `launch-director`, `marketing-strategist`, `sales-lead` — all **PASS**.

Each has explicit `## What you read` and `## What you write` / `## What you write back` sections
in the body (not just frontmatter); every `plan/NN-slug.md`, `gtm.*`, and `quantitative_claims`
reference checked against `docs/DATA-CONTRACT.md` — all valid; every referenced skill
(`skills/gtm/fundraising-deck-prep`, `skills/gtm/launch-plan`, `skills/gtm/positioning-and-messaging`,
`skills/gtm/content-calendar`, `skills/gtm/outbound-sales-playbook`) confirmed to exist on disk;
`docs/CONNECTORS-CATALOG.md` (referenced by all four for the connectors-liaison handoff) confirmed
to exist; single disclaimer statement each, stated once, not stacked; `launch-director`'s pivot
protocol and `fundraising-advisor`'s funding-strategy gate both correctly cross-reference
`agents/orchestrator.md`'s pivot protocol and Non-negotiable #3 by name. No jargon issues — TAM/
LTV/COCA/DMU used freely, correctly presumed DE-literate per the checklist's own carve-out for
`agents/gtm/*`.

No findings.

---

## Ops (`agents/ops/*`, all 5 files, all read in full)

`customer-success-lead`, `finance-controller`, `growth-analyst`, `operations-manager`,
`scaling-strategist` — all **PASS**.

Same standard as GTM: explicit `## What you read` / `## What you write` in every body;
`risk_log[].type: "business"` entries all match the exact schema in `docs/DATA-CONTRACT.md`;
`ops-<slug>-<sequential-number>` id scheme used consistently across all 5 (increment-from-highest
convention stated identically in each); every skill referenced
(`skills/ops/retention-and-churn-analysis`, `runway-and-burn-tracking`, `kpi-dashboard-setup`,
`weekly-metrics-review`, `scaling-readiness-check`) confirmed to exist, and each one's
"business-type dispatch" section (referenced by name from the owning agent) confirmed present.
`operations-manager`'s drift-comparison math (LTV/COCA/TAM vs. plan) is fully worked, sourced, and
consistent with the same thresholds `financial-modeling-reviewer` and `vc-panel` use. `finance-
controller`'s proactive-escalation logic for runway <3 months correctly defers to "whatever
scheduling/trigger capability is available" rather than hardcoding a tool name — good discipline
for an environment-dependent capability. Financial disclaimer stated once, correctly, in
`finance-controller`.

No findings.

---

## Risk (`agents/risk/*`, both files, both read in full)

`ai-risk-analyst`, `privacy-compliance-officer` — both **PASS** on the skill-quality-auditor
checklist in isolation.

Both have unusually strong "How to invoke me — the contract" sections clarifying the relationship
to their calling gate skills (`skills/risk/ai-risk-review`, `skills/risk/privacy-check`); both
state their `risk_log` write discipline (append-only, never self-close `status`) identically to how
every other `risk_log`-writing agent in the repo states it — a good sign of real cross-file
convention-following, not just per-file compliance. `tools: Read, Grep, Glob, Edit` on both is
correctly scoped (Edit for `risk_log` writes, no general Write access, consistent with
`privacy-compliance-officer`'s own explicit "I do not have Write access outside `risk_log`"
statement).

**FLAGGED — see Cross-file consistency → Blocking #1.** Both files (`privacy-compliance-officer`
directly, and its calling skill `skills/risk/privacy-check` and `agents/connectors-liaison.md`
indirectly) reference `connectors.json` as if it's a standalone file on disk. This is a real,
cross-file consistency problem (now stale against the corrected `CONVENTIONS.md`/
`DATA-CONTRACT.md`), not a single-file structural defect — hence why it's not a checklist `FAIL`
in isolation but is the top finding in the consistency pass below.

---

## DE steps sampled (06, 09, 13, 17, 20, 23 — all read in full)

`06-full-life-cycle-use-case`, `09-identify-your-next-10-customers`,
`13-map-the-process-to-acquire-a-paying-customer`, `17-calculate-the-ltv-of-a-customer`,
`20-identify-key-assumptions`, `23-show-that-dogs-will-eat-the-dog-food` — all **PASS**.

All six: frontmatter `name` matches folder exactly; `NN-slug` matches `docs/DE-24-STEPS.md`
character-for-character; explicit `## Reads` and `## Write plan/...` + `## Update
business-state.json` sections in every body; every `plan/NN-slug.md` cross-reference (Step 13
reading Step 12, Step 17 reading Steps 15/16, Step 20 sweeping Steps 1-19, Step 23 reading Step 22,
etc.) resolves to a real file and a real DE-24-STEPS slug; every "business-type branching" section
covers all six `business_basics.business_type` enum values without silently dropping `other`;
`key_assumptions`/`quantitative_claims` entries shown as JSON match the Data Contract schema
exactly, with `step_ref` values in the correct underscore convention.

**Sourced-claim rule, verified precisely.** Steps 17, 09, 20, and 23 all produce numbers that could
land in the plan as fact, and all four correctly instruct a `quantitative_claims` entry with a real
`source`. Cross-checked against `skills/risk/ai-risk-review`'s own binding "Who must call this"
table: exactly five DE steps (04, 14, 16, 17, 19 — confirmed by grepping all 24 step skills for the
mandatory-gate section) are required to call the AI-risk gate on completion, and Step 17 is the only
sampled step among those five — it correctly wires the gate in, with the right PASS/BLOCKED
handling and the right non-override-itself rule. Steps 06, 09, 13, 20, and 23 correctly do **not**
call the gate (they're not on the binding table, even though 09/20/23 do produce
`quantitative_claims` entries) — this is by design, not an oversight, and all five skills are
internally consistent with that design.

No findings — this sample was clean.

---

## QA layer itself (`agents/qa/*`, `skills/qa/eval-a-skill`)

Both `skill-quality-auditor` and `consistency-checker` satisfy their own checklist: both have
explicit body statements of what they read/write ("You do not write files" /
"you do not write the report to disk yourself"), correct `tools: Read, Grep, Glob`, no `model:`
override, single distinct persona-less mandate each. `eval-a-skill` correctly delegates rather than
re-implementing either agent's logic, and its report-format example (fictional file names
`agents/gtm/launch-planner.md`, `skills/gtm/launch-brief/SKILL.md`) is a normal illustrative
template, not a broken reference — reviewed and confirmed not a defect.

**FIXED — `agents/qa/consistency-checker.md`, §4 "Paths outside the CONVENTIONS §1 layout."**
This section's own reference list of the expected `agents/` subfolder set and `.startup/<slug>/`
sub-structure had drifted from the current repo and the just-corrected `CONVENTIONS.md`:
- It listed `connectors/` as a named `agents/` subfolder. No such folder exists — `connectors-liaison.md`
  is a singleton file directly under `agents/` (confirmed on disk and now stated explicitly in
  `CONVENTIONS.md` §1).
- It was missing `design/`, which does exist (`agents/design/brand-designer.md`) and is now listed
  in `CONVENTIONS.md` §1.
- It listed `connectors.json` and `cadence.json` as expected files under `.startup/<slug>/` — per
  the corrected `CONVENTIONS.md` §5 and `docs/DATA-CONTRACT.md` (which never described them as
  separate files), these are `connectors`/`cadence` keys *inside* `business-state.json`.

This is exactly the kind of small, unambiguous, mechanical fix the audit's scope discipline permits
directly in a QA agent file: it doesn't touch `agents/council/*`, `CONVENTIONS.md`, or
`DATA-CONTRACT.md`, and it corrects the checker's own reference data to match the (already-updated)
source of truth rather than making a judgment call about what that truth should be. Fixed to list
the current subfolder set correctly, note the singleton-agent pattern, drop the stale file names,
and explicitly instruct that a lingering `connectors.json`/`cadence.json` file reference elsewhere
in the repo is itself a finding under this check — which is exactly what surfaced Blocking #1 below.

---

## Cross-file consistency (consistency-checker's checks, applied by hand)

### Blocking

**1. [Broken/stale reference] Several operational files describe `connectors.json`/`cadence.json`
as standalone mirror files on disk — a design `CONVENTIONS.md` §5 no longer describes (and
`docs/DATA-CONTRACT.md` never described).**

Files, with what they say:
- `agents/connectors-liaison.md:186-188` — "If the working directory layout's `connectors.json`
  mirror doesn't exist yet, create/update it... matching how `cadence.json` mirrors
  `business-state.json.cadence...`" — this describes *actively creating and maintaining* two files
  that, per the current Data Contract, should not exist at all.
- `agents/orchestrator.md:276` — "mirror it into `cadence.json`."
- `agents/risk/privacy-compliance-officer.md:145,238,245` — treats `connectors.json` as a real,
  checkable file distinct from `business-state.json.connectors` ("Confirm `connectors.json` /
  `business-state.json.connectors.wired_up` shows...").
- `skills/risk/privacy-check/SKILL.md`, `docs/PRIVACY-AND-DATA-HANDLING.md`, `docs/ARCHITECTURE.md`
  — also reference `connectors.json` (not individually re-quoted here; same pattern).

Evidence this is now genuinely stale, not just an alternate phrasing: `CONVENTIONS.md` §5 (current,
mid-session edit) states explicitly, "Connector status and check-in cadence live INSIDE this file,
as its own `connectors` and `cadence` top-level keys — there is no separate connectors.json or
cadence.json on disk." `docs/DATA-CONTRACT.md`'s top-level shape has always defined `connectors`
and `cadence` as JSON keys, never as filenames.

**Fix:** whoever is doing the `connectors.json`/`cadence.json` consolidation (a concurrent round-4
agent appears to be mid-way through it — they already fixed `CONVENTIONS.md` §5 during this
session) needs to also update `agents/connectors-liaison.md` (stop describing mirror-file creation),
`agents/orchestrator.md` (drop the `cadence.json` mirror step), `agents/risk/privacy-compliance-
officer.md` (check `business-state.json.connectors` only), and the two docs. **Not fixed here** —
this spans files well outside this round's assigned scope (orchestrator, connectors-liaison,
privacy-compliance-officer, two docs) and is clearly mid-refactor by another concurrent agent;
editing it now risks a direct collision with that in-flight work. Flagging with full file:line
detail so whoever owns that refactor can close it out completely rather than leaving
`CONVENTIONS.md` as the only place it's actually been fixed.

### Advisory

**2. [Missing body statement, all 10 `agents/council/*` files]** — see Council section above.
Not blocking (the `tools:` field already makes "writes nothing" mechanically true, and the
`## Output format` section fully documents what's returned), but a real, repo-wide gap against
`skill-quality-auditor`'s own explicit checklist language. Same fix applies to all 10 identically —
worth doing in one pass by whoever owns `agents/council/*` this round.

### Field-ownership, duplicate-name, and panel-completeness checks

- **Field ownership**: no conflicts found. `business_basics` (owned by `onboarding-interview`),
  `gtm.*` (owned by `launch-director`, with the one explicit, correctly-documented exception that
  `run-review-council` may *infer* a funding track for weighting purposes but is explicitly
  forbidden from writing `gtm.funding_strategy` itself — checked and confirmed in
  `skills/business-plan/run-review-council/SKILL.md` §9), `ops.*` (owned by `operations-manager`),
  and `risk_log[]` (appended by `ai-risk-analyst`, `privacy-compliance-officer`, and all 5 `ops/*`
  agents, all using compatible `{id, type, raised_by, description, status}` shapes with consistent
  `type` values against the Data Contract's enum) all check out.
- **Duplicate names**: repo-wide, not sampled — zero duplicates across all 27 `agents/*.md` frontmatter
  `name:` values and all 46 `skills/*/SKILL.md` frontmatter `name:` values. Zero folder/`name:`
  mismatches across all 46 skills.
- **Broken read/write chains**: every `plan/NN-slug.md` reference found anywhere in `agents/**/*.md`
  or `skills/**/SKILL.md` (26 distinct paths swept via full-corpus grep) matches
  `docs/DE-24-STEPS.md`'s canonical slugs exactly — zero silent mismatches (the one near-miss,
  `plan/09-identify-next-10-customers.md`, turned out to be `consistency-checker.md`'s own
  illustrative example of what a broken chain would look like, not a real reference — confirmed by
  reading it in context).
- **Orphaned cross-references**: every `skills/...` and `agents/...` path referenced across the
  audited files (70 distinct path-shaped strings swept) resolves to a real file or directory, with
  the exceptions already accounted for above (fictional example paths in `eval-a-skill`'s template,
  and `/mnt/skills/public/pptx/SKILL.md`, which is the global Claude Skill mount, not a repo path).
- **Review-council panel completeness**: 10 distinct, genuinely different personas in
  `agents/council/*` — comfortably above the 3-file minimum. `skills/business-plan/run-review-
  council/SKILL.md`'s seat-selection logic (read in full) was cross-checked against `docs/DATA-
  CONTRACT.md`'s "Council persona coverage by business_type" table and matches it exactly —
  `marketplace-liquidity-specialist` and `services-unit-economics-reviewer` are the two type-matched
  contextual seats, `technical-feasibility-reviewer` is content-triggered and outranks both per the
  documented tie-break rule, and `saas`/`consumer_app`/`other` remain the documented open gap in
  both places consistently.
- **Layout drift**: one real finding, already fixed — see "QA layer itself" above
  (`consistency-checker.md`'s own §4 reference list had drifted).

### Coverage note

This pass covered: all 10 `agents/council/*`, all 4 `agents/gtm/*`, all 5 `agents/ops/*`, both
`agents/risk/*`, 6 of 24 DE-step skills (06, 09, 13, 17, 20, 23), both `agents/qa/*`,
`skills/qa/eval-a-skill`, `skills/business-plan/run-review-council` (read in full for the
seat-selection cross-check), and `agents/orchestrator.md`'s Delegation Map section — 29 files read
in full. The duplicate-name sweep and the path-existence sweep covered the **entire** corpus (all
27 agents, all 46 skills), not just the sampled set, since both are cheap to run exhaustively with
`grep`/`find` and sampling them would defeat the point. The remaining 18 DE-step skills and their
own `plan/NN-slug.md` writers were not individually re-audited this round; nothing in the sampled 6
suggests a systemic problem there, but that's an inference from a representative sample, not a
claim of full coverage.

---

## Honest assessment: did the checklists hold up?

**Yes, largely — and the two most valuable findings this pass produced (the council write-statement
gap, and the `connectors.json`/`cadence.json` staleness) were found *because* the checklists were
specific and mechanical enough to apply literally, not because of open-ended reading.**
`skill-quality-auditor`'s item 3 ("even if that statement is a one-line 'writes nothing'... its
absence from the body is a FAIL even if implied") is exactly specific enough that running it against
all 10 council files in sequence surfaced the same gap 10 times in a row — a pattern invisible to
the 2-3-file spot-checks this layer had only ever gotten before. Same story for
`consistency-checker`'s §4 path-layout check: applying it to its own file caught the checker's
reference data drifting out from under a live doc edit happening in the same session.

**Where the checklists showed real strain at this scale:**

1. **`skill-quality-auditor` has no mechanism for "this file is correct, but the shared convention
   it depends on just changed underneath it."** The council write-statement gap and the
   connectors.json staleness are both, at bottom, the same failure shape: a file was correct when
   written, and a shared contract it depends on (implicitly, via convention-following, not via a
   direct citation) moved. Auditing one file in isolation against `CONVENTIONS.md` and
   `DATA-CONTRACT.md` — as the checklist instructs — can't catch that a *sibling* file's design
   assumption is now stale; that only showed up here because this pass happened to run during a
   live edit to `CONVENTIONS.md` by another agent. At the scale this repo is heading toward (the
   task brief cites "hundreds of agents, thousands of skills"), a shared-contract change like the
   connectors.json fix will keep silently orphaning dependent files unless something greps the
   corpus for the old pattern at the moment the contract changes — neither QA agent currently does
   this, and it's arguably the single highest-value addition either could get. **Not added this
   round** — it would be a real design addition (something like "when auditing a file, also grep the
   corpus for any other file asserting the same fact-about-shared-state and flag disagreement"),
   which is squarely the kind of judgment call this round's scope discipline says to flag rather
   than freelance into `consistency-checker.md`.
2. **`skill-quality-auditor`'s item 3 write-statement rule is binary in a way that slightly
   undersells its own reasoning.** All 10 council files have a `tools:` field that omits `Write`/
   `Edit` entirely — which is a *stronger*, more mechanically-checkable guarantee of "writes
   nothing" than a body sentence would be, yet the checklist treats the missing sentence as a full
   `FAIL` regardless. The checklist's own stated reasoning (frontmatter/tools are parsed differently
   than the body, by different audiences) is sound in the abstract, but in this specific case the
   `tools:` field *is* machine-parseable in exactly the way the checklist wants the body statement
   to be. This is a minor tightening opportunity, not a design flaw — the fix is a body sentence,
   not a checklist change — but a future editor of `skill-quality-auditor.md` could reasonably add
   one clause: "if `tools:` omits both `Write` and `Edit`, a missing body write-statement is still a
   FAIL, but note in the fix that the tools field already proves the behavior — the fix is
   documentation, not a behavior change." **Not changed this round** — genuinely a judgment call
   about the checklist's own precision, not a mechanical correction, so it's logged here rather than
   edited.
3. **Sampling worked, but only because this round pre-selected files known to be recently-touched
   or high-stakes.** The 6 sampled DE steps (06, 09, 13, 17, 20, 23) all passed cleanly, which is a
   genuinely good sign — but it's also six files that happened to already be some of the most
   carefully cross-referenced in the repo (17 wires the mandatory AI-risk gate; 09/20/23 are
   explicitly named as reality-check/audit steps in Aulet's own framework, which seems to have made
   their authors more careful). A sample chosen this way is representative of "the steps builders
   were told to be careful about," not necessarily of the 18 unsampled steps — worth noting plainly
   rather than letting a clean sample imply a clean full set.

**Bottom line:** the QA layer's checklists are genuinely load-bearing at this scale — this pass
would have taken much longer and found much less without them, and the two real, high-value
findings above were both direct products of applying the checklists literally rather than skimming.
The gap isn't in the checklists' rigor, it's in their scope: both are explicitly single-file or
single-pass tools by design (`skill-quality-auditor` audits one file; `consistency-checker` compares
a set at one point in time), and neither is built to catch a shared-contract file changing *during*
the audit and silently orphaning files the audit already passed or hasn't reached yet. That's a real
gap worth a future round's attention, but it's a scope gap, not a correctness bug in what each tool
already checks.
