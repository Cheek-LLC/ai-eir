# Step 20: Identify Key Assumptions

## Full list, aggregated from Steps 1-19

| ID | Statement (short) | Step | Confidence |
|---|---|---|---|
| ka-001-segment-counts | Beachhead company-count is a founder estimate, not a paid data pull | 01 | low |
| ka-004-turnover-rate | 15%/year leadership-opening rate is a founder estimate | 04 | low |
| ka-008-vacancy-cost | Vacancy cost is real per client anecdote but never quantified | 08 | low |
| ka-009-referral-concentration | Pipeline is concentrated in 2 referral sources | 09 | medium |
| ka-010-playbook-informal | Screening method exists only in Jordan's head, not written down | 10 | high |
| ka-011-vc-intro-competition | Rate of losing deals to free VC-intro hires is unmeasured | 11 | low |
| ka-013-conversion-sample | Funnel conversion rates are founder-tracked, not CRM data | 13 | medium |
| ka-014-pin2-repeat-overlap | Pin 2 TAM and Step 17's repeat-rate LTV may double-count the same clients | 14 | low |
| ka-015-retainer-revisit | Retainer model deferred pending playbook + delivery capacity | 15 | medium |
| ka-016-delivery-hours-estimate | 90-hr delivery estimate is not time-tracked | 16 | low |
| ka-017-repeat-rate-optimism | Belief in a higher long-run repeat rate is unreflected in the headline LTV | 17 | low |
| ka-017-founder-delivery-rate | Delivery cost uses the same unvalidated $100/hr placeholder as COCA | 17 | low |
| ka-018-relationship-maintenance-cost | ~29 hrs/engagement background BD time is backed out, not tracked | 18 | low |
| ka-019-founder-rate | $100/hr placeholder may understate real market rate for Jordan's role | 19 | low |

## Services-specific priority scan (per this step's guidance)

Per this step's services branching, looked hardest for three categories — and found a genuinely
new, previously-unlogged one in the process:

1. **Delivery-capacity assumptions disguised as business-model/LTV assumptions.** `ka-010`
   (unwritten playbook) and `ka-015` (deferred retainer model) both are, at root, capacity
   assumptions. The single largest one, however, was not yet logged anywhere upstream — surfacing
   it here, new, per this step's explicit instruction to look for exactly this pattern:

   ```json
   { "id": "ka-020-associate-replication", "statement": "The entire growth plan (Step 24) assumes an associate recruiter, once trained on a not-yet-written playbook, can replicate Jordan's fill rate and technical-screening quality bar independently. Zero associate-run searches have ever been completed — this is untested, not just unproven at scale", "step_ref": "20_identify_key_assumptions", "confidence": "low", "test_plan": "Run the first associate-led search as a real paid engagement (not a simulation), with Jordan doing QA/oversight only, not personally sourcing — see Step 21/22 for the specific test design", "test_result": null }
   ```

2. **Scope-creep/pricing assumptions baked into Step 16's effective-rate math.** `ka-016`
   (untimed delivery-hours estimate) is exactly this pattern — the effective $783/hr rate computed
   in Step 16 rests on an estimate, not logged time, so if real delivery hours run higher than 90,
   every downstream margin/LTV/COCA figure that depends on it is optimistic by an unknown amount.

3. **Referral-pipeline sustainability assumptions.** `ka-009` (2-source concentration) is exactly
   this pattern, named already at Step 9 and restated here as a Step-20-priority item, not a new
   one.

## Ranked for Step 21 testing (top 3, by consequence if wrong)

1. **ka-020-associate-replication** — if wrong, the entire capacity-scaling growth plan (Step 24)
   fails regardless of how healthy the LTV:COCA ratio looks.
2. **ka-016-delivery-hours-estimate** — if wrong (real hours materially exceed 90), every margin
   figure downstream is overstated.
3. **ka-009-referral-concentration** — if the 2 concentrated referral sources go quiet, the whole
   pipeline (not just growth, but current-state revenue) is at risk.

## Update business-state.json

```json
"20_identify_key_assumptions": {
  "status": "drafted",
  "summary": "14 assumptions carried from Steps 1-19, plus one new one surfaced here (ka-020-associate-replication, the single most consequential untested assumption in the plan); top 3 ranked for Step 21 testing",
  "file": "plan/20-identify-key-assumptions.md"
}
```
