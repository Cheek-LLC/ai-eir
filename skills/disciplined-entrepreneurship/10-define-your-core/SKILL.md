---
name: 10-define-your-core
description: >
  Use to run Disciplined Entrepreneurship Step 10 with a founder: identify the single, durable
  Core the company is built around (Unique, Important to the persona, and Growing stronger over
  time) and distinguish it from a temporary Moat and from the multiple customer-facing
  Competitive Advantages that flow from it. Trigger phrases: "define our core," "what's our
  moat," "sustainable competitive advantage," "defensibility." Do not accept a list of several
  "cores" — press for the single foundational asset.
---

# Step 10: Define Your Core

## Role in the 24 steps

Second step of Theme 3. Names the single, durable asset or capability the company will be built
around and will not outsource — distinct from the (possibly several) customer-facing competitive
advantages that result from it. This directly informs Step 11's chosen axes (you plot where your
Core lets you win) and is a load-bearing fact for every later claim about defensibility.

## Read before starting

- `.startup/<slug>/business-state.json`, including `business_basics.business_type` — read before
  probing for candidate Cores (see "Business-type branching").
- `.startup/<slug>/plan/07-high-level-product-specification.md` — what the product can do.
- `.startup/<slug>/plan/08-quantify-the-value-proposition.md` — why it matters to the persona.
- `.startup/<slug>/plan/02-select-a-beachhead-market.md` for competitive context. If Step 7 or 8
  is missing or `not_started`, stop and tell the founder to complete those first.

## Interview the founder

1. What can you do that would be genuinely hard for a well-resourced competitor to replicate
   quickly — proprietary technology, a unique dataset, a network effect, exclusive
   relationships/partnerships/IP, deep domain expertise/team, brand/community, or a
   business-model/cost-structure advantage?
2. If a well-funded competitor decided to copy you tomorrow, what specifically would take them
   the longest to build or acquire?
3. Does this advantage get **stronger over time** as you grow — a data flywheel, network
   effects, brand, economies of scale — or does it stay static, or even erode?
4. Could you, in principle, license or outsource this? (If yes, it's probably not your Core — a
   true Core is something you build the company around and keep in-house.)
5. What are the resulting competitive advantages/customer-visible benefits that flow from this
   Core (faster, cheaper, better UX, etc.)? These can be plural even though the Core is singular.

## Business-type branching

What a real, durable Core tends to look like differs by type — use these as prompts for the
interview questions above, not as a checklist to rubber-stamp:

- **SaaS:** common real Cores are proprietary data/models trained on accumulating usage, deep
  workflow/integration lock-in, or network effects within a workspace or team.
- **Physical product:** common real Cores are a proprietary manufacturing process or IP, exclusive
  supplier/material-sourcing relationships, or a brand built over years — "our product is well
  designed" is not a Core; a competitor can copy a design.
- **Marketplace:** the single most common real Core is liquidity/network effects — density on one
  side attracting the other — but this is only a true Core once real liquidity exists, not merely
  hoped for; a pre-liquidity marketplace usually has no durable Core yet, and that's a legitimate
  finding, not a failure to paper over.
- **Services:** common real Cores are a proprietary methodology/playbook, a practitioner's
  reputation/expertise that's genuinely hard to replicate, or a proprietary tool/dataset built
  through delivering the service. A generalist services business often has no durable Core yet —
  say so plainly rather than defaulting to "our people" as a Core, which rarely survives the
  Unique test.

## Method: Core vs. Moat vs. Competitive Advantage — three distinct things

- **Core** = the single, foundational, hard-to-replicate capability or asset the company is built
  around and does not outsource.
- **Competitive advantages** = the customer-facing benefits (often several) that result from the
  Core — these are what get plotted on the Step 11 competitive-position chart.
- **Moat** = a temporary advantage (e.g., "competitors don't know what we're doing yet," a
  first-mover speed lead) that slows competitors down but doesn't durably keep them behind. A
  moat is real and useful, but it is **not** a Core — call it out explicitly if that's what the
  founder is actually describing.

Test any candidate Core against three criteria, all required:
1. **Unique** — genuinely hard for others to replicate.
2. **Important** — directly drives something the Persona (Step 5) values highly, per the
   quantified value proposition (Step 8).
3. **Grows** — gets stronger relative to competitors over time, rather than eroding.

Require the founder to name **one** Core. If they list several candidates, ask which one the
others actually depend on — the rest become supporting competitive advantages or assets, not
additional Cores.

## When the founder doesn't know

Don't invent a Core (e.g., defaulting to "our proprietary AI algorithm") with no real basis —
this is common and dishonest for a pre-product company. If no durable Core exists yet, say so
plainly and add a `key_assumptions` entry: `statement`: "No durable Core identified yet; current
advantage (<name it>) may be a temporary moat rather than a sustainable Core," `step_ref`:
`10_define_your_core`, `confidence`: `low`, `test_plan`: "identify what asset to invest in over
the next 12-24 months that would become a true Core (e.g., proprietary data, network effects),"
`test_result`: `null`. This is a genuine and important finding — do not soften it.

## Write `plan/10-define-your-core.md`

```markdown
# Step 10: Define Your Core

## Candidate advantages considered

## The Core
(single statement) — passes Unique / Important / Grows because:
- Unique:
- Important:
- Grows:

## Resulting competitive advantages
(feeds Step 11's axis choice)

## Core or just a Moat?
(explicit judgment)

## Assumptions / gaps flagged
```

## Update `business-state.json`

```json
"disciplined_entrepreneurship": {
  "10_define_your_core": {
    "status": "drafted",
    "summary": "Core: <one-line statement>; resulting advantages: <A, B>; verdict: <true core|moat only|not yet identified>",
    "file": "plan/10-define-your-core.md"
  }
}
```

Append any new `key_assumptions` entries; preserve every other key untouched.

## Definition of done

- Exactly one Core named, tested against Unique/Important/Grows.
- Resulting competitive advantages listed separately from the Core itself.
- Honest verdict given if the "core" is really just a moat, or not yet identified.
- `business-state.json` key `10_define_your_core` set to `status: "drafted"`.
- Stop here — review/approval happens later via the council skill, not this one.
