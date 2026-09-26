---
name: 13-pitch-deck-design
description: >
  Use once a real pitch deck exists (built by `skills/gtm/fundraising-deck-prep` or
  `skills/design/pitch-deck`) and needs a design-quality pass — Tactic 13 of Paul Cheek's 15
  Tactics: Pitch Decks for Startups. Triggers: "does our deck look good," "review our pitch deck's
  design," "our deck feels cluttered," "should we cut slides," "make the deck presentable." This
  tactic does not build deck content or narrative — that's `fundraising-deck-prep` (investor
  narrative, when raising) and `skills/design/pitch-deck` (general slide content, via the built-in
  `pptx` skill) — it's a thin pointer to both plus the visual-design and storytelling discipline
  neither of those already owns: slide-count discipline, visual hierarchy, and telling a story
  instead of dumping data.
---

# Tactic 13: Pitch Deck Design

## What this tactic is, and what it isn't

Two skills already own deck **content**:

- **`skills/gtm/fundraising-deck-prep`** builds the investor narrative and slide-by-slide brief
  when the business is actually raising outside capital — every number sourced, every anticipated
  objection pulled from real VC-panel review notes. It hands the actual `.pptx` build to the
  built-in `pptx` skill.
- **`skills/design/pitch-deck`** builds a general-purpose deck straight from the approved plan
  (problem/solution, market size, business model, traction, team, ask) when the founder wants a
  deck but isn't necessarily deep in an active raise, and defers to `fundraising-deck-prep`'s
  narrative arc when that brief already exists.

**This tactic does not re-specify deck content structure — both skills above already own that in
full, and duplicating it here would just create two places that could drift out of sync.** This
tactic's job is the design-quality pass that neither of them fully owns: whether the deck a
founder is about to actually present *works* as a presented artifact — visual hierarchy, slide
discipline, and storytelling — once the content exists.

**Scope boundary:** this is a design/communication review, not investor-narrative strategy and not
legal/securities advice — those boundaries are already stated once by `fundraising-deck-prep` and
`agents/gtm/fundraising-advisor.md`; this tactic doesn't repeat them.

## What you read

- `.startup/<slug>/business-state.json` `gtm.artifacts` — check for an existing `fundraising-deck-
  brief`, `pitch-deck`, or `pitch-deck-general` entry. **This tactic requires one of these to
  already exist** — if none does, hand off to `fundraising-deck-prep` (if `gtm.funding_strategy` is
  `raising_outside_capital`) or `skills/design/pitch-deck` (otherwise) first; there is nothing to
  design-review yet.
- The actual deck file(s) referenced by those `gtm.artifacts` entries, and the brief
  (`gtm/fundraising-deck-brief.md`) if one exists — read the real slide content, not just the file
  list, so the review below is concrete to this deck, not generic.
- `.startup/<slug>/design/brand-identity.md`, if it exists — the deck's visual styling should be
  consistent with it; flag a contradiction rather than silently letting the deck drift from brand.
- `.startup/<slug>/tactics/13-pitch-deck-design.md`, if it already exists — for what was already
  flagged last review, so this pass reports what changed, not a repeat of the same list.

## What you write

- `.startup/<slug>/tactics/13-pitch-deck-design.md` — the design-quality review below.
- You do **not** write `business-state.json.tactics` yourself. Report your output file and a
  one-line summary back to whoever invoked you; the orchestrator updates
  `business-state.json.tactics.13_pitch_deck_design` after confirming the file output.

## The design-quality pass

### 1. Slide-count discipline

A deck that will actually be **presented live** (demo day, an investor meeting with the founder
narrating) should run **10-15 slides** for the core narrative. Every slide beyond that is a slide
the founder either has to rush through or that dilutes the one story the deck is supposed to tell.
Detail that's genuinely needed for diligence-level questions — a deeper cohort breakdown, a
competitive-matrix appendix, additional traction data — belongs in a **backup/appendix section**
(5-10 slides, clearly separated, pulled up only if a specific question calls for it), never folded
into the core deck just because the data exists.

**Live-presented vs. cold-sent decks need different density, and this is a real, distinct design
call, not a stylistic preference:** a deck the founder narrates in person can run sparse — a single
number or image per slide, with the founder supplying the context out loud. A deck that will be
**emailed cold** (sent ahead of a meeting, or to an investor who will never hear the founder pitch
it) has no narrator, so each slide needs enough self-contained text to carry its own point.
Building one deck to serve both purposes without adjusting density for the actual delivery channel
is a common, avoidable mistake — ask which situation this deck is for, and say so explicitly in
the review if the deck's density doesn't match its intended use.

### 2. Visual hierarchy — one idea per slide, stated as a real headline

Each slide should have exactly one point, and the slide's title should be able to state that
point as a real assertion, not a label. Compare **"Market"** (a label — tells the reader nothing
until they've absorbed the whole slide) against **"Our beachhead market is $[X]M and growing
[Y]% annually"** (an assertion — the reader gets the point from the title alone, and the slide's
body exists to support it, not to be the only place the point is made). Check every slide title in
the deck against this test; flag every slide whose title is a label instead of an assertion.

Beneath the headline: a strict **legibility rule** — no more than roughly 6 bullets, no more than
roughly 6 words each, or replace bullets entirely with a single chart/diagram/number that makes the
point visually. A slide that needs a paragraph of body text to make its point is a sign the point
itself needs to be simplified, not that the founder needs smaller type.

### 3. "Tell a story, don't dump data"

The deck's slide order should read as an actual narrative arc — problem, tension (why existing
solutions fail), resolution (this product), and possibility (the size of what this becomes) — not
a checklist of business-plan sections presented in whatever order the plan happened to cover them.
Both `fundraising-deck-prep` and `skills/design/pitch-deck` already order slides this way by
default; this review's job is confirming the *execution* holds the arc together once real content
is in the slides, not re-deriving the order.

The concrete test for "data dump" versus "story": every number on a slide should exist because it
serves that slide's one point, not because it was available and felt rigorous to include. A market-
size slide with five sourced statistics and no clear "so what" is a data dump; the same slide with
one number, stated as the assertion-headline, and the sourcing in a small caption, is a story beat.
Flag any slide where this test fails.

### 4. Consistency and polish

- **Color/type consistent with `design/brand-identity.md`** if it exists — check the deck actually
  uses that direction rather than a generic template default; flag any drift.
- **No unlabeled placeholder visuals.** If a screenshot or product visual is a stand-in (per
  `skills/design/pitch-deck`'s own explicit placeholder convention), confirm it's still clearly
  marked as a placeholder, not something that could be mistaken for a real product shot.
- **Speaker notes carry the depth, not the slide.** Both upstream skills already put "investor will
  likely ask" content into speaker notes (`addNotes`, per the `pptx` skill) rather than on the
  visible slide — confirm that discipline held in the actual built file, and flag any slide where
  defensive detail leaked onto the visible surface instead.

## Output file: `tactics/13-pitch-deck-design.md`

```markdown
# Tactic 13: Pitch Deck Design — <business name> — <date>

## Deck reviewed
<Which gtm.artifacts entry/entries — file path, which upstream skill produced it, whether this is
a raising-oriented deck (fundraising-deck-prep) or a general deck (design/pitch-deck).>

## Delivery-channel check
<Live-presented, cold-sent, or both — and whether slide density actually matches.>

## Slide-count discipline
Core deck slide count: N (target 10-15). Appendix/backup slides: N.
<Any slide recommended to move to appendix, and why.>

## Visual hierarchy findings
<Per-slide: title-as-assertion pass/fail, bullet/word-count check, any slide needing simplification.>

## Story-arc check
<Whether slide order reads as problem->tension->resolution->possibility; any "data dump" slide
flagged with the specific fix (cut, or restate around one point).>

## Consistency and polish
<Brand-identity match, placeholder labeling, speaker-notes discipline.>

## Recommended fixes, prioritized
1. ...
```

## Done means

- The upstream content skill (`fundraising-deck-prep` or `design/pitch-deck`) was identified and
  its output read directly — this review is never run against a deck that doesn't exist yet.
- Slide count and delivery-channel density were checked explicitly, not assumed.
- Every slide's title was tested as assertion-vs-label; every "data dump" slide was named
  specifically, not gestured at generally.
- Concrete, prioritized fixes are stated — never a vague "the deck could look nicer."
- `tactics/13-pitch-deck-design.md` is written. `business-state.json.tactics` is left to the
  orchestrator.
