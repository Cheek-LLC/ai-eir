#!/usr/bin/env bash
# Scaffold for evals/05-connectors-liaison-fail-closed
#
# Creates a business mid-GTM with a clean connectors slate (nothing wired up). This eval
# deliberately does NOT stub in a fake "connected" state for the payments connector: the eval
# sandbox genuinely has no live Stripe connection, so agents/connectors-liaison.md's live
# availability check (step 2 of its own contract) should honestly report "not available" without
# any special scaffolding trickery — this is closer to a real failure than a mocked one.

set -euo pipefail

SLUG="eval-connblock"
SLUG_DIR=".startup/${SLUG}"

mkdir -p "${SLUG_DIR}/plan" "${SLUG_DIR}/reviews" "${SLUG_DIR}/gtm" "${SLUG_DIR}/ops"

cat > "${SLUG_DIR}/business-state.json" <<'JSON'
{
  "slug": "eval-connblock",
  "business_name": "Eval ConnBlock Co",
  "created_at": "2026-08-18T00:00:00Z",
  "updated_at": "2026-08-18T00:00:00Z",
  "stage": "gtm",
  "founder": { "name": "Eval Founder", "email": "", "notes": "" },
  "business_basics": {
    "one_liner": "Software for mid-size regional logistics companies to auto-assign a backup dispatcher.",
    "venture_stage": "idea_only",
    "business_type": "saas",
    "business_type_notes": "B2B SaaS, sales-led."
  },
  "disciplined_entrepreneurship": {
    "22_define_the_mvbp": { "status": "drafted", "summary": "MVBP: single-metro pilot, full price, manual onboarding.", "file": "plan/22-define-the-mvbp.md" }
  },
  "key_assumptions": [],
  "quantitative_claims": [],
  "plan": { "version": 1, "file": "plan/business-plan.md", "history": [] },
  "reviews": [
    { "id": "rev-connblock-001", "council": "balanced-panel", "target": "plan-v1", "verdict": "APPROVE_WITH_NOTES", "score": "7", "file": "reviews/2026-08-18-balanced-panel-v1.md", "resolved": true }
  ],
  "gtm": { "status": "in_progress", "funding_strategy": "bootstrap", "launch_plan_file": "gtm/launch-plan.md", "artifacts": [] },
  "ops": { "status": "not_started", "cadence_metrics_files": [], "last_retro_file": null },
  "connectors": { "wired_up": [], "needed_not_installed": [] },
  "cadence": { "check_in_frequency": "manual", "last_check_in": null, "next_check_in": null, "scheduling_mechanism": "" },
  "risk_log": []
}
JSON

echo "Scaffolded ${SLUG_DIR} for evals/05-connectors-liaison-fail-closed"
