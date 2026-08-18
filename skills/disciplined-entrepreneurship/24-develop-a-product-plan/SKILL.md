---
name: 24-develop-a-product-plan
description: >
  Use once Step 23's real usage evidence is drafted and the founder needs the forward-looking
  roadmap: what gets built next, in what order, and why. Triggers: "product roadmap," "what do
  we build next," "product plan," "roadmap after MVBP," "scaling the product," "step 24."
  Closes the Disciplined Entrepreneurship loop by sequencing near-term MVBP-to-full-product work
  against Step 23's adoption evidence, and connects the beachhead-to-follow-on bowling-pin
  sequence (Step 14) forward into go-to-market and operations execution — the final step of the
  24 and the hinge into GTM/ops.
---

# Step 24: Develop a Product Plan

## What this step is

The last of the 24 steps, and deliberately forward-looking: given everything learned from
selling and observing real usage of the MVBP (Step 22-23), what does the product roadmap
actually look like from here — first to fully deliver on the beachhead value proposition at
scale, then to open up the follow-on markets sized in Step 14. This step's job is to turn 23
steps of analysis into a sequenced, prioritized build plan, and to explicitly hand off the
threads that other parts of this plugin (GTM, ops, scaling) need to pick up next. It does not
re-litigate earlier decisions — it sequences execution of them.

## Reads

- `.startup/<slug>/business-state.json` (whole file)
- `.startup/<slug>/plan/23-show-that-dogs-will-eat-the-dog-food.md` — required. Real usage
  evidence (or its absence) directly determines roadmap priority: weak adoption in a specific
  workflow area means that area gets prioritized before anything else, regardless of what looks
  impressive to build.
- `.startup/<slug>/plan/22-define-the-mvbp.md` — required. Every manual/concierge piece flagged
  there as "automate later" is a candidate roadmap item now, with its stated automation trigger
  checked against current evidence.
- `.startup/<slug>/plan/07-high-level-product-specification.md` if present — the full intended
  product the MVBP was a deliberate subset of; this step plans the path from MVBP to that spec.
- `.startup/<slug>/plan/14-calculate-the-tam-for-follow-on-markets.md` — required. The bowling-
  pin sequence and its stated trigger conditions determine when follow-on-market product work
  enters the roadmap, not before.
- `.startup/<slug>/plan/21-test-key-assumptions.md` if present — any assumption still `deferred`
  should map to a roadmap item or an explicit "not yet, and here's why."

## Founder-facing deliverables

1. **Near-term roadmap (next 1-2 quarters)** — prioritized list of what gets built, each item
   justified by: (a) an automation trigger from Step 22 that's now been hit, (b) a weak-adoption
   signal from Step 23 that needs fixing, or (c) closing a gap to the full spec (Step 7) that
   blocks broader beachhead sales. Reject "roadmap items" justified only by founder excitement
   with no tie to evidence.
2. **Follow-on market readiness gate** — the specific, stated condition (from Step 14) that must
   be true before product work for pin 2 begins, and current distance to that gate.
3. **Sequencing rationale** — why this order and not another; what's explicitly deprioritized
   and why that's an acceptable near-term risk.
4. **Resourcing reality check** — what this roadmap assumes about team size/capability; flag
   anything that assumes hires or skills not yet in place.
5. **Handoff to GTM/ops** — explicitly list what this roadmap needs from go-to-market (e.g., "pin
   2 launch needs a new positioning brief") and from ops/scaling (e.g., "automating onboarding
   requires the support playbook to exist first") so those parts of the plugin have a clear
   starting brief rather than having to re-derive it.

Ask the founder directly:
- "Looking at Step 23's real usage data, what's the single thing customers are struggling with
  or ignoring that you'd build next regardless of anything else on this list?"
- "What's the actual trigger — not a date, a condition — for starting pin 2's product work?"
- "What would you need to hire or learn to execute the next 2 quarters of this roadmap?"

## When the founder doesn't know

Roadmap prioritization not grounded in Step 23 evidence or a stated trigger condition is founder
opinion, which is fine to include but must be labeled as such rather than presented as
evidence-driven. Add a `key_assumptions` entry when a roadmap item rests on an unvalidated bet:

```json
{ "id": "ka-024-roadmap-bet", "statement": "Assumes self-serve onboarding will fix the weak-adoption signal from Step 23 rather than a deeper workflow-fit problem", "step_ref": "24_develop_a_product_plan", "confidence": "low", "test_plan": "Ship self-serve onboarding to next 3 MVBP customers and recheck adoption signal before committing further roadmap capacity", "test_result": null }
```

## Output file: `plan/24-develop-a-product-plan.md`

```markdown
# Step 24: Product Plan

## Near-term roadmap (next 1-2 quarters)
| Item | Justification (Step 22 trigger / Step 23 evidence / spec gap) | Priority |
|---|---|---|
| ... | ... | ... |

## Follow-on market readiness (Step 14 bowling pins)
Pin 2 trigger condition: ... | Current distance to trigger: ...

## Sequencing rationale
...

## Resourcing reality check
...

## Handoff briefs
### To GTM
...
### To Ops/Scaling
...

## Open assumptions
- ka-024-...: ...
```

## Update business-state.json

```json
"24_develop_a_product_plan": {
  "status": "drafted",
  "summary": "<top 2-3 near-term roadmap priorities and the follow-on market readiness gate>",
  "file": "plan/24-develop-a-product-plan.md"
}
```

Append any new `key_assumptions` entries. Note for downstream builders: this step is the last of
the 24 Disciplined Entrepreneurship steps — once it's `drafted`, the plan-assembly skill
(`skills/business-plan/`, owned elsewhere) is what stitches all 24 step files into
`plan/business-plan.md`, and the GTM/ops handoff briefs written above are what those parts of the
plugin should read next. Do not attempt plan assembly or GTM/ops execution from this skill.
Preserve every other key untouched.

## Done means

- `plan/24-develop-a-product-plan.md` written with an evidence-grounded near-term roadmap and
  explicit GTM/ops handoff briefs.
- `business-state.json` key `24_develop_a_product_plan` set to `status: "drafted"`; leave
  review/approval to the later council skill — this skill's job ends at `drafted` even though
  it's the last of the 24 steps.
