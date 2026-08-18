---
name: 09-identify-your-next-10-customers
description: >
  Use to run Disciplined Entrepreneurship Step 9 with a founder: name 10 REAL, specific, named
  prospects (people or organizations, not generic descriptions) matching the End User Profile
  and Persona who could realistically be reached in the next 1-3 months, with a fit rationale
  and access path for each. Trigger phrases: "next 10 customers," "who can we sell to first,"
  "early pipeline," "beachhead reality check." Doubles as a reality check on the beachhead
  choice — never pad the list with fabricated names to reach 10.
---

# Step 9: Identify Your Next 10 Customers

## Role in the 24 steps

First step of Theme 3 ("How does your customer acquire your product?"). Forces the beachhead
selection (Step 2) and the End User Profile/Persona (Steps 3, 5) to prove themselves against
reality: can the founder actually name 10 specific people or organizations they could reach? This
is both a validity check on everything upstream and the seed of the early sales pipeline that
Steps 13/18 (acquisition/sales process) and the GTM skills build on later.

## Read before starting

- `.startup/<slug>/business-state.json`, including `business_basics.business_type` — read before
  interviewing (see "Business-type branching").
- `.startup/<slug>/plan/03-build-an-end-user-profile.md` and
  `.startup/<slug>/plan/05-profile-the-persona-for-the-beachhead-market.md` — **required**, the
  fit criteria for who counts as a real prospect. If either is missing or `not_started`, stop and
  tell the founder to complete those steps first.
- `.startup/<slug>/plan/02-select-a-beachhead-market.md` for where to look.

## Interview the founder

1. Thinking about the End User Profile and Persona, name 10 real, specific people or
   organizations — not "companies like X," actual named prospects — you could plausibly reach in
   the next 1-3 months.
2. For each: how would you actually get access to them — warm intro, existing relationship, a
   specific cold-outreach channel, a community or event?
3. For each: why do they specifically fit the profile, beyond just being in the same industry?
4. Have you already talked to any of these 10? What did they say?
5. If you can't name 10 yet, what's blocking you — not enough people in the space, haven't
   started outreach, or does the beachhead itself turn out to be too narrow or inaccessible?

## Business-type branching

- **SaaS:** access paths are typically an existing network, direct LinkedIn outreach, communities/
  Slack or Discord groups the persona is in, or a waitlist/content audience already built.
- **Physical product:** access paths are typically existing retail-buyer relationships, pop-ups/
  markets, a direct social audience, or wholesale contacts.
- **Services:** access paths are typically referrals from past clients or colleagues, or an
  existing professional network — cold outreach converts far less reliably here than a warm
  introduction.
- **Marketplace:** the "next 10" must include **both sides** — 10 supply-side prospects alone (or
  10 demand-side prospects alone) isn't a real pipeline for a marketplace, since neither side has
  anything to transact with the other. Name real prospects on both sides, even if the split isn't
  even, and say explicitly whether the binding constraint is supply or demand right now.

## Method: real names, not a description of a type of customer

Build a table of 10 named prospects, each with: name/organization, role, fit rationale (tied
explicitly to Steps 3/5's profile), access path (how you'd actually reach them), and current
status (not contacted / contacted / in conversation). This step is deliberately a **reality
check** — if the founder can only name a handful of real prospects, that's a legitimate finding
about the beachhead's accessibility (Step 2) or the profile's specificity (Step 3), not a
formatting problem to paper over. Surface it explicitly rather than forcing a fabricated 10.

## When the founder doesn't know

**Never fabricate fictitious named people or companies to fill out the list of 10** — a list
padded with invented names is worse than no list, because it silently defeats the entire point of
this step. If the founder can only name fewer than 10 real prospects:
- List exactly what's real, honestly, even if short.
- Add a `key_assumptions` entry: `statement`: "Founder has identified only N of 10 target next
  customers; beachhead accessibility is unproven," `step_ref`:
  `09_identify_your_next_10_customers`, `confidence`: `low`, `test_plan`: "networking/outreach
  plan to identify the remaining prospects within [a stated timeframe]," `test_result`: `null`.

## Write `plan/09-identify-your-next-10-customers.md`

```markdown
# Step 9: Next 10 Customers

## Fit criteria
(summarized from Steps 3 & 5)

## Prospects
| # | Name/org | Role | Fit rationale | Access path | Status | Side (marketplace only: supply/demand) |
|---|---|---|---|---|---|---|

## Signal check: does this validate the beachhead?
(explicit judgment — if fewer than 10 real prospects exist, say so and what it implies for Step 2)

## Assumptions flagged
```

## Update `business-state.json`

```json
"disciplined_entrepreneurship": {
  "09_identify_your_next_10_customers": {
    "status": "drafted",
    "summary": "<N> of 10 real prospects identified; beachhead accessibility: <validated|unproven>",
    "file": "plan/09-identify-your-next-10-customers.md"
  }
}
```

Append any new `key_assumptions` entries; preserve every other key untouched.

## Definition of done

- Every listed prospect is real and named — no placeholders styled as real names.
- Honest count stated even if below 10, with the accessibility implication called out.
- `business-state.json` key `09_identify_your_next_10_customers` set to `status: "drafted"`.
- Stop here — review/approval happens later via the council skill, not this one.
