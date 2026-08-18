---
name: outbound-sales-playbook
description: >
  Use when `agents/gtm/sales-lead.md` needs an executable outbound sales playbook — not generic
  "cold outreach best practices" but real prospect targets, DMU-mapped messaging, a dated
  multi-touch sequence with drafted scripts, objection handling, and costed weekly activity
  targets. Turns plan steps 9 (next-10-customers), 12 (decision-making unit), 13 (process to
  acquire a paying customer), and 18 (costed sales process — refines 13 for COCA) into
  `.startup/<slug>/gtm/outbound-sales-playbook.md`. Reads `gtm/positioning.md` if present so
  outbound copy matches market-facing messaging. Trigger on requests for a sales playbook,
  outbound sequence, prospect list, cold email templates, call scripts, or sales process
  documentation.
---

# Outbound sales playbook

You are producing a document a founder opens Monday morning and starts executing from — real
names or real ICP criteria, real scripts with the blanks specific to this business already
filled in, a real weekly number to hit. Generic sales advice is not acceptable output here; the
whole point is that steps 9/12/13/18 already did the specific thinking, and this skill converts
it into action.

## What you read (required)

1. `plan/09-identify-your-next-10-customers.md` — the target list. If it names actual companies
   or people, those are your targets, formatted into a working tracker. If it only describes ICP
   criteria (industry, size, trigger event), build the playbook's targeting section around that
   criteria explicitly — never invent named companies or people that aren't in the founder's plan.
2. `plan/12-determine-the-dmu.md` — every role in the buying decision and what each cares about
   (economic buyer's budget/ROI concern, champion's internal-credibility concern, end user's
   day-to-day friction, technical evaluator's risk/integration concern, any named blocker).
3. `plan/13-map-the-process-to-acquire-a-paying-customer.md` and
   `plan/18-map-the-sales-process-to-acquire-a-customer.md` — treat as one process per
   `CONVENTIONS.md`: stages and channel from 13, time/cost/conversion detail from 18 folded into
   each stage. If they conflict on a stage, channel, or DMU role, state the conflict explicitly.
4. `business-state.json` `quantitative_claims` for the sourced COCA/pricing figures behind step
   18's costing — flag any activity-target math that rests on an unsourced number.
5. `gtm/positioning.md`, if present — pull the messaging pillars and elevator pitches directly
   into outbound copy rather than freelancing new value-prop language.

If step 9 is too generic to target ("small businesses," no criteria) or 12/13/18 don't describe
an actual process (no stages, no DMU roles), stop and report exactly what's missing rather than
producing a playbook built on invented assumptions.

## Deliverable: `.startup/<slug>/gtm/outbound-sales-playbook.md`

### 1. Target tracker

A working table seeded with the real step-9 targets (or, if only ICP criteria exist, a
criteria-based sourcing brief plus a tracker template ready to fill in):
`Company/Prospect | Why them (from step 9) | DMU role reached | Stage | Next action | Owner`.

### 2. DMU-mapped messaging

For every DMU role named in step 12: a one-line summary of what they care about, and a tailored
opening line/hook that speaks to that specific concern (the economic buyer's opener talks ROI/
cost; the end user's opener talks daily friction) — pulled from `positioning.md` pillars where
they map, or built fresh from step 12/3 detail where they don't.

### 3. Multi-touch outbound sequence — fully drafted, not outlined

A concrete, dated sequence (adjust touch count/spacing to what steps 13/18 describe as the real
acquisition process — don't force a generic 5-touch template onto a process step 13 describes
differently). A standard structure to adapt:

- **Day 1** — Cold email (full subject line + body, [bracketed] fields only for prospect-specific
  facts like name/company, not for the value prop itself).
- **Day 3** — LinkedIn (or channel-appropriate) connection note (drafted).
- **Day 5** — Call script: opener, 2–3 discovery questions tied to the DMU role's concern,
  objection-ready close — plus a voicemail script for no-answer.
- **Day 8** — Follow-up email with a specific proof point from step 8/positioning (a customer
  quote, the quantified value-prop number, or a relevant piece of content from the calendar).
- **Day 14** — Breakup email (drafted, genuinely low-pressure, leaves the door open).

Every template must be fully written copy the founder can send with minimal editing, not "write
an email about X here."

### 4. Discovery call framework

A concrete agenda (opening/rapport, 4–6 qualification questions mapped to what step 13/18 need to
know to move a prospect to the next stage, value articulation moment, next-step ask) plus the
specific qualification questions themselves, not just the framework headers.

### 5. Objection handling script bank

5–8 objections specific to this DMU/process (pull from step 11 competitive position if available,
and from any relevant `risk_log`/`key_assumptions` entries about pricing or trust skepticism),
each with a genuine, specific response — flag any objection that doesn't have a strong answer yet
rather than writing an overselling rebuttal.

### 6. Costed weekly activity targets

Show the arithmetic, not just the number: target close count (from step 9's next-10 goal) ÷
step-13/18 stage conversion rates × touches-per-stage = weekly calls/emails/meetings target. Cite
the `quantitative_claims` entries the conversion/cost assumptions come from. If a number is
unsourced, state the target as provisional and say what would need to be tracked to firm it up.

### Front-matter note (state once)

One line at the top: this is a planning aid built from the founder's own research and
assumptions, not licensed sales-compliance advice — cold-call and commercial-email rules (e.g.
TCPA, CAN-SPAM, and their non-US equivalents) vary by jurisdiction and channel and the founder
should confirm compliance for their specific situation. State once, not per script.

## Write-back

Write `.startup/<slug>/gtm/outbound-sales-playbook.md`. Report back to `sales-lead` that it's
complete (or exactly what's blocking it and why). This skill does not update
`business-state.json` itself.
