# Step 17: Calculate the LTV of a Customer

> **Marketplace gap encountered while drafting this file — flagged prominently, not buried:**
> unlike Steps 4, 5, 6, 8, 9, 12, 13, 15, 16, 19, 22, and 23, **this step's SKILL.md contains no
> marketplace-specific branching at all** (confirmed by grep — zero mentions of "marketplace").
> The step's formula (`ARPU × gross margin × expected lifetime`) implicitly assumes "a customer"
> is a single, unambiguous, revenue-paying entity — true for SaaS, not true here. SkyClaim has
> **two candidate "customers"**: the demand-side contractor (who pays SkyClaim directly and has a
> genuine, computable LTV) and the supply-side pilot (who is paid *by* SkyClaim, generates zero
> direct revenue of their own, but is the binding constraint on the whole business per Step 4). I
> had to decide, unprompted by this file, which one "LTV" refers to. I chose **demand-side only**,
> since that's the only side with a standard revenue-based LTV — and flag this explicitly because
> Step 19 (COCA) *does* have marketplace guidance requiring supply-side COCA to be computed and
> reported separately, creating a direct cross-step mismatch: Step 19 will produce a supply-side
> COCA number with **no corresponding LTV in this file to sanity-check it against**. See Step 19
> for how this plays out concretely.

## Reads
`plan/16-set-your-pricing-framework.md` (required), `plan/15-design-a-business-model.md`
(required), `plan/08-quantify-the-value-proposition.md`.

## Formula and inputs (demand-side contractor LTV)
ARPU: ~35 properties/year booked through SkyClaim per active demand-side contractor once ramped
(founder estimate, extrapolated from Ray Delgado's stated volume expectations — not yet measured)
× $31.50/property SkyClaim revenue (18% of $175, from Step 16) = **$1,102.50/year revenue per
contractor**.
Gross margin: 85% — cost to serve a demand-side customer is mostly payment processing and light
support overhead (founder estimate; no built cost model yet).
Expected lifetime: ~4 years, assumed ~15-20% annual churn — founder estimate reasoning from
storm-restoration trade relationships being typically sticky once trust is established (Ray's own
3-year relationship with Osei Aerial is the only real data point, and it's an N of 1 for the
*old*, non-marketplace relationship, not yet evidence for marketplace-specific retention).

## LTV calculation
LTV = $1,102.50/year × 85% margin × 4 years = **≈$3,750** (rounded — see false-precision note
below), per demand-side contractor customer.

## Open assumptions
- `ka-017-churn`: "No cohort data yet; LTV uses an assumed ~15-20% annual churn based on a single
  N-of-1 legacy relationship (Ray Delgado's 3 years with Osei Aerial, a different, non-marketplace
  business relationship), not marketplace-specific data." `step_ref`:
  `17_calculate_the_ltv_of_a_customer`, `confidence`: `low`, `test_plan`: "Recompute from actual
  demand-side cohort retention once 2+ full storm seasons of real marketplace bookings exist,"
  `test_result`: `null`.
- `ka-017-arpu-unmeasured`: "The ~35 properties/year ARPU assumption is extrapolated from one
  conversation with one prospect (Ray Delgado) about his *hoped-for* volume, not measured booking
  data." `step_ref`: `17_calculate_the_ltv_of_a_customer`, `confidence`: `low`, `test_plan`:
  "Recompute once real booking volume exists for at least 3 demand-side customers across a full
  storm season," `test_result`: `null`.
- `ka-017-no-marketplace-guidance`: "This step's SKILL.md has no marketplace-specific branching,
  forcing an undocumented judgment call about which side 'LTV' refers to (demand-side chosen here)
  — see the flagged note at the top of this file and the cross-step mismatch it creates with
  Step 19's supply-side COCA requirement." `step_ref`: `17_calculate_the_ltv_of_a_customer`,
  `confidence`: `low`, `test_plan`: "Flag to plugin maintainers as a methodology gap, not
  resolvable by this business alone — see QA-FINDINGS-ROUND3.md," `test_result`: `null`.

## Quantitative claims (required)
```json
{ "id": "qc-017-ltv", "claim": "Blended LTV per demand-side (contractor) customer", "value": "≈$3,750", "step_ref": "17_calculate_the_ltv_of_a_customer", "source": "computed: $1,102.50/yr revenue per contractor (35 properties/yr x $31.50 SkyClaim take, both founder-estimated) x 85% gross margin (founder estimate, no built cost model) x 4-year expected lifetime (assumed ~15-20% churn, single N-of-1 legacy data point — see ka-017-churn)", "confidence": "low", "ai_risk_flag": true }
```

## Note for Step 19
This LTV covers the **demand-side customer only**. No supply-side (pilot) LTV exists in this
model — see the flagged note at the top of this file. Step 19's COCA work will need to reckon with
that gap directly, not silently.

## Mandatory AI-risk gate — before this step is reported done
Invoked `skills/risk/ai-risk-review` against this file plus the business-slug. **BLOCKED** on
first pass: the LTV figure was initially computed and stated as "$3,748.50" — false precision
given every input is a low-confidence founder estimate or a single N-of-1 data point. Fixed by
rounding to "≈$3,750" (shown above). Re-ran: **PASS**. The scope-ambiguity finding above
(demand-only LTV with no marketplace guidance) was also raised by the analyst but assessed as
**advisory, not blocking** — it's a real, structural gap worth fixing in the step's own SKILL.md,
but does not make *this file's own numbers* unsourced or falsely precise once demand-only scope is
stated plainly (which it now is). Logged as `ar-skyclaim-003` (advisory) and `ar-skyclaim-004`
(the false-precision finding, mitigated) — see `risk_log`.

## Update business-state.json
`17_calculate_the_ltv_of_a_customer`: `status: "drafted"`, summary references the ≈$3,750
demand-side-only LTV and flags the marketplace scope gap explicitly.
