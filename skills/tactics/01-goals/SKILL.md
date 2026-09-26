---
name: 01-goals
description: >
  Use once a business reaches `stage: approved` (plan approved by council, not yet operating) to
  turn the plan's stated milestones into committed, time-boxed operational goals — specific
  numbers and dates the founder actually commits to, not aspirations. Trigger phrases: "what are
  our goals now," "set our milestones," "what should we be aiming for," "turn the plan into
  targets," starting execution after plan approval, revisiting goals after a pivot or a missed/hit
  milestone. This is Tactic 1 of Paul Cheek's 15 Tactics — goal-setting and milestone-charting
  only. It does not build the tracking dashboard; that's `skills/ops/kpi-dashboard-setup`, which
  this skill's output feeds.
---

# Tactic 1: Goals — Operational Goals and KPIs: Charting the Course to Major Milestones

## Role in the 15 tactics

First of the two Foundations tactics (Tactic 1–2), meant to run right after a plan reaches
`stage: approved` and before real GTM/product execution tactics (3–15) start. The plan is full of
implied milestones — a TAM to capture, an MVBP to ship, a business model to prove out — but a plan
is not a commitment. This tactic's job is converting those implied milestones into a short list of
specific, dated, numbered goals the founder stands behind, so there is something concrete to chart
progress against week to week and quarter to quarter.

This is **not** the KPI tracking dashboard. `skills/ops/kpi-dashboard-setup` builds the mechanics
of an ongoing metrics dashboard (which KPIs, what data source, what cadence) fit to the business's
real revenue model — read that skill in full before running this one so you don't duplicate its
work. This skill's distinct job is upstream of that: deciding *what the founder is actually trying
to hit* and *by when*. Once this skill produces a committed goal set, `kpi-dashboard-setup` is
what turns "hit $10k MRR by March 1" into a trackable weekly number with a data source — hand it
this skill's output rather than re-deriving targets inside the dashboard skill.

## What you read

- `.startup/<slug>/business-state.json` — confirm `stage` is `approved` or later (`gtm`,
  `operating`). If `stage` is earlier than `approved`, stop and tell the founder this tactic runs
  after plan approval, not before — do not manufacture goals against an unapproved plan.
  Also read `business_basics` (type, one-liner) and any existing `tactics.01_goals` entry (you may
  be revising, not starting fresh).
- `.startup/<slug>/plan/business-plan.md` — read the **executive summary** in full, plus the
  underlying step files it draws from:
  - `plan/15-design-a-business-model.md` — the chosen revenue archetype; goals should be phrased in
    that model's real units (MRR for subscription, GMV/take-rate for marketplace, units sold for
    physical product, utilization/realized margin for services), not a generic revenue number.
  - `plan/22-define-the-mvbp.md` — what "shipped" or "launched" concretely means for this business;
    an early milestone is almost always tied to the MVBP actually reaching real users.
  - `plan/24-develop-a-product-plan.md` — the plan's own stated timeline/sequencing, which is your
    starting point for dates, not something you invent independently of it.
- `quantitative_claims` entries tied to step_refs 04/14 (TAM), 17 (LTV), 19 (COCA) — these are the
  plan's *sized* numbers; a goal that references market capture or unit economics should trace back
  to one of these, never restate a number the plan never actually committed to.
- `.startup/<slug>/tactics/01-goals.md` if it already exists — you're revising a committed goal
  set, not starting over; carry forward any goal still in flight and mark hit/missed ones instead
  of deleting them.

## What you write

Output file: `tactics/01-goals.md`. **You do not write `business-state.json.tactics` yourself** —
draft the file, walk the founder through it, and once they confirm it, tell them (or the
orchestrator) that `tactics.01_goals` is ready to be set to `status: "drafted"` (or `"complete"`
once the goals are actually hit) with a summary and this file path. Updating that key is the
orchestrator's job, exactly like the DE step skills work for `disciplined_entrepreneurship`.

## Method: from plan milestones to committed goals

1. **Pull the plan's implied milestones first, don't start from a blank page.** From the executive
   summary and steps 15/22/24, list every point in the plan where something changes state: MVBP
   ships, first paying customer, a specific revenue level, a specific TAM-capture percentage, a
   fundraise closing, a headcount threshold. This is raw material, not the goal list itself — a
   plan milestone is directional ("reach initial traction in the beachhead") until the founder
   attaches a number and a date to it.

2. **For each candidate milestone, force three things out of the founder in this conversation:**
   - **The metric**, stated in the business's real unit from step 15/16 (MRR, GMV, units sold,
     active users, signed contracts — never "revenue" or "growth" unqualified).
   - **The number.** Ask directly: "By [date], what number would tell you this is working?" Do not
     suggest a number first and ask the founder to confirm it — that produces an anchored, not a
     committed, number. If the founder can't produce one, that milestone isn't ready to be a goal
     yet; leave it as a plan-stage aspiration and say so explicitly rather than inventing a
     placeholder.
   - **The date.** Push for a real calendar date, not "soon" or "this quarter" left vague — "by
     March 1, 2027," not "by Q1."

3. **No invented numbers, ever.** Every goal in the output file must be something the founder
   actually said in this conversation, not a number this skill selects for them because it sounds
   plausible for the business type or stage. If the founder is unsure, that uncertainty is the
   answer — record the milestone as "not yet committed" rather than filling in a benchmark figure.
   This mirrors the Data Contract's `quantitative_claims` sourcing discipline: a number without a
   real source (here, "founder committed, [date]") does not belong in this file as if it were
   settled.

4. **Distinguish leading milestones from lagging ones.** A revenue or customer-count goal is
   usually lagging — it tells you the outcome after the fact. Push for at least one or two leading
   goals per milestone period (e.g. "50 discovery calls booked by [date]" ahead of "$10k MRR by
   [date]") so the founder has something actionable to chase week to week, not just a scoreboard
   number to watch arrive or not.

5. **Set a review cadence for the goals themselves**, distinct from the KPI dashboard's ongoing
   tracking cadence — ask the founder when they want to revisit this specific goal set (a natural
   default is at each major milestone date, or quarterly, whichever is sooner) and record it.

6. **Cap the list.** More than 5-7 live goals at once is not a committed goal set, it's a wish
   list — if the founder names more, ask them to rank and cut, or group into a small number of
   headline goals with the rest as supporting sub-goals underneath them.

## Business-type notes

- **SaaS / subscription:** MRR/ARR targets, paid-conversion count, a specific churn ceiling by a
  date — pull the pricing metric from step 16 so the goal is denominated correctly (per-seat,
  usage-based, etc.).
- **Marketplace:** goals on *both* sides independently (supply-side count, demand-side count) plus
  a liquidity/match-rate goal — a marketplace goal set that only states demand-side numbers is
  missing the harder half.
- **Physical product:** units sold, sell-through rate by channel, first retail placement or DTC
  reorder-rate goal, tied to step 15's channel model.
- **Services:** signed-engagement count, utilization rate, realized margin per engagement — not a
  generic revenue figure divorced from the fee-for-service model.
- **Consumer app:** activation/retention goals ahead of monetization goals if the plan's model is
  freemium — a founder who only sets a revenue goal before activation is proven is skipping the
  step that actually predicts it.

## Write `tactics/01-goals.md`

```markdown
# Tactic 1: Goals — <business name>

_Last revised: <date>. Plan version referenced: business-plan.md v<N>._

## Where these came from
(one paragraph: which plan sections/steps these milestones trace back to)

## Committed goals
| # | Milestone | Metric (real unit) | Target number | Target date | Leading or lagging | Founder-committed? | Status |
|---|---|---|---|---|---|---|---|
(Founder-committed? = yes, this conversation | no — plan-stage aspiration, not yet a committed goal)
(Status = not started | in progress | hit | missed)

## Plan milestones not yet turned into committed goals
(list any candidate the founder wasn't ready to commit a number/date to, and why)

## Goal-review cadence
(when the founder wants to revisit this set — date or trigger)

## Feeds into
- `skills/ops/kpi-dashboard-setup` — turns the committed goals above into weekly-trackable KPIs
  with real data sources. Run that skill next once this goal set is confirmed.
```

## Done means

- Every goal in the "Committed goals" table has a real metric in the business's own unit, a
  founder-stated number, and a founder-stated date — none invented by this skill.
- Any plan-stage milestone the founder wasn't ready to commit to is recorded honestly as
  not-yet-committed, not smoothed into a fake target.
- A goal-review cadence is recorded.
- `tactics/01-goals.md` is written (or revised in place, preserving hit/missed history).
- You've told the founder/orchestrator that `business-state.json.tactics.01_goals` is ready to be
  set — you did not write that key yourself.
- Stop here — do not build the tracking dashboard; that's a separate call to
  `skills/ops/kpi-dashboard-setup` using this file's committed goals as input.
