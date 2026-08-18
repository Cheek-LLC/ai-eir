# QA Findings — Round 2: Are the Gates Actually Wired In?

**Scope of this pass.** Round 1 built three blocking gates — `skills/risk/ai-risk-review`,
`skills/risk/privacy-check`, and the connectors mechanism (`agents/connectors-liaison.md` /
`skills/connectors/discover-and-suggest-connector`) — and each gate file itself documents its
"expected callers" (a table, in the case of the two risk gates; a named list in
`agents/connectors-liaison.md`'s own frontmatter description, in the connectors case). This pass
checks, file by file, whether each expected caller's *actual current text* makes the call a real,
unambiguous, blocking step, or just a passing mention, or nothing at all.

**Method.** For every expected-caller pair, I read the caller file in full and classified it:

- **REAL GATE** — the file names the gate skill/agent explicitly, states the call happens at a
  specific point in the workflow, and makes proceeding conditional on a non-blocking result (or
  an explicit, logged override). An agent executing the file's instructions literally would
  actually stop and invoke the gate.
- **VAGUE MENTION** — the gate is named somewhere in the file, but not as a concrete, ordered,
  blocking instruction — e.g. an analogy ("this mirrors what ai-risk-analyst checks"), a call
  routed to the wrong entry point, or a mention with no consequence attached.
- **MISSING ENTIRELY** — the gate is not named anywhere in the caller file. Confirmed by full read
  of the file plus a repo-wide grep for the gate's name/path.

**Result count.** 21 expected-caller pairs checked across the three gates.

| Gate | REAL GATE | VAGUE MENTION | MISSING ENTIRELY |
|---|---|---|---|
| `skills/risk/ai-risk-review` | 2 | 0 | 8 |
| `skills/risk/privacy-check` | 0 | 1 | 6 |
| `agents/connectors-liaison.md` | 0 | 0 | 5 |
| **Total** | **2** | **1** | **19** |

The headline finding: the gates themselves (the three files I own) are well-specified — clear
tables of who must call them, clear blocking/non-blocking logic, clear override protocol. Almost
none of their expected callers actually call them. `skills/business-plan/run-review-council` is
the sole exception and should be the template every other caller is brought up to.

---

## Gate 1: `skills/risk/ai-risk-review` (mandatory before any numeric-claim artifact reaches the founder/council)

Expected callers, per that SKILL.md's own "Who must call this, and when" table.

| # | Expected caller | Verdict | Exact fix needed |
|---|---|---|---|
| 1 | `skills/disciplined-entrepreneurship/04-calculate-the-tam-for-the-beachhead-market/SKILL.md` | **MISSING ENTIRELY** | File has a "Definition of done" section that sets `status: "drafted"` with no call to the gate at all — confirmed no occurrence of "ai-risk" anywhere in the file. Add a step between "Update `business-state.json`" and "Definition of done": *"Before reporting the TAM to the founder or marking this step `drafted`, invoke `skills/risk/ai-risk-review` against this step's `plan/04-...md` and its new `quantitative_claims` entry. Do not report the TAM or set `status: drafted` on a BLOCKED result without a fix or a logged founder override."* Update "Definition of done" to require a PASS (or logged override) as one of its bullets. |
| 2 | `skills/disciplined-entrepreneurship/14-calculate-the-tam-for-follow-on-markets/SKILL.md` | **MISSING ENTIRELY** | Same shape of fix as #1: insert the gate call before "Done means," conditioned on the new `qc-014-*` entries, before `status: "drafted"` is set or the ranked follow-on list is reported. |
| 3 | `skills/disciplined-entrepreneurship/16-set-your-pricing-framework/SKILL.md` | **MISSING ENTIRELY** | Same shape of fix: insert before "Done means," gating on the `qc-016-price` entry, before price points are reported as final. |
| 4 | `skills/disciplined-entrepreneurship/17-calculate-the-ltv-of-a-customer/SKILL.md` | **MISSING ENTIRELY** | Same shape of fix: insert before "Done means," gating on the `qc-017-ltv` entry. |
| 5 | `skills/disciplined-entrepreneurship/19-calculate-the-coca/SKILL.md` | **MISSING ENTIRELY** | Same shape of fix: insert before "Done means," gating on `qc-019-coca` and `qc-019-ltv-coca-ratio`. This is the single most consequential step to fix — it's the plan's core unit-economics gate and currently has zero AI-risk check wired in. |
| 6 | `skills/business-plan/assemble-business-plan/SKILL.md` | **MISSING ENTIRELY** | The gate table requires this call "after `plan/business-plan.md` is written, before the plan is presented to the founder as ready ... [before] setting `stage: "plan_assembled"` and handing off." The file's §8/§9 ("Update business-state.json" / "Done looks like") set `stage: "plan_assembled"` and report the plan as complete with **no gate call anywhere in the file**. Add a new numbered section between current §7 (delegate the writing) and §8 (update business-state.json): *"§7.5 — Mandatory AI-risk gate. Before setting `stage: "plan_assembled"` or reporting the plan as ready, invoke `skills/risk/ai-risk-review` against the freshly-written `plan/business-plan.md`. BLOCKED → do not set `stage`, do not report the plan as done; route to the orchestrator per that skill's override protocol. PASS → proceed to §8."* |
| 7 | `skills/business-plan/revise-business-plan/SKILL.md` | **MISSING ENTIRELY** | The gate table requires this call "after a revised `plan/business-plan-vN.md` is written, before presenting the revision as addressing council feedback." The file's §3 ("Re-synthesize the plan") writes the new version and §5–6 mark items addressed and advance `stage` to `council_review` with **no gate call**. Add a step between §3 and §4: call `skills/risk/ai-risk-review` against the new `plan/business-plan-v{N+1}.md`; a BLOCKED result must be resolved or overridden before §5's "mark items addressed" step runs, since a revision that introduces a new unsourced number shouldn't be reported as having addressed council feedback. |
| 8 | `skills/business-plan/run-review-council/SKILL.md` — pre-council call | **REAL GATE** | None. §1 ("Mandatory pre-council AI-risk gate") is exactly the pattern every other caller should copy: names the gate skill explicitly, states it runs before any persona is convened, and gives an unambiguous BLOCKED/PASS branch with what each means operationally. |
| 9 | `skills/business-plan/run-review-council/SKILL.md` — post-verdict integrity call | **REAL GATE** | None. §7 ("Post-verdict AI-risk council-integrity gate") is equally concrete: names the call, states what it does and doesn't gate, and requires the finding to be written into the review file, not left as a conversational aside. |
| 10 | Any `skills/gtm/*` skill producing a fundraising deck brief or investor-facing document with numbers — concretely, `skills/gtm/fundraising-deck-prep/SKILL.md` | **MISSING ENTIRELY** | The skill's "Write-back" section reports the LTV:COCA ratio and hands off with no gate call — confirmed no "ai-risk" occurrence in the file, despite the file itself acknowledging "An unsourced number in a fundraising deck is a real risk... do not let one through uncited" (§4 of "What you read"). Add a step at the end of "Deliverable 1," before "Deliverable 2: the actual deck": *"Before handing this brief to the `pptx` skill or reporting it as ready, invoke `skills/risk/ai-risk-review` against `gtm/fundraising-deck-brief.md`. Do not proceed to the deck build on a BLOCKED result without a fix or logged override — an investor deck is exactly the artifact this gate exists to protect."* |

**Root cause pattern:** every DE-step skill (04/14/16/17/19) and the two business-plan synthesis
skills end with a "Done means" / "Update business-state.json" section that sets status/stage and
reports completion — and none of them insert the mandatory gate call before that report, even
though the gate's own file explicitly names each of them as a required caller. The fix is
mechanical and identical in shape across all 8 missing pairs: one new instruction, placed
immediately before the file's existing "mark as done / report to founder" step, naming the gate
skill, the exact artifact to hand it, and the BLOCKED/PASS branch.

---

## Gate 2: `skills/risk/privacy-check` (Mode A onboarding notice; Mode B mandatory pre-send gate)

Expected callers, per that SKILL.md's own "Who is expected to call this gate" table.

| # | Expected caller | Verdict | Exact fix needed |
|---|---|---|---|
| 1 | `skills/interview/onboarding-interview/SKILL.md` (Mode A, once, right after business basics are captured) | **MISSING ENTIRELY** | Confirmed by full read: the file's "Closing the onboarding interview" section (5 steps) never mentions `privacy-check` or `privacy-compliance-officer`, and there is no other point in the file where it's called either — the skill goes straight from capturing `business_basics` to handing off to the orchestrator. Insert a new step between "Phase 2 — Business-type framing" and "The vague-answer playbook" (i.e., right after business basics are captured, matching the gate's own required timing): *"Once business basics are captured, invoke `skills/risk/privacy-check` in Mode A before proceeding to the vague-answer/I-don't-know phases of the interview. This is a one-time, mandatory call — check for an existing `privacy-onboarding-<slug>` `risk_log` entry first per that skill's own instructions."* |
| 2 | Any `skills/gtm/*` skill, before an external send (list import, CRM sync, ad audience push) | **MISSING ENTIRELY** | None of the five `skills/gtm/*` files (`positioning-and-messaging`, `content-calendar`, `outbound-sales-playbook`, `fundraising-deck-prep`, `launch-plan`) reference `privacy-check` or `privacy-compliance-officer` anywhere — confirmed by grep across `skills/gtm/`. In the plugin's current design these skills write markdown artifacts (a playbook, a calendar, a brief) rather than performing the send themselves, so there may be no live gap *yet* — but the moment any of these (most plausibly `outbound-sales-playbook`, which explicitly produces a "target tracker" of real prospect names/emails) is extended to actually push that list into a connector, the call must exist. Recommend the owning reviewer add an explicit note to `outbound-sales-playbook/SKILL.md`'s "Write-back" section: *"This skill produces the playbook only; it does not send anything. The agent/skill that actually loads this target tracker into an email tool or CRM must call `skills/risk/privacy-check` (Mode B) immediately before that send — this file does not perform that send itself."* — so the gap doesn't get silently inherited by whichever future skill adds the real send. |
| 3 | Any `skills/ops/*` skill, before an external send (analytics/finance/payments sync) | **MISSING ENTIRELY** | Same shape as #2: `kpi-dashboard-setup`, `weekly-metrics-review`, and `runway-and-burn-tracking` all currently work from founder-*reported* numbers typed into the conversation, not a live pull from a connected analytics/accounting tool — so there is no live send today. Same recommendation: add a one-line note to `skills/ops/kpi-dashboard-setup/SKILL.md` (the skill most likely to grow a live analytics-connector pull, per `docs/CONNECTORS-CATALOG.md`'s `google-analytics` row) stating that any future live-pull extension must call `skills/risk/privacy-check` (Mode B) first. |
| 4 | `agents/connectors-liaison.md`, before actually moving real data through a newly-wired connector | **VAGUE MENTION** (real, blocking call — but to the wrong entry point) | `agents/connectors-liaison.md` §4 ("Privacy gate — before any real data flows") does call for a mandatory, blocking check every time, with real teeth (it will not let the calling agent proceed without a verdict, and treats the officer being unavailable as a blocking gap, not a pass) — that part is genuinely well-built. But the text says *"Call `agents/risk/privacy-compliance-officer.md`'s privacy-check gate"* — i.e., it invokes the **subagent directly**, bypassing `skills/risk/privacy-check` (the actual callable gate entry point that `privacy-check/SKILL.md` itself says other skills should call, and that owns the Mode A/B framing, the calling-contract fields, and the override bookkeeping). `privacy-check/SKILL.md`'s own table lists `agents/connectors-liaison.md` as an expected caller of *the skill*, not the agent. **Fixed in this pass** (I own `agents/connectors-liaison.md`) — see "What I tightened" below; §4 now names `skills/risk/privacy-check` (Mode B) as the call target, with the required calling-contract fields spelled out inline. |

**Root cause pattern:** identical to Gate 1 — the gate's own table is accurate about who should
call it, but three of the four callers never do, and the fourth calls the right underlying agent
through the wrong door. Items #2 and #3 are a softer finding than #1 (no artifact in the repo
today performs a literal external send from a `skills/gtm/*` or `skills/ops/*` skill), but the
gap is real the moment one is added, and nothing in either family of skills currently documents
that obligation for whoever builds that extension next.

---

## Gate 3: `agents/connectors-liaison.md` (the one place that touches "a real external tool is needed")

Expected callers, per that agent file's own frontmatter description: *"Callers are expected to be
`agents/gtm/launch-director.md`, `agents/gtm/sales-lead.md`, `agents/gtm/fundraising-advisor.md`,
`agents/ops/growth-analyst.md`, and `agents/ops/finance-controller.md`."*

| # | Expected caller | Verdict | Exact fix needed |
|---|---|---|---|
| 1 | `agents/gtm/launch-director.md` | **MISSING ENTIRELY** | Per `docs/CONNECTORS-CATALOG.md`, this agent is the one that wires up `stripe` (checkout/pricing on the launch page) and `webflow`/etc. (publishing the landing page). Confirmed by full read: the file never mentions `connectors-liaison`. Add a step to "Decide sequencing, then delegate": before or alongside delegating to `marketing-strategist`, name the point at which a launch-page/checkout connector need is identified and delegate to `agents/connectors-liaison.md` with the task/purpose/business-slug per that agent's own "What a calling agent must tell you" contract, and do not report the launch plan as ready to execute until the liaison's status is `available`/cleared or the gap is recorded in `connectors.needed_not_installed[]`. |
| 2 | `agents/gtm/sales-lead.md` | **MISSING ENTIRELY** | Per the catalog, this agent is the expected wirer of `gmail`/`hubspot`/`calendly`. Confirmed by full read: no mention of `connectors-liaison` anywhere — the file delegates straight to `skills/gtm/outbound-sales-playbook` and reports done. Add a step after the playbook is produced: if the founder wants to actually start executing the sequence (not just have the document), delegate to `agents/connectors-liaison.md` for the email/CRM connector before any real send is attempted — state plainly in "What you write back" that the playbook being complete is not the same as the outbound tooling being wired and cleared. |
| 3 | `agents/gtm/fundraising-advisor.md` | **MISSING ENTIRELY** | Per the catalog, this agent is the expected context for `docusign`/`pandadoc` (sending SAFEs/term sheets). Confirmed by full read: no mention of `connectors-liaison`. This is lower-urgency than #1/#2 since the current skill only produces a deck brief, not a signed-document send — but if/when this agent's scope grows to actually sending term sheets, the delegation must exist. Recommend adding a one-line forward-note in "What you do," parallel to the note recommended for `outbound-sales-playbook` above. |
| 4 | `agents/ops/growth-analyst.md` | **MISSING ENTIRELY** | Per the catalog, this agent is the expected context for `google-analytics`/`plausible`/`posthog`. Confirmed by full read: the file explicitly works from founder-reported numbers only (see "Never fabricate") and never mentions `connectors-liaison` — there's no live-pull path today. Recommend the same forward-note pattern: if `kpi-dashboard-setup` or `weekly-metrics-review` is ever extended to pull live analytics instead of asking the founder, that extension must delegate to `agents/connectors-liaison.md` first. |
| 5 | `agents/ops/finance-controller.md` | **MISSING ENTIRELY** | Per the catalog, this agent is the expected context for `quickbooks`/`xero` (reconciling Stripe payouts, tracking burn). Confirmed by full read: the file works entirely from founder-reported cash/spend/revenue figures (see "The core discipline: real numbers, every time") and never mentions `connectors-liaison`. Same forward-note recommendation as #4 — and note this is the catalog's own "Highest-sensitivity category" (full bank-linked financial visibility), so when a live accounting-sync path is added, the connector delegation is not optional. |

**Root cause pattern:** `agents/connectors-liaison.md` is comprehensively specified on its own
side (identify → check → surface → gate → record, all mandatory, all logged) but literally none
of its five named expected callers reference it. Three of the five (`launch-director`,
`sales-lead`, `fundraising-advisor`) are GTM agents whose whole job is to move toward a real
external action (checkout, outreach send, signed documents) and currently stop one step short of
that action without ever routing through the liaison. The other two (`growth-analyst`,
`finance-controller`) currently only consume founder-reported numbers, so the gap is latent
rather than live — but nothing in either file documents that boundary, so a future extension could
easily add a live connector pull without ever discovering the liaison exists.

---

## Note on `docs/DATA-CONTRACT.md` (not edited — out of scope for this pass)

No schema change is strictly required to fix the findings above — every fix is a *process*
instruction (call the gate at point X), not a new field. One thing worth flagging to the
Data-Contract owner for a future pass, not fixed here: `quantitative_claims[].ai_risk_flag` and
`risk_log` entries currently have no field that records *which specific `ai-risk-review` gate
invocation* cleared or blocked a given artifact/version — so there's no mechanical way, later, to
confirm "step 04's TAM was actually gated before `plan/04-...md` was marked `drafted`" versus
"the risk_log entry exists for an unrelated reason." If the eight `MISSING ENTIRELY` gate calls
above get wired in, consider adding an optional `gated_by` (risk_log entry id) field to the
`disciplined_entrepreneurship[NN].` step-status object and to `plan.history[]` entries, so a gate
call becomes auditable against the specific artifact version it cleared, not just inferable from
timing. This is a suggestion for whoever owns `docs/DATA-CONTRACT.md`, not a finding against a
specific caller file.

---

## What I tightened in the gate files themselves (Part B of this pass)

I own exactly: `agents/risk/ai-risk-analyst.md`, `skills/risk/ai-risk-review/SKILL.md`,
`docs/AI-RISK-FRAMEWORK.md`, `agents/risk/privacy-compliance-officer.md`,
`skills/risk/privacy-check/SKILL.md`, `docs/PRIVACY-AND-DATA-HANDLING.md`,
`agents/connectors-liaison.md`, `skills/connectors/discover-and-suggest-connector/SKILL.md`,
`docs/CONNECTORS-CATALOG.md`. I did not touch any GTM/ops/business-plan/DE-step/council file —
those fixes are the table rows above, for whichever reviewer owns each file this round.

Within the nine files I own, I added a clearly labeled **"MANDATORY GATE — DO NOT SKIP"** callout
block to each gate's entry point (`ai-risk-review/SKILL.md`, `privacy-check/SKILL.md`,
`connectors-liaison.md`), stating explicitly, in one place, at the top of the file:

- What to pass in (the exact fields the calling contract requires).
- What a blocking vs. non-blocking result looks like, in plain terms.
- What happens if a caller skips the gate anyway (named as a violation of this file's contract,
  not left implicit).

I also fixed the one concrete bug found in my own files: `agents/connectors-liaison.md` §4 was
calling `agents/risk/privacy-compliance-officer.md` directly, bypassing `skills/risk/privacy-check`
— the actual documented entry point. It now names `skills/risk/privacy-check` (Mode B) as the call
target, consistent with that skill's own "who is expected to call this gate" table.
