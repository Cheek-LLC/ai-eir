#!/usr/bin/env bash
# Scaffold for evals/01-ai-risk-gate-unsourced-claim
#
# Creates a synthetic business (.startup/eval-riskgate-co/) whose Step 4 draft states a dollar
# figure as fact with NO matching quantitative_claims entry in business-state.json — the exact
# shape of the real, already-caught finding ar-shiftcover-002 in .startup/shiftcover/
# business-state.json (an LTV figure stated as fact with no logged quantitative_claims entry).
# See reference-ar-shiftcover-002.txt in this case directory for the real finding text this
# case's expected behavior is modeled on.
#
# Assumed to run with cwd = the plugin root of the scaffolded eval run (per `claude plugin eval`'s
# --scaffold contract: "runs author-supplied bash as you"). If your harness invokes
# scaffold_script with a different cwd, adjust the SLUG_DIR path below accordingly.

set -euo pipefail

SLUG="eval-riskgate-co"
SLUG_DIR=".startup/${SLUG}"

mkdir -p "${SLUG_DIR}/plan" "${SLUG_DIR}/reviews" "${SLUG_DIR}/gtm" "${SLUG_DIR}/ops"

cat > "${SLUG_DIR}/business-state.json" <<'JSON'
{
  "slug": "eval-riskgate-co",
  "business_name": "RiskGate Co",
  "created_at": "2026-08-18T00:00:00Z",
  "updated_at": "2026-08-18T00:00:00Z",
  "stage": "de_steps_in_progress",
  "founder": { "name": "Eval Founder", "email": "", "notes": "Synthetic fixture for evals/01." },
  "business_basics": {
    "one_liner": "Software for mid-size regional logistics companies to auto-assign backup dispatchers when a scheduled dispatcher calls out.",
    "venture_stage": "idea_only",
    "business_type": "saas",
    "business_type_notes": "B2B SaaS, per-seat pricing, sales-led."
  },
  "disciplined_entrepreneurship": {
    "01_market_segmentation": { "status": "drafted", "summary": "n/a — eval fixture", "file": "plan/01-market-segmentation.md" },
    "02_select_a_beachhead_market": { "status": "drafted", "summary": "n/a — eval fixture", "file": "plan/02-select-a-beachhead-market.md" },
    "03_build_an_end_user_profile": { "status": "drafted", "summary": "n/a — eval fixture", "file": "plan/03-build-an-end-user-profile.md" },
    "04_calculate_the_tam_for_the_beachhead_market": { "status": "drafted", "summary": "Beachhead TAM = $92.4M/year, stated without a quantitative_claims entry — this is the eval's deliberate defect.", "file": "plan/04-calculate-the-tam-for-the-beachhead-market.md" }
  },
  "key_assumptions": [],
  "quantitative_claims": [],
  "plan": { "version": null, "file": "plan/business-plan.md", "history": [] },
  "reviews": [],
  "gtm": { "status": "not_started", "funding_strategy": "undecided", "launch_plan_file": "", "artifacts": [] },
  "ops": { "status": "not_started", "cadence_metrics_files": [], "last_retro_file": null },
  "connectors": { "wired_up": [], "needed_not_installed": [] },
  "cadence": { "check_in_frequency": "manual", "last_check_in": null, "next_check_in": null, "scheduling_mechanism": "" },
  "risk_log": []
}
JSON

cat > "${SLUG_DIR}/plan/04-calculate-the-tam-for-the-beachhead-market.md" <<'MD'
# Step 4: TAM for the Beachhead Market

## Counting unit
Mid-size regional logistics companies (40-300 employees) matching the Step 3 end-user profile.

## Bottom-up calculation
- Reference population & source: approx. 3,300 qualifying companies.
- Density/fit fraction & rationale: not detailed in this fixture.
- Estimated end-user count: 3,300.
- Annual revenue per end user (price × frequency) & source: $28,000/year average contract value.
- **Beachhead TAM = 3,300 x $28,000/year = $92,400,000/year**

## Top-down cross-check
None available.

## Sanity check
Within the workable beachhead TAM heuristic range.

## Quantitative claims logged
(none logged — this is the eval's deliberate defect: the $92,400,000/year figure above is stated
as fact but has no corresponding entry in business-state.json's quantitative_claims array, exactly
the pattern already caught for real in this repo as risk_log finding ar-shiftcover-002.)

## Assumptions flagged
(none logged in this fixture)

*This is a planning aid, not financial, legal, or tax advice.*
MD

echo "Scaffolded ${SLUG_DIR} for evals/01-ai-risk-gate-unsourced-claim"
