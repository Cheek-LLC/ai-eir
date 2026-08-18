---
name: 23-show-that-dogs-will-eat-the-dog-food
description: >
  Use once the MVBP (Step 22) has been sold to at least one real paying customer and the founder
  needs to prove actual usage and adoption, not just a signed deal. Triggers: "dogs eating the
  dog food," "are customers actually using it," "usage data," "adoption signal," "engagement
  metrics," "are they really using this," "step 23." Validates real customer usage/engagement
  post-sale with concrete data — a closed deal from Step 22 is necessary but not sufficient; this
  step is about what happens after the money changes hands.
---

# Step 23: Show That "The Dogs Will Eat the Dog Food"

## What this step is (and isn't)

A signed, paid deal from Step 22 proves someone was willing to pay — it does **not** prove the
product actually delivers value in real use. The "dog food" metaphor: it doesn't matter how good
the marketing or the sales pitch was if, once delivered, the dogs (real customers) won't eat it
(actually use it). This step requires **real usage evidence**, not customer sentiment or a
satisfied-sounding conversation. Aulet is explicit that qualitative impressions and founder
enthusiasm are not sufficient here — concrete data on actual behavior is required: are they
logging in, completing the core workflow, coming back, expanding usage, renewing, or actively
referring others.

Do not accept "the customer seems happy" as evidence for this step. Push for measurable signal:
usage frequency, feature adoption depth, retention/renewal, expansion (seats/spend growing), and
unprompted advocacy (referral, testimonial volunteered without being asked, case-study
willingness).

"Measurable signal" looks different by `business_basics.business_type` — push for the concrete
version, not a generic one:
- **SaaS:** login/feature-usage events, DAU/WAU, core-workflow completion rate.
- **Physical product:** repeat purchase or reorder rate, consumption rate of a consumable,
  unprompted reviews/unboxing engagement.
- **Marketplace:** repeat transaction rate on **each side separately** (supply-side re-listing,
  demand-side repeat purchase) — a healthy demand side with a churning supply side is not healthy.
- **Services:** retainer renewal/expansion, scope increase requested by the client, referral to
  another client — for a one-off project, "would they hire you again" is the closest analog.

## Reads

- `.startup/<slug>/business-state.json` (whole file). Check `business_basics.business_type` for
  which usage signal above is the right one to chase.
- `.startup/<slug>/plan/22-define-the-mvbp.md` — required. Establishes who the paying
  customer(s) are and what "using it" was supposed to mean per the MVBP's definition of success.
- `.startup/<slug>/plan/06-full-life-cycle-use-case.md` if present — the intended full usage
  pattern this step checks actual behavior against.
- `.startup/<slug>/plan/03-build-an-end-user-profile.md` if present — the end user (who may
  differ from the economic buyer per the DMU) is specifically who must be shown to actually use
  the product.

## Founder-facing deliverables

For each MVBP customer sold in Step 22, gather and report:

1. **Usage frequency and depth** — how often, and how much of the core workflow (from Step 6's
   full life cycle use case) they actually complete, vs. abandon.
2. **Retention signal** — still active at 30/60/90 days? Renewed or expanded (if the contract
   period has elapsed)? Churned (and if so, why — real reason, not a guess)?
3. **Value realization check** — does actual usage data support the value quantified in Step 8
   (e.g., if the pitch was "saves 5 hours/week," is there any evidence usage is producing that)?
4. **Unprompted advocacy** — has this customer referred anyone, agreed to a reference call, or
   volunteered a testimonial without being asked? This is a stronger signal than a satisfied
   survey response.
5. **Honest negative signal** — where usage is weak or absent, say so plainly and identify the
   likely cause (onboarding friction, wrong end user targeted, value not actually delivered,
   habit formation failure) rather than explaining it away.

Ask the founder directly:
- "Pull up actual usage data right now — not what you think is happening, what's logged. What
  does it show?"
- "If this customer's contract renewal came up today, would they renew without you asking twice?"
- "Has anyone used this in a way you didn't expect, or stopped using a part of it you thought was
  important?"

## When the founder doesn't know

If no usage instrumentation exists yet, or the MVBP hasn't been in a real customer's hands long
enough to observe a pattern, do not fabricate adoption signal. Add a `key_assumptions` entry and
state plainly in the plan file that this step is not yet resolvable:

```json
{ "id": "ka-023-usage-data", "statement": "No usage instrumentation exists yet; adoption/retention signal cannot be measured", "step_ref": "23_show_that_dogs_will_eat_the_dog_food", "confidence": "low", "test_plan": "Instrument core workflow completion and login frequency before/alongside next MVBP sale; revisit this step once 30 days of real usage data exists", "test_result": null }
```

Any usage numbers reported here should also get a `quantitative_claims` entry when presented as
fact (e.g., "80% weekly active usage") since these become claims other steps and reviewers will
rely on:

```json
{ "id": "qc-023-wau", "claim": "Weekly active usage rate, first MVBP cohort", "value": "2 of 3 customers active weekly", "step_ref": "23_show_that_dogs_will_eat_the_dog_food", "source": "founder-reported usage logs, n=3, 6 weeks of data", "confidence": "low", "ai_risk_flag": true }
```

## Output file: `plan/23-show-that-dogs-will-eat-the-dog-food.md`

```markdown
# Step 23: Show That "The Dogs Will Eat the Dog Food"

## Per-customer usage evidence
### Customer: <name/anonymized ID>
- Usage frequency/depth: ...
- Retention/renewal status: ...
- Value realization vs. Step 8 claim: ...
- Unprompted advocacy: ...

(repeat per MVBP customer)

## Honest read
Overall adoption signal: Strong | Mixed | Weak | Not yet measurable
If weak or mixed: likely cause and what changes as a result

## Open assumptions
- ka-023-...: ...
```

## Update business-state.json

```json
"23_show_that_dogs_will_eat_the_dog_food": {
  "status": "drafted",
  "summary": "<honest one-sentence read on real usage/adoption signal across MVBP customers>",
  "file": "plan/23-show-that-dogs-will-eat-the-dog-food.md"
}
```

Append `quantitative_claims` and `key_assumptions` entries; preserve all other keys.

## Done means

- `plan/23-show-that-dogs-will-eat-the-dog-food.md` written with real usage evidence per
  customer, or an explicit statement that evidence doesn't exist yet — never a synthesized
  "customers seem happy" substitute.
- `business-state.json` key `23_show_that_dogs_will_eat_the_dog_food` set to `status: "drafted"`;
  leave review/approval to the later council skill.
