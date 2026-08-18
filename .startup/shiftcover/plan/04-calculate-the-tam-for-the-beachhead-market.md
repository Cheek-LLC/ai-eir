# Step 4: TAM for the Beachhead Market

## Counting unit
One QSR franchise group operating 10-50 units in a single U.S. metro/regional cluster (per Step
3's profile) — the buying unit is the franchise group/organization, not the individual location,
since the Director of Operations signs one contract covering all locations.

## Bottom-up calculation
- **Reference population & source:** Maria's estimate, based on her familiarity with two
  franchise-operator networks (a regional International Franchise Association chapter and an
  independent QSR-operators group she is a member of) — she estimates roughly **3,000** QSR
  franchise groups nationally fall in the 10-50 unit band. This is a founder estimate, **not** an
  independently verified count (no Census/NAICS/trade-association published count was available
  to Maria or found for this session) — flagged low confidence below.
- **Density/fit fraction & rationale:** Not applicable as a separate multiplier — the 3,000 figure
  is already scoped to the 10-50 unit band directly (not derived from a larger population via a
  fit fraction).
- **Estimated end-user count (organizations):** 3,000 franchise groups.
- **Locations per group (for the price calc):** average of 22 (midpoint-weighted toward the lower
  end of the 10-50 range, per Maria's observation that groups cluster more heavily near 10-20
  units than near 50) → **66,000 locations** total across the beachhead.
- **Annual revenue per end user:** Anchored to the Step 16 pricing framework ($149/location/month
  — see that step for derivation) → $1,788/location/year.
- **Beachhead TAM = 66,000 locations × $1,788/year = $118,008,000/year ≈ $118M/year.**

## Top-down cross-check
None available. Maria does not have access to a paid market-research report for this specific
segment, and no credible free published count was located for this session. This is stated
plainly rather than papered over with a fabricated top-down figure.

## Sanity check
$118M/year at 100% beachhead share falls within the "tens to low hundreds of millions" workable
range this step's heuristic describes — no flag to revisit Step 2 on sizing grounds. The bigger
open risk is the reference-population estimate's low confidence (see below), not the order of
magnitude.

## Quantitative claims logged
- `qc-04-tam` (below)

```json
{
  "id": "qc-04-tam",
  "claim": "Beachhead TAM (annual revenue at 100% share)",
  "value": "$118M/year = 3,000 franchise groups x 22 locations/group x $1,788/location/year",
  "step_ref": "04_calculate_the_tam_for_the_beachhead_market",
  "source": "founder estimate — Maria Chen's familiarity with a regional IFA chapter and an independent QSR-operators group; not an independently published count. Price anchor from qc-016-price (Step 16).",
  "confidence": "low",
  "ai_risk_flag": true
}
```

## Assumptions flagged
```json
{ "id": "ka-004-group-count", "statement": "The 3,000-group and 22-locations-per-group figures are founder estimates from personal network familiarity, not a published/independently sourced count.", "step_ref": "04_calculate_the_tam_for_the_beachhead_market", "confidence": "low", "test_plan": "Cross-check against a published trade-association member count or a paid market report before this figure is used in any external-facing (investor) context.", "test_result": null }
```

*This is a planning aid, not financial, legal, or tax advice.*
