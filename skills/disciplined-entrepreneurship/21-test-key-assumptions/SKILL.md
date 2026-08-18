---
name: 21-test-key-assumptions
description: >
  Use once Step 20's ranked assumption register is drafted and the founder needs a concrete test
  plan for the riskiest ones. Triggers: "test our assumptions," "validate assumptions," "lean
  experiments," "de-risk the plan," "how do we prove this," "step 21." Turns each leap-of-faith
  assumption from Step 20 into a real experiment (method, success metric, minimum threshold,
  cost, timeline) and records the outcome in `key_assumptions[].test_result` — resolving each one
  or explicitly deferring it with a stated reason, rather than leaving placeholders unaddressed.
---

# Step 21: Test Key Assumptions

## What this step is

Step 20 built the ranked register; this step is where the register gets acted on. Every
leap-of-faith assumption shortlisted in Step 20 gets a real, executable test design here. Where
the founder has already gathered evidence (even informally, since starting the interview
process), record the result now. Where testing hasn't happened yet, the assumption is not
"resolved" — it must be explicitly marked as **deferred**, with a stated reason and a concrete
trigger for when it will be revisited (e.g., "after first 10 paying customers," "before council
review of pricing"). No leap-of-faith assumption from Step 20 may leave this step with a blank
`test_result` and no deferral reason — that is the placeholder-cleanup this step exists to force.

## Reads

- `.startup/<slug>/business-state.json` (whole file) — specifically the full `key_assumptions`
  array, focused on the entries Step 20 ranked as leap-of-faith.
- `.startup/<slug>/plan/20-identify-key-assumptions.md` — required. The ranked shortlist this
  step works through, in order.

## Founder-facing deliverables

For each leap-of-faith assumption from Step 20's shortlist, design a real test:

1. **Test method** — the cheapest, fastest way to get real signal: a customer interview script,
   a landing-page/ad test, a pre-sale/letter-of-intent ask, a concierge pilot, a price-stated-out-
   loud conversation, a technical spike. Match the method to the assumption type (a pricing
   assumption needs a real pricing conversation, not a survey asking "would you pay for this").
2. **Success metric and minimum threshold** — the specific, falsifiable bar that counts as
   validated (e.g., "3 of 5 prospects agree to a paid pilot at the stated price" — not "positive
   feedback").
3. **Cost and timeline** — how much time/money the test takes, and by when it can run.
4. **Outcome** — if the founder has already run something resembling this test (even
   informally), record the result now: validated, invalidated (and what changed as a result), or
   inconclusive.
5. **Deferral** — for anything not yet testable (e.g., needs a customer base that doesn't exist
   yet), state explicitly: "deferred until <trigger>" and why that's an acceptable order of
   operations rather than an evasion.

Ask the founder directly:
- "Of these top assumptions, which one could you actually test this week with one phone call?"
- "For the ones you can't test yet — what specifically has to happen first, and are you
  comfortable proceeding with a paid pilot before it's resolved?"

## When the founder doesn't know

This step does not invent test results. An assumption without real evidence stays `test_result:
null` and gets an explicit deferral reason in the plan file and in the assumption's `test_plan`
field — it must never be silently upgraded to "validated" because a plausible test design exists
on paper. Design ≠ execution.

## Output file: `plan/21-test-key-assumptions.md`

```markdown
# Step 21: Test Key Assumptions

## Test plans and outcomes
### ka-XXX-... — <statement>
- Test method: ...
- Success metric / threshold: ...
- Cost / timeline: ...
- **Outcome:** Validated | Invalidated | Inconclusive | Deferred until <trigger>
- If invalidated: what changes downstream (which prior step needs revisiting)?

(repeat for every leap-of-faith assumption from Step 20)

## Unresolved risk carried forward
List every assumption still `deferred` or `inconclusive`, with its trigger condition, so the
plan and council reviewers see open risk explicitly rather than it disappearing.
```

## Update business-state.json

For each assumption addressed, update its entry in `key_assumptions` in place: set
`test_result` to the outcome (or leave `null` with the `test_plan` field updated to state the
deferral reason and trigger explicitly). Then write:

```json
"21_test_key_assumptions": {
  "status": "drafted",
  "summary": "<count validated / invalidated / deferred, and the single biggest open risk carried forward>",
  "file": "plan/21-test-key-assumptions.md"
}
```

Preserve every other key untouched.

## Done means

- `plan/21-test-key-assumptions.md` written with a test plan and outcome (or explicit deferral)
  for every leap-of-faith assumption from Step 20.
- `key_assumptions` entries updated in place with `test_result` or a stated deferral reason —
  none left silently blank.
- `business-state.json` key `21_test_key_assumptions` set to `status: "drafted"`; leave
  review/approval to the later council skill.
