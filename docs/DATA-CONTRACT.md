# Data Contract — `business-state.json`

Canonical schema for `.startup/<business-slug>/business-state.json`. Every agent/skill that
reads or writes business data must conform to this schema. If you need a new field, add it
here in the same change that introduces it — don't invent undocumented fields.

`<business-slug>` is a kebab-case slug derived from the business name, created at the start
of the onboarding interview (`skills/interview/onboarding-interview`).

## Top-level shape

```json
{
  "slug": "string",
  "business_name": "string",
  "created_at": "ISO-8601 timestamp",
  "updated_at": "ISO-8601 timestamp",
  "stage": "interview | de_steps_in_progress | plan_assembled | council_review | revising | approved | gtm | operating | paused",
  "founder": {
    "name": "string",
    "email": "string (optional, only if the user offers it)",
    "notes": "string"
  },
  "disciplined_entrepreneurship": {
    "01_market_segmentation": { "status": "not_started|drafted|reviewed|approved", "summary": "string", "file": "plan/01-market-segmentation.md" },
    "02_beachhead_market": { "...": "same shape" },
    "...": "one entry per step, keys 01..24, matching docs/DE-24-STEPS.md filenames exactly"
  },
  "key_assumptions": [
    { "id": "string", "statement": "string", "step_ref": "e.g. 04_tam_beachhead", "confidence": "low|medium|high", "test_plan": "string", "test_result": "string|null" }
  ],
  "quantitative_claims": [
    { "id": "string", "claim": "string", "value": "string", "step_ref": "string", "source": "string", "confidence": "low|medium|high", "ai_risk_flag": "boolean" }
  ],
  "plan": {
    "version": "integer, starts at 1",
    "file": "plan/business-plan.md",
    "history": [ { "version": "integer", "file": "plan/business-plan-vN.md", "created_at": "timestamp", "summary_of_changes": "string" } ]
  },
  "reviews": [
    { "id": "string", "council": "string, e.g. vc-panel", "target": "string, e.g. plan-v1 or step-05", "verdict": "APPROVE|APPROVE_WITH_NOTES|REVISE|REJECT", "score": "1-10", "file": "reviews/<timestamp>-<council>.md", "resolved": "boolean" }
  ],
  "gtm": {
    "status": "not_started|in_progress|launched",
    "launch_plan_file": "gtm/launch-plan.md",
    "artifacts": [ { "type": "string, e.g. pitch-deck|landing-page|content-calendar", "file": "string" } ]
  },
  "ops": {
    "status": "not_started|active",
    "cadence_metrics_files": [ "ops/<timestamp>-metrics.md" ],
    "last_retro_file": "string|null"
  },
  "connectors": {
    "wired_up": [ "string, connector name" ],
    "needed_not_installed": [ { "connector": "string", "purpose": "string", "needed_by_step": "string" } ]
  },
  "cadence": {
    "check_in_frequency": "weekly|biweekly|monthly|manual",
    "last_check_in": "timestamp|null",
    "next_check_in": "timestamp|null",
    "scheduling_mechanism": "string, e.g. harness-trigger|manual-reminder — describes how re-activation actually happens in this environment"
  },
  "risk_log": [
    { "id": "string", "type": "ai_risk|privacy|legal", "raised_by": "string, agent name", "description": "string", "status": "open|mitigated|accepted" }
  ]
}
```

## Conventions

- Every step file under `plan/NN-slug.md` corresponds 1:1 to a key in `disciplined_entrepreneurship`.
- Any number presented as fact in `plan/business-plan.md` (market size, LTV, COCA, pricing, etc.)
  must have a corresponding entry in `quantitative_claims` with a `source` — "founder estimate",
  "web research (cite URL)", or "industry benchmark (cite)". Numbers without a source are an
  AI-risk finding (see `agents/risk/ai-risk-analyst.md`) and block council approval.
- `risk_log` entries are never silently deleted — mark `mitigated`/`accepted` with a note in the
  relevant review file instead.
- Agents should read the whole `business-state.json` before acting and write back only the keys
  they own, preserving everything else — never blind-overwrite the file.

See `docs/DE-24-STEPS.md` for the authoritative list of the 24 step keys/filenames.
