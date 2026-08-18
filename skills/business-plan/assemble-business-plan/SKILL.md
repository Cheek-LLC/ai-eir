---
name: assemble-business-plan
description: >
  Use once all 24 disciplined_entrepreneurship entries in business-state.json reach status
  drafted or later (drafted, reviewed, or approved) — i.e. every skills/disciplined-entrepreneurship/NN-slug
  skill has produced its plan/NN-slug.md. Triggers on phrases like "assemble the business
  plan," "put the plan together," "all 24 steps are done, write the plan," or when the
  orchestrator advances a business past de_steps_in_progress. Reads all 24 plan/NN-slug.md
  files plus key_assumptions/quantitative_claims/risk_log from business-state.json, and
  synthesizes plan/business-plan.md — a single investor-grade document organized around the
  six Disciplined Entrepreneurship themes, not a concatenation of the 24 files. Produces
  plan/business-plan.md, sets plan.version = 1, and advances stage to plan_assembled. Also
  handles an explicit request for an early look at an in-progress plan ("give me a draft of
  what we have so far," "early plan preview," "I know we're not done, show me a draft") via a
  separate, clearly-labeled partial-draft path (§0a) that never touches plan.version or stage.
---

# Assemble Business Plan

You turn 24 independently-drafted Disciplined Entrepreneurship step files into one coherent,
investor-grade business plan. This is a synthesis task, not a file-merge task — read
`agents/business-plan-editor.md` before you start; that subagent does the actual writing and
you are responsible for feeding it the right material and enforcing the output contract below.

## 0. Preconditions

1. Load `.startup/<business-slug>/business-state.json`.
2. Confirm all 24 keys under `disciplined_entrepreneurship` (see `docs/DE-24-STEPS.md` for the
   canonical 01..24 key list) have `status` in `{drafted, reviewed, approved}`. If any is
   `not_started`, stop and report which step(s) are still missing — do not assemble the
   canonical plan.version-bearing plan and do not silently skip a step. If the founder is
   explicitly asking for an early look at the in-progress plan rather than the final assembly,
   switch to the partial-draft path in §0a instead of just stopping — see that section for when
   it applies and how it differs from this canonical path.
3. Confirm each of those entries' `file` points to a `plan/NN-slug.md` that actually exists on
   disk. If a status says `drafted` but the file is missing, treat that as blocking — report it,
   don't fabricate the section.

## 0a. Partial / draft mode — explicit opt-in only, never the default

Disciplined Entrepreneurship's own logic is sequential: later steps depend on earlier ones (14
reuses 4's methodology and Step 1's segments; 18 extends 13's map; 19 is built directly from 18
and 17). That is exactly why §0 refuses to synthesize the canonical, investor-grade
`plan/business-plan.md` from an incomplete step set — a plan that quietly skips a dependency
would misrepresent itself as complete. But a real founder mid-way through the 24 steps
legitimately wants to see how the story reads so far, and refusing that outright isn't useful
either. The resolution: a separate, unmistakably-labeled draft output that is never mistaken for
the real thing and never advances plan state.

**Trigger.** Only on an explicit founder request for an early/partial/in-progress view (see the
frontmatter trigger phrases). Never enter this path automatically just because §0's all-24 gate
failed — offer it, don't assume it ("Steps 9, 12, and 16 aren't drafted yet, so I can't assemble
the full plan. I can put together a partial draft of what's done so far, covering [themes] — want
that instead?").

**Scope rule — contiguous completed themes only, not a scattered subset.** Because DE steps
build on each other within and across themes, a partial draft assembles complete leading themes
only: walk the six themes in order (Theme 1 → Theme 6, per the table in §2) and include a theme
in the draft only if every step it folds in is `drafted`/`reviewed`/`approved` AND every prior
theme is also fully complete. Stop at the first incomplete theme; do not include a later theme
out of sequence even if it happens to be done (e.g. steps 20-22 drafted early is not a reason to
include Theme 5 if Theme 3 is still missing step 12). This mirrors DE's own build-up logic rather
than fighting it.

**Reconciliations — only where both sides exist.** Apply the same reconciliation rules as §3
below wherever both prerequisite steps fall inside the completed-theme range (e.g. if Themes 1-4
are complete, still do the 13+18 narrative, the TAM(4)-vs-TAM(14) side-by-side, and the LTV:COCA
ratio). If a reconciliation's steps span the boundary (one side done, one side missing — e.g. LTV
step 17 drafted as part of a complete Theme 4 but COCA step 19 not yet, which would in fact keep
that whole theme incomplete under the contiguous rule above) it can't occur; state plainly in the
draft which reconciliation is pending and why.

**Output — never touches the canonical files or state.** Write to
`plan/business-plan-draft.md` (a distinct filename from `plan/business-plan.md` and from any
`plan/business-plan-vN.md`). Head the file unmistakably:

```markdown
# DRAFT — PARTIAL PLAN (Themes 1-<N> of 6 complete)
**This is an in-progress preview, not the assembled plan.** Steps <list of not-yet-drafted
steps> are still missing. Do not submit this to council review (`skills/business-plan/
run-review-council` operates on the canonical `plan/business-plan.md`) and do not treat any
number here as final — reconciliations involving a not-yet-drafted step are marked pending
below, not computed.
```

Delegate the actual writing to `business-plan-editor` exactly as in §7, but tell it explicitly
this is the partial-draft path: only the completed themes, the same voice/no-invented-numbers
rules, an executive summary written last covering only what's actually in the draft (never a
preview of themes not yet written), and the pending-reconciliation flags above instead of an
Appendix for undrafted steps.

Do **not** write anything to `business-state.json` for this path — `plan.version`, `plan.file`,
and `stage` are reserved for the canonical assembly gated by §0, and the Data Contract has no
field representing an unassembled partial draft; inventing one is out of scope for this skill.
The draft file, clearly labeled, is the complete deliverable. Report back to the founder: which
themes are covered, which step(s) are still needed to reach the next theme, and the file path —
and remind them this file will be superseded (not merged) once the real 24-step assembly runs.

## 1. Gather source material

Read, in full:

- All 24 `plan/NN-slug.md` files.
- `key_assumptions`, `quantitative_claims`, and `risk_log` from `business-state.json`.
- Any existing `plan/business-plan.md` (there shouldn't be one yet at version 1 — if one
  exists, this is a re-assembly, not a fresh assembly; treat it as informational only, the
  output still starts a fresh version 1 unless `plan.version` already exists, in which case
  stop and hand off to `revise-business-plan` instead, since assemble-business-plan owns only
  the first version).

## 2. Theme-to-step mapping (the plan's section spine)

The assembled plan is organized around the six DE themes, not the 24 files in raw order. Hand
the business-plan-editor subagent this mapping explicitly:

| Plan section | DE steps folded in |
|---|---|
| 1. Who Is Your Customer? | 01 market segmentation, 02 beachhead market, 03 end-user profile, 04 beachhead TAM, 05 persona |
| 2. What Can You Do For Your Customer? | 06 full life cycle use case, 07 high-level product spec, 08 quantified value proposition |
| 3. How Does Your Customer Acquire Your Product? | 09 next 10 customers, 10 define your core, 11 competitive position, **13 + 18 combined acquisition-process narrative** (see reconciliation rule below), 12 DMU (fold into the acquisition narrative at the decision-maker stage rather than as a standalone subsection) |
| 4. How Do You Make Money Off Your Product? | 14 follow-on TAM, 15 business model, 16 pricing framework, 17 LTV, 19 COCA (references the acquisition-process costing from section 3 rather than re-deriving it), explicit LTV:COCA ratio |
| 5. How Do You Design and Build Your Product? | 20 key assumptions, 21 test key assumptions, 22 MVBP |
| 6. How Do You Scale Your Business? | 23 dogs will eat the dog food, 24 product plan |

Note step 12 (DMU) and step 13/18 both land in section 3 — the DMU is the *who* inside the
acquisition process, not a separate topic; write it as a subsection of the same narrative
(who's involved at each stage: economic buyer, champion, end user, blocker) rather than a
disconnected list.

## 3. Required reconciliations — do not let the editor skip these

Instruct the business-plan-editor subagent, explicitly, to perform these three reconciliations
(full detail on how in `agents/business-plan-editor.md`):

1. **Steps 13 + 18 → one acquisition-process narrative.** These two files describe the same
   process at different levels of rigor (13 = the process, 18 = the same process costed and
   staged for COCA purposes). The assembled plan must have exactly one process narrative in
   section 3, with per-stage cost/time/conversion detail folded in, not two separate write-ups.
   Where the two files disagree (different stage counts, different channels, different DMU
   roles), that disagreement must be surfaced as an entry in Key Assumptions & Open Risks, not
   silently resolved by picking one file over the other.
2. **TAM reconciliation (step 4 vs. step 14).** State the beachhead TAM (step 4) and follow-on
   TAM (step 14) side by side with their methodologies. Do not silently add them into a single
   headline number unless the editor confirms the methodologies and timeframes are actually
   compatible — if not, say so and give both numbers with their distinct scope.
3. **LTV:COCA reconciliation (step 17 vs. step 19).** Compute and state the LTV:COCA ratio
   explicitly in section 4. If the ratio is below roughly 3:1, or if either LTV or COCA rests
   on a `key_assumptions` entry with no `test_result` yet, flag that plainly in both section 4
   and Key Assumptions & Open Risks — do not present the ratio as settled fact if it isn't.
   **For a `services` business specifically, a *healthy* ratio needs the same explicit scrutiny
   as an unhealthy one — do not let a strong number alone read as a growth signal.** Step 19's own
   services guidance already carries the instruction to state whether the ratio reflects real
   scalability or is orthogonal to a delivery-capacity constraint (a services business can post an
   excellent LTV:COCA ratio while still being unable to grow revenue without proportionally adding
   headcount) — but that instruction lives in the individual step file, and a less careful drafter
   could omit it there without this assembly step catching the gap. Explicitly re-state the
   capacity-vs-ratio distinction in section 4 whenever `business_basics.business_type: services`,
   regardless of whether the ratio itself looks healthy.
   **For a `consumer_app` business specifically, the opposite case needs the same explicit
   scrutiny: a *weak* ratio built entirely from pre-launch, zero-real-data placeholders (a
   retention curve, a freemium-conversion rate) needs an explicit statement that it reflects
   current-assumption risk, not a proven-unviable business.** Do not let a scary number alone read
   as a verdict on the underlying idea before real data exists to test the assumptions it's built
   on — and do not let that caveat become an excuse to soften or hide a genuinely bad number either;
   state both plainly, the same "not settled, but not hidden or minimized" discipline the services
   caveat above requires in the opposite direction.

## 4. Key Assumptions & Open Risks section

Build this section from data, not vibes:

- Every entry in `key_assumptions` — statement, step it came from, confidence, test plan, and
  test result (or "not yet tested" if `test_result` is null).
- Every `quantitative_claims` entry with `confidence: low` or `ai_risk_flag: true`, called out
  by name.
- Every `risk_log` entry with `status: open` (mention `mitigated`/`accepted` ones too, but
  clearly labeled as such — never omit a risk_log entry regardless of status).
- The two reconciliation flags from step 3 above (13/18 disagreement, TAM methodology
  mismatch, weak LTV:COCA ratio) if applicable.

This section exists so a reviewer never has to go hunting through 24 appendix subsections to
find out what's still shaky. It should be readable as a standalone risk register.

## 5. Appendix

One subsection per step, 01 through 24, each a faithful detailed summary of that step's
`plan/NN-slug.md` (not a verbatim copy — tightened for length, but nothing substantive
dropped). This is where a reader goes for the full depth behind any claim made in the body of
the plan.

## 6. Executive summary — written last

Only after every other section is drafted, write the executive summary. It compresses what was
actually written (not a preview of intentions): the beachhead customer and problem, the
product, the acquisition motion, the unit economics (including the LTV:COCA ratio), the single
biggest open risk, and the ask (if the business-state record has funding intent — check
`founder.notes` and the plan sections for it; if there's no funding ask, summarize what "done"
looks like for the MVBP/next milestone instead).

## 7. Delegate the writing

Call the `business-plan-editor` subagent with: the full theme mapping (step 2), the
reconciliation instructions (step 3), the Key Assumptions & Open Risks data (step 4), and
instruct it to write the appendix (step 5) and executive summary (step 6, last) in that order.
**Also explicitly instruct it to write the mandatory `Confidence & Validation Status` section**
(per `agents/business-plan-editor.md`'s own contract and `docs/AI-RISK-FRAMEWORK.md`), placed
immediately after the executive summary — do not assume the editor will include it unprompted;
name it in the delegation. Tell it explicitly to write to `plan/business-plan.md`. Do not draft
the plan prose yourself — delegate it, then review the output against this SKILL's requirements
before finalizing (theme sections present, both reconciliations visible, LTV:COCA ratio stated,
Confidence & Validation Status section present with all four required parts, executive summary
present and last-written-in-spirit i.e. consistent with the rest of the doc). A plan missing this
section will fail §7.5's gate below — catching its absence here, before the gate call, saves a
round trip.

## 7.5. Mandatory AI-risk gate — before the plan is ready or `stage` advances

Per `skills/risk/ai-risk-review`'s own "Who must call this, and when" table, this skill is a
required caller: invoke `skills/risk/ai-risk-review` against the freshly-written
`plan/business-plan.md`, handing it the whole document (not a summary) plus the `business-slug`,
**after** §7's editor pass and **before** §8's write-back or reporting the plan as ready.

- **PASS** → proceed to §8.
- **BLOCKED** → do not set `stage: "plan_assembled"`, do not report the plan as done. Either fix
  the specific finding(s) and re-run the gate to confirm, or route to the orchestrator for an
  explicit, logged founder override (per `agents/orchestrator.md` Non-negotiable #3 and the gate's
  own override protocol) — this skill does not accept an override itself. There is no third path:
  do not present the plan "with a caveat" instead of resolving this.

This is the one call this skill cannot skip regardless of time pressure — see the gate's own
"MANDATORY GATE" banner. Note the finding's `risk_log` entry ids in your final report per §9.

## 8. Update business-state.json

Read the full file, then write back only these keys (preserve everything else):

- `plan.version = 1`
- `plan.file = "plan/business-plan.md"`
- `plan.history`: leave as-is (empty or absent) — history entries start on the first revision.
- `stage = "plan_assembled"`
- `updated_at`: current ISO-8601 timestamp.

Do not touch `disciplined_entrepreneurship`, `reviews`, `gtm`, `ops`, `connectors`, `cadence`,
or `risk_log` — those belong to other skills/agents.

## 9. Done looks like

- `plan/business-plan.md` exists, has the six theme sections + Key Assumptions & Open Risks +
  Appendix + executive summary (last section written but typically placed first in the
  document), and both required reconciliations are visibly present in the text.
- `skills/risk/ai-risk-review` returned PASS, or every BLOCKED finding was fixed-and-rechecked or
  carries a logged founder override — see §7.5. A plan that skipped this call is not done per this
  plugin's contract even if every number happens to be sourced correctly.
- `business-state.json` has `plan.version = 1`, `plan.file` set, `stage = "plan_assembled"`.
- Report back: the plan's file path, a one-paragraph summary of the biggest open risk you
  surfaced, the LTV:COCA ratio you computed, and the AI-risk gate's PASS/BLOCKED result with any
  `risk_log` ids it wrote.

For the §0a partial-draft path instead: `plan/business-plan-draft.md` exists, is headed
unmistakably as a partial draft, covers only complete leading themes, and `business-state.json`
is untouched. The mandatory gate in §7.5 applies only to the canonical `plan/business-plan.md`
path (per the gate's own required-callers table) — running it on every partial draft would cut
against the point of a fast preview, so it's optional here, not mandatory; use your judgment if
the draft looks like it's about to be shared outside the working session (e.g. the founder wants
to forward it to an advisor) and run the gate then. Report back the themes covered and the next
step(s) needed to unlock the following theme.
