# Master Index — after Round 11

**Naming note:** this plugin was renamed from "30-Minute Startup" to "AI EIR (Entrepreneur in
Residence)" in round 11 — references to rounds 1-10 below keep the original name for historical
accuracy (see `docs/CHANGELOG.md`'s own naming note).

Full catalog of every agent, skill, and command in the plugin after round 1 (v0.1 build, 15
parallel builders), round 2 (adversarial review + fix pass, 9 parallel reviewers plus a live
end-to-end dry run — see `docs/QA-FINDINGS-ROUND2.md` and `docs/QA-FINDINGS-GATES-ROUND2.md`),
round 3 (deepening business-type branching to all 24 steps, 2 new council personas, CI/validation
hardening, ops instrumentation across all 5 ops skills, a connectors audit, and a second live dry
run against a marketplace business — see `docs/QA-FINDINGS-ROUND3.md` and
`docs/QA-FINDINGS-CONNECTORS-ROUND3.md`), round 4 (2 more council personas closing the last
persona-coverage gap, a third live dry run against a services business, a `CONVENTIONS.md`
staleness audit that closed a cross-cutting `connectors.json`/`cadence.json` drift across 7 files,
a first full-repo QA-tooling dogfood pass, and a first Layer 2 eval-suite seed — see
`docs/QA-FINDINGS-ROUND4.md` and `docs/QA-DOGFOOD-ROUND4.md`), round 5 (the council
write-statement mechanical fix closing round 4's last flagged dogfood gap, a fourth live dry run
against a `consumer_app` business, and the first real execution of `docs/TESTING.md`'s Layer 3
regression checklist — which found and fixed a genuine, previously-uncaught bug in
`revise-business-plan`'s stage-transition logic — see `docs/QA-FINDINGS-ROUND5.md` and
`docs/QA-LAYER3-REGRESSION-ROUND5.md`), round 6 (the first completed revision cycle, driven
live against `shiftcover`'s standing REVISE verdict — confirming round 5's fix holds and finding a
real revision-routing gap of its own — and the first live GTM/ops/check-in run, driven against
`vantage-point-search`'s standing `approved` stage — finding a real 2-4.3x runway-overstatement bug
and a real connectors-gate scope ambiguity — see `docs/QA-FINDINGS-ROUND6.md` and
`docs/QA-FINDINGS-POSTAPPROVAL-ROUND6.md`), and round 7 (the first live exercise of the
founder-override mechanism, driven against `shiftcover`'s standing REJECT verdict — finding a real
silent-failure risk in `launch-director`'s override detection — and the first live second recurring
check-in cycle plus a real mid-lifecycle pivot, driven against `vantage-point-search` — finding the
DE-step reopening protocol was a single unspecified sentence with no real mechanics — see
`docs/QA-FINDINGS-OVERRIDE-ROUND7.md` and `docs/QA-FINDINGS-PIVOT-ROUND7.md`, both now landed and
resolved), round 8 (a findings-backlog sweep re-auditing all 34 deferred items across seven prior
rounds' findings documents against current file state — see `docs/QA-BACKLOG-SWEEP-ROUND8.md` — and
real-use-readiness polish to `README.md`, `plugin.json`, and `onboarding-interview`, run instead of
an eighth simulated dry run per `docs/ROADMAP.md`'s own diminishing-returns finding), and round 9 (a
direct human instruction, not a swarm-self-directed continuation — 10 parallel functional-specialist
"expert entrepreneur" agents building product, legal, HR, customer success, growth/CRO, pricing,
fundraising/IR, operations/fulfillment, and competitive-intelligence skills/agents plus a new
13th council persona `operational-execution-reviewer`, and a new `skills/autonomous-continuation` +
`/continue-business` pair giving the plugin a genuine, disciplined unattended-firing entry point for
a scheduled Routine), and round 10 (a live dry-run validation of every round-9 skill — 11 parallel
agents, each on a disposable copy of a canonical fixture, live-executing one round-9 skill/agent/
persona as literal instructions against real data; found and fixed 6 real gaps including a
single-axis stage-gate bug independently confirmed by 3 test agents across 5 skills, and confirmed
the new council persona's trigger logic works correctly with no defect found — see
`docs/QA-FINDINGS-*-ROUND10.md` and `docs/CHANGELOG.md`'s round 10 entry). **Round 10 is complete
and integrated** — every count and claim below was re-walked directly against the repo (`find`,
targeted `grep`, and a live run of `scripts/validate-plugin.sh`) while writing this revision, not
carried forward from the prior snapshot. Round 10 deepened round 9's own files rather than adding
new ones, so the skill/agent/command/council-file totals below are unchanged from the round-9
snapshot. `/list-skills` gives a live, always-current view for day-to-day use between
regenerations.

**Live validation output at the time of this revision:**
`PASS — no structural drift from CONVENTIONS.md detected` — **56 skills, 34 agents, 6 commands, 13
council files checked, 0 warnings, 0 errors**, all 24 DE step folders matching
`docs/DE-24-STEPS.md`, every referenced `business-state.json` top-level field matching
`docs/DATA-CONTRACT.md`, and every `agents/council/*.md` file committing to the CONVENTIONS.md §6
verdict schema.

## Entry points (`commands/`)

| Command | Purpose |
|---|---|
| `/start-business` | Begin a brand-new business — delegates to `startup-operator` to bootstrap `.startup/<slug>/` and start onboarding. |
| `/business-status` | Resume an existing business by slug/name — re-reads state, reports status, continues where it left off. |
| `/check-in` | Manually trigger a recurring check-in outside the automatic cadence — assumes a live founder present to answer. |
| `/continue-business` | **New, round 9.** The unattended counterpart to `/check-in`/`/business-status` — the command a scheduled Routine should target. Delegates to `skills/autonomous-continuation`; never asks a question it expects an immediate live answer to. |
| `/run-council` | Manually invoke a review council against the current plan for a gut-check, outside the normal approval flow. |
| `/list-skills` | Live enumeration of every skill/agent in the plugin, grouped by category. |

## The central agent

**`startup-operator`** (`agents/orchestrator.md`) — the one agent founders mostly talk to. Owns
the full lifecycle state machine (`stage` field in `business-state.json`): interview → 24 DE
steps → plan assembly → council review/revision loop → GTM → ops → recurring check-ins. Never
does specialist work itself; interviews, sequences, delegates, and enforces that a REVISE/REJECT
verdict blocks progress unless resolved or explicitly founder-overridden. Round 2 fixed a
step-status ambiguity here: no DE step's `status` is ever promoted past `"drafted"` by anything in
the plugin — `"approved"` is a whole-plan stage-machine state, not a per-step status. Round 3's
marketplace dry run independently re-confirmed this fix holds and, separately, found the identical
vacuous-status bug pattern recurring in the review council's own seat-selection logic (see below) —
now fixed there too. Round 7's first live founder-override run found the state-machine diagram's
override branch was backwards (looping back through another council re-run instead of going straight
to `approved`) — **fixed**, and confirmed correct by the same run. The same round's pivot dry run
found Phase 6's DE-step-reopening protocol was a single unspecified sentence; **fixed** with a real
"Reopening a subset of DE steps after a pivot" procedure (which steps revert to `not_started`, which
get a `NEEDS RE-CONFIRMATION:` summary flag instead, and a cheap pre-reassembly skim-check) — see the
round 7 section below.

## Interview (`skills/interview/`)

| Skill | Purpose |
|---|---|
| `onboarding-interview` | First conversation with a new founder — captures identity/basics, classifies business type, sets honest depth/time expectations, pushes back on vague answers. Round 2 wired the mandatory AI-risk gate in here too; round 3's marketplace dry run ran it live and confirmed the privacy-notice call fires correctly. |
| `recurring-check-in` | Conversational shape of every check-in after launch — asks for real founder-reported numbers, walks open risks/assumptions, confirms next cadence. Round 7's second-check-in-cycle dry run found this skill anticipated a pivot signal surfacing in its own Phase 2 conversation but gave its executor no instruction for what to do next, despite `docs/DATA-CONTRACT.md` explicitly naming this skill as the one that hands a pivot to the orchestrator — **fixed**, Phase 2 now names the handoff explicitly. |

Design rationale for both: `docs/UX-INTERVIEW-DESIGN.md`.

## Autonomous continuation (`skills/autonomous-continuation/`) — new, round 9

A singleton skill living directly under `skills/` (same pattern `agents/business-plan-editor.md` and
`agents/connectors-liaison.md` already use under `agents/`), invoked by `/continue-business` rather
than a category directory. This is the entry point for a **scheduled Routine/cron firing with no live
founder necessarily present** — distinct in kind from both interview skills above, which assume a live
conversation. Classifies the current stage's next action into autonomous-safe (do it — a metrics
snapshot, a retro, drafting an artifact from data already on disk) / founder-required (list it, never
fabricate it) / gated-never-cross-unattended (a council override, a real launch, a connector spend —
these require a founder physically present per `agents/orchestrator.md`'s Non-negotiables regardless of
how confident an autonomous read is). Produces a single scannable async digest rather than an interview
nobody's there to answer, and reschedules the next firing itself. `agents/orchestrator.md`'s own
self-scheduling logic now points a scheduled firing's prompt here specifically, not at a generic resume
command. See `README.md`'s "Setting up a fully automated recurring routine" for the user-facing setup
instructions this enables.

## Disciplined Entrepreneurship — the 24 steps (`skills/disciplined-entrepreneurship/`)

One skill per step of Bill Aulet's framework, each producing `plan/NN-slug.md` plus a
`disciplined_entrepreneurship.NN_slug_key` entry in `business-state.json`. See
`docs/DE-24-STEPS.md` for the canonical list and `docs/DATA-CONTRACT.md` for the state-key
convention. Six themes:

1. **Who is your customer?** (01–05) market-segmentation, select-a-beachhead-market,
   build-an-end-user-profile, calculate-the-tam-for-the-beachhead-market,
   profile-the-persona-for-the-beachhead-market
2. **What can you do for your customer?** (06–08) full-life-cycle-use-case,
   high-level-product-specification, quantify-the-value-proposition
3. **How does your customer acquire your product?** (09–13) identify-your-next-10-customers,
   define-your-core, chart-your-competitive-position, determine-the-dmu,
   map-the-process-to-acquire-a-paying-customer
4. **How do you make money off your product?** (14–19) calculate-the-tam-for-follow-on-markets,
   design-a-business-model, set-your-pricing-framework, calculate-the-ltv-of-a-customer,
   map-the-sales-process-to-acquire-a-customer, calculate-the-coca
5. **How do you design and build your product?** (20–22) identify-key-assumptions,
   test-key-assumptions, define-the-mvbp
6. **How do you scale your business?** (23–24) show-that-dogs-will-eat-the-dog-food,
   develop-a-product-plan

**Business-type branching: complete across all 24 steps for `marketplace` and `services`; complete
for `consumer_app` in 21 of 24 (Steps 1, 2, and 4 closed a real gap this round), confirmed by
reading section content, not just a heading grep.** Steps `01`–`14`, `17`, `18`, `20`, `21`, `23`,
and `24` carry a literal `## Business-type branching` heading; steps `15`, `16`, `19`, and `22`
carry the same real, developed per-type content under a differently-worded heading each step's own
author chose (`## Business-type starting points`, `## Business-type cost drivers`, `## Business-type
MVBP shapes`) — all confirmed to give `marketplace`, `services`, and `consumer_app` genuinely
distinct treatment, not a reskinned SaaS paragraph. Round 3's marketplace dry run (`docs/QA-
FINDINGS-ROUND3.md`) found and that round's fixes closed two real cross-step gaps here: steps `17`
and `18` had zero marketplace branching (now fixed — step 17 requires per-side LTV with an explicit
no-comparable-LTV note where relevant; step 18 requires costing both sides' funnels separately),
and step `4`'s beachhead-TAM sanity-check heuristic didn't distinguish GMV from take-rate revenue
for a marketplace (now fixed with an explicit GMV-vs-take-rate clause). **Round 5's consumer_app dry
run (`docs/QA-FINDINGS-ROUND5.md`) found the identical gap-class recurring for a fourth business
type, and it was load-bearing**: step 4's formula (price × purchase frequency) had no answer for a
freemium consumer app, producing a real, demonstrated ~20x-overstated naive TAM with nothing
downstream to catch it — a blocking finding, since step 4 is one of the five AI-risk-gated steps.
**Fixed**: step 4 now has an explicit `**Consumer app:**` branch instructing the blended
ad-plus-subscription method as the number of record; step 2 gained a generic B2C fallback question
(step 1 already had a thinner, generic B2C interview question that round 5 judged workable, if
worth revisiting). Steps `04`, `14`, `16`, `17`, and `19` additionally each carry a `## Mandatory
AI-risk gate` section (a round 2 fix, confirmed working live — not just present — by round 3's,
round 4's, and round 5's dry runs, each of which triggered at least one real BLOCKED→fix→PASS cycle,
four rounds running) that blocks `status: "drafted"` until every fact-claim they produce is sourced.
Step 19 additionally now carries a standing "round explicitly before writing the headline figure"
reminder (round 5), added after the AI-risk gate's false-precision catch landed at this exact step
in three of the four rounds' dry runs.

## Business plan (`skills/business-plan/`, `agents/business-plan-editor.md`)

| File | Purpose |
|---|---|
| `assemble-business-plan` | Synthesizes all 24 step files into one investor-ready `plan/business-plan.md` — reconciles steps 13+18, TAM(4) vs TAM(14), LTV(17):COCA(19); calls the mandatory AI-risk gate and checks for the required Confidence & Validation Status section before considering assembly done (round 2 fix, confirmed live by round 3's dry run — it correctly BLOCKED on a genuinely unsourced step-23 claim, then PASSED after the fix). |
| `revise-business-plan` | Routes a council's required revisions back to the owning step or a synthesis fix, produces the next plan version with an itemized changelog. Round 5's first real Layer 3 regression pass found a genuine, previously-uncaught bug here: this skill instructed writing `stage = "council_review"` once revision work finished, a value `run-review-council`'s own precondition never reads or expects and would reject outright — no fixture had ever driven a revision cycle far enough to hit this seam, so it had survived undetected. **Fixed**: the skill now leaves `stage` at `"revising"`, matching what `run-review-council` and `agents/orchestrator.md` both already expected. Unverified by a live run as of this revision — round 6's shiftcover revision cycle is the first live test of the fix. |
| `business-plan-editor` (agent) | The actual drafting/editing voice both skills delegate to — precise, quantified, refuses cosmetic-only revisions. States the Confidence & Validation Status section as mandatory on every canonical plan and revision. |

## Review councils (`agents/council/`, `skills/business-plan/run-review-council/`)

**13 distinct reviewer personas**, confirmed by direct directory listing and by
`scripts/validate-plugin.sh`'s own live count — a fixed 4-seat core plus one contextual 5th seat
chosen by priority rules (business type, or the plan's own content), convened as a
strategy-weighted panel (funding-track aware: bootstrap vs. venture vs. undecided), aggregated by
the "harshest non-outlier verdict" rule (round 2 hardened this computation's edge cases; round 3's
dry run exercised it by hand a second time, hit a genuinely different worked case — a lone REJECT
surviving the outlier test via cross-severity tag corroboration — and found (then fixed) a gap
where that survivor's own findings could still be absent from the severity-gated Required Revisions
checklist; round 4's dry run hit a third, distinct shape of the same underlying "aggregation layer
can under-surface a real concern" family — a syntactic tag-overlap check missing a semantically
real corroboration, and an undefined checklist heading when the aggregate is `APPROVE_WITH_NOTES` —
both now fixed):

`vc-panel` · `expert-entrepreneur-panel` · `customer-discovery-skeptic` ·
`product-market-fit-panel` · `financial-modeling-reviewer` · `competitive-strategy-reviewer` ·
`sales-motion-reviewer` · `technical-feasibility-reviewer` · `marketplace-liquidity-specialist` ·
`services-unit-economics-reviewer` · `hardware-physical-product-operator` ·
`regulated-industry-compliance-reviewer` · `operational-execution-reviewer` (round 9)

**`operational-execution-reviewer` (round 9)** is the newest contextual-seat candidate — an ex-COO
lens asking not whether the strategy is sound (every other seat's territory) but whether *this
specific team, at this size,* can actually execute it: summing Steps 13/18/22's concurrent
operational load against a realistic weekly-hours ceiling and checking for a credible first-90-days
operating sequence. Slotted into `run-review-council/SKILL.md` §3 at priority tier #3 (below the
regulated-industry and technical-feasibility triggers, above the business-type-match tier), gated on
a demanding **two-of-three** independent execution-complexity signal specifically so the existing
type-matched seats stay unconditional for the ordinary single-axis case — see
`docs/DATA-CONTRACT.md`'s persona-coverage table and `docs/CHANGELOG.md`'s round 9 entry for the full
trigger and placement reasoning.

`run-review-council` decides which seats convene and how they're weighted for a given business,
calls the AI-risk gate before and after the panel, and writes the aggregate verdict to `reviews/`.
Every persona's own body now states explicitly, under an added "## What you write" section, that it
writes nothing to disk and returns its verdict to the calling skill instead (round 5's mechanical
fix, confirmed landed by a direct case-insensitive grep across all 12 files — this closes the one
gap round 4's QA dogfood pass flagged as systemic but explicitly out of that round's own scope).
Round 5's fourth live dry run (`docs/QA-FINDINGS-ROUND5.md`, **Kindling**, a `consumer_app`
business) also found and fixed a real gap in this layer: `competitive-strategy-reviewer`'s
"Calibrate by business type" section had no `consumer_app` bullet, discovered by hand-working the
seat-selection logic against a real fixture where `product-market-fit-panel`'s own trigger — meant
to be the most load-bearing seat for exactly this business type — did not fire, because the
business's real weak points clustered in unit economics and Core rather than the PMF-range steps
the trigger counts. **Fixed**: a `consumer_app` calibration bullet was added; a genuinely dedicated
`consumer_app` contextual persona remains an open, future-round question per
`docs/DATA-CONTRACT.md`'s coverage table.

**The marketplace and services personas are a confirmed, working fix, not a checkbox.** Round 3's
marketplace dry run compared `marketplace-liquidity-specialist`'s verdict against what the persona
it replaced (`competitive-strategy-reviewer`) would have produced for the same plan, and found the
new persona surfaced a real, consequential finding (disintermediation risk) no other panelist
raised in any form. Round 4's services dry run ran the identical comparison for
`services-unit-economics-reviewer` and found the same result — two `[DELIVERY-CAPACITY]` findings
(a capacity-ceiling arithmetic inconsistency; an uncounted guarantee cost folded out of the margin
figures) that no other seat's rubric owns.

**A real bug found and fixed in the seat-selection logic itself.** Round 3's dry run found the
§3 trigger rules for `competitive-strategy-reviewer` (the default 5th seat) and
`product-market-fit-panel` each carried a clause keyed to Steps 10/11 reaching `status: "approved"`
— which, per the orchestrator's own design (see above), never happens for any business, ever,
making the clause unconditionally true and silently overriding two other legitimately-firing
triggers for every business type other than `marketplace`/`services`. This is the same bug class
round 2 found in the orchestrator, independently present here, and confirmed to have survived a
full round-3 rewrite of the surrounding section untouched. **Fixed**: both clauses now key off a
real, variable content signal (low-confidence `key_assumptions` on steps 10/11, or an explicit
no-differentiated-Core finding) instead of a status value that can never actually vary. Round 4's
dry run re-ran the current (by-then substantially rewritten, two-tiers-larger) seat-selection logic
against a services business and confirmed this fix still holds — the rewrite around the two new
personas did not regress it.

**The two newest personas closed the last gap in `docs/DATA-CONTRACT.md`'s persona-coverage
table.** `regulated-industry-compliance-reviewer` is a content-signal trigger (not tied to any
single `business_type` value) checked with the highest priority of any contextual seat — ahead of
`technical-feasibility-reviewer` — for a health/fintech/regulated-activity signal in
`business_basics.business_type_notes` or Steps 1/7/15. `hardware-physical-product-operator` is the
unconditional dedicated seat for `physical_product`. Round 4's services dry run exercised the new,
highest-priority trigger live for the first time on a real fixture and found (then fixed) a real
false-positive risk: a literal keyword match (e.g. "licensed," "HIPAA") fired regardless of whether
the matched text described the business's own pursued activity or a surveyed-and-rejected
candidate/segment, or even a sentence explicitly *denying* the regulated attribute. The trigger
spec now requires the match to describe "the business's own actual or pursued activity."

## Go-to-market (`agents/gtm/`, `skills/gtm/`)

`launch-director` (coordinator) → `marketing-strategist`, `sales-lead`, `fundraising-advisor`
(gated on `gtm.funding_strategy`). Skills: `launch-plan`, `positioning-and-messaging`,
`content-calendar`, `outbound-sales-playbook`, `fundraising-deck-prep` (builds the actual
`.pptx` via the built-in `pptx` skill). Round 7's founder-override dry run found `launch-director`
would have silently proceeded as if an overridden REJECT/REVISE plan had cleared review cleanly — its
Gate check read only `stage`, and its `risk_log` read was scoped to "anything open," which by
construction excludes the `accepted`-status entries a founder override produces. **Fixed:** the Gate
now re-reads the most recent `reviews[]` verdict whenever `stage` is `approved`, detects an override
via the review file's mark and matching `accepted` entries, and states it plainly before any
sequencing work. The same round's pivot dry run found the existing "mid-GTM pivot" section had no
coverage for a pivot signal firing *after* launch (`gtm.status: "launched"`) — **fixed** with an
explicit post-launch clause (already-shipped artifacts get flagged as targeting the pre-pivot band,
not assumed immune). See the round 7 section below for both.

**Round 9** added `skills/gtm/investor-updates-and-cap-table-basics` — the ongoing-IR sequel to
`fundraising-deck-prep` (which builds the first pitch deck; this skill covers the recurring investor
update and cap-table literacy once a raise is active), and appended a pointer to it at the end of
`agents/gtm/fundraising-advisor.md` without touching that file's existing pre-close mandate.

## Product (`agents/product/`, `skills/product/`) — new category, round 9

The plugin's first dedicated product-management coverage, closing a real gap DE steps 6-8/22/24 never
owned past initial spec — ongoing roadmap and prioritization once a business is `operating`.
`product-lead` (`agents/product/product-lead.md`) owns `skills/product/roadmap-and-prioritization`
(RICE-scored roadmap items sourced from real churn/support/funnel data, tagged Core-vs-Context and
beachhead-aligned-vs-off-segment against the plan's actual DE steps 3/5/10) and periodically checks the
shipped product against the plan's stated Core/beachhead/value-proposition for drift, flagging it via
`risk_log` rather than rewriting plan files itself. Output: `ops/product-roadmap-<timestamp>.md`,
pointed to by the new `ops.last_roadmap_file` field in `docs/DATA-CONTRACT.md`.

## Operations (`agents/ops/`, `skills/ops/`)

`operations-manager` (coordinator, runs plan-vs-actual drift checks) → `growth-analyst`,
`finance-controller` (proactive runway escalation), `customer-success-lead`,
`scaling-strategist`, and — new, round 9 — `people-lead`, `pricing-strategist`,
`competitive-intelligence-lead`. Skills: `weekly-metrics-review`, `kpi-dashboard-setup`,
`runway-and-burn-tracking`, `retention-and-churn-analysis`, `scaling-readiness-check`, and — new,
round 9 — `hiring-and-org-design`, `customer-success-playbook`, `experimentation-and-optimization`,
`pricing-and-monetization-optimization`, `operations-and-fulfillment-playbook`,
`competitive-intelligence-monitoring`.

**Business-type instrumentation: complete across all 5 original ops skills**, confirmed by direct
inspection — every one of `kpi-dashboard-setup`, `weekly-metrics-review`, `retention-and-churn-
analysis`, `runway-and-burn-tracking`, and `scaling-readiness-check` now reads
`business_basics.business_type` and dispatches its metric/KPI set accordingly (this closes the gap
this file previously tracked, where only `kpi-dashboard-setup` had it as of the round-3 snapshot).

**Round 9's six new ops skills, each an "optimization agent" or advanced-expert playbook in a
functional area the plugin had no dedicated coverage for before this round:**
- `hiring-and-org-design` (+ `people-lead`) — runway-gated should-we-hire decision (cross-references
  `runway-and-burn-tracking` directly), per-`business_basics.business_type` first-hire sequencing,
  comp/equity bands tied to `funding_intent`, a concrete job-description + scorecard deliverable.
- `customer-success-playbook` (appended to existing `customer-success-lead`) — health-scoring
  framework (green/yellow/red, founder-set thresholds from real known-good/bad accounts), per-type
  onboarding definitions, expansion motion gated to the plan's real pricing tiers, a save-play
  escalation path into `retention-and-churn-analysis`, and a self-correcting practice comparing the
  health model's predictions against real outcomes.
- `experimentation-and-optimization` (appended to existing `growth-analyst`) — ICE-prioritized
  experiment selection and a genuinely rigorous statistical-significance section (sample-size
  formula, a worked reference table, a hard anti-peeking rule) sized for early-stage traffic — the
  round's most differentiated single piece of content. A shipped, statistically valid experiment is
  explicitly allowed to update the relevant `quantitative_claims[]` entry, closing the loop back into
  the plan.
- `pricing-and-monetization-optimization` (+ `pricing-strategist`) — evidence-gated triggers for
  revisiting DE step 16's pricing (not a calendar ritual), packaging/tiering frameworks, grandfathering
  and phased-rollout discipline for a price change, and the same `quantitative_claims[]` feedback loop.
- `operations-and-fulfillment-playbook` (appended to existing `operations-manager`) — real,
  type-specific SOPs branching by `business_basics.business_type`: inventory/vendor/fulfillment
  economics for `physical_product`, supply-side onboarding/liquidity ops for `marketplace` (explicitly
  the ongoing-ops sequel to `marketplace-liquidity-specialist`'s plan-stage review), delivery-capacity
  utilization discipline for `services`.
- `competitive-intelligence-monitoring` (+ `competitive-intelligence-lead`) — the ongoing sequel to DE
  step 11's one-time competitive chart: a fixed monitoring cadence, a structured win/loss reason
  taxonomy with a pattern-threshold hand-off to `positioning-and-messaging`, and explicit
  positioning-drift-detection criteria for when a competitive shift rises to "the plan needs a
  re-review."

## Design (`agents/design/brand-designer.md`, `skills/design/`)

`brand-designer` grounds every visual decision in steps 3/5/8/10. Skills: `brand-identity`
(name/tagline/voice brief, not production assets), `pitch-deck` (via the built-in `pptx`
skill), `landing-page` (via the built-in `design` skill).

## Risk (`agents/risk/`, `skills/risk/`)

Three risk/planning-aid lenses, sharing `risk_log`:
- `ai-risk-analyst` / `ai-risk-review` — unsourced numeric claims, false precision,
  automation bias, review-council integrity spot-checks. Blocking gate before any
  numeric-claim-bearing artifact reaches a founder or council; round 2 wired this gate directly
  into DE steps 04/14/16/17/19 and onboarding rather than leaving it dependent on downstream
  discipline alone; round 3's dry run confirmed it fires correctly, live, on a second independent
  business.
- `privacy-compliance-officer` / `privacy-check` — data minimization, connector consent gate,
  scope-of-advice boundary (not legal/financial/tax advice).
- `legal-structure-and-ip-basics` (skill only, new round 9, no dedicated agent) — entity choice
  (LLC vs. Delaware C-corp) tied directly to `business_basics.funding_intent`, founder equity/vesting
  mechanics, IP-assignment traps, and contract hygiene, closing with an explicit "when this needs a
  real lawyer" boundary. Logs to `risk_log` with `type: "legal"` (already in the schema, unused until
  now). Not yet wired into a specific DE step or orchestrator phase — the authoring agent recommended
  DE step 15, before GTM launch, and whenever `funding_intent` changes; left as an open wiring item
  for a future round rather than done under this round's own integration-pass time budget.

## Connectors (`agents/connectors-liaison.md`, `skills/connectors/`)

`connectors-liaison` is the checkpoint every GTM/ops agent calls before touching a real
external tool — identifies the need, checks live availability, prompts via whatever
connector-discovery capability the environment exposes (or falls back to plain-language manual
instructions), and always routes through the privacy-check gate before data actually flows. The
liaison agent itself correctly distinguishes `wired_up` from `needed_not_installed` and never
silently deletes a needed-but-absent entry.

**Round 3's caller audit is complete** (`docs/QA-FINDINGS-CONNECTORS-ROUND3.md`): all 19
`agents/gtm/*`, `agents/ops/*`, `skills/gtm/*`, and `skills/ops/*` files were read in full and
cross-checked against `docs/CONNECTORS-CATALOG.md` — result: **5 REAL CHECK** (`launch-director`,
`sales-lead`, `fundraising-advisor`, `growth-analyst`, `finance-controller` — the same five round 2
fixed, all confirmed still genuinely fail-closed on a fresh read), **0 ASSERTED-BUT-NOT-REAL**, and
**14 correctly N/A** (document-only skills/agents that never touch a connector, confirmed clean by
grep, not just by absence of a read). The audit also found and fixed one real ambiguity in
`connectors-liaison.md` itself: its "report back to the calling agent" section now states
explicitly that a not-safe-to-proceed status blocks only the connector-dependent piece of a
caller's task — the caller must still produce whatever it can complete without the connector and
mark the pending piece explicitly, never silently omit it or block the whole deliverable. Catalog
of real tools by category: `docs/CONNECTORS-CATALOG.md`.

## Quality assurance (`agents/qa/`, `skills/qa/`)

`skill-quality-auditor` (single-file structural audit) and `consistency-checker` (cross-file
conflicts: field ownership, broken read/write chains, duplicate names, layout drift), both
invoked via `eval-a-skill`. Strategy and pre-release regression checklist: `docs/TESTING.md`.
Structural rules are additionally enforced mechanically by `scripts/validate-plugin.sh` (495
lines as of this revision, up from 299 at the round-3 snapshot — round 3 added the two checks
described below), which runs in CI on every `push` and `pull_request` via
`.github/workflows/validate-plugin.yml` (added round 2; still the only workflow file; confirmed to
have no `branches:` filter on either trigger and no `continue-on-error` anywhere, so it genuinely
fails the check rather than merely annotating). The two checks round 3 added, both confirmed live
in this revision's validation run: (1) every `business-state.json` top-level field referenced
anywhere in the corpus is cross-checked against `docs/DATA-CONTRACT.md`'s declared schema
(warning-level), and (2) every `agents/council/*.md` file's own instructions are checked for
literal commitment to the CONVENTIONS.md §6 verdict schema — a `## Verdict:` heading naming all
four values (error-level).

**Round 4's full-repo dogfood pass landed** (`docs/QA-DOGFOOD-ROUND4.md`) — `skill-quality-auditor`
and `consistency-checker` run for real, at real full-repo scale, for the first time: 29 files read
in full (all 10 then-current council files, all 4 GTM agents, all 5 ops agents, both risk agents, 6
sampled DE steps, the QA layer itself), plus a duplicate-name sweep and a cross-reference/path-
existence sweep across the **entire** corpus (all agents, all skills, unsampled). Findings: one
cross-cutting `connectors.json`/`cadence.json` staleness (traced into 7 files, all now fixed — see
the round 4 section of `docs/ROADMAP.md`), one stale reference list inside
`consistency-checker.md`'s own §4 (fixed same-pass), and one systemic, deliberately-out-of-scope
finding — all council personas missing an explicit "## What you write" body statement — flagged for
a later round to fix mechanically rather than touched there. **Round 5 made exactly that fix**,
confirmed landed above (12 of 12 council files).

**Round 4's first Layer 2 behavioral eval suite seed landed.** `evals/` now exists at the repo
root with **7 eval cases** (`01-ai-risk-gate-unsourced-claim`, `02-council-verdict-aggregation`,
`03-onboarding-vague-answer-pushback`, `04a-de-step04-branching-saas`,
`04b-de-step04-branching-marketplace`, `05-connectors-liaison-fail-closed`,
`06-revise-routes-through-revise-business-plan`), a `run-evals.sh` harness, a shared `lib/`, and a
`README.md` — confirmed present by direct directory listing, closing a gap `docs/TESTING.md` had
described without a real suite behind it since round 1.

**Round 5's fourth live dry run and first real Layer 3 regression pass both landed, confirmed
present.** `docs/QA-FINDINGS-ROUND5.md` (Kindling, `consumer_app`, `idea_only`) surfaced and closed
real gaps in Steps 1/2/4's consumer_app branching and `competitive-strategy-reviewer`'s calibration
(both detailed above). `docs/QA-LAYER3-REGRESSION-ROUND5.md` ran `docs/TESTING.md` §3.1–§3.6 for
real against all three then-existing fixtures for the first time (6 PASS, 9 GAP, 2 FAIL — one fixed,
the `revise-business-plan` stage-value bug; one logged, vantage-point-search's un-flipped
`resolved` field) and named, in its own closing section, exactly the two gaps round 6 is now
attempting to close live: a full revision cycle, and a run past `stage: "approved"`.
`docs/CHANGELOG.md` also landed this round, confirmed present, consolidating rounds 1-5's build
history into one chronological ledger.

**Round 6 landed and is confirmed resolved.** `docs/QA-FINDINGS-ROUND6.md` drove
`.startup/shiftcover/` through a real, full revision cycle for the first time — round 5's
`revise-business-plan` stage-value fix held live, with no workaround needed, and the run's own real
re-review (a genuinely new 5-persona panel, a real REJECT via semantic tag-overlap corroboration)
surfaced one significant new gap: a discarded outlier's required revisions were never carried
forward for rework by `revise-business-plan`, so they resurfaced identically on re-review. **Fixed**:
`revise-business-plan/SKILL.md` §0 now explicitly carries forward discarded-but-real and
also-flagging concerns as in-scope work alongside the aggregate checklist; §1 now distinguishes
decision-gated from time-gated blocked items. `docs/QA-FINDINGS-POSTAPPROVAL-ROUND6.md` drove
`.startup/vantage-point-search/` through GTM, a live `connectors-liaison` invocation, and the ops
layer's first-ever real check-in — the entire post-approval half of the lifecycle diagram, exercised
live for the first time — and found a real, significant bug: `runway-and-burn-tracking`'s formula had
no period-normalization step, which would have overstated a real biweekly first check-in's runway by
roughly 2.1x (and would compound to ~4.3x at a weekly cadence), on the single number
`finance-controller` names as the one whose staleness is "actively dangerous." **Fixed**: the skill
now normalizes any non-monthly period's burn to a monthly-equivalent figure before computing runway.
The same run also found and fixed a real, previously-undocumented ambiguity in the connectors gate's
scope (agent-automated vs. founder-personal actions) in `agents/connectors-liaison.md`. All fixes
confirmed present in the current files as of this revision, not carried forward from either finding's
own description.

**Round 7 landed and is confirmed resolved.** `docs/QA-FINDINGS-OVERRIDE-ROUND7.md` drove the
founder-override mechanism live for the first time against `shiftcover`'s standing REJECT verdict —
Non-negotiable #3's own "not a shrug" bar held under a real, reasoned founder decision, and driving
the override through to its actual downstream consequence found a real bug: `agents/gtm/
launch-director.md` would have proceeded as if the plan had cleared review cleanly, since its Gate
check read only `stage` and its "What you read" instruction filtered `risk_log` to "anything open" —
but an override's entries are `accepted` by design, invisible to that read by construction. **Fixed**:
`launch-director`'s Gate section now re-reads the most recent `reviews[]` verdict whenever `stage` is
`approved`, confirms an override via the review file's mark and the matching `accepted` entries, and
states it plainly before any sequencing work; a related bug in the orchestrator's state-machine
diagram (which had described the override path as looping back through another council re-run,
backwards from the mechanism's purpose) was fixed in the same pass. `docs/QA-FINDINGS-PIVOT-ROUND7.md`
drove a second recurring check-in cycle and a real, evidence-based mid-lifecycle pivot against
`vantage-point-search` for the first time, and found `agents/orchestrator.md` Phase 6's entire
specification for reopening DE steps after a pivot was one unspecified sentence, with no
partial-reopening mechanic, no status semantics for a probably-still-valid-but-unconfirmed step, and
no transitive-impact guidance. **Fixed**: Phase 6 now has a real "Reopening a subset of DE steps after
a pivot" procedure, plus a new `NEEDS RE-CONFIRMATION:` summary-prefix convention (also documented in
`docs/DATA-CONTRACT.md`). Two related handoff gaps were found and fixed in the same pass:
`skills/interview/recurring-check-in/SKILL.md` gave its executor no instruction for what to do once a
pivot signal surfaced in conversation, despite `docs/DATA-CONTRACT.md` explicitly assigning this write
to it by name (**fixed**, Phase 2 now names the handoff); and `launch-director`'s mid-GTM pivot section
had nothing for a pivot signal firing after launch (**fixed**, already-shipped artifacts now get
flagged rather than assumed immune). All fixes confirmed present in the current files as of this
revision, not carried forward from either finding's own description.

**Round 8 in progress, not yet landed as of this revision.** One agent is sweeping every prior round's
findings documents (all ten `docs/QA-FINDINGS-*.md` reports plus the dogfood and Layer 3 passes) for
deferred or explicitly out-of-scope items and closing what's safely closeable now; the other is
preparing the plugin for real human trial use (README/onboarding polish), consistent with
`docs/ROADMAP.md`'s own recommendation that further simulated dry runs have hit diminishing returns.
**A direct check found no `docs/QA-BACKLOG-SWEEP-ROUND8.md`** as of this revision — confirmed by
directory/file listing, not assumed absent; the real-use-readiness agent's own output was not
independently re-read while writing this revision, since it's outside this revision's edit scope.

## Reference docs (`docs/`)

`ARCHITECTURE.md` (lifecycle narrative) · `ARCHITECTURE-IMPLEMENTATION.md` (file-level
mechanics) · `DATA-CONTRACT.md` (business-state.json schema, now including a council
persona-coverage-by-business-type table, closed as of round 4) · `DE-24-STEPS.md` (canonical step
list) · `UX-INTERVIEW-DESIGN.md` · `AI-RISK-FRAMEWORK.md` · `PRIVACY-AND-DATA-HANDLING.md` ·
`CONNECTORS-CATALOG.md` · `TESTING.md` · `ROADMAP.md` · `CHANGELOG.md` (landed round 5, extended
rounds 6 and 7 — a chronological ledger of what got built, what broke, and what got fixed across
rounds 1-7, indexing every findings doc below) · `QA-FINDINGS-ROUND2.md` (round 2's ShiftCover B2B SaaS dry
run — resolved, findings fixed directly) · `QA-FINDINGS-GATES-ROUND2.md` (round 2's parallel
risk-gate sweep) · `QA-FINDINGS-ROUND3.md` (round 3's SkyClaim marketplace dry run — resolved, all
four findings fixed directly) · `QA-FINDINGS-CONNECTORS-ROUND3.md` (round 3's connectors-enforcement
audit — resolved, no fixes owed to any caller file, one ambiguity fixed in
`connectors-liaison.md` itself) · `QA-FINDINGS-ROUND4.md` (round 4's Vantage Point Search services
dry run — resolved, all five findings fixed directly) · `QA-DOGFOOD-ROUND4.md` (round 4's first
full-repo QA-tooling dogfood pass — resolved: the connectors.json/cadence.json drift and
`consistency-checker.md`'s own stale reference list both fixed directly; the one systemic
out-of-scope finding, the council write-statement gap, handed to and closed by round 5) ·
`QA-FINDINGS-ROUND5.md` (round 5's Kindling consumer-app dry run — resolved, all consequential
findings fixed directly, confirmed in this revision) · `QA-LAYER3-REGRESSION-ROUND5.md` (round 5's
first real Layer 3 pre-release regression pass — one FAIL fixed directly, one FAIL logged as
fixture data off-limits to this round, 9 GAPs named plainly as the plugin's genuinely untested
surface, which became the direct basis for round 6's scope) · `QA-FINDINGS-ROUND6.md` (round 6's
first completed revision cycle against `shiftcover` — resolved: round 5's `revise-business-plan`
fix confirmed live, and a real discarded-outlier revision-routing gap found and fixed) ·
`QA-FINDINGS-POSTAPPROVAL-ROUND6.md` (round 6's first live GTM/ops/check-in run against
`vantage-point-search` — resolved: a real 2-4.3x runway-overstatement bug and a real connectors-gate
scope ambiguity, both found and fixed) · `QA-FINDINGS-OVERRIDE-ROUND7.md` (round 7's first live
founder-override run against `shiftcover`'s standing REJECT — resolved: a real silent-failure risk in
`launch-director`'s override detection and a backwards state-machine diagram branch, both found and
fixed) · `QA-FINDINGS-PIVOT-ROUND7.md` (round 7's first live second check-in cycle and mid-lifecycle
pivot against `vantage-point-search` — resolved: the DE-step reopening protocol's missing mechanics,
plus two related pivot-handoff gaps in `recurring-check-in` and `launch-director`, all found and
fixed). Root `CONVENTIONS.md` is the contract every file above conforms to; round 4's staleness audit
re-checked it against the repo it governs and fixed the one real drift found (§5's
`connectors.json`/`cadence.json` description, traced into 6 more files).

**`docs/QA-BACKLOG-SWEEP-ROUND8.md` does not yet exist as of this revision** — a round 8 deliverable,
confirmed absent by a direct file-existence check, not assumed. Add it to this list once a file read
confirms it's landed; do not cite it as existing until then.

## Totals (walked directly against the repo via `find` and a live `scripts/validate-plugin.sh` run)

- **34 agents** across orchestration (1), council (**13** personas — `technical-feasibility-
  reviewer` added round 2; `marketplace-liquidity-specialist` and `services-unit-economics-
  reviewer` added round 3; `hardware-physical-product-operator` and `regulated-industry-
  compliance-reviewer` added round 4; `operational-execution-reviewer` added round 9), GTM (4),
  ops (**8** — `people-lead`, `pricing-strategist`, `competitive-intelligence-lead` added round 9),
  risk (2), QA (2), connectors (1), design (1), product (**1**, new category — `product-lead`,
  round 9), and plan-editing (1)
- **56 skills** across interview (2), autonomous-continuation (**1**, new singleton, round 9), the
  24 DE steps, business-plan (3), GTM (**6** — `investor-updates-and-cap-table-basics` added round
  9), ops (**11** — `hiring-and-org-design`, `customer-success-playbook`,
  `experimentation-and-optimization`, `pricing-and-monetization-optimization`,
  `operations-and-fulfillment-playbook`, `competitive-intelligence-monitoring` added round 9),
  product (**1**, new category, round 9), design (3), risk (**3** — `legal-structure-and-ip-basics`
  added round 9), QA (1), connectors (1) — the largest single-round skill/agent growth since round
  1's initial build; rounds 3 through 8 held the total flat, deepening existing files rather than
  adding new ones, before round 9's 10-agent breadth expansion
- **6 slash commands** (`/continue-business` added round 9)
- **1 CI workflow** (`.github/workflows/validate-plugin.yml`, added round 2, still the only one —
  runs `scripts/validate-plugin.sh` on every `push` and `pull_request`, checking 2 more structural
  properties than it did at the round-2 snapshot, unchanged since round 3)
- **7 Layer 2 eval cases** under `evals/` (seeded round 4 — `01-ai-risk-gate-unsourced-claim`
  through `06-revise-routes-through-revise-business-plan`, one case, 04, split into an `a`/`b`
  pair — unchanged since round 4, confirmed by directory listing; round 9 added no new eval cases
  for its new skills, a real gap a future round should close)

**Round 9 grew the skill/agent count for the first time since round 1** (rounds 2-8 all held it
flat or near-flat, deepening existing files) — 10 concurrently-running agents, each scoped to
strictly disjoint files per its own brief, produced 15 new files (9 new skills, 4 new agents, 1 new
council persona, plus this round's own `skills/autonomous-continuation` and
`commands/continue-business.md`) and 6 append-only edits to existing agent files, with **zero
file-collision incidents** — confirmed both by every agent's own `git status`/`git diff` check in
its final report and by a live run of the validator after all 10 landed.

`scripts/validate-plugin.sh` output at the time of this revision: `PASS — no structural drift from
CONVENTIONS.md detected` (56 skills, 34 agents, 6 commands, 13 council files, 0 warnings, 0 errors,
all 24 DE step folders matching `docs/DE-24-STEPS.md`).
