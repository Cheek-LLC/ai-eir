#!/usr/bin/env bash
# Scaffold for evals/03-onboarding-vague-answer-pushback
#
# Creates a brand-new business skeleton at .startup/eval-vagueco/ in exactly the state
# skills/interview/onboarding-interview/SKILL.md's own Step 0 describes for a fresh business:
# stage "interview", all 24 disciplined_entrepreneurship keys present at not_started, empty
# arrays everywhere. This lets the eval prompt drop straight into the moment right after the
# founder gives their one-line pitch, without the agent needing to bootstrap the directory itself
# first (that's a separate concern from what this case tests).

set -euo pipefail

SLUG="eval-vagueco"
SLUG_DIR=".startup/${SLUG}"

mkdir -p "${SLUG_DIR}/plan" "${SLUG_DIR}/reviews" "${SLUG_DIR}/gtm" "${SLUG_DIR}/ops"

cat > "${SLUG_DIR}/business-state.json" <<'JSON'
{
  "slug": "eval-vagueco",
  "business_name": "Working Title",
  "created_at": "2026-08-18T00:00:00Z",
  "updated_at": "2026-08-18T00:00:00Z",
  "stage": "interview",
  "founder": { "name": "Eval Founder", "email": "", "notes": "" },
  "business_basics": {
    "one_liner": "",
    "venture_stage": "",
    "business_type": "",
    "business_type_notes": ""
  },
  "disciplined_entrepreneurship": {
    "01_market_segmentation": { "status": "not_started", "summary": "", "file": "plan/01-market-segmentation.md" },
    "02_select_a_beachhead_market": { "status": "not_started", "summary": "", "file": "plan/02-select-a-beachhead-market.md" },
    "03_build_an_end_user_profile": { "status": "not_started", "summary": "", "file": "plan/03-build-an-end-user-profile.md" },
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

cat > "${SLUG_DIR}/interview-log.md" <<'MD'
# Interview Log — Working Title
MD

echo "Scaffolded ${SLUG_DIR} for evals/03-onboarding-vague-answer-pushback"
