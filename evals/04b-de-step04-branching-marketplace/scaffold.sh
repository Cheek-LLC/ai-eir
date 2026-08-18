#!/usr/bin/env bash
# Scaffold for evals/04b-de-step04-branching-marketplace
#
# Mirrors evals/04a's structure exactly (same DE step, same fixture shape) but with
# business_basics.business_type = "marketplace" and a demand-side end-user profile, so the only
# variable between the two cases is the business type — exactly what this pair of cases is
# designed to isolate.

set -euo pipefail

SLUG="eval-branch-mkt"
SLUG_DIR=".startup/${SLUG}"

mkdir -p "${SLUG_DIR}/plan" "${SLUG_DIR}/reviews" "${SLUG_DIR}/gtm" "${SLUG_DIR}/ops"

cat > "${SLUG_DIR}/business-state.json" <<'JSON'
{
  "slug": "eval-branch-mkt",
  "business_name": "HomeFixNow",
  "created_at": "2026-08-18T00:00:00Z",
  "updated_at": "2026-08-18T00:00:00Z",
  "stage": "de_steps_in_progress",
  "founder": { "name": "Eval Founder", "email": "", "notes": "" },
  "business_basics": {
    "one_liner": "A marketplace connecting households with vetted independent home-repair contractors for same-week bookings.",
    "venture_stage": "idea_only",
    "business_type": "marketplace",
    "business_type_notes": "Two-sided marketplace: households (demand) book independent contractors (supply) for home-repair jobs; take a commission on each completed booking."
  },
  "disciplined_entrepreneurship": {
    "01_market_segmentation": { "status": "drafted", "summary": "n/a — eval fixture", "file": "plan/01-market-segmentation.md" },
    "02_select_a_beachhead_market": { "status": "drafted", "summary": "Beachhead: homeowning households in one metro who've booked a home-repair job in the last 12 months.", "file": "plan/02-select-a-beachhead-market.md" },
    "03_build_an_end_user_profile": { "status": "drafted", "summary": "Demand-side end user: homeowner booking a repair job; demand side is the binding constraint on transaction volume.", "file": "plan/03-build-an-end-user-profile.md" },
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

Beachhead: homeowning households in one metro area who have booked at least one home-repair job
in the last 12 months.
MD

cat > "${SLUG_DIR}/plan/03-build-an-end-user-profile.md" <<'MD'
# Step 3: Build an End User Profile

Counting unit / end user: the homeowner booking a repair job (demand side). Demand is the binding
constraint on transaction volume in this beachhead, not supply (contractor onboarding is not the
bottleneck at this stage) — size Step 4 from the demand side.
MD

echo "Scaffolded ${SLUG_DIR} for evals/04b-de-step04-branching-marketplace"
