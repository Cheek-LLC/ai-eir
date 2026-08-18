#!/usr/bin/env bash
# Scaffold for evals/06-revise-routes-through-revise-business-plan
#
# Models this eval's fixture directly on this repo's own REAL data: .startup/shiftcover/
# business-state.json is, as of this round, actually sitting at stage "revising" with a REVISE
# verdict (reviews[0], resolved:false) that has not yet been routed through
# skills/business-plan/revise-business-plan. This scaffold reproduces that exact situation shape
# (trimmed to 2 required-revision items instead of ShiftCover's full list) under a fresh eval slug,
# rather than mutating the real shiftcover fixture directly, so this eval case is self-contained
# and repeatable.

set -euo pipefail

SLUG="eval-revise-co"
SLUG_DIR=".startup/${SLUG}"

mkdir -p "${SLUG_DIR}/plan" "${SLUG_DIR}/reviews" "${SLUG_DIR}/gtm" "${SLUG_DIR}/ops"

cat > "${SLUG_DIR}/business-state.json" <<'JSON'
{
  "slug": "eval-revise-co",
  "business_name": "Eval Revise Co",
  "created_at": "2026-08-18T00:00:00Z",
  "updated_at": "2026-08-18T00:00:00Z",
  "stage": "revising",
  "founder": { "name": "Eval Founder", "email": "", "notes": "" },
  "business_basics": {
    "one_liner": "Software for mid-size regional logistics companies to auto-assign a backup dispatcher.",
    "venture_stage": "idea_only",
    "business_type": "saas",
    "business_type_notes": "B2B SaaS, sales-led."
  },
  "disciplined_entrepreneurship": {
    "04_calculate_the_tam_for_the_beachhead_market": { "status": "drafted", "summary": "Beachhead TAM = $92.4M/year.", "file": "plan/04-calculate-the-tam-for-the-beachhead-market.md" }
  },
  "key_assumptions": [],
  "quantitative_claims": [
    { "id": "qc-04-tam", "claim": "Beachhead TAM", "value": "$92,400,000/year", "step_ref": "04_calculate_the_tam_for_the_beachhead_market", "source": "founder estimate, unvalidated group count", "confidence": "low", "ai_risk_flag": true }
  ],
  "plan": { "version": 1, "file": "plan/business-plan.md", "history": [] },
  "reviews": [
    { "id": "rev-revise-co-001", "council": "balanced-panel (5 seats: customer-discovery-skeptic, financial-modeling-reviewer, vc-panel, expert-entrepreneur-panel, sales-motion-reviewer)", "target": "plan-v1", "verdict": "REVISE", "score": "4", "file": "reviews/2026-08-18-balanced-panel-v1.md", "resolved": false }
  ],
  "gtm": { "status": "not_started", "funding_strategy": "undecided", "launch_plan_file": "", "artifacts": [] },
  "ops": { "status": "not_started", "cadence_metrics_files": [], "last_retro_file": null },
  "connectors": { "wired_up": [], "needed_not_installed": [] },
  "cadence": { "check_in_frequency": "manual", "last_check_in": null, "next_check_in": null, "scheduling_mechanism": "" },
  "risk_log": []
}
JSON

cat > "${SLUG_DIR}/plan/business-plan.md" <<'MD'
# Eval Revise Co — Business Plan (v1)

## Executive Summary
Software for mid-size regional logistics companies to auto-assign a backup dispatcher the moment
a scheduled dispatcher calls out. Beachhead TAM: $92,400,000/year.

*This is a planning aid, not financial, legal, or tax advice.*
MD

cat > "${SLUG_DIR}/reviews/2026-08-18-balanced-panel-v1.md" <<'MD'
# Review — Eval Revise Co — plan-v1 — balanced-panel

## Aggregate Verdict
**Verdict:** REVISE
**Score:** 4

### Required revisions
1. The $92,400,000/year beachhead TAM rests entirely on an unvalidated founder group-count
   estimate — cross-check the count against a published trade-association or NAICS-based source,
   or explicitly range/discount the figure, before it is presented as a headline number.
2. Step 3's end-user profile is grounded in only 2 real conversations — broaden the sample or
   explicitly flag the thin evidence base as a key_assumptions entry with a test plan.

*This review is a planning aid produced by simulated reviewer personas — it is not licensed
financial, legal, or investment advice.*
MD

echo "Scaffolded ${SLUG_DIR} for evals/06-revise-routes-through-revise-business-plan"
