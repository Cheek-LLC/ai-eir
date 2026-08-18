---
name: 05-profile-the-persona-for-the-beachhead-market
description: >
  Use to run Disciplined Entrepreneurship Step 5 with a founder: build ONE vivid, specific
  Persona — ideally a real named individual the founder has actually talked to — that
  instantiates the End User Profile from Step 3, complete with a day-in-the-life narrative,
  goals, frustrations, and trusted sources. Trigger phrases: "build a persona," "who is our
  target user," "day in the life of our customer." Distinct from Step 3's aggregate profile:
  this is one specific person used as the team's shared touchstone for every later decision.
---

# Step 5: Profile the Persona for the Beachhead Market

## Role in the 24 steps

Fifth and final step of Theme 1 ("Who is your customer?"). Takes the composite End User Profile
(Step 3) and, now with market context from Step 4's sizing, focuses it into one vivid individual
the whole team can picture and argue about concretely — "would Persona X actually want this
feature" becomes an answerable question. Every step from here forward (6-24) should be written
from or checked against this persona.

## Read before starting

- `.startup/<slug>/business-state.json`, including `business_basics.business_type` — read before
  drafting (see "Business-type branching").
- `.startup/<slug>/plan/03-build-an-end-user-profile.md` — **required**. The persona must be a
  specific instantiation of this profile, not a different or broader character.
- `.startup/<slug>/plan/04-calculate-the-tam-for-the-beachhead-market.md` — read for market
  context (not a hard dependency, but the persona should make sense against the sizing work).
  If Step 3 is missing or `not_started`, stop and tell the founder to complete it first.

## Interview the founder

1. Of everyone you talked to for Step 3, is there ONE real person who best represents the End
   User Profile? Aulet's method strongly prefers a real individual over a fabricated composite —
   push for this before settling for a hypothetical.
2. What's their name (real, if the founder is comfortable using it — otherwise a representative
   first name, clearly labeled as such), role/title, and company (or life context, for consumer)?
3. Walk me through a typical day for them — hour by hour if possible. Where does the problem area
   in your product actually show up in that day?
4. What are their top 2-3 priorities or goals at work (or in life)? What are they measured or
   rewarded on?
5. What frustrates them most about how they currently handle the problem your product addresses?
6. What do they read or watch, and who do they trust for recommendations? How do they typically
   discover new tools or approaches?
7. Is there a quote, in their own words, that captures how they feel about this problem?

## Business-type branching

- **SaaS:** the "day in the life" should center on their workflow and tools — where in their
  actual work the problem shows up.
- **Physical product:** the "day in the life" should center on the purchase/usage occasion (the
  moment the need arises, where they are, what else is happening) rather than a generic workday.
- **Marketplace:** if Step 3 produced two profiles (supply-side and demand-side), build the
  persona from whichever side is the harder constraint to win first (usually supply, in early
  marketplaces) and say explicitly which side this persona represents — a single persona silently
  standing in for both sides understates how different their days actually look. A second persona
  for the other side is worth building once the first is solid, but is not required to call this
  step done.
- **Services:** distinguish clearly whether the persona is the person who experiences the problem
  or the person who commissions the engagement (per Step 3's split) — name which one this persona
  is, since the day-in-the-life and goals differ substantially between the two.

## Method: one vivid individual, not a restatement of Step 3

Build a single persona write-up with these elements — specific and concrete, not generic:

- **Snapshot**: name, role/title, company/context.
- **Day in the life**: a short narrative walking through their day, with the problem area
  placed at the point it actually occurs.
- **Goals & how they're measured**: their real success metrics, not assumed ones.
- **Frustrations & current workaround**: what they do today instead of using your product.
- **Decision-making style & trusted sources**: how they evaluate and adopt new things.
- **Representative quote**: a direct line, ideally something they actually said.

Distinguish sharply from Step 3: Step 3 is the *aggregate filter* (characteristics that define
who's in vs. out of the target population). Step 5 is *one specific person* instantiating that
filter, used for storytelling and team alignment — not a restated summary of Step 3's table.

## When the founder doesn't know

If no real individual has been interviewed yet, still draft the persona, but:
- Label it explicitly: "Hypothetical — composited from the Step 3 profile, not yet grounded in a
  real interviewed individual."
- Add a `key_assumptions` entry: `statement`: "Persona is not yet validated against a real
  interviewed end user," `step_ref`: `05_profile_the_persona_for_the_beachhead_market`,
  `confidence`: `low`, `test_plan`: "identify and interview a real end user matching the profile
  and adopt them (or a close match) as the persona of record," `test_result`: `null`.
- Do not invent specific biographical facts (a workplace, a quote) and present them as if
  observed — mark anything invented as illustrative, not factual.

## Write `plan/05-profile-the-persona-for-the-beachhead-market.md`

```markdown
# Step 5: Persona for the Beachhead Market

## Persona snapshot
Name / Role / Company or context

## Day in the life
(narrative)

## Goals & how they're measured

## Frustrations & current workaround

## Decision-making style & trusted sources

## Representative quote

## Grounding
(real interviewee, or composite/hypothetical — state plainly which)

## Assumptions flagged
```

## Update `business-state.json`

```json
"disciplined_entrepreneurship": {
  "05_profile_the_persona_for_the_beachhead_market": {
    "status": "drafted",
    "summary": "Persona: <name>, <role> — grounded in <real interview | hypothesis>",
    "file": "plan/05-profile-the-persona-for-the-beachhead-market.md"
  }
}
```

Append any new `key_assumptions` entries; preserve every other key untouched.

## Definition of done

- One specific, vivid persona documented with all six elements above.
- Grounding stated honestly (real individual vs. hypothesis).
- `business-state.json` key `05_profile_the_persona_for_the_beachhead_market` set to
  `status: "drafted"`.
- Stop here — Theme 1 is now complete. Review/approval happens later via the council skill.
