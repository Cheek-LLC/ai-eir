---
name: positioning-and-messaging
description: >
  Use when `agents/gtm/marketing-strategist.md` needs to produce or revise positioning and
  messaging for a business — a positioning statement, messaging pillars with sourced proof
  points, elevator pitches at multiple lengths, tagline options, and objection handling. Draws
  the value proposition and end-user persona directly from the plan's steps 3 (end user
  profile), 5 (beachhead persona), and 8 (quantified value proposition), plus steps 1/2 for
  market context and 11 for competitive differentiation. Produces
  `.startup/<slug>/gtm/positioning.md`, the required input to `content-calendar`,
  `outbound-sales-playbook` messaging, and (if applicable) `fundraising-deck-prep`'s narrative.
  Trigger on requests for a positioning statement, tagline, elevator pitch, messaging pillars,
  or "how do we talk about this." Does not cover visual identity, logo, or color — that's
  `skills/design/*`.
---

# Positioning and messaging

You are writing the words a stranger reads or hears in the first five seconds, and the words a
salesperson or the founder falls back on when explaining the business at a dinner party. Every
word must trace back to what the founder already established in their plan — you are compressing
and sharpening, not inventing a new story.

## What you read (required, in this order)

1. `plan/03-build-an-end-user-profile.md` — who actually uses this day to day, their role, goals,
   and the "priority initiative" this product connects to.
2. `plan/05-profile-the-persona-for-the-beachhead-market.md` — the specific persona, richer than
   the end-user profile (name-able archetype, day-in-the-life, watering holes).
3. `plan/08-quantify-the-value-proposition.md` — the numbered before/after claim. This is your
   primary proof point for every messaging pillar.
4. `plan/01-market-segmentation.md` and `plan/02-select-a-beachhead-market.md` — for scope
   discipline: position to the beachhead, not the addressable market.
5. `plan/11-chart-your-competitive-position.md` — the real primary competitive alternative
   (including "do nothing" / spreadsheets / manual process if that's what the plan names).
6. `business-state.json` `quantitative_claims` — cross-check every number you're about to use
   against a sourced entry here.

If steps 3, 5, or 8 are missing or too thin to build a real positioning statement (e.g. step 8
has no actual number, just "saves time"), stop and report the gap rather than inventing a
persona or a number that isn't in the plan.

## Deliverable: `.startup/<slug>/gtm/positioning.md`

Produce every section below with real, business-specific content — no bracketed placeholders in
the final file.

### 1. Positioning statement

Use the Geoffrey Moore template, filled in completely:

> For **[target customer — the step 5 persona, named specifically, not "businesses"]** who
> **[statement of need or opportunity — the specific friction from step 3/5]**, **[product
> name]** is a **[product category]** that **[key benefit — the step 8 quantified claim]**.
> Unlike **[primary competitive alternative — from step 11]**, our product **[primary
> differentiation — the specific reason the alternative fails this persona]**.

Write it as one clean paragraph, then also give the reasoning underneath: why this beachhead
persona and not a broader "businesses," why this competitive alternative and not a direct
competitor if step 11 names "status quo"/manual process as the real alternative.

### 2. Messaging pillars (3–4)

For each pillar: a one-line claim, the proof point that backs it (sourced — cite the
`quantitative_claims` entry or the plan step), and one sentence on why this specific persona
cares. Pillars must be distinct from each other (not three phrasings of the same point) and must
collectively cover: the core value prop (step 8), the competitive differentiation (step 11), and
one credibility/trust pillar (team, early traction from step 23 if it exists, or methodology).

### 3. Elevator pitches

Three lengths, each a complete, deliverable script (not notes):
- **10-second** (one sentence, for a name-tag conversation)
- **30-second** (for "so what do you do?")
- **2-minute** (for an actual sit-down — problem, solution, proof, ask)

Each must be internally consistent with the positioning statement and use the same proof points.

### 4. Tagline options (3–5)

Short (under ~8 words), each paired with one line on the tradeoff it makes (e.g. "leads with the
number vs. leads with the emotional outcome"). Flag which one you'd recommend and why, tied to
what the step 5 persona responds to.

### 5. Objection handling

5 real objections this specific persona would raise, drawn from step 11's competitive
alternatives and any `risk_log`/`key_assumptions` entries relevant to customer skepticism (e.g.
an unresolved assumption about willingness to pay). For each: the objection in the persona's own
likely words, and a genuine rebuttal — not a deflection. If an objection doesn't have a strong
answer yet (e.g. the plan's evidence is thin), say so honestly rather than writing a rebuttal that
oversells.

### 6. Voice and tone guardrails

A short banned-words list tailored to this business's actual register (start from: revolutionary,
game-changing, best-in-class, seamless, unlock, empower, disrupt, synergy — add any category-
specific jargon this persona would find alienating, per step 5). State the register to write in
instead (e.g. "direct, numbers-first, no exclamation points" vs. "warm, conversational" — pick
based on the actual persona, don't default to one house style for every business).

### Front matter note (state once)

Include one line at the top of the file: this is a planning/messaging aid built from the
founder's own plan, not licensed advertising-claims-substantiation or legal review — regulated
categories (health, financial, children's products) may have real claims rules the founder should
have a professional check before publishing. State it once here; don't repeat it per section.

## Write-back

Write `.startup/<slug>/gtm/positioning.md`. Report back to `marketing-strategist` that it's
complete (or exactly what's blocking it) — this skill does not update `business-state.json`
itself.
