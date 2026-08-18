---
name: 08-quantify-the-value-proposition
description: >
  Use to run Disciplined Entrepreneurship Step 8 with a founder: compute the quantified gap
  between the Persona's "as-is" state (status quo, including the next best alternative) and the
  "possible" state with the product, in the metric the Persona already cares about, and judge
  whether that gap is large enough to overcome switching costs. Trigger phrases: "quantify the
  value proposition," "how much value do we create," "ROI for the customer," "as-is vs. possible
  state." Every value figure produced here is a fact-claim and must get a sourced
  `quantitative_claims` entry.
---

# Step 8: Quantify the Value Proposition

## Role in the 24 steps

Third and final step of Theme 2. Converts the product spec (Step 7) into a concrete, numeric
value statement for the Persona (Step 5), expressed in the metric that Persona's own goals
(from Step 5) and current life cycle (Step 6) already care about — then judges honestly whether
that value clears the bar needed to overcome switching costs and status-quo bias.

## Read before starting

- `.startup/<slug>/business-state.json`, including `business_basics.business_type` — read before
  choosing the metric to quantify (see "Business-type branching").
- `.startup/<slug>/plan/07-high-level-product-specification.md` — **required**; defines what the
  product actually does. If missing or `not_started`, stop and tell the founder to complete
  Step 7 first.
- `.startup/<slug>/plan/05-profile-the-persona-for-the-beachhead-market.md` — whose value this is.
- `.startup/<slug>/plan/06-full-life-cycle-use-case.md` — the "as-is" state to compare against.

## Interview the founder

1. What is Persona's single top priority/metric they're judged on (from Step 5's goals)?
2. Describe the "as-is" state today, without your product: how much time, money, or risk does the
   current approach — including doing nothing — cost Persona, in their own terms?
3. Describe the "possible" state with your product: what specifically changes (time saved, cost
   reduced, revenue/output increased, risk or error reduced)?
4. Can you put a number on the as-is and possible states? What's the source — Persona's own
   estimate, an industry benchmark, your own calculation?
5. What's the **next best alternative**? Per Aulet, this is very often the status quo or current
   habit itself, not just a named competitor — how does your quantified benefit compare once you
   net out the cost/effort of switching?
6. Is the gap between as-is and possible large enough to justify the pain of switching (new tool,
   workflow change, adoption risk)? Answer this directly, don't hedge it away.

## Business-type branching

What the value is typically denominated in differs by type:

- **SaaS:** commonly time saved × the persona's hourly value, error/risk reduced, or a direct
  revenue/efficiency gain — expressed as $/year or a productivity metric the persona already
  tracks.
- **Physical product:** commonly cost avoided versus the current product/DIY alternative, or an
  outcome improvement (durability, health, performance) — compare total cost of ownership, not
  just sticker price, since that's usually the honest as-is/possible comparison.
- **Marketplace:** quantify **each side separately** — supply-side value is typically incremental
  revenue or utilization gained; demand-side value is typically time/cost saved finding a match or
  a better price found. Don't average the two sides into one number; report both.
- **Services:** commonly the outcome delivered (revenue generated, cost avoided, risk reduced) net
  of the service's cost and the client's own time spent managing the engagement.
- **Consumer app:** value is often denominated in time saved, enjoyment/entertainment gained, or
  social connection rather than a direct dollar figure — if there's no direct payment for the
  as-is/possible comparison, quantify via a proxy (time spent, task-completion rate, frequency of
  use) or via willingness-to-pay signaled by conversion to a paid tier. The next best alternative
  is frequently another free app already occupying that slice of attention, or simply not using an
  app for this at all — compare against that honestly, not against a paid competitor that isn't
  the real alternative most users face.
- **Other / genuine hybrid:** pick the denomination (time, money, risk, enjoyment) that matches
  whichever type's lens actually governs how this persona thinks about the problem, confirming
  with the founder rather than defaulting to a dollar figure because it's easier to compute.

## Method: as-is minus possible, in Persona's own metric, checked against switching cost

1. **Anchor to Persona's own priority metric** from Step 5 — not a generic business metric
   invented for convenience.
2. **State the as-is value** with a number and a source.
3. **State the possible value** (with the product) with a number and a source.
4. **Compute the quantified value proposition** = possible − as-is, in that metric, optionally
   converted to a dollar figure.
5. **Compare explicitly to the next best alternative** — remember the status quo/current habit is
   frequently the toughest competitor, not a rival product. The quantified benefit needs to be
   large enough to overcome real switching costs; treat this as a genuine bar to clear.
6. **State the judgment plainly**: is the gap big enough? If it's marginal, say so — don't dress
   up a weak number.

## Every value figure here is a fact-claim — source it, never invent it

This step produces numbers presented as fact. It **must** get entries in `quantitative_claims`
for the as-is value, the possible value, and/or the delta:

```json
{
  "id": "qc-08-value-delta",
  "claim": "Quantified value proposition for <Persona>",
  "value": "<as-is metric> -> <possible metric> = <delta>, ≈ $<X>/year equivalent",
  "step_ref": "08_quantify_the_value_proposition",
  "source": "<founder estimate | customer-reported figure from Step 3/9 conversations | industry benchmark (cite) | web research (cite URL)>",
  "confidence": "low|medium|high",
  "ai_risk_flag": true
}
```

Set `ai_risk_flag: true` whenever any input came from AI-assisted estimation rather than the
founder directly or a document/customer they supplied.

## When the founder doesn't know

Never invent the as-is or possible numbers to make a compelling story. If no hard number exists,
use a clearly labeled range from the founder's best judgment and add a `key_assumptions` entry:
`step_ref`: `08_quantify_the_value_proposition`, `confidence`: `low`, `test_plan`: "validate the
as-is cost and possible benefit via direct interviews with the Next 10 Customers (Step 9) or a
pilot," `test_result`: `null`.

This output is a planning aid, not financial, legal, or tax advice — state that once here.

## Write `plan/08-quantify-the-value-proposition.md`

```markdown
# Step 8: Quantified Value Proposition

## Persona's top priority metric
(from Step 5)

## As-is state
(number + source)

## Possible state with product
(number + source)

## Quantified value proposition
(delta, and $ equivalent if applicable)

## Comparison to next best alternative / status quo
(explicit switching-cost check)

## Judgment: is the gap big enough?
(state plainly — yes/no/marginal, and why)

## Quantitative claims logged

## Assumptions flagged

*This is a planning aid, not financial, legal, or tax advice.*
```

## Update `business-state.json`

```json
"disciplined_entrepreneurship": {
  "08_quantify_the_value_proposition": {
    "status": "drafted",
    "summary": "Quantified value = <delta> (~$X/year) vs. next best alternative; gap judged <sufficient|marginal|insufficient>",
    "file": "plan/08-quantify-the-value-proposition.md"
  }
}
```

Append the `quantitative_claims` entries (mandatory) and any `key_assumptions` entries. Preserve
every other key untouched.

## Definition of done

- As-is and possible states both stated with numbers and sources.
- Sourced `quantitative_claims` entries added — no unsourced value figure stands as fact.
- Explicit, honest judgment on whether the value clears the switching-cost bar.
- `business-state.json` key `08_quantify_the_value_proposition` set to `status: "drafted"`.
- Stop here — Theme 2 is now complete. Review/approval happens later via the council skill.
