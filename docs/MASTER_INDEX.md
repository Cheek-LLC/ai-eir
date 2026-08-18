# Master Index — after Round 3, during Round 4

Full catalog of every agent, skill, and command in the plugin after round 1 (v0.1 build, 15
parallel builders), round 2 (adversarial review + fix pass, 9 parallel reviewers plus a live
end-to-end dry run — see `docs/QA-FINDINGS-ROUND2.md` and `docs/QA-FINDINGS-GATES-ROUND2.md`), and
round 3 (deepening business-type branching to all 24 steps, 2 new council personas, CI/validation
hardening, ops instrumentation across all 5 ops skills, a connectors audit, and a second live dry
run against a marketplace business — see `docs/QA-FINDINGS-ROUND3.md` and
`docs/QA-FINDINGS-CONNECTORS-ROUND3.md`, both now landed and resolved). **Round 3 is complete and
integrated** — every count and claim below was re-walked directly against the repo (`find`,
targeted `grep`, and a live run of `scripts/validate-plugin.sh`) while writing this revision, not
carried forward from the prior snapshot. **Round 4 is running concurrently with this revision**
(2 more council personas, a third live dry run against a services business, a `CONVENTIONS.md`
staleness audit, a full-repo QA-tooling dogfood pass, and a first Layer 2 eval-suite seed) —
regenerate this file again once round 4 lands rather than trusting the round-4-shaped claims below,
which are explicitly marked as checked-and-not-yet-present. `/list-skills` gives a live,
always-current view for day-to-day use between regenerations.

**Live validation output at the time of this revision:**
`PASS — no structural drift from CONVENTIONS.md detected` — **46 skills, 27 agents, 5 commands, 10
council files checked, 0 warnings, 0 errors**, all 24 DE step folders matching
`docs/DE-24-STEPS.md`, every referenced `business-state.json` top-level field matching
`docs/DATA-CONTRACT.md`, and every `agents/council/*.md` file committing to the CONVENTIONS.md §6
verdict schema.

## Entry points (`commands/`)

| Command | Purpose |
|---|---|
| `/start-business` | Begin a brand-new business — delegates to `startup-operator` to bootstrap `.startup/<slug>/` and start onboarding. |
| `/business-status` | Resume an existing business by slug/name — re-reads state, reports status, continues where it left off. |
| `/check-in` | Manually trigger a recurring check-in outside the automatic cadence (also the fallback when no scheduling capability exists). |
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
now fixed there too.

## Interview (`skills/interview/`)

| Skill | Purpose |
|---|---|
| `onboarding-interview` | First conversation with a new founder — captures identity/basics, classifies business type, sets honest depth/time expectations, pushes back on vague answers. Round 2 wired the mandatory AI-risk gate in here too; round 3's marketplace dry run ran it live and confirmed the privacy-notice call fires correctly. |
| `recurring-check-in` | Conversational shape of every check-in after launch — asks for real founder-reported numbers, walks open risks/assumptions, confirms next cadence. |

Design rationale for both: `docs/UX-INTERVIEW-DESIGN.md`.

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

**Business-type branching: complete across all 24 steps, confirmed by reading section content, not
just a heading grep.** Steps `01`–`14`, `17`, `18`, `20`, `21`, `23`, and `24` carry a literal
`## Business-type branching` heading; steps `15`, `16`, `19`, and `22` carry the same real,
developed per-type content under a differently-worded heading each step's own author chose
(`## Business-type starting points`, `## Business-type cost drivers`, `## Business-type MVBP
shapes`) — all four confirmed to give `marketplace`, `services`, and `consumer_app` genuinely
distinct treatment, not a reskinned SaaS paragraph. Round 3's marketplace dry run (`docs/QA-
FINDINGS-ROUND3.md`) found and this round's fixes closed two real cross-step gaps here: steps `17`
and `18` had zero marketplace branching (now fixed — step 17 requires per-side LTV with an explicit
no-comparable-LTV note where relevant; step 18 requires costing both sides' funnels separately),
and step `4`'s beachhead-TAM sanity-check heuristic didn't distinguish GMV from take-rate revenue
for a marketplace (now fixed with an explicit GMV-vs-take-rate clause). Steps `04`, `14`, `16`,
`17`, and `19` additionally each carry a `## Mandatory AI-risk gate` section (a round 2 fix,
confirmed working live — not just present — by round 3's dry run, which triggered a real BLOCKED
finding on steps 04 and 17 and fixed both) that blocks `status: "drafted"` until every fact-claim
they produce is sourced.

## Business plan (`skills/business-plan/`, `agents/business-plan-editor.md`)

| File | Purpose |
|---|---|
| `assemble-business-plan` | Synthesizes all 24 step files into one investor-ready `plan/business-plan.md` — reconciles steps 13+18, TAM(4) vs TAM(14), LTV(17):COCA(19); calls the mandatory AI-risk gate and checks for the required Confidence & Validation Status section before considering assembly done (round 2 fix, confirmed live by round 3's dry run — it correctly BLOCKED on a genuinely unsourced step-23 claim, then PASSED after the fix). |
| `revise-business-plan` | Routes a council's required revisions back to the owning step or a synthesis fix, produces the next plan version with an itemized changelog. |
| `business-plan-editor` (agent) | The actual drafting/editing voice both skills delegate to — precise, quantified, refuses cosmetic-only revisions. States the Confidence & Validation Status section as mandatory on every canonical plan and revision. |

## Review councils (`agents/council/`, `skills/business-plan/run-review-council/`)

**10 distinct reviewer personas**, confirmed by direct directory listing and by
`scripts/validate-plugin.sh`'s own live count — a fixed 4-seat core plus one contextual 5th seat
chosen by priority rules (business type, or the plan's own content), convened as a
strategy-weighted panel (funding-track aware: bootstrap vs. venture vs. undecided), aggregated by
the "harshest non-outlier verdict" rule (round 2 hardened this computation's edge cases; round 3's
dry run exercised it by hand a second time, hit a genuinely different worked case — a lone REJECT
surviving the outlier test via cross-severity tag corroboration — and found (then fixed) a gap
where that survivor's own findings could still be absent from the severity-gated Required Revisions
checklist; §8.4 now has an explicit "Also flagging, regardless of severity" callout for exactly
this case):

`vc-panel` · `expert-entrepreneur-panel` · `customer-discovery-skeptic` ·
`product-market-fit-panel` · `financial-modeling-reviewer` · `competitive-strategy-reviewer` ·
`sales-motion-reviewer` · `technical-feasibility-reviewer` · `marketplace-liquidity-specialist` ·
`services-unit-economics-reviewer`

`run-review-council` decides which seats convene and how they're weighted for a given business,
calls the AI-risk gate before and after the panel, and writes the aggregate verdict to `reviews/`.

**The two newest personas are a confirmed, working fix, not a checkbox.** Round 3's marketplace
dry run compared `marketplace-liquidity-specialist`'s verdict against what the persona it replaced
(`competitive-strategy-reviewer`) would have produced for the same plan, and found the new persona
surfaced a real, consequential finding (disintermediation risk) no other panelist raised in any
form.

**A real bug found and fixed in the seat-selection logic itself.** The same dry run found the
§3 trigger rules for `competitive-strategy-reviewer` (the default 5th seat) and
`product-market-fit-panel` each carried a clause keyed to Steps 10/11 reaching `status: "approved"`
— which, per the orchestrator's own design (see above), never happens for any business, ever,
making the clause unconditionally true and silently overriding two other legitimately-firing
triggers for every business type other than `marketplace`/`services`. This is the same bug class
round 2 found in the orchestrator, independently present here, and confirmed to have survived a
full round-3 rewrite of the surrounding section untouched. **Fixed**: both clauses now key off a
real, variable content signal (low-confidence `key_assumptions` on steps 10/11, or an explicit
no-differentiated-Core finding) instead of a status value that can never actually vary.

**Round 4 in progress, not yet landed as of this revision:** two more personas —
`regulated-industry-compliance-reviewer` and `hardware-physical-product-operator` — are being
built to close the two remaining gaps in `docs/DATA-CONTRACT.md`'s persona-coverage table. **A
direct walk of `agents/council/` immediately before writing this section found exactly the same 10
files listed above and neither new persona present** — re-walk the directory before quoting a
count higher than 10.

## Go-to-market (`agents/gtm/`, `skills/gtm/`)

`launch-director` (coordinator) → `marketing-strategist`, `sales-lead`, `fundraising-advisor`
(gated on `gtm.funding_strategy`). Skills: `launch-plan`, `positioning-and-messaging`,
`content-calendar`, `outbound-sales-playbook`, `fundraising-deck-prep` (builds the actual
`.pptx` via the built-in `pptx` skill).

## Operations (`agents/ops/`, `skills/ops/`)

`operations-manager` (coordinator, runs plan-vs-actual drift checks) → `growth-analyst`,
`finance-controller` (proactive runway escalation), `customer-success-lead`,
`scaling-strategist`. Skills: `weekly-metrics-review`, `kpi-dashboard-setup`, `runway-and-burn-
tracking`, `retention-and-churn-analysis`, `scaling-readiness-check`.

**Business-type instrumentation: complete across all 5 ops skills**, confirmed by direct
inspection — every one of `kpi-dashboard-setup`, `weekly-metrics-review`, `retention-and-churn-
analysis`, `runway-and-burn-tracking`, and `scaling-readiness-check` now reads
`business_basics.business_type` and dispatches its metric/KPI set accordingly (this closes the gap
this file previously tracked, where only `kpi-dashboard-setup` had it as of the round-3 snapshot).

## Design (`agents/design/brand-designer.md`, `skills/design/`)

`brand-designer` grounds every visual decision in steps 3/5/8/10. Skills: `brand-identity`
(name/tagline/voice brief, not production assets), `pitch-deck` (via the built-in `pptx`
skill), `landing-page` (via the built-in `design` skill).

## Risk (`agents/risk/`, `skills/risk/`)

Two distinct risk lenses, both logging to `risk_log`:
- `ai-risk-analyst` / `ai-risk-review` — unsourced numeric claims, false precision,
  automation bias, review-council integrity spot-checks. Blocking gate before any
  numeric-claim-bearing artifact reaches a founder or council; round 2 wired this gate directly
  into DE steps 04/14/16/17/19 and onboarding rather than leaving it dependent on downstream
  discipline alone; round 3's dry run confirmed it fires correctly, live, on a second independent
  business.
- `privacy-compliance-officer` / `privacy-check` — data minimization, connector consent gate,
  scope-of-advice boundary (not legal/financial/tax advice).

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

**Round 4 in progress, not yet landed as of this revision:** a full-repo dogfood pass actually
running `skill-quality-auditor` and `consistency-checker` at scale for the first time (prior rounds
exercised their design, not a real full-corpus run), plus a first Layer 2 behavioral eval suite
seed. **A direct check found no `docs/QA-DOGFOOD-ROUND4.md`-shaped file and no `evals/` directory
at the repo root** as of this revision — confirmed by directory listing, not assumed absent.

## Reference docs (`docs/`)

`ARCHITECTURE.md` (lifecycle narrative) · `ARCHITECTURE-IMPLEMENTATION.md` (file-level
mechanics) · `DATA-CONTRACT.md` (business-state.json schema, now including a council
persona-coverage-by-business-type table) · `DE-24-STEPS.md` (canonical step list) ·
`UX-INTERVIEW-DESIGN.md` · `AI-RISK-FRAMEWORK.md` · `PRIVACY-AND-DATA-HANDLING.md` ·
`CONNECTORS-CATALOG.md` · `TESTING.md` · `ROADMAP.md` · `QA-FINDINGS-ROUND2.md` (round 2's
ShiftCover B2B SaaS dry run — resolved, findings fixed directly) ·
`QA-FINDINGS-GATES-ROUND2.md` (round 2's parallel risk-gate sweep) ·
`QA-FINDINGS-ROUND3.md` (round 3's SkyClaim marketplace dry run — resolved, all four findings fixed
directly, confirmed in this revision) · `QA-FINDINGS-CONNECTORS-ROUND3.md` (round 3's connectors-
enforcement audit — resolved, no fixes owed to any caller file, one ambiguity fixed in
`connectors-liaison.md` itself). Root `CONVENTIONS.md` is the contract every file above conforms
to.

**Round 4 deliverables, checked directly and confirmed not yet present in `docs/` as of this
revision** — do not cite these as existing until a file read confirms otherwise: a
`docs/QA-FINDINGS-ROUND4.md`-shaped file (the services-business dry run), a
`docs/QA-DOGFOOD-ROUND4.md`-shaped file (the QA-tooling full-repo run), and any file documenting
the `CONVENTIONS.md` staleness audit's results. An `evals/` directory for the Layer 2 behavioral
eval suite seed is likewise not yet present at the repo root.

## Totals (walked directly against the repo via `find` and a live `scripts/validate-plugin.sh` run)

- **27 agents** across orchestration (1), council (**10** personas — `technical-feasibility-
  reviewer` added round 2; `marketplace-liquidity-specialist` and `services-unit-economics-
  reviewer` added round 3; round 4's 2 additional personas not yet landed), GTM (4), ops (5),
  risk (2), QA (2), connectors (1), design (1), and plan-editing (1)
- **46 skills** across interview (2), the 24 DE steps, business-plan (3), GTM (5), ops (5),
  design (3), risk (2), QA (1), connectors (1) — same total as the round-3 snapshot; round 3's
  work deepened existing skill files rather than adding new skill folders, confirmed by
  `scripts/validate-plugin.sh`'s own live count, not by incrementing the prior number
- **5 slash commands**
- **1 CI workflow** (`.github/workflows/validate-plugin.yml`, added round 2, still the only one —
  runs `scripts/validate-plugin.sh` on every `push` and `pull_request`, now checking 2 more
  structural properties than it did at the round-2/round-3-snapshot version of this document)

`scripts/validate-plugin.sh` output at the time of this revision: `PASS — no structural drift from
CONVENTIONS.md detected` (46 skills, 27 agents, 5 commands, 10 council files, 0 warnings, 0 errors,
all 24 DE step folders matching `docs/DE-24-STEPS.md`).
