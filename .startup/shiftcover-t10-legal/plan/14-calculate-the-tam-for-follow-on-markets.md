# Step 14: TAM for Follow-on Markets

## Bowling pin sequence
Beachhead (QSR franchise groups, 10-50 units) → Pin 2: Multi-location casual-dining chains →
Pin 3: Multi-location convenience-store retail.

## Follow-on market candidates

### Pin 2: Multi-location casual-dining chains (10-50 units)
- **Adjacency logic:** Same shift-manager/GM end-user shape, same DMU structure (Director of Ops
  buyer, GM user), same SMS-broadcast product core — the main open question is whether tipped-
  staff compensation changes who's willing to pick up a backup shift (flagged as unresolved,
  carried from Step 1).
- **TAM calculation (bottom-up):** No independent count available; scaling the Step 4 method,
  Maria estimates roughly **2,200** casual-dining groups nationally in the 10-50 unit band (lower
  than QSR's 3,000 because casual dining skews toward fewer, larger units per group) × ~18
  locations/group average × the same $1,788/location/year price anchor = 2,200 × 18 × $1,788 ≈
  **$70.8M/year**.
- **TAM:** $70.8M/year (see `qc-014-pin2-tam` below).
- **Trigger condition to pursue:** After the beachhead reaches roughly 15-20% penetration of the
  Step 9 prospect pipeline (a stated, checkable trigger, not a date) *and* the tipped-staff
  incentive question is resolved via at least 3 real casual-dining GM conversations.

### Pin 3: Multi-location convenience-store retail (10-50 units)
- **Adjacency logic:** Different vertical, but same core mechanic (hourly shift, call-out
  coverage) plus a distinct 24-hour-urgency angle. Adjacency is weaker than Pin 2's — Maria has no
  direct network here (carried from Step 2's low "right to win" score for this segment).
- **TAM calculation:** Not computed with real inputs — Maria has no basis for a group-count
  estimate in this vertical yet. Stated honestly as **not yet sizeable** rather than forcing a
  number from nothing.
- **TAM:** Not calculated this pass — see assumption below.
- **Trigger condition to pursue:** After Pin 2 is underway and only if a warm relationship into
  convenience retail develops (currently none exists).

## Open assumptions
```json
{ "id": "ka-014-pin2-groupcount", "statement": "The 2,200 casual-dining-group count and 18-locations-per-group figures for Pin 2 are founder estimates extrapolated from the Step 4 QSR method, not independently sourced.", "step_ref": "14_calculate_the_tam_for_follow_on_markets", "confidence": "low", "test_plan": "Validate via a trade-association count or market report before this figure is used in any external-facing context.", "test_result": null }
```
```json
{ "id": "ka-014-pin3-nosize", "statement": "Pin 3 (convenience retail) TAM was not calculated — founder has no basis for a group-count estimate in this vertical and no existing network relationship there.", "step_ref": "14_calculate_the_tam_for_follow_on_markets", "confidence": "low", "test_plan": "Revisit only once Pin 2 is underway and a real relationship into convenience retail exists.", "test_result": null }
```

## Quantitative claims logged
```json
{ "id": "qc-014-pin2-tam", "claim": "TAM for follow-on market: multi-location casual-dining chains, 10-50 units", "value": "$70.8M/year = 2,200 groups x 18 locations/group x $1,788/location/year", "step_ref": "14_calculate_the_tam_for_follow_on_markets", "source": "founder estimate, extrapolated from the same method as qc-04-tam; needs independent verification", "confidence": "low", "ai_risk_flag": true }
```

Note: this Pin 2 figure and the Step 4 beachhead figure ($118M) use the **same** pricing anchor
and a similar bottom-up method (compatible timeframe: both annual, current-year dollars), so a
combined "$188.8M near-term addressable" statement would be methodologically defensible *if* both
group-count estimates independently held up — but since both rest on unverified founder estimates
(`ka-004-group-count`, `ka-014-pin2-groupcount`), this plan does not state a combined headline
figure as settled fact; see Key Assumptions & Open Risks in the assembled plan.
