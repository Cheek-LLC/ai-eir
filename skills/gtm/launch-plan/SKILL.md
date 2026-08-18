---
name: launch-plan
description: >
  Use when `agents/gtm/launch-director.md` needs to assemble the go-to-market launch plan for a
  business after its plan has cleared council review. Synthesizes positioning, the content
  calendar, the outbound sales playbook, and (if applicable) the fundraising deck brief into one
  sequenced pre-launch/launch/post-launch plan with real dates, owners, channels, and success
  metrics tied to the beachhead market and the next-10-customers list. Produces
  `.startup/<slug>/gtm/launch-plan.md`. Do not use this to draft positioning, content, sales
  scripts, or pitch content from scratch — those are `positioning-and-messaging`,
  `content-calendar`, `outbound-sales-playbook`, and `fundraising-deck-prep` respectively; this
  skill assembles and sequences their already-produced outputs.
---

# Launch plan

You are drafting the single sequencing document that turns finished GTM artifacts into a
week-by-week execution plan. You are not writing new positioning or new content — you are
scheduling and prioritizing what already exists, and calling out honestly what doesn't exist yet.

## What you read

- `plan/business-plan.md` — executive summary, plus the beachhead market (step 2), next-10-
  customers (step 9), MVBP/launch readiness (step 22), and early-traction signal (step 23)
  sections. If the assembled plan is thin on any of these, read the underlying `plan/NN-slug.md`
  file directly.
- `business-state.json`: `gtm.funding_strategy`, `gtm.artifacts` (what's actually been produced
  so far), `key_assumptions` and `risk_log` entries still `open`.
- Whichever of these exist under `gtm/`: `positioning.md`, `content-calendar.md`,
  `outbound-sales-playbook.md`, `fundraising-deck-brief.md`. Read every one that's listed in
  `gtm.artifacts` — don't reference an artifact you haven't actually opened and checked.

## What "done" looks like

`.startup/<slug>/gtm/launch-plan.md`, with every section below filled with real content specific
to this business — no placeholder brackets left unresolved, no "[insert date]." If an input this
plan depends on doesn't exist yet (e.g. `fundraising-advisor` was skipped, or the sales playbook
came back partial), say so explicitly in the relevant section rather than silently omitting it.

## Structure to produce

### 1. Launch readiness snapshot

A short checklist, not prose: is the MVBP (step 22) actually built and usable by a real customer
today? Are there `key_assumptions` still untested (step 20/21) that materially affect the launch
motion (e.g. an unvalidated pricing assumption)? List each with status
(`ready` / `not ready` / `unknown`) and what closes the gap. If launch readiness is `not ready` on
something load-bearing (the product itself, not marketing polish), say plainly that launch should
slip until it's resolved — don't schedule a launch week around a product that doesn't exist yet.

### 2. Objective and success metrics

State the launch's concrete goal as the next-10-customers list from step 9 becoming actual
customers (name the count and the timeframe, e.g. "3 of the next 10 signed within 6 weeks of
launch") and the quantified value proposition (step 8) as the outcome metric to actually prove
with the first cohort ("first 5 customers each report the claimed time/cost saving within 30
days"). Vague goals ("build awareness") are not acceptable here — every goal must be countable.

### 3. Pre-launch phase (T-minus 4 weeks to T-minus 1 week)

A week-by-week task table: `Week | Task | Owner | Depends on | Source artifact`. Owners are
`marketing-strategist`, `sales-lead`, `fundraising-advisor` (if applicable), or `founder` (for
things only the founder can do — e.g. approving final copy, personally reaching out to a warm
contact on the next-10 list). Pull real tasks from the content calendar's pre-launch posts, the
sales playbook's first-touch sequence start date, and (if applicable) investor outreach timing
from the fundraising deck brief — don't invent generic pre-launch tasks disconnected from the
actual artifacts.

### 4. Launch week — day by day

`Day | Action | Channel | Owner`. Tie directly to the content calendar's launch-week posts and
the sales playbook's outreach cadence hitting the next-10 list. Include the specific CTA each day
drives toward (from the content calendar) so launch week reads as one coordinated push, not
disconnected activities on the same days.

### 5. Post-launch cadence (30 / 60 / 90 days)

What continues, what changes, and the checkpoint questions at each mark, tied back to the
objective in §2 (e.g. Day 30: how many of the next-10 have converted, does the value-prop claim
hold for real customers, does the content calendar's ongoing weekly cadence — from
`content-calendar.md` — need adjustment based on what performed). State explicitly that ongoing
metrics tracking and retros are `agents/ops/*`'s job from this point, not this plan's — this
section hands off, it doesn't take over ops' territory.

### 6. Channel plan summary

A compact table pulling from `content-calendar.md` and `outbound-sales-playbook.md`: channel,
purpose in the launch (awareness / consideration / conversion), owning artifact. This is a
summary for someone skimming the launch plan — it doesn't replace the full detail in those files,
it links to them.

### 7. Fundraising milestone integration (only if `gtm.funding_strategy` is `raising_outside_capital`)

If `fundraising-deck-brief.md` exists, integrate investor-outreach milestones into the same
timeline (e.g. "target: first investor meetings scheduled by week 3, using early-traction data
from the launch as the freshest proof point in the deck"). If `funding_strategy` is `bootstrap` or
`undecided`, omit this section entirely (state in one line that it's not applicable — don't leave
a silent gap that reads as an oversight).

### 8. Risks and open assumptions carried into GTM

Pull from `risk_log` (status `open`) and `key_assumptions` (no `test_result` yet) that are
relevant to launch execution — not the whole log, just what could actually derail this specific
launch plan. State what would have to be true for each to stop being a risk.

## Write-back

This skill's own output is the `gtm/launch-plan.md` file. It does not update
`business-state.json` — `launch-director` owns that write, using its own knowledge of what it
delegated and confirmed, not a self-report from this skill.
