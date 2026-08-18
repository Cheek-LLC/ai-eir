#!/usr/bin/env bash
# Scaffold for evals/04a-de-step04-branching-saas
#
# Creates a SaaS-type business with Step 2/3 already drafted (Step 4's own SKILL.md refuses to run
# without them), so the eval prompt can go straight to "run Step 4" and the only free variable is
# whether the agent applies the SaaS branch (count companies/seats x ACV) or gets it wrong.

set -euo pipefail

SLUG="eval-branch-saas"
SLUG_DIR=".startup/${SLUG}"

mkdir -p "${SLUG_DIR}/plan" "${SLUG_DIR}/reviews" "${SLUG_DIR}/gtm" "${SLUG_DIR}/ops"

cat > "${SLUG_DIR}/business-state.json" <<'JSON'
{
  "slug": "eval-branch-saas",
  "business_name": "DispatchBack",
  "created_at": "2026-08-18T00:00:00Z",
  "updated_at": "2026-08-18T00:00:00Z",
  "stage": "de_steps_in_progress",
  "founder": { "name": "Eval Founder", "email": "", "notes": "" },
  "business_basics": {
    "one_liner": "Software for mid-size regional logistics companies to auto-assign a backup dispatcher the moment a scheduled dispatcher calls out.",
    "venture_stage": "idea_only",
    "business_type": "saas",
    "business_type_notes": "B2B SaaS, per-seat pricing sold to the dispatch-ops manager; each qualifying company runs multiple dispatch seats across shifts."
  },
  "disciplined_entrepreneurship": {
    "01_market_segmentation": { "status": "drafted", "summary": "n/a — eval fixture", "file": "plan/01-market-segmentation.md" },
    "02_select_a_beachhead_market": { "status": "drafted", "summary": "Beachhead: mid-size regional trucking/logistics companies, 40-300 employees.", "file": "plan/02-select-a-beachhead-market.md" },
    "03_build_an_end_user_profile": { "status": "drafted", "summary": "End user: dispatch-shift supervisor at a mid-size regional logistics company.", "file": "plan/03-build-an-end-user-profile.md" },
    "04_calculate_the_tam_for_the_beachhead_market": { "status": "not_started", "summary": "", "file": "plan/04-calculate-the-tam-for-the-beachhead-market.md" }
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

cat > "${SLUG_DIR}/plan/02-select-a-beachhead-market.md" <<'MD'
# Step 2: Select a Beachhead Market

Beachhead: mid-size regional trucking/logistics companies (40-300 employees) running their own
dispatch operations rather than outsourcing to a 3PL.
MD

cat > "${SLUG_DIR}/plan/03-build-an-end-user-profile.md" <<'MD'
# Step 3: Build an End User Profile

Counting unit / end user: the dispatch-shift supervisor role at a qualifying company. Each
qualifying company runs an average of 3 dispatch seats across its shifts (this is the seat count
Step 4 should multiply by).
MD

echo "Scaffolded ${SLUG_DIR} for evals/04a-de-step04-branching-saas"
