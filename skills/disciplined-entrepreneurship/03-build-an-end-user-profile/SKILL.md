---
name: 03-build-an-end-user-profile
description: >
  Use to run Disciplined Entrepreneurship Step 3 with a founder: build a composite End User
  Profile for the beachhead market selected in Step 2, grounded in primary market research
  (real conversations), covering firmographic/demographic anchor, behavioral traits,
  psychographic traits, and the distinguishing characteristic that predicts fit. Trigger
  phrases: "end user profile," "who exactly is our customer," "characteristics of our target
  user." Not the same as the Persona (Step 5, one specific vivid individual) — this step is the
  aggregate filter, not a named person.
---

# Step 3: Build an End User Profile

## Role in the 24 steps

Third step of Theme 1. Turns the chosen beachhead market (Step 2) into a specific, checkable
description of who within that market you're actually building for — granular enough that you
could point at a person in a room and say "in profile" or "out of profile." This is a
*composite*, built from multiple real people, not one named individual (that's Step 5), and it
is the direct input to Step 4's TAM count and Step 5's Persona.

## Read before starting

- `.startup/<slug>/business-state.json`, including `business_basics.business_type` — read before
  asking anything below; the profile dimensions that matter differ by type (see "Business-type
  branching").
- `.startup/<slug>/plan/02-select-a-beachhead-market.md` — **required**. If missing or Step 2's
  status is `not_started`, stop and tell the founder to run Step 2 first.

## Interview the founder

1. Have you talked to real potential end users in this beachhead? How many, and what did you
   learn from each?
2. Describe 3-5 real people you've talked to or observed: job title/role, company context (or
   life context for consumer), day-to-day tasks.
3. What behavioral or psychographic traits recur across them — tools/workflows they already use,
   how they currently solve the problem, attitudes and values, whether they hold budget
   authority, how they discover new solutions?
4. What need or pain, in their own words, keeps coming up across conversations?
5. Is the end user the same person as the economic buyer, or someone else entirely? (This seeds
   Step 12's DMU — don't resolve it fully here, just capture the observation.)
6. What distinguishes someone genuinely IN this profile from someone who superficially looks
   similar but wouldn't behave the same way (e.g., same job title at a very different company
   size or maturity)?

## Business-type branching

Ask for what actually determines a good answer at this step for this business type, not a
type-blind version of the questions above:

- **SaaS:** ask about the end user's role and tools — what's their job title, what software stack
  are they already living in, do they have budget authority or do they need to convince someone
  else, what does a typical day look like at the moment they'd feel this problem.
- **Physical product:** ask about the end user's purchase context instead — where do they
  typically shop for products like this, what triggers the purchase occasion (a life event, a
  season, a replacement need), who else in the household or team influences the purchase, what's
  their price sensitivity at the category level.
- **Marketplace:** ask about **both sides separately and explicitly** — a supply-side profile
  (what does a seller/provider look like, what's their motivation to list) and a demand-side
  profile (what does a buyer look like, what's their motivation to transact). Treating either side
  alone as "the end user" is the step-3 mistake specific to marketplaces — write two profiles, not
  one, and carry both forward into Steps 4 and 5.
- **Services:** ask about who experiences the pain day-to-day versus who commissions the
  engagement — the end user of a services offering (the person whose problem gets solved) is often
  not the person buying it; note the split here even though full DMU mapping is Step 12.

## Method: composite profile from primary market research, not a demographic guess

Build the profile across four dimensions, and require every claim to trace back to an actual
conversation, not an assumption dressed up as observation:

1. **Firmographic/demographic anchor** — B2B: industry, company size/revenue/headcount,
   role/title, department. B2C: age range, life stage, income band, household context.
2. **Behavioral characteristics** — how they currently solve the problem today, what
   tools/workflows they use, purchase/budget authority, tech-savviness, trusted information
   sources.
3. **Psychographic/attitudinal characteristics** — values, risk tolerance, what they're
   optimizing for.
4. **Distinguishing/trigger characteristic** — the specific thing that makes this person
   susceptible to your solution *now*, separating true fits from lookalikes.

This must be based on **actual conversations (primary market research)**, not invented
demographics. If the founder has done fewer than ~5 real conversations, say so plainly in the
output — this step exists specifically to force "get out of the building" discipline.

## When the founder doesn't know

If primary research is thin (fewer than 5 conversations) or absent, still draft a best-effort
profile from the founder's hypotheses, but:
- Label it clearly as hypothesis-based, not research-validated.
- Add a `key_assumptions` entry: `statement`: "End user profile is not yet validated by primary
  market research (only N conversations so far)," `step_ref`: `03_build_an_end_user_profile`,
  `confidence`: `low`, `test_plan`: "conduct at least 10 interviews with candidates matching the
  hypothesized profile," `test_result`: `null`.
- Do not fabricate specific behavioral or attitudinal detail and present it as observed fact.

## Write `plan/03-build-an-end-user-profile.md`

```markdown
# Step 3: End User Profile

## Research basis
(# of real conversations, method — interviews, observation, surveys)

## Profile dimensions
(for a marketplace, complete one full table per side — supply-side profile and demand-side
profile — rather than one shared table; see "Business-type branching" above)
| Dimension | Detail |
|---|---|
| Firmographic/demographic anchor | |
| Behavioral characteristics | |
| Psychographic characteristics | |
| Distinguishing/trigger characteristic | |

## Narrative profile
(for a marketplace: one narrative per side)
("This person is a ... who currently ... and struggles with ...")

## In-profile vs. out-of-profile
(what makes someone a real fit vs. a superficial lookalike)

## Relationship to the economic buyer
(same person as end user, or different — note only, full DMU mapping is Step 12)

## Assumptions flagged
```

## Update `business-state.json`

```json
"disciplined_entrepreneurship": {
  "03_build_an_end_user_profile": {
    "status": "drafted",
    "summary": "End user profile drafted from N conversations: <one-line description of the profile>",
    "file": "plan/03-build-an-end-user-profile.md"
  }
}
```

Append any new `key_assumptions` entries; preserve every other key untouched.

## Definition of done

- Profile covers all four dimensions with specifics, not generic filler.
- Research basis (conversation count/method) stated honestly, including if it's thin.
- `business-state.json` key `03_build_an_end_user_profile` set to `status: "drafted"`.
- Any unvalidated hypotheses logged in `key_assumptions`.
- Stop here — this step does not select the TAM count (Step 4) or name one specific persona
  (Step 5). Review/approval happens later via the council skill.
