---
name: fundraising-deck-prep
description: >
  Use when `agents/gtm/fundraising-advisor.md` needs an investor narrative and pitch deck for a
  business whose plan targets outside capital. Builds a full slide-by-slide deck brief from
  plan steps 4 and 14 (beachhead and follow-on TAM), 15 (business model), 17 and 19 (LTV and
  COCA unit economics), plus the VC-panel council's review notes when available, then hands the
  actual slide build to the `pptx` skill. Produces `.startup/<slug>/gtm/fundraising-deck-brief.md`
  (the full narrative and per-slide content) and, when the deck is built,
  `.startup/<slug>/gtm/pitch-deck.pptx`. States once that this is pitch-practice material, not
  legal or securities-compliance advice. Trigger on requests for a pitch deck, investor deck,
  fundraising narrative, or deck brief — only when the business is actually raising.
---

# Fundraising deck prep

You are building the brief a founder rehearses from and the deck built from it — the actual
narrative, numbers, and slide content, not a generic pitch-deck template with section headers and
no substance. Every number in this deck must be traceable to the founder's own plan; every
anticipated objection should come from real evidence (the VC-panel's own review notes, where
available) rather than a generic "investors might ask about competition" placeholder.

## What you read (required)

1. `plan/04-calculate-the-tam-for-the-beachhead-market.md` and
   `plan/14-calculate-the-tam-for-follow-on-markets.md` — state both numbers with what each
   measures. If `plan/business-plan.md` already reconciled them (combined total vs. kept
   separate, with a stated reason), carry that reconciliation forward rather than re-deriving it;
   if it didn't, do the reconciliation here and flag it as new analysis.
2. `plan/15-design-a-business-model.md` — the actual revenue mechanism; this drives the "how big
   can this get" and "why now" slides.
3. `plan/17-calculate-the-ltv-of-a-customer.md` and `plan/19-calculate-the-coca.md` — compute the
   LTV:COCA ratio explicitly and state it as a number, not a vague "healthy unit economics." A
   ratio under ~3:1 is a real seed-stage weakness — put it in the brief's honest-risks section
   plainly; do not omit or soften it. If either figure rests on an untested `key_assumptions`
   entry, mark the ratio itself as provisional in the brief.
4. `business-state.json` `quantitative_claims` — every number that goes in the deck must trace to
   a sourced entry. An unsourced number in a fundraising deck is a real risk (investors will
   probe exactly these numbers); do not let one through uncited.
5. The most recent `reviews/*-vc-panel-*.md` file(s), if present — extract the Risks/gaps and
   Required revisions sections. Use them as the primary source for the "anticipated objections"
   built into each relevant slide's talking points, not generic VC-objection tropes.
6. `plan/23-show-that-dogs-will-eat-the-dog-food.md` and `plan/24-develop-a-product-plan.md` for
   the traction and roadmap slides.
7. `gtm/positioning.md`, if it exists — the investor narrative's problem/solution framing should
   match market-facing positioning; don't tell investors a different story than customers.

## Deliverable 1: `.startup/<slug>/gtm/fundraising-deck-brief.md`

A front-matter line stating the hard line once (see below), then full content — talking points
and the specific sourced numbers to say out loud, not just slide titles — for each slide:

1. **Title / one-liner** — the company, in the words from `positioning.md` if it exists.
2. **Problem** — the persona's real friction (step 3/5), stated the way an investor who's never
   met this persona will understand it in one read.
3. **Solution** — the product, tied directly to the quantified value proposition (step 8).
4. **Market size** — beachhead TAM (step 4) and follow-on TAM (step 14), reconciled per above,
   with the sourced methodology stated (not just the number — investors discount unsourced TAM
   slides on sight).
5. **Business model** — from step 15: how money is actually made, pricing framework (step 16) if
   it materially affects the story.
6. **Traction** — from step 23 and any real customer/pipeline data in `gtm/outbound-sales-
   playbook.md`'s target tracker if that skill has already run; if there's genuinely no traction
   yet, say so and lean the slide on validated `key_assumptions` test results instead of
   fabricating traction.
7. **Unit economics** — LTV (step 17), COCA (step 19), the ratio, stated plainly including if
   it's weak or provisional.
8. **Competition** — from step 11, positioned honestly (a 2x2 or direct comparison, not a
   dismissive one-liner about competitors).
9. **Team** — whatever the plan/founder record actually supports; do not invent credentials.
10. **The ask** — amount, use of funds, and the milestone it buys (tie to the launch plan's
    post-launch 30/60/90 goals if `gtm/launch-plan.md` exists).
11. **Roadmap** — from step 24, the next 12–18 months at a level an investor can sanity-check.

For each slide, add a short **"Investor will likely ask"** note pulling from the VC-panel review
notes where relevant, with the founder's best available answer — including "we don't have a
strong answer yet, here's our plan to get one" where that's the honest state.

## Deliverable 2: the actual deck — delegate to the `pptx` skill

Do not build the `.pptx` yourself with ad hoc code. Once the brief above is complete, invoke the
`pptx` skill to build `.startup/<slug>/gtm/pitch-deck.pptx` from it:

- Follow the `pptx` skill's own guidance for creating a new deck (`pptxgenjs`, `pres.layout` set
  before adding slides, native charts for the TAM/market-size and unit-economics visuals, its
  hex-color and shadow/list gotchas) — this skill does not re-document pptx mechanics, defer to
  `/mnt/skills/public/pptx/SKILL.md` for all of that — and run its `scripts/office/validate.py`
  before considering the deck done.
- One slide per numbered section above, in that order, unless the founder's plan clearly argues
  for a different order.
- Put the exact sourced numbers from the brief onto the slides (TAM, LTV, COCA, ratio, ask amount)
  — the deck should never say something the brief doesn't already say with a source.
- Speaker notes: put the "Investor will likely ask" content in each slide's speaker notes
  (`addNotes`, per the pptx skill) so it's available during rehearsal without cluttering the
  visible slide.
- If deck-building tools or environment aren't available in this invocation, it's still correct to
  deliver the brief alone and report clearly that the `.pptx` build step didn't run — the brief is
  a complete, usable deliverable on its own.

## The hard line — state once

Add this once, in the brief's front matter, and do not repeat it slide-by-slide or in every
response: *This deck and narrative are pitch-practice materials built from the founder's own plan
— not legal, financial, tax, or securities-compliance advice. They do not cover cap table
structuring, SAFE/equity/convertible-note terms, accredited-investor verification, Reg D or other
securities filings, or diligence-room document assembly; the founder should engage a qualified
securities attorney before running an actual raise.*

## Write-back

Write `.startup/<slug>/gtm/fundraising-deck-brief.md`, and `.startup/<slug>/gtm/pitch-deck.pptx`
if the pptx build step ran. Report back to `fundraising-advisor` which of the two exist, and
surface the LTV:COCA ratio and any unresolved "investor will likely ask" items plainly — don't
bury a weak ratio in the file where it might not get read. This skill does not update
`business-state.json` itself.
