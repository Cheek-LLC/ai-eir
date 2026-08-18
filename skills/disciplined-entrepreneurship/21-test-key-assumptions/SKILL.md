---
name: 21-test-key-assumptions
description: >
  Use once Step 20's ranked assumption register is drafted and the founder needs a concrete test
  plan for the riskiest ones. Triggers: "test our assumptions," "validate assumptions," "lean
  experiments," "de-risk the plan," "how do we prove this," "step 21." Turns each leap-of-faith
  assumption from Step 20 into a real experiment (method, success metric, minimum threshold,
  cost, timeline) and records the outcome in `key_assumptions[].test_result` — resolving each one
  or explicitly deferring it with a stated reason. Also gives every non-shortlisted item in Step
  20's full inventory a lighter recorded disposition, so nothing is left silently unaddressed.
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

This step's coverage is **not limited to the top 5-8 shortlist**. Step 20's full inventory
(everything in `key_assumptions` and every low-confidence/`ai_risk_flag` entry in
`quantitative_claims`, across all 19 prior steps) is the actual scope — the shortlist just tells
you which items get a *full* test design first. Every other item in the full inventory still
needs an explicit, recorded disposition (see deliverable 6 below); "it wasn't on the top-8 list"
is not a reason an assumption gets to leave this step untouched. Note the two arrays resolve
differently per the Data Contract: `key_assumptions` entries carry their own `test_result`
field, so disposition means setting it directly. `quantitative_claims` entries have no
`test_result` field — a flagged claim's disposition means either linking it to the
`key_assumptions` entry that already covers it (most do — e.g. `qc-017-ltv` is covered by
`ka-017-churn`), or, if no such entry exists yet, creating one so the claim has somewhere real to
get resolved; the claim's own `confidence` gets upgraded (with `source` updated to say how) only
once that linked assumption is actually validated, never before.

## Reads

- `.startup/<slug>/business-state.json` (whole file) — the full `key_assumptions` array and the
  full `quantitative_claims` array, not just the entries Step 20 ranked as leap-of-faith.
- `.startup/<slug>/plan/20-identify-key-assumptions.md` — required. Both the ranked shortlist
  (worked in order, full test designs) and the full inventory table (every entry gets at least
  the lighter disposition in deliverable 6).

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
6. **Full-inventory disposition** — for every item in Step 20's full inventory that is *not* on
   the leap-of-faith shortlist, give it a one-line disposition: fold it into a related shortlisted
   item's test if the two would actually be resolved by the same evidence, mark it "accepted —
   low impact/uncertainty, not worth dedicated testing now" (and say why that judgment is safe),
   or defer it with a trigger exactly like a shortlisted item. Every `key_assumptions` entry in
   the full inventory gets a real disposition in its own `test_result`/`test_plan` fields; every
   flagged `quantitative_claims` entry gets a linked (or newly created) `key_assumptions` entry
   so it has somewhere to actually resolve, per the note above. No entry from Step 20's full
   inventory may leave this step with no disposition recorded anywhere.

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

## Full-inventory disposition (non-shortlisted items)
| ID | Statement | Disposition |
|---|---|---|
| ka-XXX-... | ... | Folded into ka-YYY's test \| Accepted — low impact/uncertainty \| Deferred until <trigger> |

## Unresolved risk carried forward
List every assumption still `deferred` or `inconclusive` — from the shortlist *and* the full
inventory — with its trigger condition, so the plan and council reviewers see open risk
explicitly rather than it disappearing.
```

## Update business-state.json

For each `key_assumptions` entry addressed — shortlisted *or* from the full-inventory disposition
pass — update its entry in place: set `test_result` to the outcome (or leave `null` with the
`test_plan` field updated to state the deferral/accepted-risk reason and trigger explicitly). No
`key_assumptions` entry from Step 20's full inventory should still have both a null `test_result`
and an untouched `test_plan` after this step. For each flagged `quantitative_claims` entry, add
(or point to) the `key_assumptions` entry that tracks its resolution as described above — leave
the claim's own `confidence`/`source` untouched unless that linked assumption is already
validated. Then write:

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
  for every leap-of-faith assumption from Step 20, **and** a recorded disposition (folded-in,
  accepted, or deferred) for every other entry in Step 20's full inventory — no silent gaps.
- `key_assumptions` entries updated in place with `test_result` or a stated deferral/accepted-risk
  reason — none left silently blank, including entries outside the top-8 shortlist. Flagged
  `quantitative_claims` entries each have a `key_assumptions` entry tracking their resolution.
- `business-state.json` key `21_test_key_assumptions` set to `status: "drafted"`; leave
  review/approval to the later council skill.
