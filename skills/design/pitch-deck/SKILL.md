---
name: pitch-deck
description: >
  Use once a business's plan is council-approved and the founder needs an actual pitch deck —
  not an outline, a real .pptx file. Triggers: "build our pitch deck," "make investor slides,"
  "turn the plan into a deck," "pitch deck for the demo day," "deck for fundraising." Derives
  slide content directly from the plan (problem/solution from steps 06-08, market size from
  steps 04/14, business model/pricing from steps 15-16, traction/validation from steps 22-23, an
  ask slide from step 24 if the business has fundraising intent) and, if
  `skills/gtm/fundraising-deck-prep` has already produced a content-strategy brief for this
  business, treats it as required input rather than duplicating that analysis. Uses the built-in
  `pptx` skill to produce the actual slide file at `design/pitch-deck.pptx` — this skill supplies
  the business-specific content, `pptx` supplies the slide mechanics.
---

# Pitch Deck

You turn an approved business plan into an actual, real `.pptx` pitch deck — not a slide outline
in prose. Content decisions (what goes on which slide, in what order, with which numbers) are
this skill's job; slide mechanics, layout, and visual polish are the built-in `pptx` skill's job.
Invoke `pptx` (via the Skill tool) to actually build the file once you've worked out the content
below — do not hand-roll slide XML or reimplement what that skill already does well.

## 1. Reads

- `.startup/<slug>/business-state.json` (whole file, to preserve unrelated keys on write-back,
  and to check `founder.notes` / `key_assumptions` for fundraising intent and team info not
  captured elsewhere in the 24 steps).
- `.startup/<slug>/plan/business-plan.md` if assembled — useful for the executive-summary framing
  and the reconciled LTV:COCA figure, but go to the source step files below for slide-level detail
  since the assembled plan compresses things a deck needs to state precisely.
- Source step files, required unless noted:
  - **06-full-life-cycle-use-case, 07-high-level-product-specification,
    08-quantify-the-value-proposition** — problem, solution, and the quantified promise.
  - **04-calculate-the-tam-for-the-beachhead-market, 14-calculate-the-tam-for-follow-on-markets**
    (14 optional if not yet drafted) — market size, staged beachhead-then-expansion.
  - **15-design-a-business-model, 16-set-your-pricing-framework** — how the business makes money.
  - **22-define-the-mvbp, 23-show-that-dogs-will-eat-the-dog-food** — traction/validation
    evidence: what's actually been built and validated so far, not aspirational claims.
  - **24-develop-a-product-plan** — roadmap and milestones; source for the ask slide's "what this
    money buys" if the business has fundraising intent (check `founder.notes` and the plan's
    executive summary for an explicit funding ask — do not assume fundraising intent, ask the
    founder directly if it's ambiguous).
  - **17-calculate-the-ltv-of-a-customer, 19-calculate-the-coca** (optional but strong if present)
    — unit economics slide; state the LTV:COCA ratio explicitly, exactly as
    `agents/business-plan-editor.md` requires in the assembled plan.
  - **11-chart-your-competitive-position** (optional) — competition slide, if drafted.
  - **09-identify-your-next-10-customers** (optional) — grounds the go-to-market slide in named,
    real prospects rather than an abstract "go-to-market strategy" slide.
- If a brand-identity brief exists at `.startup/<slug>/design/brand-identity.md`, read it and
  carry its tagline/voice direction into slide copy so the deck sounds consistent with other
  launch materials — do not contradict it.

### Fundraising-deck-prep handoff

Check for `.startup/<slug>/gtm/fundraising-deck-brief.md`, produced by the GTM builder's
`skills/gtm/fundraising-deck-prep` (invoked via `agents/gtm/fundraising-advisor.md` whenever
`gtm.funding_strategy` is `raising_outside_capital`). Corroborate with `business-state.json`
`gtm.artifacts`: that skill registers `{ "type": "fundraising-deck-brief", "file":
"gtm/fundraising-deck-brief.md" }` and, if its own `pptx` build step ran, also `{ "type":
"pitch-deck", "file": "gtm/pitch-deck.pptx" }`. That skill's job is narrative/investor strategy
(what story to tell, which objections to preempt — pulled from the VC-panel's actual review
notes, not generic tropes) — **do not redo that analysis here; read the brief and defer to its
narrative arc and emphasis for slide ordering and framing**, referencing it explicitly in your
output rather than silently reproducing its reasoning. If it does not exist yet (funding
strategy isn't `raising_outside_capital`, or the founder hasn't asked for fundraising prep),
proceed using the plan alone — this skill's content stands as a solid general-purpose deck
either way, not one written to substitute for the fundraising-specific narrative.

**Avoid building a redundant, colliding deck.** If `gtm/pitch-deck.pptx` already exists (i.e.
`fundraising-deck-prep`'s own `pptx` build already ran), that deck and this skill's deck are
built from different code paths for overlapping purposes (fundraising narrative vs. general
investor/demo-day deck) and both would otherwise register under the same `gtm.artifacts` type —
`"pitch-deck"` — at two different file paths, so whichever writes second silently clobbers the
other's registration per the "replace in place" rule in §5, even though both files still exist on
disk. Before building a new deck in that situation: tell the founder plainly that a fundraising
deck already exists at `gtm/pitch-deck.pptx`, and confirm whether they want (a) to use that one
as-is, or (b) a second, differently-purposed deck (e.g. a general/demo-day deck distinct from the
investor-fundraising narrative). Only proceed to build if they choose (b), and in that case
register this skill's output under the distinct type `"pitch-deck-general"` (not `"pitch-deck"`)
in §5 so neither `gtm.artifacts` entry overwrites the other — say explicitly in your report back
that two decks now exist and what distinguishes them. (This type-collision is a real gap between
this skill and `agents/gtm/fundraising-advisor.md`/`skills/gtm/fundraising-deck-prep`, which this
skill does not own — flag it for whoever owns those files to reconcile the `type` naming
convention properly; the `"pitch-deck-general"` fallback here is a local mitigation, not the
final fix.)

## 2. Slide outline

Default structure (11-13 slides depending on what's available and whether fundraising is in
scope). Adjust order only if the fundraising-deck-prep brief specifies a different narrative arc
for a specific investor audience — otherwise use this:

1. **Title** — business name, one-line value proposition (from step 08), founder name(s).
2. **Problem** — the specific, felt problem for the beachhead persona (steps 03/05/06), stated
   concretely (who, what triggers the pain, what it costs them today) — not an industry-wide
   abstraction.
3. **Solution** — what the product actually does (step 07), tied directly back to the problem
   slide's specific pain points, one-to-one where possible.
4. **Product** — how it works in practice (step 06's use case walked through as a short
   narrative or numbered flow); note where a screenshot/demo visual should go as a placeholder if
   no product visual exists yet — be explicit that this is a placeholder, not a fabricated
   screenshot.
5. **Market size** — beachhead TAM (step 04) stated with its methodology, plus follow-on TAM
   (step 14) as expansion opportunity if drafted; every number here must trace to a
   `quantitative_claims` entry with a real source — if a number lacks one, flag it in your report
   back rather than presenting it as settled.
6. **Business model & pricing** — how revenue is made (step 15) and the pricing framework
   (step 16), concretely (actual price points/tiers, not "flexible pricing").
7. **Traction / validation** — what's actually been built and shown to work (steps 22-23):
   MVBP status and any dog-food evidence. State honestly what stage this is — a pre-launch
   business should not present this slide as if it has paying-customer traction it doesn't have.
8. **Go-to-market** (optional, strong if step 09 is drafted) — the next-10-customers motion,
   named/specific rather than generic "sales and marketing strategy."
9. **Competition** (optional, if step 11 is drafted) — competitive position, framed around the
   step 10 core differentiator, not a feature checklist.
10. **Unit economics** (optional, if steps 17/19 are drafted) — LTV, COCA, and the LTV:COCA ratio
    stated explicitly; if the ratio is weak (below roughly 3:1) or provisional (assumptions
    untested), say so on the slide rather than presenting it as a clean win.
11. **Team** — ask the founder directly for team member names/roles/relevant credibility if not
    already captured anywhere in `business-state.json`; do not fabricate team bios.
12. **Roadmap / milestones** — near-term plan from step 24.
13. **The ask** — only if fundraising intent is confirmed: amount raising, use of funds (tied to
    the roadmap milestones above), and what the round unlocks. Omit this slide entirely, don't
    leave a placeholder, if the founder isn't fundraising right now.

## 3. Numbers discipline

Every figure that lands on a slide as stated fact (market size, price, LTV, COCA, any
percentage) must trace to a `quantitative_claims` entry in `business-state.json` with a real
`source`. If a number you'd otherwise want to feature has no source, either omit it or state it
explicitly as an estimate on the slide (small caption, not hidden) — never present an unsourced
number as settled the way the plan's own no-invented-numbers rule (CONVENTIONS.md §7,
`agents/orchestrator.md` non-negotiable #4) requires elsewhere in this plugin.

## 4. Build the deck

Once slide content is worked out per §2-3, invoke the built-in `pptx` skill to actually produce
`.startup/<slug>/design/pitch-deck.pptx`. Give it: the full slide-by-slide content above, and (if
available) the color/type direction from `design/brand-identity.md` so the deck's visual styling
is consistent with the brand direction rather than a generic template. If no brand-identity brief
exists yet, use clean, investor-standard styling — restrained, legible, not template-default
clip-art — and note to the founder that running `skills/design/brand-identity` first would make
future materials more consistent.

## 5. Update business-state.json

Read the whole file, write back only:
- `gtm.artifacts`: append `{ "type": "pitch-deck", "file": "design/pitch-deck.pptx" }` (replace
  in place if a `pitch-deck` entry already exists **and it points at this same file**,
  `design/pitch-deck.pptx` — that's a refresh, e.g. after a plan revision. If a `pitch-deck`
  entry exists pointing at `gtm/pitch-deck.pptx` instead, that's the fundraising-deck-prep
  output, not a prior run of this skill — do not replace it; see the collision handling above and
  use `"pitch-deck-general"` as the type for this file in that case instead).
- `updated_at`: current ISO-8601 timestamp.

Preserve every other key untouched.

## 6. Done means

- `.startup/<slug>/design/pitch-deck.pptx` exists as a real, openable slide deck (not a text
  outline) with every slide from §2 that applies to this business.
- Every number on every slide either has a `quantitative_claims` source or is visibly flagged as
  an estimate.
- `business-state.json.gtm.artifacts` has a `pitch-deck` entry (or `pitch-deck-general`, if this
  ran alongside an existing fundraising deck per the collision handling above).
- Report back: slide count and outline, which slides used optional/not-yet-drafted plan sections
  (so the founder knows what's thin), the LTV:COCA ratio if the unit-economics slide was included,
  and whether `gtm/fundraising-deck-brief.md` was found and used (and, if a `gtm/pitch-deck.pptx`
  already existed, which of the two decks now exist and what distinguishes them).
