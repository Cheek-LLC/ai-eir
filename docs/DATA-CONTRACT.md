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
  "business_basics": {
    "one_liner": "string, the founder's one-line description of the business, refined during onboarding until it names a real customer and a real problem",
    "venture_stage": "idea_only | already_operating | pivoting",
    "business_type": "saas | physical_product | marketplace | services | consumer_app | other",
    "business_type_notes": "string, free-text detail beyond the category (e.g. 'B2B SaaS, usage-based' or 'physical product, sold DTC + one retail channel') — every DE step skill reads this before tailoring its questions"
  },
  "disciplined_entrepreneurship": {
    "01_market_segmentation": { "status": "not_started|drafted|reviewed|approved", "summary": "string", "file": "plan/01-market-segmentation.md" },
    "02_select_a_beachhead_market": { "...": "same shape" },
    "...": "one entry per step, keys 01..24 — each key is the step's DE-24-STEPS.md slug with hyphens replaced by underscores (e.g. 04-calculate-the-tam-for-the-beachhead-market -> 04_calculate_the_tam_for_the_beachhead_market). This is the convention every skills/disciplined-entrepreneurship/*/SKILL.md file actually writes — do not abbreviate it."
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
    "funding_strategy": "bootstrap|raising_outside_capital|undecided",
    "launch_plan_file": "gtm/launch-plan.md",
    "artifacts": [ { "type": "string, e.g. pitch-deck|positioning|content-calendar|outbound-sales-playbook|fundraising-deck-brief|landing-page", "file": "string" } ]
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
    { "id": "string", "type": "ai_risk|privacy|legal|business", "raised_by": "string, agent name", "description": "string", "status": "open|mitigated|accepted" }
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
- `risk_log[].type: "business"` is for material drift/operational findings raised by the
  `agents/ops/*` layer post-launch (e.g. actual COCA far exceeding the step-19 projection,
  runway crossing a critical threshold, churn concentrated on-beachhead, realized customers
  off-segment from the step-3/5 profile) — distinct from `ai_risk`/`privacy`/`legal`, which are
  typically raised by `agents/risk/*`.
- Agents should read the whole `business-state.json` before acting and write back only the keys
  they own, preserving everything else — never blind-overwrite the file.
- `gtm.funding_strategy` is set by `agents/gtm/launch-director.md` the first time GTM work starts,
  inferred from the plan's business-model section (step 15) and executive summary plus any
  explicit founder statement in `founder.notes`; it stays `undecided` (never guessed) if the plan
  doesn't say, and `agents/gtm/fundraising-advisor.md` only runs when it's
  `raising_outside_capital`. Any later agent may update it if the founder's capital strategy
  changes — never leave it stale against a revised plan.
- `business_basics` is set by `skills/interview/onboarding-interview` and owned by it thereafter
  (a pivot updates it via `skills/interview/recurring-check-in` handing the change to the
  orchestrator, never a silent overwrite by a step skill). Every
  `skills/disciplined-entrepreneurship/NN-slug/SKILL.md` must read `business_basics.business_type`
  before asking its questions and tailor them accordingly — see `docs/UX-INTERVIEW-DESIGN.md` for
  worked examples of how the same step diverges by business type.

See `docs/DE-24-STEPS.md` for the authoritative list of the 24 step keys/filenames.
