---
name: 12-determine-the-dmu
description: >
  Use to run Disciplined Entrepreneurship Step 12 with a founder: map the Decision-Making Unit
  for a typical purchase in the beachhead market — End User, Champion, Primary Economic Buyer,
  plus any Influencers, Recommenders, and veto-holders (e.g. IT/security/legal/procurement) —
  naming the realistic job title/function for each role. Trigger phrases: "decision-making
  unit," "DMU," "who signs off on the purchase," "who else is involved in buying this." Names
  WHO is involved; mapping the acquisition process itself is Step 13, owned elsewhere.
---

# Step 12: Determine the Customer's Decision-Making Unit (DMU)

## Role in the 24 steps

Fourth step of Theme 3, and the last step this skill package owns. Maps every role involved in a
typical purchase decision within the beachhead — because most B2B (and many consumer) purchases
involve more than one person, and treating the End User as the only relevant party is a common
and costly mistake. This is the direct input to Step 13 (mapping the process to acquire a paying
customer), built by other skills — this step stops at identifying *who*, not *how* to win them.

## Read before starting

- `.startup/<slug>/business-state.json`, including `business_basics.business_type` — read before
  mapping roles (see "Business-type branching").
- `.startup/<slug>/plan/05-profile-the-persona-for-the-beachhead-market.md` — **required**; the
  Persona is usually (but not always) the End User role in the DMU.
- `.startup/<slug>/plan/06-full-life-cycle-use-case.md` — for the light-touch mention of who gets
  involved before purchase. If Step 5 is missing or `not_started`, stop and tell the founder to
  complete it first.

## Interview the founder

1. In a typical purchase within your beachhead, is the End User (Persona) also the person who
   pays or approves budget? If not, who is?
2. Who would actively champion bringing your product in — pushing for it internally? Is this the
   same person as the end user, or someone else (e.g., a manager who benefits from the team
   adopting it)?
3. Besides the champion and the economic buyer, who else gets consulted or must sign off — IT or
   security review, procurement, legal, a manager's manager?
4. Is there anyone who could kill the deal even if everyone else likes it — a veto-holder such as
   IT security, compliance, or a skeptical executive?
5. For each role, what's the realistic job title/function at a typical target organization (or,
   for consumer, which household member)? Be specific — "VP of Engineering at a 50-200 person
   SaaS company," not "a decision maker."
6. Roughly how many total people are typically involved before a deal closes?

## Business-type branching

- **SaaS:** for anything touching customer data, expect an IT/security-review veto-holder even in
  otherwise simple deals; the economic buyer is often a budget-holding manager/director, not the
  end user themselves.
- **Physical product (B2C):** the DMU often collapses to one or two people (the buyer plus a
  household influencer). For B2B physical product (equipment, supplies), expect procurement and an
  operations/facilities approver in addition to the end user.
- **Services:** expect a champion who directly experienced the pain, plus whoever controls budget
  for outside vendors — in larger organizations this is frequently a separate procurement or
  finance approval step even for a small first engagement.
- **Marketplace:** map a DMU **per side**, independently — the supply side has its own decision
  process (e.g., a shop owner deciding whether to list, possibly with a business partner's
  sign-off) and the demand side has its own (e.g., a consumer deciding to buy, possibly with a
  household influencer). Mapping only one side's DMU misses half the acquisition problem Step 13
  needs to solve.
- **Consumer app:** the DMU usually collapses to just the End User, who is also their own economic
  buyer (paying for their own subscription or in-app purchase) — the common case is one person, not
  three or four roles. Check for two real exceptions before collapsing it, though: a household/
  social influencer who recommended it or shares the account/subscription, and — for anything a
  minor could plausibly use — a parent/guardian acting as an explicit veto-holder via app-store
  parental controls or payment approval.
- **Other / genuine hybrid:** map the DMU using whichever pattern above (simple/collapsed consumer,
  B2B multi-role, per-side marketplace) actually matches how a purchase happens in this specific
  business, and say explicitly which pattern was used and why, rather than defaulting to generic
  B2B roles for a business that doesn't have them.

## Method: name the roles, then name the real titles that fill them

Map the DMU using Aulet's core roles:
- **End User** — who actually uses the product day to day (usually = Persona, Step 5; note if
  it's someone else here).
- **Champion** — who actively wants and pushes for the purchase internally; may or may not be the
  End User.
- **Primary Economic Buyer** — who controls and approves the budget, and can say yes to spending.
- **Additional roles as relevant**: Influencers/Recommenders (advise but don't decide),
  Veto-holders (can kill a deal even if others want it — often IT/security/legal/compliance), and
  Procurement (a formal purchasing gatekeeper, mainly at larger organizations).

State explicitly how many distinct people this collapses to for *this specific beachhead* — in
small/simple sales (consumer, solo-founder SMB) these roles often collapse into one person; in
B2B/enterprise they typically split across three or more. Map what's realistic here, don't
default to enterprise complexity for a simple market or vice versa. For every role, name the
realistic job title/function within the Step 3 target-org profile — not a generic label.

## When the founder doesn't know

If the founder hasn't observed a real buying process yet (no pilot or sales conversations),
don't assert specific titles as confirmed fact. Draft best-guess roles based on the End User
Profile and typical company size for this beachhead, and add a `key_assumptions` entry:
`statement`: "DMU roles are hypothesized, not yet confirmed via real sales conversations,"
`step_ref`: `12_determine_the_dmu`, `confidence`: `low`, `test_plan`: "confirm via conversations
with the Next 10 Customers (Step 9) — ask directly 'who else needs to be involved in this
decision?'," `test_result`: `null`.

## Write `plan/12-determine-the-dmu.md`

```markdown
# Step 12: Decision-Making Unit (DMU)

## DMU roles
(for a marketplace, complete one full table per side — supply-side DMU and demand-side DMU —
rather than one shared table)
| Role | Who fills it (realistic title) | Same as End User? | Notes |
|---|---|---|---|
| End User | | | |
| Champion | | | |
| Primary Economic Buyer | | | |
| Influencer/Recommender | | | |
| Veto-holder | | | |
| Procurement (if applicable) | | | |

## Veto/blocker risks

## Typical deal size & complexity
(how many distinct people, roughly, before close)

## Implications for the acquisition approach
(teed up for Step 13 — not solved here)

## Assumptions flagged
```

## Update `business-state.json`

```json
"disciplined_entrepreneurship": {
  "12_determine_the_dmu": {
    "status": "drafted",
    "summary": "DMU mapped: <N> distinct roles/people typical; champion = <title>, economic buyer = <title>",
    "file": "plan/12-determine-the-dmu.md"
  }
}
```

Append any new `key_assumptions` entries; preserve every other key untouched.

## Definition of done

- All applicable DMU roles named with realistic job titles for this beachhead, not generic labels.
- Explicit statement of how many distinct people are typically involved.
- Unconfirmed roles logged in `key_assumptions`, not asserted as fact.
- `business-state.json` key `12_determine_the_dmu` set to `status: "drafted"`.
- Stop here — do not map the acquisition process itself; that is Step 13, owned by another
  builder. Review/approval happens later via the council skill.
