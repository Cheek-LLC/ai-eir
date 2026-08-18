# Product Roadmap — Vantage Point Search — 2026-09-29

First roadmap cycle for this business — no prior `ops/product-roadmap-*.md` exists, so there is
nothing to carry forward and the "Shipped since last roadmap" section below is necessarily empty.
Produced by `agents/product/product-lead.md` invoking `skills/product/roadmap-and-prioritization`.

**Precondition note, stated plainly rather than silently worked around.** The skill/agent gate is
`stage: "operating"` (or a late-`gtm` beta-cohort exception). `business-state.json.stage` is
currently `"de_steps_in_progress"` — Steps 01/02/04 were reopened 2026-09-29 by a founder-stated
pivot signal (`risk_log["ops-vantage-point-search-001"]`) to narrow the beachhead's lower bound.
Neither this skill nor the agent file says what to do when a business is mid-pivot on early DE
steps but still operationally live: `gtm.status` is `"launched"`, `ops.status` is `"active"`, two
real ops check-in cycles exist, and the founder is actively running BD/delivery day to day. This
run proceeded anyway, on the judgment that "operationally live with real usage data" is the
condition the skill's Reads section actually depends on, not the literal `stage` string — the same
kind of judgment call `operations-manager` and the orchestrator made elsewhere in this business's
history when the schema didn't have an exact state for what was actually happening. Flagged here,
not hidden — see the QA findings doc for why this is a real gap, not just a note.

## Anchor

**Core (plan/10):** Jordan's core is his personal network plus a demonstrated, repeatable
technical-screening method — 11 years of relationships with engineering leaders and candidates at
exactly the beachhead's company profile, and a structured technical-assessment rubric he applies
consistently but has never formalized as written IP (`ka-010-playbook-informal`). Per Step 10's own
honest assessment, this is closer to founder-market fit/execution quality than a classic
defensible moat — it lives entirely in Jordan's head, and codifying it into a written, teachable
playbook is named as "the single highest-leverage move" to convert it into a durable,
institutional asset (`plan/10-define-your-core.md`).

**Beachhead persona (plan/03 & 05):** Dana, a hiring CTO/technical co-founder at a ~120-150
person, Series C, VC-backed infrastructure/devtools company (Step 5's worked example: ~130
employees, ~35-person eng org), 10-14 weeks into a stalled DIY VP Engineering search. She isn't
struggling to evaluate candidates — she's struggling to find candidates worth evaluating on top of
an already-full job, wants a hire who can scale the org 2x within 18 months, and is more afraid of
a bad hire than a slow one (`plan/03-build-an-end-user-profile.md`,
`plan/05-profile-the-persona-for-the-beachhead-market.md`).

**Say-so-plainly per Step 1:** Step 5's persona status is `drafted` but carries a
`FLAGGED FOR RE-CONFIRMATION` note in `business-state.json` as of 2026-09-29 — the pivot signal
narrowing the beachhead's lower bound to ~120+ employees means the *segment band* (Step 2) is
mid-rewrite even though Dana's own worked example (~130 employees) already sits comfortably inside
the proposed narrower band. Treating Step 5 as usable-as-is for this cycle's anchor (per Step 1's
own allowance to proceed when a step is flagged for confirmation-only, not full rewrite), but
naming the in-flight state explicitly rather than treating it as settled.

## Intake log

| ID | Description | Source | Evidence |
|---|---|---|---|
| ri-vps-01 | Write the technical-screening playbook | `plan/24-develop-a-product-plan.md` (priority 1); `plan/10-define-your-core.md`; `key_assumptions["ka-010-playbook-informal"]` | Unresolved, "no movement," at both the 2026-09-15 and 2026-09-29 check-ins (`interview-log.md`); Step 10 names it the single highest-leverage core-durability move |
| ri-vps-02 | Design and test a fee-floor / tiered pricing structure for sub-120-employee prospects | `key_assumptions["ka-025-segment-fee-floor"]` (step_ref 16); `ops/2026-09-29-growth-metrics.md` funnel table; `risk_log["ops-vantage-point-search-001"]` (acknowledged, not re-raised as new — see note below) | 2 real declines this period at the identical process stage (internal budget check) citing the identical mechanism (30% fee too large to justify for a first senior hire without a formal spend process): #2 (~80 employees, declined 2026-09-24), #4 (~60 employees, declined 2026-09-26) |
| ri-vps-03 | Systematize a referral/advocacy ask from placed candidates (e.g. an explicit post-placement LinkedIn/referral prompt) | `interview-log.md`, 2026-09-15 entry (founder-reported "what's working that you didn't expect") | n=1: prospect #8's cold-inbound signal (a placed candidate's LinkedIn post driving an unprompted contact) — Jordan's own words: he "hadn't expected any non-referral, non-outbound channel to produce a real conversation" |
| ri-vps-04 | Time-track delivery hours per engagement (replace the `ka-016` placeholder estimate with logged data) | `ops/2026-09-29-retro.md` "Data gaps"; `key_assumptions["ka-016-delivery-hours-estimate"]` | Recommended at both 2026-09-15 and 2026-09-29 check-ins with zero founder action either time — a 2-consecutive-check-in stuck pattern, named explicitly in the retro |
| ri-vps-05 | Hire and ramp first associate recruiter; run their first search as MVBP #2 (real paid engagement, Jordan on QA only) | `plan/24-develop-a-product-plan.md` (priority 2, costed explicitly); `key_assumptions["ka-020-associate-replication"]` | Step 15 names delivery capacity as "the single largest threat to the whole plan"; Step 20 ranks `ka-020` the single most consequential untested assumption; Step 24 gives a real conservative Year-1 estimate of 3 associate placements and a full cost/return buildup |
| ri-vps-06 | Lightweight CRM/BD funnel tracking | `plan/24-develop-a-product-plan.md` (priority 3); `key_assumptions["ka-013-conversion-sample"]`, `["ka-018-relationship-maintenance-cost"]`; `business-state.json.connectors.needed_not_installed` (hubspot) | Both assumptions currently rest on "founder memory, not logged data"; hubspot connector already flagged `needs_manual_setup` by `connectors-liaison` at GTM kickoff, still not installed |
| ri-vps-07 | Founder/support feature-request tracking | — | **Not tracked anywhere.** No support ticket system, spreadsheet, or informal note-taking of inbound feature/change requests exists in any read file. Named as a finding per this skill's own instruction ("not tracked anywhere is itself a finding, not silently skipped"), not scored, no items to list. |

**On `risk_log["ops-vantage-point-search-001"]` specifically:** this is `operations-manager`'s
already-open pivot-signal entry about the same underlying decline pattern that evidences
`ri-vps-02` above. Per this skill's own Reads instruction ("you don't want to re-surface a drift
finding another agent already logged as if it were new"), that risk_log entry itself is **not**
re-entered as a new roadmap intake item — only the concrete *pricing-structure alternative*
(`ka-025-segment-fee-floor`, which Step 16 named as "worth considering, not required") is scored
here as a real, distinct roadmap item.

**Retention-metrics intake channel — explicitly empty, not skipped.** Neither
`ops/2026-09-15-retention-metrics.md` nor `ops/2026-09-29-retention-metrics.md` yielded any churn
reasons — both correctly state "not applicable" (project-based engagements, no completions or
churn events either period). This intake source produced zero real items this cycle; recorded here
so it isn't mistaken for an unreviewed source.

## Scored items

| ID | Description | Reach | Impact | Confidence | Effort (person-wk) | RICE score | Core/Context | Beachhead/Off-segment |
|---|---|---|---|---|---|---|---|---|
| ri-vps-02 | Fee-floor / tiered pricing test, sub-120-employee segment | 2 (real declines, `ops/2026-09-29-growth-metrics.md`) | 1 — medium. Metric: sub-120-employee internal-budget-check conversion rate — currently 0% (0 of 2) this period; no `ops/kpi-dashboard.md` line item tracks this segment cut today, a real dashboard gap named here | 50% — real but thin (n=2); matches `ka-025-segment-fee-floor`'s own logged `confidence: low` | 0.5 — **role-played founder estimate, this session** (Jordan, dry-run: "not a build effort, a proposal and a couple of test conversations") — no disk-sourced figure exists for this; see QA findings | 2.0 | Context (pricing-structure work, not the technical-screening capability itself) | **Off-segment** — flagged explicitly: this item's entire premise is testing whether to keep serving the sub-120-employee band the founder is actively trying to exit via the in-flight Step 01/02 pivot |
| ri-vps-03 | Referral/advocacy ask from placed candidates | 1 (n=1, prospect #8, `interview-log.md` 2026-09-15) | 0.5 — low, capped by n=1. Metric: Referral rate (`ops/kpi-dashboard.md`) — new-prospect referral share was 0% (0/2) the 2026-09-15 period and ~33% (1/3) the 2026-09-29 period; this item targets a *new*, currently-0%, non-referral/non-outbound channel | 50% — real but thin (single data point) | 0.25 — **role-played founder estimate, this session** (Jordan, dry-run: "a template message and remembering to send it — maybe a day") | 1.0 | Context | Beachhead-aligned (placed candidates and their networks sit inside the same beachhead company profile) |
| ri-vps-05 | Hire/ramp associate recruiter + first paid search (MVBP #2) | 3 — Step 24's own conservative Year-1 placement estimate (`plan/24-develop-a-product-plan.md`), a real founder-committed figure, not invented for this exercise | 3 — massive. Metric: Billable utilization (`ops/kpi-dashboard.md`, currently 28%, no plan baseline yet) and total concurrent-engagement capacity (currently capped ~4, Step 15); directly tests `ka-020-associate-replication`, Step 20's single most consequential open assumption | 50% — matches `ka-020`'s own logged `confidence: low`: "zero associate-run searches have ever been completed... untested, not just unproven at scale" | 8 — **role-played founder estimate, this session** (Jordan, dry-run: "recruiting an associate is itself a whole search, 6-9 weeks to source and close, then a 4-month ramp at ~5 hrs/week of my own oversight" — partially grounded in Step 24's real 80-hour/4-month ramp figure, but the person-week "effort" framing itself had to be improvised; see QA findings) | 0.56 | **Core-reinforcing** — this is the direct mechanism for testing whether Step 10's technical-screening rubric is transferable, i.e. whether the Core is durable at all — but explicitly dependent on `ri-vps-01` (the playbook) existing first | Beachhead-aligned |

## Unscored — needs data

- **ri-vps-01 (write the playbook)** — no real Reach number exists or can exist for this item in
  isolation: it touches zero customers directly. Its real Reach is entirely mediated through
  `ri-vps-05` (the associate-hire chain it gates) — see the QA findings doc for why this is a
  genuine RICE-framework-fit gap for a services business's roadmap, not a thin-evidence problem
  (the evidence for *urgency* is actually strong and repeatedly cited: two consecutive check-ins
  with zero movement). Would be unblocked by scoring it as a precondition weight on `ri-vps-05`
  rather than as an independent line, which this skill's table format doesn't provide for.
- **ri-vps-04 (time-track delivery hours)** — same category as above: an internal
  measurement-infrastructure fix with no customer-facing Reach number, even though the urgency
  evidence is strong and dated (`ops/2026-09-29-retro.md`, 2 consecutive check-ins, explicit
  founder non-action both times).
- **ri-vps-06 (lightweight CRM/BD tracking)** — same category: closes a real, named data-quality
  gap (`ka-013`, `ka-018`) but has no direct customer-facing Reach number of its own.
- **ri-vps-07 (feature-request tracking)** — no items exist to score; the finding itself
  ("not tracked anywhere") is the deliverable for this line, per the skill's own instruction.

## Sequencing

**Capacity this cycle:** 1 person-week — **role-played founder estimate, this session** (Jordan,
dry-run: "between engagement delivery and BD, maybe 4-5 real hours a week left over for anything
else"). No real, disk-sourced capacity figure exists for any cycle in this fixture; see QA
findings for why this is structurally unavoidable in an async, non-interactive dry run of a skill
built around live founder questions.

### Now
Taken in RICE-score order, cut to the 1 person-week stated capacity:

| ID | RICE | Effort (pw) | Running total |
|---|---|---|---|
| ri-vps-02 | 2.0 | 0.5 | 0.5 / 1.0 |
| ri-vps-03 | 1.0 | 0.25 | 0.75 / 1.0 |

ri-vps-05 (RICE 0.56, next in rank order) does not fit — its 8-person-week effort is an order of
magnitude beyond this cycle's stated capacity — so it does not enter "Now" purely on RICE order
despite being the single highest-Impact, Core-reinforcing item on the board. Not overridden by
hand; the capacity cut is applied mechanically per the skill's own Step 5 instruction, and the
consequence is named explicitly in Flags below rather than silently accepted.

### Next
- **ri-vps-05** — hire/ramp associate + first paid search. Highest strategic priority per Step 24
  and the single most consequential open assumption per Step 20, but its real 8-person-week effort
  spans multiple cycles; sequenced for the next 2-3 cycles' combined capacity, not deferred on
  priority grounds.
- **ri-vps-01** — write the playbook. Unscored, but a hard precondition for ri-vps-05 — should
  realistically start before or alongside ri-vps-05, not strictly after it; the Now/Next split
  above doesn't capture this dependency ordering, which is worth the founder's attention directly
  (Next-bucket items aren't sequenced against each other by this skill's own format).

### Later
- **ri-vps-04** — time-track delivery hours. Real, low-effort, unscored — a plausible near-term
  "Now" candidate on a future cycle once its urgency (2 consecutive stalled check-ins) outweighs
  ri-vps-02/03's turn in the queue; not a dumping ground, explicitly worth revisiting next cycle.
- **ri-vps-06** — lightweight CRM/BD tracking. Same status as ri-vps-04.

## Flags

**Core/Context split, "Now" bucket:** 2 of 2 items (100%) are tagged **Context**. This is a
majority — flagged explicitly per Step 4's instruction, and it is the exact input
`agents/product/product-lead.md`'s drift check §1 reads. See the drift check below for how this
cycle's single-cycle read is handled (insufficient cycles to call it a trend, but real and named).

**Beachhead/off-segment split, "Now" bucket:** 1 of 2 items (50%) is tagged **Off-segment**
(ri-vps-02). Worth stating plainly, not softened: the highest-RICE-scoring item this cycle is a
pricing experiment aimed at retaining the exact sub-120-employee sub-segment the founder is
actively trying to stop spending BD time on, per the same-day pivot signal
(`risk_log["ops-vantage-point-search-001"]`). RICE ranked it #1 because its Reach (2 real declines)
and low Effort (0.5 person-week) beat the associate-hire item's much larger but much costlier
Impact — a mechanical consequence of the scoring, not a judgment call, and one the founder should
see directly before this cycle's Now bucket is treated as a real commitment.

## Shipped since last roadmap (first roadmap)

Not applicable — this is the first roadmap cycle for this business; no prior
`ops/product-roadmap-*.md` exists to diff against.

---

## `agents/product/product-lead.md` drift check (run for real, first time for this business)

1. **Core/Context balance, trended.** **Insufficient cycles to assess trend — will reassess next
   cycle** (only 1 roadmap cycle exists; the check's own bar is "2+ consecutive cycles"). Named
   anyway rather than silenced: this single cycle's "Now" bucket is already 100% Context (see
   Flags above) — not material by the letter of the check (needs persistence), but worth watching
   at the very next cycle rather than treated as a clean slate.

2. **Beachhead alignment, trended.** **Insufficient cycles to assess trend — will reassess next
   cycle**, same reason. This check's "material" bar also includes "a single cycle shows a sharp
   jump... that the founder hasn't already flagged as a deliberate segment-expansion decision" —
   that clause presumes a prior baseline to jump from, which doesn't exist on a first cycle, so it
   cannot literally fire either. Named as a real gap in the check's own design for a first-ever
   cycle, not resolved by inventing a 0% baseline to compare against. Substantively, though: this
   cycle's 50% off-segment share directly echoes the already-open `risk_log["ops-vantage-point-
   search-001"]` entry (same segment, same evidence, same founder statement) — not re-logged as a
   new finding per this agent's own instruction not to duplicate an already-open entry, but named
   here as reinforcing evidence for that existing entry.

3. **Value-proposition check.** **Insufficient data.** No launch-era engagement has completed
   (both `ops/*-retention-metrics.md` files: "not applicable... no engagement concluded"), so there
   is no real retained-customer usage account to compare against Step 8's quantified value driver
   ($15,000-$21,000 founder-time-avoided). Cannot be run meaningfully yet — stated honestly rather
   than forced, matching `operations-manager`'s own LTV/COCA "insufficient data" reads both periods.

4. **Spec creep/shrink check.** **Not applicable this cycle.** This is the first roadmap; the
   "Shipped since last roadmap" section is necessarily empty, so there is nothing yet to compare
   against `plan/07-high-level-product-specification.md`.

**Risk_log:** No new entry filed. Every check above either (a) cannot be assessed on a first cycle
(checks 1, 2's trend clause, 3, 4) or (b) substantively overlaps with the already-open
`risk_log["ops-vantage-point-search-001"]` entry (check 2's non-trend reading) — filing a new entry
here would duplicate that one, which this agent's own Reads instruction says not to do. This is a
"no new material finding" read, but every check was actually run and cited against real evidence
above, not asserted — per the agent's own "Never rubber-stamp" section.

**Report back:**
- Roadmap file: `ops/product-roadmap-2026-09-29.md` (this file).
- Headline "Now" bucket: `ri-vps-02` (fee-floor pricing test, off-segment) and `ri-vps-03`
  (referral-advocacy ask), 0.75 of 1.0 stated person-week capacity used.
- Drift flag: real and worth the founder's direct attention (100% Context, 50% off-segment in
  "Now"), but not yet "material" under either check's literal trend/jump bar on a first cycle —
  named plainly rather than smoothed into "no drift."
- No new `risk_log` entry filed — see reasoning above.
