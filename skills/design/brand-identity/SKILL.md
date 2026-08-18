---
name: brand-identity
description: >
  Use once a business's plan is council-approved and the founder needs brand direction — a name
  sanity-check, tagline options, a color-and-type direction, and a voice-and-tone guide. Triggers:
  "what should we name this," "give us tagline options," "brand colors," "brand voice," "help us
  sound like ourselves," "brand identity brief," "does our name work." Derives every
  recommendation from the plan's actual persona (step 05) and value proposition (step 08), not
  generic brand-agency defaults. Produces `design/brand-identity.md` — a strategic brief, not
  production assets. Does not and cannot generate a logo file, a font file, or final artwork;
  says so explicitly and points the founder to the honest next step.
---

# Brand Identity

You produce a brand identity **brief** — a strategic direction document a human designer, a logo
tool, or the founder themselves can execute against. You do not and cannot produce a logo file,
a font file, or finished artwork. Say this once, plainly, in the brief itself (see §6) — not as a
repeated disclaimer on every section.

## 1. Reads

- `.startup/<slug>/business-state.json` (whole file, to preserve unrelated keys on write-back,
  and to read `business_name`, `founder.notes` for any existing brand instincts already stated).
- `.startup/<slug>/plan/05-profile-the-persona-for-the-beachhead-market.md` — **required.** The
  persona's vocabulary, what they trust, what reads as credible vs. try-hard to them, is the
  single biggest input to tone and voice.
- `.startup/<slug>/plan/08-quantify-the-value-proposition.md` — **required.** The quantified
  promise is the spine of every tagline candidate.
- `.startup/<slug>/plan/03-build-an-end-user-profile.md` and
  `.startup/<slug>/plan/10-define-your-core.md` — if present, use for additional grounding (the
  end-user's day-to-day context; the defensible differentiator that should show up in voice, not
  just copy).
- `.startup/<slug>/plan/11-chart-your-competitive-position.md` — if present, use to make sure
  tagline/voice choices differentiate from named competitors rather than echoing their language.

If step 05 or step 08 is missing, stop and tell the founder those are required before brand work
can be grounded in anything real — do not proceed with placeholder positioning.

## 2. Name check

Sanity-check `business_name` against what you now know about the persona and positioning — not
a trademark or legal clearance (say so explicitly; that's outside this skill's scope and the
founder should run a real trademark/domain search before committing). Check for:

- **Say-ability and spell-ability** out loud, first try, by someone who's never seen it written.
- **Collision risk** with the named competitors from step 11, if available (same name, confusingly
  similar name, same category clichés — e.g. every competitor also uses "-ly" or "Hub").
- **Fit with the persona's register** — does it read as credible to *this* specific buyer (step
  05), not "startups in general"? A playful, informal name can be exactly right or exactly wrong
  depending on whether the persona is a solo consumer or a compliance officer signing a contract.
- **Stretch room** — does the name box the business into the beachhead only, or does it survive
  the follow-on markets from step 14 (if drafted)?

If the check surfaces a real concern, say so plainly and give 2-3 alternative directions (not
finished names — naming a company well is its own specialist exercise) the founder could explore.
If the name holds up, say that plainly too — don't manufacture a concern to seem thorough.

Note explicitly in the brief: you have not checked domain, trademark, or social-handle
availability — if a web-search tool is available in this session, offer to do a quick availability
sanity-check on request, but do not present an unchecked name as cleared.

## 3. Tagline options

Generate 6-8 tagline candidates, each traceable to a specific line in step 08's value proposition
or step 10's core differentiator — not generic category taglines. For each candidate, note in one
clause *which* positioning element it leads with, so the founder can pick based on which angle
they want to emphasize (the quantified outcome, the differentiator, the persona's specific pain).
Group them into 2-3 clusters by angle (e.g. "leads with the number," "leads with who it's for,"
"leads with the differentiator") rather than presenting eight undifferentiated options.

Ban generic startup tagline moves: "The future of X," "X, reimagined," "Where X meets Y," any
tagline that could be copy-pasted onto a competitor's site by swapping the product noun. If a
generated candidate fails this test, cut it before it reaches the founder.

## 4. Color and type direction (direction, not final assets)

This is a **direction**, described in words and reasoning, not a rendered palette or chosen font
files — be explicit about that boundary in the brief. Produce:

- **2-3 palette directions**, each described as a mood + role structure (primary, secondary,
  accent, neutral) with example hex ranges as illustrative anchors (e.g. "a primary in the deep
  teal range, #0F5C56–#146B64, paired with a warm off-white neutral") rather than one locked hex
  value — a designer or logo tool will refine the exact values. Tie each direction's mood
  explicitly to the persona and value prop (e.g. "the persona is a time-pressed operations
  manager who distrusts flashy tools — direction 1 leans restrained and utilitarian rather than
  playful, because playful would undercut the credibility this persona needs to see").
- **Type direction**: 1-2 pairings described by category and mood (e.g. "a grounded geometric
  sans for headlines, a highly legible text-optimized serif or sans for body — avoid anything
  novelty or hand-drawn given the compliance-adjacent persona"), not specific licensed font names
  the founder would need to buy — name well-known reference points for feel only.
- Explicitly reference `dataviz` skill palette conventions if this business will need charts/data
  visualization in its product or investor materials, so the brand palette and any future chart
  palette are designed to work together rather than clashing later.

If the founder wants a quick visual sense of a direction rather than only reading the words, offer
(don't default to) building a small mood-board Artifact via the built-in `design` skill — a single
artboard showing the palette swatches and type pairing side by side. This is optional and
secondary; the markdown brief is the deliverable of record.

## 5. Voice and tone guide

Derive directly from the persona (step 05), not a generic brand-voice framework. Produce:

- **3-5 voice attributes** stated as a spectrum, not an adjective list (e.g. "Direct — we state
  the number and the tradeoff, we don't hedge with 'may vary'" rather than just "direct"), each
  paired with a "not this" contrast to make it actionable (e.g. "confident, not hypey"). Each
  attribute should be something a competitor's brand voice plausibly gets wrong, given what step
  05 says this persona actually responds to.
- **Words to use / words to avoid**, grounded in the persona's actual vocabulary from step 05 and
  the specific claims step 08/10 can back up. Avoid list should include category clichés this
  business can't credibly claim (e.g. don't let a pre-revenue business's voice guide invite
  "trusted by thousands").
- **One worked example**: take one real sentence from the plan (e.g. the value proposition
  statement) and show it rewritten in-voice, so the guide is demonstrably usable, not abstract.

## 6. Output file: `design/brand-identity.md`

```markdown
# Brand Identity Brief — <business_name>

*This is a strategic direction brief, not production-ready assets. It does not include a logo
file, licensed fonts, or final artwork — take this brief to a human designer or a logo-generation
tool as the next step. Business/brand content here is a planning aid, not legal clearance —
run a real trademark/domain search before committing to a name.*

## Positioning inputs
- End-user profile (step 03): <one-line pull>
- Persona (step 05): <one-line pull>
- Value proposition (step 08): <one-line pull>
- Core / differentiation (step 10): <one-line pull>

## Name check
<verdict + reasoning, per §2>

## Tagline options
### Leads with the outcome
1. ...
### Leads with who it's for
...
### Leads with the differentiator
...

## Color & type direction
### Direction A — <mood name>
...
### Direction B — <mood name>
...

## Voice & tone guide
| Attribute | Not this | In practice |
|---|---|---|
| ... | ... | ... |

**Words to use:** ...
**Words to avoid:** ...

**Worked example:**
- Plan language: "<pulled sentence>"
- In-voice: "<rewritten sentence>"

## Next steps
Take this brief to a human designer or a logo-generation tool for the mark itself. Run a real
trademark/domain/social-handle search before committing to the name. Use the tagline cluster and
voice guide as direct input to `skills/design/pitch-deck` and `skills/design/landing-page` for a
consistent voice across all launch materials.
```

## 7. Update business-state.json

Read the whole file, write back only:
- `gtm.artifacts`: append `{ "type": "brand-identity", "file": "design/brand-identity.md" }`
  (replace in place if a brand-identity entry already exists — this is a refresh).
- `updated_at`: current ISO-8601 timestamp.

Preserve every other key untouched. (If this skill is invoked directly rather than via
`agents/design/brand-designer.md`, it still owns this same narrow write — see that agent's file
for the full rationale on why `gtm.artifacts` is the right home for this entry.)

## 8. Done means

- `design/brand-identity.md` exists with all six sections populated with plan-grounded, specific
  content — no generic placeholder brand language anywhere in it.
- The logo/production-assets boundary is stated once, plainly, in the file itself.
- `business-state.json.gtm.artifacts` has a `brand-identity` entry pointing at the file.
- Report back to whoever invoked this skill: the recommended tagline cluster (not just "options
  generated"), the one thing that most differentiates this brand direction from a generic
  competitor in the same category, and the name-check verdict.
