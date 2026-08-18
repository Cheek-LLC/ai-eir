# QA Findings — Round 6: First Live Post-Approval Run (GTM → Ops → Recurring Check-In)

**Method.** I picked up **Vantage Point Search** (`.startup/vantage-point-search/`) — a retained
technical-executive-search services business, `stage: "approved"` since round 4's real council
review — and drove it, for real, through every stage this plugin has never once exercised live:
`agents/gtm/launch-director.md`'s full sequencing (funding-strategy determination, delegation to
`marketing-strategist` and `sales-lead`, correct skip of `fundraising-advisor`), a real, live
invocation of `agents/connectors-liaison.md` → `skills/connectors/discover-and-suggest-connector`
(confirmed via `ToolSearch` that no CRM tool and no connector-discovery capability exist in this
environment, not assumed), `agents/ops/operations-manager.md`'s first-ever real check-in
(delegating to `growth-analyst`, `finance-controller`, `customer-success-lead`, correctly *not*
invoking `scaling-strategist`), and a full `skills/interview/recurring-check-in` pass walking all
16 open `key_assumptions` by name. Every artifact below is a real file this session wrote and is
still on disk — nothing here is a hypothetical description of what a run would produce.
`scripts/validate-plugin.sh` passes clean (0 warnings, 0 errors) after all changes.

**Simulated timeline, stated plainly.** Consistent with how rounds 1-5 compressed a 24-step/
multi-week DE process into one working session's dated log entries, this round compresses a
GTM-launch-to-first-retro arc into dated `interview-log.md`/`business-state.json` entries spanning
2026-08-18 (GTM kickoff) → 2026-09-01 (launch) → 2026-09-15 (first ops check-in + recurring
check-in), rather than 4 weeks of real wall-clock time passing in this session. This is a
methodology note, not a finding.

**Fixture disposition.** `.startup/vantage-point-search/` now has `stage: "operating"`,
`gtm.status: "launched"`, `ops.status: "active"`, real files under `gtm/` (4) and `ops/` (5), a
`connectors.needed_not_installed` entry, and `cadence` set to `biweekly` with a real
`next_check_in`. `reviews[0].resolved` was flipped `true` — see §1.

---

## 1. Fixed in place: round-4's approved review was left `resolved: false`

**File:** `.startup/vantage-point-search/business-state.json` (`reviews[0]`).

On resume, `stage` was already `"approved"` but `reviews[0].resolved` was still `false`. Per
`agents/orchestrator.md` Phase 4 step 2, an `APPROVE_WITH_NOTES` verdict should be flipped to
`resolved: true` "once you've told the founder what the notes were" — this step was never actually
completed in round 4's fixture, only the stage transition was. Not a plugin bug (the orchestrator's
instructions are unambiguous and I followed them correctly to fix it) — flagged here because it's a
real, concrete example of exactly the kind of drift `agents/orchestrator.md`'s "on resume, always
report before acting" discipline exists to catch, and it was genuinely caught this way: I told
Jordan the four outstanding notes before flipping the flag, per the letter of the instruction, not
just mechanically setting the boolean. **Severity: minor** (self-corrected, no downstream effect,
but worth a fixture-hygiene note for future rounds picking up an `approved`-stage business).

## 2. Significant: `runway-and-burn-tracking`'s formula has no period-normalization step, and this
is the first time it's ever run against a non-monthly cadence

**File:** `skills/ops/runway-and-burn-tracking/SKILL.md`, Step 2.

The skill's runway formula is `runway_months = cash_on_hand / net_burn`, and `net_burn = spend −
revenue (this period)`. The skill is explicitly meant to run "at every recurring ops check-in" per
its own frontmatter, and `cadence.check_in_frequency` can be `weekly`/`biweekly`/`monthly`/`manual`
— but nothing in Step 2 (or anywhere else in the file) instructs normalizing a non-monthly period's
spend/revenue to a monthly figure before dividing into "months" of runway. Applied literally to
Vantage Point Search's real biweekly (14-day) first check-in — cash $34,000, period spend $1,200,
period revenue $0 — a drafter following the letter of the formula would compute `34,000 / 1,200 ≈
28.3` and report **"28.3 months runway,"** more than double the correct, monthized figure
(~13.2 months, computed by scaling the 14-day burn to a 30-day equivalent before dividing). This
is not a hypothetical: I hit exactly this ambiguity while writing `ops/2026-09-15-finance-metrics.md`
and had to improvise the normalization step myself, flagging it explicitly in the output file (see
that file's "Normalization note").

Given `agents/ops/finance-controller.md`'s own stated stakes — "a stale or fabricated number is not
just misleading, it's actively dangerous... a founder can make a real payroll decision off it" —
a silent 2x overstatement of runway on a business's very first biweekly check-in is exactly the
failure mode this agent exists to prevent, just produced by the *skill's own formula* rather than a
fabricated input. The error compounds further at a `weekly` cadence (~4.3x overstatement) or is
understated at a cadence longer than a month (none currently exist, but the same gap would apply in
reverse). **Fix:** add an explicit Step 1b (or fold into Step 2): "If this period is not
approximately one calendar month, normalize this period's net burn to a monthly-equivalent figure
(`period_burn ÷ period_days × 30`) before computing `runway_months`, and state both the raw period
figure and the monthized figure in the output file so the reader can see the normalization, not
just the final number" — mirroring exactly what I did by hand this session. **Severity: significant**
(not blocking — a careful drafter, as demonstrated, can still get it right — but this is the single
highest-stakes number in the entire ops layer per the file's own framing, and the gap survived every
prior round because ops has literally never run before this round).

## 3. Ambiguity, non-blocking here: whether a founder's own personal email send needs the
connectors-liaison gate

**Files:** `docs/CONNECTORS-CATALOG.md` (`gmail` row), `agents/gtm/launch-director.md`,
`agents/gtm/sales-lead.md`.

The catalog's `gmail` row names "GTM — `agents/gtm/launch-director.md` sending the launch
announcement" as the task creating the connector need, without qualifying whether that means *the
agent itself* automating a send through a wired tool, or *the founder personally* sending an email
from their own inbox on the agent's recommendation. I hit this directly at launch: Jordan sending a
short personal email to his own warm-network list from his own inbox is, on one reading, exactly
the "launch announcement" scenario the catalog names as needing the `gmail` connector; on the other
(the reading I used, stated explicitly in `gtm/launch-plan.md` §8), it doesn't need a connector at
all, because no agent action is moving data through a wired tool — the founder is just using email
the way anyone does, outside this plugin's action space entirely. Both readings are defensible, and
the plugin's own docs don't disambiguate them anywhere I could find. Getting this wrong in either
direction is a real problem: reading it too broadly means an agent could tell a founder they
*can't* send their own email without connecting a tool first (a real, unnecessary UX regression);
reading it too narrowly (or letting a caller quietly assume "founder-side" for what's actually an
agent-automated bulk send) would let real prospect/customer data move through an agent-initiated
send with no privacy gate — precisely what `skills/risk/privacy-check` Mode B exists to prevent.
**Fix:** add one sentence to `agents/connectors-liaison.md`'s "MANDATORY GATE" callout (or
`docs/CONNECTORS-CATALOG.md`'s header) stating explicitly: the gate applies when *the agent itself*
initiates or automates an action through a connector it operates — not when the founder is
instructed to personally take an action through their own already-existing tools/inbox. **Severity:
significant** (a real, previously-undocumented ambiguity, first surfaced by an actual launch-day
sequence — but non-blocking this round since I resolved it explicitly and stated my reasoning in
the artifact rather than leaving it silent).

## 4. Ambiguity, non-blocking here (redundant triggers absorbed it): `outbound-sales-playbook`'s
DMU-role count doesn't specify whether soft-influence-only roles count toward the tier decision

**File:** `skills/gtm/outbound-sales-playbook/SKILL.md` §3, tier-decision table.

The table's step 1 instructs: "Count the distinct DMU roles from step 12's table that are populated
with a real, distinct title (not 'same as end user' / blank)." Vantage Point Search's Step 12 DMU
table has 4 rows, but one of them — "internal candidate-slate reviewer" — is explicitly marked "soft
input, not a hard veto in any observed case." The instruction's literal text ("distinct title,"
"not blank") says nothing about veto power, so I counted all 4 rows, landing on the "4+ roles"
Enterprise-tier trigger. Whether a purely-advisory, no-veto role should count the same as a
hard-veto role toward DMU *complexity* is a real, unresolved question — a DMU that's "4 roles, one
of which never actually blocks anything" is arguably less complex than the table's role-count
trigger implies. **This didn't change Vantage Point Search's outcome** — the same row (Enterprise)
is independently triggered by the procurement-shaped budget-check stage in Step 13 and by the
cycle-length exceeding 45 days at the upper end, so the ambiguity was absorbed by redundant
triggers rather than mattering here. It could matter for a different business where role-count is
the *only* signal pointing at Enterprise and one of the counted roles is soft-influence-only.
**Fix:** clarify in the tier table's step 1 whether to count only roles with real veto/blocking
power, or state explicitly that any distinctly-titled role counts regardless of veto power (and
say why). **Severity: minor** (no wrong output produced this round, but a real gap in an otherwise
admirably mechanical decision procedure).

## 5. Minor / design observation: walking all 16 `key_assumptions` by name doesn't scale gracefully
against a tight cadence, though the discipline itself is sound

**File:** `skills/interview/recurring-check-in/SKILL.md`, Phase 3.

This is the first time this skill has run against a business with a genuinely large
`key_assumptions` list (16 unresolved entries) on a tight (`biweekly`) cadence — a combination no
prior round's fixture produced. Following Phase 3 exactly as written ("list each one by its
`statement`, and ask directly") is real, honest work, and I don't think it's wrong — the discipline
against silently letting an assumption go unrevisited is exactly what makes this plugin more
trustworthy than a plan that gets approved once and never re-checked. But doing it for real
surfaced a genuine scale question the skill doesn't address: with 16 items and a 2-week cadence,
most check-ins will legitimately have "no movement" on most items (see `interview-log.md`'s
2026-09-15 entry — 14 of 16 had no real movement this period, correctly reported as such rather
than padded). **Not filing this as a bug** — the skill's own text already permits "leave it, but
note it was asked about again," which is exactly what I did — but flagging it as a real design
tension worth considering: a lighter "anything change on these since we last talked, or should I
walk the full list" opt-out for a founder who's mid-launch and knows nothing's moved might reduce
check-in fatigue without weakening the underlying discipline, especially as `key_assumptions` lists
grow over a business's lifetime and never shrink (per the Data Contract's own "never silently
deleted" rule). **Severity: minor / worth considering, not a defect.**

## 6. Methodological note, not a plugin bug: the cadence-scheduling mechanism was real but
deliberately not exercised live

`agents/orchestrator.md`'s recurring check-in logic instructs checking for a real scheduling/
trigger capability and, if one exists, using it. This session's environment genuinely does expose
one (`mcp__Claude_Code_Remote__create_trigger` / `send_later`) — unlike the connector case (§ below),
this was not a "nothing available" situation. I deliberately did not invoke it: creating a real,
persistent trigger against the operator's actual account that fires weeks from now referencing a
fictional QA fixture business would be a real-world side effect outside this round's actual scope,
not a neutral demonstration of the mechanism. This decision, and the reasoning, is logged explicitly
in `interview-log.md`'s 2026-09-15 entry and in `business-state.json.cadence.scheduling_mechanism`
rather than silently defaulting to either "no mechanism available" (false) or actually spawning the
trigger (an inappropriate side effect for a dry run). **Not a finding about the plugin's own logic**
— a genuine live founder session should invoke the tool exactly as written — but worth recording
because the orchestrator's instructions don't anticipate the QA-dry-run case where "a scheduling
capability exists in this session" and "it would be appropriate to actually use it right now" can
come apart. If future rounds want a stronger live test of this specific mechanism, it would need a
deliberate, disclosed choice to create and then immediately clean up a real trigger — not attempted
here without being asked to.

---

## What actually worked well

- **The connectors-liaison gate is genuinely load-bearing, confirmed by its first ever live
  invocation.** Rigorously verified (not assumed): I ran `ToolSearch` for both a generic
  connector-discovery capability and CRM-specific tools (hubspot/salesforce/pipedrive) before
  concluding neither exists in this environment, exactly as `discover-and-suggest-connector`'s
  Step B instructs ("don't judge availability from the visible tool list alone if a search
  mechanism is present"). The full chain worked end to end: identify (CRM, real task) → check (live
  scan, not the stale state file) → surface (no capability found, honest manual-setup explainer
  composed from `docs/CONNECTORS-CATALOG.md`'s real row) → record
  (`connectors.needed_not_installed`, correct schema) → report (`needs_manual_setup`, not-safe-to-
  proceed). Critically, **round 4's fix held under real pressure**: `sales-lead` did not block the
  whole playbook or silently drop the CRM ask — the full markdown target tracker was completed and
  is genuinely usable today, with only the CRM-sync convenience marked pending, inline, with its
  exact blocker named, in both `gtm/outbound-sales-playbook.md` and `gtm/launch-plan.md`.
- **`launch-director`'s funding-strategy determination and its consequence both worked correctly on
  a real business.** Three independent signals (plan executive summary, `founder.notes`,
  `business_basics.funding_intent`) all agreed on `bootstrap`; `fundraising-advisor` was correctly
  never invoked, and the reason is stated plainly in `gtm/launch-plan.md` rather than left as a
  silent gap in §7 — exactly matching the skill's own instruction not to leave that section blank
  without explanation.
- **`operations-manager`'s "insufficient data" discipline is real and produced honest output on the
  first genuine test against real early-stage numbers.** All four plan-vs-actual comparisons
  (LTV, COCA, LTV:COCA, TAM/segment) correctly returned "insufficient data" rather than a forced,
  false-precision read from zero new closes in a 5-9-week-cycle business only 14 days post-launch —
  this is the exact behavior the spec calls for, and it's the first time this logic has ever run
  against real numbers in this plugin's history. No `risk_log` entry was manufactured to make the
  retro look more eventful than an honest 14-day window actually was.
- **`operations-manager`'s specialist-sequencing logic correctly skipped `scaling-strategist`** on
  the very first check-in (no consecutive healthy periods, no founder ask) — confirms the "not every
  single check-in" rule holds in practice, not just on paper.
- **`kpi-dashboard-setup`'s fee-for-service/project-based archetype row is genuinely well-fitted**,
  confirmed by its first live use: utilization, realized project margin, pipeline coverage,
  repeat-engagement rate, and referral rate all mapped cleanly onto this business's real numbers
  with no forced SaaS-shaped metric (MRR, logo churn) anywhere in the dashboard.
- **`content-calendar`'s channel-gap handling worked exactly as designed** on a real plan that
  genuinely doesn't name a content channel (Step 2 is silent on it) — the skill correctly refused to
  default silently to generic social, instead surfacing the gap and using the most defensible
  partial evidence (Step 5's LinkedIn detail) with an explicit "pending founder confirmation" note
  carried through into `gtm/launch-plan.md`'s risks section.
- **The GTM→ops→recurring-check-in state-machine boundary held under real, live execution**:
  `launch-director` correctly refused to unilaterally declare a real-world launch (`gtm/
  launch-plan.md` §8 and the agent file's own stated boundary) — the orchestrator (this session,
  playing that role) made the actual launch-confirmation call and the `stage`/`gtm.status`
  transition, exactly matching the documented division of responsibility, for the first time this
  boundary has been exercised live rather than only read.
- **`outbound-sales-playbook`'s tier-decision table is a genuinely good design**, confirmed by
  actually running it against real DMU/process data rather than picking a tier on vibes — even
  where §4 above found a real ambiguity in it, the mechanism itself (show the count, show the
  trigger, cite the specific rows) produced a transparent, checkable answer rather than an assumed
  one.
