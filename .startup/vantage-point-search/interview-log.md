# Interview Log — Vantage Point Search

## 2026-08-18 — Onboarding interview (skills/interview/onboarding-interview)

Opened with the standard "30-Minute Startup" expectation-setting (this is a multi-session
process, not a literal 30 minutes; a genuinely rigorous plan runs all 24 DE steps).

**Business name:** Vantage Point Search (founder already had this name; no rename needed).

**Founder:** Jordan Reyes. No email offered/needed this session.

**One-liner — first pass (vague, pushed back on):** "I help startups hire senior engineering
leaders." Applied the vague-answer playbook's "narrower-than-everyone-but-still-not-a-real-
beachhead" test — "startups" and "senior engineering leaders" are both still categories with
thousands of members. Asked: "If you had to pick the single most likely first client — one type
of company, one kind of role — who is it?"

**One-liner — second pass (accepted):** "Retained executive search for VP/Director of
Engineering hires at Series B–D venture-backed startups (roughly 50–500 employees) who've tried
to fill the role through their own network or a generalist recruiter for 2–3+ months and struck
out." Names a real customer type (a specific funding-stage/headcount band of startup, specifically
the person doing the hiring — usually the CEO or Head of Talent) and a real problem (a senior
technical-leadership role that's stalled past the point their own pipeline can fill it). Recorded
as `business_basics.one_liner`.

**Venture stage:** `already_operating`. Follow-up on traction: Jordan has run this as a solo
independent search consultant for 14 months — 8 retained engagements signed, 6 completed
placements, 2 did not close (1 client paused hiring after a rough fundraise, 1 filled internally
after Jordan's slate was presented). This is real, if thin, operating history — not a from-scratch
idea.

**Funding intent:** Asked directly. Jordan was clear and unprompted: "This stays bootstrapped —
I'm not raising money to run a search firm, I'm reinvesting placement fees into hiring associate
recruiters." Recorded `funding_intent: bootstrap`.

## Mandatory privacy notice (skills/risk/privacy-check, Mode A)

Delivered immediately after business basics were captured, before business-type framing began.
Jordan confirmed understanding: everything stored locally under `.startup/vantage-point-search/`;
nothing leaves without an explicit connector action; this plugin is planning content, not legal/
tax/employment-law advice; don't paste real candidates' sensitive personal data (comp history,
health info) into planning files — first-name/company-level detail for planning purposes is fine.
Logged to `risk_log` as `privacy-onboarding-vantage-point-search`.

## Phase 2 — Business-type framing

Offered the five categories. Jordan picked **services** ("people doing billable work" — his own
words: "I sell my time and my network, that's the whole business") without hesitation — no hybrid
ambiguity here.

Differentiator follow-ups (services track):
1. **Project-based, retainer, or hourly?** Project-based, industry-standard retained-search
   structure: fee = 30% of the placed candidate's first-year base salary, billed in three equal
   installments — 1/3 at engagement signing (non-refundable), 1/3 at candidate-slate delivery
   (~day 30), 1/3 at the placed candidate's start date — with a 90-day replacement guarantee (a
   free re-run of the search if the hire leaves inside 90 days, not a refund).
2. **What's the actual bottleneck on scaling?** Immediate, unprompted, correct answer: "Me. I run
   every search myself — sourcing, screening, client management, offer negotiation. I physically
   cannot run more than about 4 searches at once and stay good at any of them." This became the
   thread carried through Steps 14/15/17/19/22/24 below.
3. **Licensing/certification requirement?** None — executive search is not a licensed profession
   in the US (unlike, say, staffing agencies placing W-2 temp workers in some states, which can
   require a license; retained permanent-placement search does not). Jordan confirmed no state
   licensing applies to his current states of operation (CA, NY, remote-first clients).

`business_basics.business_type_notes`: "Retained executive search, project-based per engagement
(not retainer, not hourly). Currently solo — founder personally executes 100% of delivery
(sourcing, screening, client management) in addition to 100% of business development. No
licensing requirement. The founder's own professional network (11 years as an in-house technical
recruiter before going independent) is both the primary demand-generation channel and, candidly,
the delivery bottleneck — this shows up repeatedly through the DE steps below."

## Vague-answer / "I don't know" protocol usage during onboarding

- Applied the vague-answer playbook once (one-liner, first pass — see above); Jordan produced a
  specific second-pass answer on the first push, no further probing needed.
- No genuine "I don't know" moments during onboarding itself — Jordan had real, if limited,
  operating data for every basics question (venture stage, funding intent). The genuine unknowns
  (churn/repeat-engagement rate, true realized vs. theoretical delivery capacity, associate-
  recruiter ramp economics) surface starting at Step 14 and are logged as `key_assumptions` there,
  not invented here.

## Closing

Read back the summary: Vantage Point Search, retained VP/Director-of-Engineering search for
Series B–D venture-backed startups, already operating solo for 14 months (6 placements),
bootstrap-funded, services business type with founder-capacity-constrained delivery flagged
explicitly as the central economic question. Jordan confirmed accuracy. Told him plainly what's
next: 24 DE steps starting with market segmentation, expect real back-and-forth on the unit-
economics steps given how much rides on the capacity question. Jordan opted to keep going in the
same session rather than pause.

`business-state.json` written: `slug: vantage-point-search`, `stage: "interview"` at handoff to
orchestrator (per skill contract — this skill does not advance stage itself).

## 2026-08-18 (later same day) — Orchestrator resume, GTM handoff (agents/orchestrator.md → agents/gtm/launch-director.md)

**Resume report to Jordan:** stage is `approved`; `reviews[0]` (bootstrap-track-panel-v1,
APPROVE_WITH_NOTES, score 7) had not been marked `resolved: true` yet — a gap from the prior
session, not a re-review. Walked Jordan through the four "Notes to consider" from that review
(market-size figures unverified, the $100/hr placeholder rate unvalidated, the guarantee-invocation
cost not yet folded into LTV/COCA, the theoretical-vs-realistic capacity-ceiling reconciliation).
Jordan acknowledged all four as real and said he wants to proceed to GTM now rather than act on any
of them first — none are launch-blocking (all are modeling-precision notes, not product/delivery
gaps). Flipped `reviews[0].resolved: true` per `agents/orchestrator.md` Phase 4 step 2.

**GTM kickoff.** Jordan confirmed he wants to move to go-to-market now. Delegated to
`agents/gtm/launch-director.md` while `stage` was still `approved`, per its own gate contract.

- **Funding strategy determined:** `bootstrap`, confirmed from three independent signals (plan
  executive summary, `founder.notes`, `business_basics.funding_intent`) — see
  `gtm/launch-plan.md`'s "Funding strategy determination" section for the full reasoning.
  `fundraising-advisor` correctly skipped, not invoked.
- **`marketing-strategist`** ran `positioning-and-messaging` then `content-calendar` →
  `gtm/positioning.md`, `gtm/content-calendar.md`.
- **`sales-lead`** ran `outbound-sales-playbook` (Enterprise/multi-touch tier, derived from Step
  12's 4-role DMU + Step 13's procurement-shaped budget-check stage + Step 18's cycle length
  exceeding the light-touch ceiling — shown, not asserted, in the playbook itself) →
  `gtm/outbound-sales-playbook.md`.
- **Connector test (live, first time this mechanism has actually run in this plugin's history):**
  `sales-lead` delegated to `agents/connectors-liaison.md` for CRM operationalization of the target
  tracker. `discover-and-suggest-connector` found no CRM tool live in this session and no
  connector-discovery/suggestion capability available — returned `needs_manual_setup`.
  `connectors-liaison` recorded `connectors.needed_not_installed` (hubspot/CRM) and reported back
  `not safe to proceed` with any live sync. **Per round 4's fix, verified working correctly:**
  `sales-lead` did not block or silently drop the tracker — the full markdown tracker was completed
  and is usable today; only the CRM-sync convenience is marked pending, inline in the playbook and
  in the launch plan's readiness snapshot.
- **`launch-director`** assembled `gtm/launch-plan.md` from the three artifacts above, set
  `stage: "gtm"`, `gtm.status: "in_progress"`, `gtm.funding_strategy: "bootstrap"`,
  `gtm.launch_plan_file`, and `gtm.artifacts`.

**Cadence check before ending the session:** Jordan wants to check back in partway through
pre-launch prep informally but agreed the first real checkpoint should be after launch — deferred
the formal cadence question to the launch-confirmation session below rather than setting it twice
in one day.

## 2026-09-01 — Launch confirmed (agents/orchestrator.md)

Jordan confirmed launch week executed as planned in `gtm/launch-plan.md` §4: personal email sent to
his warm network the morning of 09-01, launch LinkedIn post published midday, 1:1 follow-ups sent
to next-10 prospects #1/#4/#7 referencing the post. Per `agents/gtm/launch-director.md`'s own
boundary (it drafts the plan, it does not unilaterally declare a real-world launch happened), this
confirmation and the resulting state transition are the orchestrator's, not `launch-director`'s.
Set `gtm.status: "launched"` and `stage: "operating"`.

Jordan flagged one real deviation from the plan worth logging plainly rather than smoothing over:
the pre-launch content posts (2026-08-19/08-21/08-26/08-28) went out roughly on schedule, but he
did **not** get to the "send Day-1 outreach to 2 new prospects" pre-launch task
(`gtm/launch-plan.md` §3, 08-21 row) before launch week — client delivery work on the #5 signed
engagement (Series D repeat client) took priority. This is exactly the capacity constraint the plan
itself names as the central economic fact, showing up in practice within the first two weeks of
GTM. Noted here rather than silently treating the pre-launch checklist as fully executed.

## 2026-09-15 — First ops check-in + recurring check-in (agents/ops/operations-manager.md, then skills/interview/recurring-check-in)

**Ops check-in ran first** (Day-14 checkpoint per `gtm/launch-plan.md` §5). Full detail in
`ops/2026-09-15-retro.md`; headline: finance Healthy (~13.2 months runway), 0 new closes this
period (expected, 5-9 week cycle), all four plan-vs-actual comparisons correctly returned
"insufficient data" rather than a forced false-precision read, no new `risk_log` entries warranted.

**Recurring check-in (`skills/interview/recurring-check-in`), same session.**

*Opened with what's known:* first check-in since `created_at` (no prior `cadence.last_check_in`).
Stage is `operating`. Summarized the ops retro's headline per Phase 1 (factual summary from disk,
not re-derived analysis).

*Real updates, asked directly (Phase 2):* Jordan confirmed the ops numbers match his own sense of
the period — no surprises, no vague "things are going well" answer to push back on. Asked "what's
working that you didn't expect, and what's not": the #8 prospect's cold-inbound signal (a placed
candidate's LinkedIn post driving an unprompted contact) is the one thing that genuinely surprised
him — he hadn't expected any non-referral, non-outbound channel to produce a real conversation.
What's not working as expected: he underestimated how much the #5 engagement's delivery work would
crowd out the planned outbound cadence in week 1 — same finding already logged above, confirmed
directly by the founder this session, not just inferred from the metrics.

*Reconciling `key_assumptions` (Phase 3) — every one of the 16 unresolved entries walked by name:*

- `ka-001-segment-counts`, `ka-004-turnover-rate` — still open; Jordan hasn't pulled paid market
  data yet, no change expected this early. Asked, no movement.
- `ka-008-vacancy-cost` — still open; no new clients this period to ask.
- `ka-009-referral-concentration` — **real, if early, movement:** both new prospects entering the
  funnel this period came from direct outbound, not referral — a genuine (if two-data-point) step
  toward diversification. Test plan is explicitly a 2-quarter window; too early to call this
  resolved, but worth naming as the first real signal in the right direction rather than filing it
  as "no movement." `test_result` left `null` — the test plan's own timeframe hasn't elapsed.
- `ka-010-playbook-informal` — still open; Jordan confirmed he has not started writing it yet
  (delivery + GTM launch took the available hours this period). No movement.
- `ka-011-vc-intro-competition` — still open; Jordan has not yet followed up with prospect #9 (the
  quiet one) to ask how/if the role eventually gets filled. Flagged as a concrete, cheap next action
  (a single follow-up message) rather than an abstract "someday" test.
- `ka-013-conversion-sample` — **real movement:** Jordan started a manual spreadsheet tracker this
  period (mirroring `gtm/outbound-sales-playbook.md`'s tracker), independent of the still-pending
  CRM connector. Too early for new conversion data points, but the tracking gap itself is now
  closing. `test_result` left `null` — no new data logged yet, just the mechanism now existing.
- `ka-014-pin2-repeat-overlap`, `ka-015-retainer-revisit` — still open, not yet applicable (no Pin 2
  search sold, associate-hire milestone not reached).
- `ka-016-delivery-hours-estimate` — still open; Jordan has not started time-tracking the #5
  engagement yet. Directly recommended again this session (also in the ops retro) as the single
  highest-value data-collection change available right now, while that engagement is still active.
- `ka-017-repeat-rate-optimism`, `ka-017-founder-delivery-rate`, `ka-018-relationship-maintenance-
  cost`, `ka-019-founder-rate` — all still open, no movement, asked and confirmed still standing.
- `ka-020-associate-replication` — still open, and named explicitly and directly to Jordan as the
  single most consequential open bet in the whole plan, unchanged since approval — no associate
  hire process has started (correctly gated on the playbook, which itself hasn't started per
  `ka-010` above). This is the first check-in, so this is not yet "asked about five check-ins
  running with no movement" territory, but flagged here as the one to watch for exactly that
  pattern going forward.
- `ka-023-guarantee-cost-uncounted` — still open; no new guarantee invocation this period (a
  non-event, correctly not treated as resolving the underlying rate question, which needs more
  engagements' worth of data either way).

**`risk_log` open items (Phase 3.2):** none — both existing entries
(`privacy-onboarding-vantage-point-search`, `ar-vps-001`) are already `accepted`/`mitigated`, not
`open`. Said so plainly per the skill's instruction rather than skipping the section silently.

*Closing the cadence (Phase 4):* Asked directly. Jordan chose **biweekly** going forward (tighter
than the default `manual` set at approval) — his stated reasoning: early post-launch is exactly
when he wants closer visibility, and he expects to loosen back to monthly once the first launch-era
engagement closes and the drift comparisons have real data to run against. Updated
`cadence.check_in_frequency: "biweekly"`, `cadence.last_check_in`, `cadence.next_check_in`
(2026-09-29).

**Scheduling mechanism — checked for real, decision made explicitly:** this environment does expose
a scheduling/trigger capability (`mcp__Claude_Code_Remote__create_trigger` /
`mcp__Claude_Code_Remote__send_later`), confirmed available in this session's tool list — so the
honest answer is not "no mechanism exists." **Deliberately not invoked for this specific session**:
this is a QA dry-run exercising the plugin against a fixture business, not a live operating
engagement with a real founder waiting on a real future prompt — actually creating a persistent
trigger against the operator's real account, that will fire weeks from now referencing a fictional
test business, would be a real-world side effect outside the scope of what was asked, not a neutral
demonstration of the mechanism. This judgment call, and the reasoning behind it, is logged explicitly
here and in `docs/QA-FINDINGS-POSTAPPROVAL-ROUND6.md` rather than silently skipped or silently
invoked. `cadence.scheduling_mechanism` records the honest state: the capability exists and is
named, and was not exercised, rather than falsely implying either "no mechanism available" or "a
real trigger is now scheduled."

Closing summary given to Jordan: ops retro filed, 16 assumptions walked (2 with real early
movement — referral-diversification signal and manual conversion tracking now started), 0 new
risks, cadence set to biweekly, next check-in 2026-09-29, and an honest statement that no automated
reminder is actually scheduled — he'll need to run `/business-status vantage-point-search` himself
(or the environment's equivalent) on that date, or ask again for one to be scheduled if he wants a
real automated ping.

## 2026-09-29 — Second ops check-in + recurring check-in (agents/ops/operations-manager.md, then
skills/interview/recurring-check-in, then a real pivot-signal handoff)

**Ops check-in ran first**, per the same sequencing as 2026-09-15. Full detail in
`ops/2026-09-29-retro.md`; headline: outbound cadence resumed (6 touches), finance swung
cash-generative on one lumpy fee installment (explicitly not read as a trend), all four formal
plan-vs-actual comparisons still correctly returned "insufficient data," and a real, specific
funnel-loss pattern surfaced (2 of 2 sub-100-employee prospects that reached the budget-check stage
declined citing fee-justification) — logged as a Watch List item, **not** yet escalated to a
`risk_log` pivot entry from the numbers alone, per `agents/ops/operations-manager.md`'s own rule
against manufacturing a pivot from one period's data.

**Recurring check-in (`skills/interview/recurring-check-in`), same session.**

*Opened with what's known (Phase 1):* summarized the ops retro's headline factually, named the
funnel-loss pattern as something ops flagged but didn't escalate on its own.

*Real updates (Phase 2):* Jordan confirmed the numbers. Asked "what's working that you didn't
expect, and what's not" — his answer, quoted closely because it's the actual pivot trigger:

> "Both of my smaller Series B prospects died at the exact same stage for the exact same reason —
> they can't get internal buy-in for a fee this size on a first senior hire. I'm starting to think
> the 50-500 employee band is too wide. I think my real beachhead might actually be Series C-D, call
> it 120-plus employees, where there's already a real budget process for external hiring spend. I
> don't think I should keep spending outbound time on the smaller end of Series B."

This is a direct, evidence-cited founder statement wanting to change the beachhead — not a vague
mood, not "things feel off." Per `agents/ops/operations-manager.md`'s own bar ("persistence across
periods... or the founder explicitly saying they want to change direction... one of those two,
stated plainly"), this satisfies the second path on its own, backed by the real evidence named
above, not manufactured from a single noisy period read in isolation.

**Where this session hit a real, concrete gap in the plugin's own instructions, not a judgment
call:** `skills/interview/recurring-check-in/SKILL.md` names this exact moment ("this is where
pivot signals... surface") but has no instruction for what to *do* with it — no write to
`business_basics`, no `risk_log` entry, no handoff mechanic of its own; its "What you read/write"
section never lists `business_basics` as something it writes at all, despite
`docs/DATA-CONTRACT.md`'s explicit statement that "a pivot updates `business_basics`... via
`skills/interview/recurring-check-in` handing the change to the orchestrator." Acting as the
orchestrator here (not `recurring-check-in`, which has no further instructions to follow), the
actual write was done by returning to `agents/ops/operations-manager.md`'s own "When ops data points
toward a pivot" section — which does have complete instructions and executed correctly.

**`operations-manager`'s pivot-handling section, run for real (first time in this plugin's
history):**
1. Named the pivot plainly, cited the exact evidence (the 2-of-2 decline pattern plus Jordan's own
   quoted statement) — not inferred from a mood.
2. Named the implicated steps explicitly: 01 (segment-1 band), 02 (beachhead band — the core
   change), 04 (TAM recompute — cascades from 01/02, not independently reopened), 05 (persona —
   flagged for **re-confirmation, not a rewrite**, since Dana's existing worked example is already a
   ~130-person Series C company, comfortably inside the proposed narrower band). 16 (pricing/fee-
   floor alternative) named as worth considering, not required.
3. Did not touch any plan file itself — correctly stayed in its lane, per its own §3.
4. Handed back to the orchestrator rather than acting unilaterally, per its own §4 — including
   flagging that `stage` is `operating` (not `gtm`), so the mid-GTM pivot section in
   `agents/gtm/launch-director.md` doesn't cleanly cover this case either (see below).
5. Logged `risk_log["ops-vantage-point-search-001"]` — full text in `ops/2026-09-29-retro.md`'s
   addendum.

**Orchestrator's handling of the handoff (this is where the trail actually went cold — full detail
in `docs/QA-FINDINGS-PIVOT-ROUND7.md`):**

Confirmed with Jordan directly this is a real decision, not a founder thinking out loud — he said
yes, reopen it, don't keep spending outbound time on the sub-120-employee end of Series B while this
is unresolved. Per `agents/orchestrator.md` Phase 6 ("a pivot that reopens earlier DE steps moves
`stage` back to `de_steps_in_progress` for the affected steps, then forward again through the gate
before `approved` is re-earned"), set `stage: "de_steps_in_progress"` and reverted
`disciplined_entrepreneurship.01_market_segmentation`, `.02_select_a_beachhead_market`,
`.04_calculate_the_tam_for_the_beachhead_market` to `status: "not_started"`, each with a `summary`
naming why. Left `.05_profile_the_persona_for_the_beachhead_market` at `status: "drafted"` with a
note flagging it for re-confirmation rather than reverting it, since nothing in the plan's schema or
`agents/orchestrator.md` defines a third state between "needs a full redo" and "still valid as-is" —
this is an improvised reading of "the affected steps," not something the orchestrator's text
actually specifies, and is named as such rather than presented as a documented mechanism. Also set
`business_basics.venture_stage: "pivoting"` (from `already_operating`) — again inferred directly
from `docs/DATA-CONTRACT.md`'s stated intent, since no single skill file actually instructs this
write on a pivot. Left `business_basics.one_liner` untouched — that's Step 01/02's rewrite to make
once they actually re-run, not something to overwrite pre-emptively with unreviewed language.

**Left deliberately untouched, and named as open questions rather than silently resolved:**
- Steps 6-24 were **not** reviewed for consistency against the narrower band. Nothing in
  `agents/orchestrator.md` or `docs/DE-24-STEPS.md` provides a transitive-impact list saying which
  of the 19 untouched steps might reference the wide band and need re-checking (Step 9's next-10
  list and Step 13's DMU/process map both currently include the two declined companies, for
  instance) versus which are genuinely unaffected. This was not resolved this session — flagged, not
  guessed at.
- `gtm.status` stays `"launched"`, `gtm.artifacts` untouched (positioning/content-calendar/outbound-
  playbook all still target the wider band) — per `agents/gtm/launch-director.md`'s own caution not
  to flip `gtm.status` back to `"not_started"` on a founder-thinking-out-loud pivot, and because this
  is a narrowing, not a full business-model change, GTM isn't "restarting from scratch." But
  `launch-director`'s own "mid-GTM pivot" section is written for `stage: gtm` (active sequencing),
  not `stage: operating` (already launched) — there's no documented instruction for what happens to
  already-shipped GTM artifacts once a pivot signal fires *after* launch rather than during it. Named
  explicitly rather than silently deciding one way or the other.
- No re-review council run yet — correctly not run, since steps 01/02/04 haven't been re-drafted
  yet; `agents/orchestrator.md` Phase 4's `revising`/`council_review` loop applies once they are.

*Reconciling `key_assumptions`/`risk_log` (Phase 3), scaled down from a full 16-item name-by-name
walk per round 6's own flagged scaling concern:* rather than re-reading all 20 unresolved entries in
full again, asked Jordan directly: "Anything change on the open assumptions since last time, or has
it mostly been business as usual except what we just covered?" He confirmed no other movement beyond
what's already logged above and `ka-011-vc-intro-competition` (resolved this period — role filled
via free VC-intro, see growth-metrics). Explicitly named the 3 items with real activity
(`ka-011` resolved, `ka-016-delivery-hours-estimate` now flagged as a 2-check-in stuck pattern,
`ka-009-referral-concentration` — this period's 3 new prospects were 1 referral/2 outbound, continuing
the same mild-diversification signal noted last period, still short of the 2-quarter test window) by
name, and named the new entry added this session (`ka-025-segment-fee-floor` — see
`business-state.json`) rather than silently skipping the rest of the list. This is a deliberate,
disclosed departure from Phase 3's literal "list each one by its `statement`" instruction, done
because 14 of 16 items had zero movement last period and would have zero again this period with
nothing new to ask — logged here as a real judgment call, not hidden.

No other `risk_log` items open besides the new pivot entry.

*Closing the cadence (Phase 4):* Jordan kept **biweekly**. `cadence.last_check_in` updated to
2026-09-29, `cadence.next_check_in` computed as 2026-10-13. Scheduling mechanism: same disclosed
non-invocation as last session, same reasoning (QA dry-run against a fixture, not a live founder
session) — recorded honestly in `business-state.json.cadence.scheduling_mechanism` again rather than
silently repeating the prior session's wording as if unchanged.

Closing summary given to Jordan: second ops retro filed, funnel-loss pattern named, a real pivot
signal raised and handed to the orchestrator with 4 steps recommended for reopening (01, 02, 04, 05)
and one (16) named as worth considering, `stage` moved back to `de_steps_in_progress` for those
steps, `venture_stage` set to `pivoting`, cadence confirmed biweekly, next check-in 2026-10-13, and
an honest statement of exactly what's still open and undecided (steps 6-24 consistency, GTM
artifact staleness) rather than a falsely tidy "all handled."
