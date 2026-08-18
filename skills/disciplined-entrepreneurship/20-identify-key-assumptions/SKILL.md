---
name: 20-identify-key-assumptions
description: >
  Use once Steps 1-19 are drafted and the founder needs a consolidated, ranked list of the
  riskiest unproven beliefs the whole plan rests on. Triggers: "key assumptions," "leap of faith
  assumptions," "riskiest assumptions," "what could kill this," "assumption audit," "step 20."
  Sweeps every `key_assumptions` and `quantitative_claims` entry accumulated by Steps 1-19,
  surfaces any additional assumptions implicit in those steps that were never logged, and ranks
  the full set by impact × uncertainty so Step 21 knows exactly what to test first.
---

# Step 20: Identify Key Assumptions

## What this step is

This is the audit step: every prior step (1-19) that hit a gap in founder knowledge should have
logged a `key_assumptions` entry instead of inventing a number, and every quantitative claim
should have a `quantitative_claims` entry with a confidence level. This step **sweeps both
arrays in full**, cross-references them against the 19 plan files to catch anything that was
stated as fact in prose but never actually logged, and produces a single ranked risk register.
Step 21 then builds real test plans for the top-ranked items — this step's job is the sweep and
the ranking, not the testing.

## Reads

- `.startup/<slug>/business-state.json` (whole file) — this is the primary input. Read the
  **entire** `key_assumptions` array and the **entire** `quantitative_claims` array (every entry
  with `confidence: "low"` or `ai_risk_flag: true` is a candidate for this register regardless
  of which step logged it). Also read `business_basics.business_type` — it tells you where to
  look hardest during the gap sweep (see "Business-type branching").
- `.startup/<slug>/plan/01-market-segmentation.md` through
  `.startup/<slug>/plan/19-calculate-the-coca.md` — all 19 prior plan files. Re-scan each for
  claims stated as settled fact that have no corresponding `key_assumptions` or
  `quantitative_claims` entry (a common failure mode: a founder says "obviously" or "clearly" in
  an interview and the step-drafting skill accepts it without flagging uncertainty). Log any such
  gap found as a new `key_assumptions` entry attributed back to its originating step.

## Founder-facing deliverables

1. **Full inventory** — list every existing `key_assumptions` entry and every low-confidence or
   AI-risk-flagged `quantitative_claims` entry, grouped by originating step (1-19).
2. **Gap sweep** — for each of the 19 prior plan files, spot-check for unlogged assumptions
   (particularly common in: beachhead persona behavior, DMU roles from Step 12/13, churn/margin
   in Step 17, conversion rates in Step 18, and the business model fit in Step 15). Log anything
   found.
3. **2×2 risk ranking** — score every assumption in the register on two axes:
   - **Impact**: if this assumption is wrong, how much of the plan breaks? (low/medium/high)
   - **Uncertainty**: how little real evidence currently supports it? (low/medium/high)
   Assumptions that are high-impact AND high-uncertainty are "leap of faith" assumptions —
   Aulet's term for the handful of beliefs the entire venture is actually betting on.
4. **Ranked shortlist** — the top 5-8 leap-of-faith assumptions, ordered by risk, handed to Step
   21 for actual test-plan design.

Ask the founder directly:
- "If you're wrong about just one thing in this whole plan, which one thing would do the most
  damage?"
- "What have you been assuming is true that you've never actually asked a customer about?"

## Business-type branching

The gap sweep (deliverable 2) is where business-type knowledge matters most in this step —
unlogged assumptions tend to cluster in different places depending on `business_basics.business_
type`, and a generic sweep will miss the categories specific to each:

- **SaaS:** Look hardest for unlogged churn/expansion assumptions carried into Step 17's LTV,
  self-serve activation assumptions ("users will figure out onboarding without help") behind Step
  22's MVBP shape, and integration/security/compliance requirements assumed rather than confirmed
  with a real prospect in Step 7.
- **Physical product:** Look hardest for unit-economics assumptions that quietly shift between
  prototype/small-batch cost and cost-at-scale (Step 16's markup chain), unconfirmed regulatory/
  certification requirements gating go-to-market at all, and channel-margin assumptions (wholesale
  terms, retail markup) that were stated once and never re-verified.
- **Marketplace:** Look hardest for chicken-and-egg/liquidity assumptions — which side is assumed
  to move first, and why that assumption hasn't actually been tested — plus assumptions that
  supply and demand will naturally balance without active management, and take-rate tolerance
  assumptions on each side that were asserted rather than confirmed in a real transaction.
- **Services:** Look hardest for delivery-capacity assumptions (can this scale past the founder's
  own hours — this shows up disguised as a business-model or LTV assumption but is really a
  capacity assumption), scope-creep/pricing assumptions baked into Step 16's effective-rate math,
  and referral-pipeline sustainability assumptions (a pipeline built on one or two relationships
  that quietly stands in for "reliable acquisition channel").
- **Consumer app:** Look hardest for retention-curve assumptions (a specific D30/D90 number stated
  or implied in Step 17's LTV without real cohort data), virality/K-factor assumptions behind any
  organic-growth claim, freemium-to-paid conversion-rate assumptions behind Step 16's pricing, and
  platform/app-store dependency risk (policy changes, fee changes, discovery-algorithm shifts)
  that's easy to leave completely unstated.
- **Other:** Ask the founder which of the above categories their business most resembles, or
  sweep broadly across all of them, rather than assuming none apply (per
  `docs/UX-INTERVIEW-DESIGN.md` §4).

## When the founder doesn't know

This step's entire purpose is to make peace with what's unknown rather than hide it — there is
no "invent a number" failure mode here, since the deliverable is the list of unknowns itself.
The one discipline to hold: do not let an assumption stay vague ("pricing might be an issue") —
push every entry to a falsifiable statement ("customers will pay $499/mo without a discount")
that Step 21 can actually design a test against.

## Output file: `plan/20-identify-key-assumptions.md`

```markdown
# Step 20: Identify Key Assumptions

## Full assumption & low-confidence claim inventory
| ID | Statement | Originating step | Impact | Uncertainty | Leap of faith? |
|---|---|---|---|---|---|
| ka-004-... | ... | 04 | High | High | Yes |
| qc-017-ltv | ... | 17 | High | Medium | Yes |
| ... | | | | | |

## Newly logged gaps found during this sweep
| ID | Statement | Originating step (unlogged before now) |
|---|---|---|
| ka-020-... | ... | 15 |

## Top leap-of-faith assumptions (ranked, for Step 21)
1. ka-XXX-... — <why this ranks #1>
2. ...
```

## Update business-state.json

Append any newly discovered entries to `key_assumptions` (with `step_ref` pointing to their
*originating* step, not to step 20). Then write:

```json
"20_identify_key_assumptions": {
  "status": "drafted",
  "summary": "<count of assumptions in register and the top 3 leap-of-faith items by name>",
  "file": "plan/20-identify-key-assumptions.md"
}
```

Preserve every other key untouched — this step reads broadly but writes narrowly (its own
status key, plus any assumption entries it newly discovers).

## Done means

- `plan/20-identify-key-assumptions.md` written with the full inventory, gap sweep, and ranked
  shortlist.
- Any previously-unlogged assumptions found during the sweep are now in `key_assumptions` with
  correct `step_ref` values.
- `business-state.json` key `20_identify_key_assumptions` set to `status: "drafted"`; leave
  review/approval to the later council skill.
