# Step 17: Calculate the LTV of a Customer

## Formula and inputs
LTV = (Average Revenue Per Account per period × Gross Margin %) × Expected Customer Lifetime
(periods)

**Unit of "customer" used here: one signed franchise-group contract** (the DMU/Step 12 decision
unit — the Director of Ops signs once for the whole group), not one location — this matches the
unit Step 19's COCA will use (cost to close one group contract), so the ratio in Step 19 compares
like units. Stated explicitly because this is an easy unit-mismatch trap.

- **ARPU (per group, monthly):** Step 4 assumed an average of 22 locations/group in the beachhead.
  At 22 locations, a group qualifies for Step 16's volume tier ($129/location/month, 11+
  locations) rather than the standard $149/location/month rate. **Blended ARPU = 22 × $129 =
  $2,838/month per group.**

  > **Flag:** Step 4's TAM calculation used the standard $149/location/month rate uniformly, not
  > the $129 volume rate that actually applies to a 22-location average group. This is an
  > unreconciled inconsistency between Step 4 and Step 16 — see the note at the bottom of this
  > file and the assembled plan's Key Assumptions & Open Risks.

- **Gross margin:** Estimated **74%** (founder estimate blending typical SaaS hosting/support
  costs with a real per-SMS variable cost line — this product's marginal cost is higher than a
  pure-software SaaS because every broadcast sends real, per-message-billed SMS traffic). Not
  based on an actual vendor quote or built cost model. Flagged low confidence.
- **Expected lifetime:** No cohort data exists (idea stage, zero customers). Using a **category
  benchmark of 4%/month churn** for month-to-month vertical SaaS with no stated contract term
  (Step 16 does not specify a minimum term) → expected lifetime = 1/0.04 = **25 months**. This is
  a benchmark assumption, not founder data — flagged per `ka-017-churn` below.
- Discount rate: not applied — carried as undiscounted, nominal, stated plainly per this step's
  guidance.

## LTV calculation
LTV = $2,838/month × 74% × 25 months = **$52,503 per group contract** (blended, all group sizes
in the beachhead band treated at the 22-location average — a per-size breakdown is not computed
this pass).

## Quantitative claims logged
```json
{ "id": "qc-017-ltv", "claim": "Blended LTV per signed group contract", "value": "$52,503", "step_ref": "17_calculate_the_ltv_of_a_customer", "source": "computed: $2,838/mo blended ARPU (22-location avg group at Step 16's $129/location/mo volume tier) x 74% gross margin x 25-month expected lifetime (1/4% monthly churn, category benchmark, no cohort data — see ka-017-churn and ka-017-margin)", "confidence": "low", "ai_risk_flag": true }
```
*(Added retroactively — this entry was missing from the original draft of this step; see risk_log ar-shiftcover-002.)*

## Open assumptions
```json
{ "id": "ka-017-churn", "statement": "No cohort data yet; LTV uses an assumed 4%/mo churn (25-month expected lifetime) based on a general vertical-SaaS category benchmark, not founder data or a cited specific benchmark study.", "step_ref": "17_calculate_the_ltv_of_a_customer", "confidence": "low", "test_plan": "Recompute from actual cohort retention once 6+ months of paying-customer data exists.", "test_result": null }
```
```json
{ "id": "ka-017-margin", "statement": "74% gross margin is a founder estimate blending typical SaaS costs with an unmodeled per-SMS variable cost; no actual SMS vendor quote or built cost model exists yet.", "step_ref": "17_calculate_the_ltv_of_a_customer", "confidence": "low", "test_plan": "Get an actual SMS vendor (e.g., Twilio-class provider) volume quote and rebuild the margin estimate before this LTV figure is used in any external-facing context.", "test_result": null }
```
```json
{ "id": "ka-017-step4-price-mismatch", "statement": "Step 4's beachhead TAM used the standard $149/location/month rate for all locations, but the average 22-location group actually qualifies for Step 16's $129/location/month volume tier — Step 4's TAM is therefore overstated relative to Step 16's own pricing tiers and has not been reconciled.", "step_ref": "17_calculate_the_ltv_of_a_customer", "confidence": "low", "test_plan": "Recompute Step 4's TAM using the blended/volume-tier price before presenting the TAM figure alongside this LTV figure in the same document.", "test_result": null }
```

## Note for Step 19
This LTV ($52,503 per group contract) will be compared against COCA once Step 19 is drafted for
the LTV:COCA sanity check — no ratio is computed here. Step 19 must compute COCA per the same
unit (cost to close one group contract), not per location.
