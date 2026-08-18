---
name: 07-high-level-product-specification
description: >
  Use to run Disciplined Entrepreneurship Step 7 with a founder: derive a prioritized (Must/
  Should/Could/Won't), high-level functional product specification, with every capability
  traced back to a specific touchpoint in Step 6's Full Life Cycle Use Case. Trigger phrases:
  "product spec," "what should we build first," "feature prioritization," "MVP feature list."
  Explicitly high-level and functional only — no architecture, tech stack, or engineering
  design decisions belong here.
---

# Step 7: High-Level Product Specification

## Role in the 24 steps

Second step of Theme 2. Turns the Full Life Cycle Use Case (Step 6) into a concrete, prioritized
set of product capabilities — the minimum coherent set that lets the Persona get through the life
cycle successfully. This is a high-level *functional* spec, explicitly not engineering design
(no architecture, tech stack, or implementation decisions) — those belong to other parts of the
plugin (e.g., ops/build skills), not here.

## Read before starting

- `.startup/<slug>/business-state.json`, including `business_basics.business_type` — read before
  drafting the spec (see "Business-type branching").
- `.startup/<slug>/plan/06-full-life-cycle-use-case.md` — **required**; every feature must trace
  to a touchpoint here. If missing or `not_started`, stop and tell the founder to complete Step 6
  first.
- `.startup/<slug>/plan/05-profile-the-persona-for-the-beachhead-market.md` for whose needs this
  serves.

## Interview the founder

1. For each touchpoint in the FLCUC where the product has a role, what specifically must the
   product do there?
2. What's the smallest set of capabilities that gets Persona through the full life cycle
   successfully — not a wishlist, the minimum coherent set?
3. Of those, which are must-have for a first version vs. nice-to-have later?
4. Are there any capabilities you're assuming are "obviously needed" that you haven't actually
   validated the Persona wants?
5. Describe the moment of highest value — what does Persona see or do at the core interaction?
6. What does the product explicitly *not* do at this stage — where's the scope boundary?

## Business-type branching

- **SaaS:** ask about must-have integrations, deployment model (cloud multi-tenant vs. on-prem vs.
  hybrid), uptime/SLA expectations at this customer tier, and data residency/security requirements
  the beachhead segment will actually ask about.
- **Physical product:** ask about materials and manufacturing tolerances, unit cost at target
  volume, packaging and shipping constraints, and any required regulatory certification (FDA,
  CPSC, UL, etc.) that gates going to market at all — a spec that ignores this isn't a real spec.
- **Services:** ask about what's standardized versus custom per engagement, what a delivery "unit"
  actually is (a project, a retainer month, an hour), and what tooling or process makes the service
  repeatable rather than fully bespoke every time.
- **Marketplace:** ask separately what each side of the marketplace needs from a first version
  (e.g., a listing/fulfillment flow for supply, a search/trust flow for demand) — a spec that only
  covers one side's capabilities isn't a marketplace spec yet.

## Method: trace every feature to a life-cycle touchpoint, then force prioritization

1. **Traceability first.** For every capability under consideration, name the specific FLCUC
   stage it serves. A capability that can't be traced to a stage is either speculative (flag it)
   or the FLCUC (Step 6) was incomplete — don't add untraceable features silently.
2. **Prioritize with MoSCoW** — Must / Should / Could / Won't have, applied honestly. If every
   item lands in "Must," push back: over-scoping the first version is the most common founder
   mistake at this step. An empty "Won't have" list is a red flag, not a sign of ambition.
3. **Describe the core user flow** in plain language — the "moment of value" walkthrough. A rough
   textual description of what the persona sees/does is sufficient; no visual mockup is required
   at this level of spec.
4. **State the scope boundary explicitly** — what the product will not attempt to do, at least
   for the first version, and why.

## When the founder doesn't know

If the founder wants a feature that isn't clearly traceable to an FLCUC touchpoint or a validated
Persona need, either trace it together or flag it honestly: add a `key_assumptions` entry,
`statement`: "Feature '<X>' is assumed valuable but not validated against the FLCUC or Persona
pain points," `step_ref`: `07_high_level_product_specification`, `confidence`: `low`,
`test_plan`: "test with the Next 10 Customers (Step 9) or an early prototype," `test_result`:
`null`. Do not silently promote an untraced feature to "Must."

## Write `plan/07-high-level-product-specification.md`

```markdown
# Step 7: High-Level Product Specification

## Traceability
| FLCUC stage | Required capability | Priority |
|---|---|---|

## Prioritized capability list
### Must have
### Should have
### Could have
### Won't have (this version)

## Core user flow ("moment of value")
(plain-language walkthrough)

## Explicit out-of-scope items

## Assumptions flagged
```

## Update `business-state.json`

```json
"disciplined_entrepreneurship": {
  "07_high_level_product_specification": {
    "status": "drafted",
    "summary": "<N> Must-have capabilities defined, traced to the FLCUC; core flow: <one line>",
    "file": "plan/07-high-level-product-specification.md"
  }
}
```

Append any new `key_assumptions` entries; preserve every other key untouched.

## Definition of done

- Every listed capability traced to a specific FLCUC stage or explicitly flagged as unvalidated.
- MoSCoW prioritization completed, including a non-empty "Won't have" list.
- `business-state.json` key `07_high_level_product_specification` set to `status: "drafted"`.
- Stop here — no architecture or tech-stack decisions belong in this file. Review/approval
  happens later via the council skill.
