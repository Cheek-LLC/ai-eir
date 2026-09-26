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
    "business_type_notes": "string, free-text detail beyond the category (e.g. 'B2B SaaS, usage-based' or 'physical product, sold DTC + one retail channel') — every DE step skill reads this before tailoring its questions",
    "funding_intent": "bootstrap | raising_outside_capital | undecided — the founder's STATED intent, captured directly during onboarding if they volunteer it (do not ask a founder who hasn't formed a view yet to guess; leave undecided). This is distinct from gtm.funding_strategy: funding_intent is the earliest founder-stated signal (or undecided), set once by onboarding-interview and never re-inferred from plan prose; gtm.funding_strategy is the confirmed, operational GTM-stage decision (which may start as an inference from the plan if funding_intent was left undecided). run-review-council should prefer funding_intent when present — it's auditable and stable across re-reviews in a way that re-scanning plan prose every cycle is not."
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
    "version": "integer or null — null/absent until the first assembly; assemble-business-plan writes 1 the first time it runs. Do NOT initialize this to 1 when creating a new business's skeleton — assemble-business-plan's own precondition treats an existing version-1 value as 'a plan already exists,' and would wrongly hand off to revise-business-plan (which requires an unresolved review to act on, and finds none) instead of ever assembling the first plan. The skeleton-creation step (onboarding-interview / orchestrator bootstrap) must leave this null.",
    "file": "plan/business-plan.md",
    "history": [ { "version": "integer", "file": "plan/business-plan-vN.md", "created_at": "timestamp", "summary_of_changes": "string" } ]
  },
  "reviews": [
    { "id": "string", "council": "string, e.g. vc-panel", "target": "string, e.g. plan-v1 or step-05", "verdict": "APPROVE|APPROVE_WITH_NOTES|REVISE|REJECT", "score": "1-10", "file": "reviews/<timestamp>-<council>.md", "resolved": "boolean" }
  ],
  "tactics": {
    "01_goals": { "status": "not_started|in_progress|complete", "summary": "string", "file": "tactics/01-goals.md" },
    "02_systems": { "...": "same shape" },
    "...": "one entry per tactic, keys 01..15 — each key is the tactic's docs/TACTICS-15.md slug with hyphens replaced by underscores (e.g. 13-pitch-deck-design -> 13_pitch_deck_design), mirroring the disciplined_entrepreneurship convention above. Round 11. Unlike disciplined_entrepreneurship steps, a tactic's status CAN reach complete — tactics are real, finishable execution work (a hire made, a round closed), not a plan artifact gated by council review. Only begin tracking a tactic once stage has reached approved (Foundations, tactics 01-02) or gtm/operating (tactics 03-15) — see agents/orchestrator.md's tactics-execution section for exactly when each one starts."
  },
  "gtm": {
    "status": "not_started|in_progress|launched",
    "funding_strategy": "bootstrap|raising_outside_capital|undecided",
    "launch_plan_file": "gtm/launch-plan.md",
    "artifacts": [ { "type": "string, e.g. pitch-deck|positioning|content-calendar|outbound-sales-playbook|fundraising-deck-brief|landing-page", "file": "string" } ]
  },
  "ops": {
    "status": "not_started|active",
    "cadence_metrics_files": [ "ops/<timestamp>-metrics.md" ],
    "last_retro_file": "string|null",
    "last_roadmap_file": "string|null — path to the most recent ops/product-roadmap-<timestamp>.md written by skills/product/roadmap-and-prioritization (round 9), mirroring last_retro_file's role as an authoritative pointer so agents/product/product-lead.md and any other agent wanting 'the current roadmap' don't have to glob and sort ops/product-roadmap-*.md by filename timestamp themselves"
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
    { "id": "string", "type": "ai_risk|privacy|legal|business|governance", "raised_by": "string, agent name", "description": "string", "status": "open|mitigated|accepted" }
  ]
}
```

## Conventions

- Every step file under `plan/NN-slug.md` corresponds 1:1 to a key in `disciplined_entrepreneurship`.
- Any number presented as fact in `plan/business-plan.md` (market size, LTV, COCA, pricing, etc.)
  must have a corresponding entry in `quantitative_claims` with a `source` — "founder estimate",
  "web research (cite URL)", "industry benchmark (cite)", or (round 10; a business's own real,
  post-launch operating data or a shipped, statistically-valid internal experiment — e.g.
  "internal experiment, see ops/experiments-log.md#EXP-NN" or "operating data, see
  ops/pricing-review-<timestamp>.md" — never a not-yet-run or under-powered test) "internal
  experiment/operating data (cite the specific ops/ file)". A tested or measured number is at
  least as strong a source as a web citation and is exactly what
  `skills/ops/experimentation-and-optimization` and `skills/ops/pricing-and-monetization-
  optimization`'s `quantitative_claims`-feedback-loop mechanic is designed to produce — do not
  treat this fourth kind as a lesser or informal source. Numbers without a source of any of these
  four kinds are an AI-risk finding (see `agents/risk/ai-risk-analyst.md`) and block council
  approval.
- `risk_log` entries are never silently deleted — mark `mitigated`/`accepted` with a note in the
  relevant review file instead.
- `risk_log[].type: "business"` is for material drift/operational findings raised by the
  `agents/ops/*` layer post-launch (e.g. actual COCA far exceeding the step-19 projection,
  runway crossing a critical threshold, churn concentrated on-beachhead, realized customers
  off-segment from the step-3/5 profile) — distinct from `ai_risk`/`privacy`/`legal`, which are
  typically raised by `agents/risk/*`.
- `risk_log[].type: "governance"` is for the plugin's own process/gate decisions, raised by
  `agents/orchestrator.md` itself — the clearest example is a founder override of a REVISE/REJECT
  council verdict per Non-negotiable #3. Distinct from `business` (which describes something
  happening *in the business*, not a decision about how this plugin is being used) and from
  `ai_risk`/`privacy`/`legal` (which describe a defect in the plan's own content, not a deliberate,
  logged choice to proceed despite one).
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
- **`NEEDS RE-CONFIRMATION:` summary prefix.** A `disciplined_entrepreneurship.NN_slug.summary`
  may be prefixed `NEEDS RE-CONFIRMATION: <what changed and why it might still be fine>` — this is
  the convention for a step whose prior content is probably still valid after a pivot reopened a
  *different* step, but hasn't been formally re-confirmed against the change (see
  `agents/orchestrator.md`'s "Reopening a subset of DE steps after a pivot"). It's a signal to
  resolve before the next plan assembly/council review, not a fourth `status` value — the step's
  `status` field itself stays whatever it already was (usually `drafted`).
- `key_assumptions[].id` and `quantitative_claims[].id` values just need to be unique within
  their array — the `ka-NN-slug`/`qc-NN-slug` style used throughout the DE step skills is a
  convention for readability, not a schema requirement, and different step skills' worked
  examples use inconsistent zero-padding (`qc-04-...` vs `qc-016-...`). Don't read padding
  differences as a bug; do keep ids unique.

- **Council persona coverage by `business_basics.business_type`** — tracked here per the roadmap's
  explicit ask, so gaps stay visible without spelunking `skills/business-plan/run-review-council/
  SKILL.md`'s seat-selection logic. This lists only the *contextual 5th seat* — the 4 core seats
  (`customer-discovery-skeptic`, `financial-modeling-reviewer`, `vc-panel`,
  `expert-entrepreneur-panel`) run for every `business_type` and aren't repeated below.

  | `business_type` | Dedicated contextual persona(s) | Notes |
  |---|---|---|
  | `marketplace` | `marketplace-liquidity-specialist` (type match, unconditional) | Yields to `technical-feasibility-reviewer` when a hardware/deep-tech signal independently fires, and to `regulated-industry-compliance-reviewer` (round 4) when a regulated-industry content signal independently fires — both ahead of the type match; see the SKILL.md tie-break rule. Also yields to `operational-execution-reviewer` (round 9) when its compound two-of-three cross-functional execution-complexity signal independently fires — a narrower override than the two above, since the two-of-three bar keeps this seat unconditional for the ordinary single-axis case; see that persona's SKILL.md §3 placement reasoning. |
  | `services` | `services-unit-economics-reviewer` (type match, unconditional) | Yields to `technical-feasibility-reviewer` on the same basis, and to `regulated-industry-compliance-reviewer` (round 4) on a regulated-industry content signal; also permanently outranks `sales-motion-reviewer`'s `business_type: services` trigger per the tie-break rule, so `sales-motion-reviewer` is logged as a runner-up rather than selected, for every services business. Also yields to `operational-execution-reviewer` (round 9) on the same narrow compound-signal basis as the `marketplace` row above. |
  | `physical_product` | `hardware-physical-product-operator` (round 4; type match, unconditional) | Closes the gap this table flagged after round 3 — every `physical_product` business now has an unconditional dedicated persona. Yields to `technical-feasibility-reviewer` when a hardware/deep-tech signal independently fires (engineering-buildability question outranks the manufacturing/supply-chain-operations question when both are live) and to `regulated-industry-compliance-reviewer` when a regulated-industry content signal independently fires (e.g. a regulated medical device); also permanently outranks `sales-motion-reviewer`'s `business_type: physical_product`-with-channel trigger per the tie-break rule, so `sales-motion-reviewer` is logged as a runner-up rather than selected, for every physical-product business — the same structural pattern round 3 established for `services`. Also yields to `operational-execution-reviewer` (round 9) on the same narrow compound-signal basis as the `marketplace` row above. |
  | *(content signal, not a `business_type` value)* | `regulated-industry-compliance-reviewer` (round 4; content match on `business_basics.business_type_notes` or Steps 1/7/15 plan text — health/medical/patient data, financial services/payments/lending, or another explicitly regulated activity) | **Not tied to any `business_type` enum value** — none of the 6 values name a regulated vertical, so this persona can fire for a regulated `saas`, `consumer_app`, `marketplace`, `services`, or `physical_product` business alike. Deliberately the *highest*-priority contextual trigger (checked first, ahead of `technical-feasibility-reviewer` and every type-matched persona above) per the SKILL.md tie-break rule and its dedicated "Why the compliance reviewer is checked first" rationale — but it still competes for the single fixed contextual seat rather than adding a 6th; see the SKILL.md "Why 5 seats stays fixed" section for the explicit flex-vs-compete decision. It does **not** close the `saas`/`consumer_app`/`other` gap below directly, since most businesses of those types carry no regulated-industry content signal at all. |
  | *(content signal, not a `business_type` value)* | `operational-execution-reviewer` (round 9; content match on Steps 13/18/22, and Step 24 for timeline — at least two of three independent execution-complexity signals, gated on a team of one or two founders) | **Also not tied to any `business_type` enum value** — like `regulated-industry-compliance-reviewer` above, it can fire for any business type, including `saas`/`consumer_app`/`other` in the row below. Sits at SKILL.md §3 priority #3 (below the compliance and technical-feasibility triggers, above every type-matched persona) — its own demanding two-of-three bar is the load-bearing safeguard that keeps the type-matched seats unconditional for the ordinary case; see the SKILL.md "Why `operational-execution-reviewer` sits between #2 and #4" section for the full reasoning. |
  | `saas`, `consumer_app`, `other` | none dedicated | **Still an open gap after round 4, partially reached (not closed) by round 9.** Covered only by the content-triggered generalist seats (`product-market-fit-panel`, `sales-motion-reviewer` on DMU-complexity content, `competitive-strategy-reviewer` as default, and — only for the subset that also carries a regulated-industry content signal — `regulated-industry-compliance-reviewer`, or a compound execution-complexity signal — `operational-execution-reviewer`, round 9, both above) and the 4 core seats. Neither content-triggered persona is a `business_type`-match persona for `saas`/`consumer_app`/`other` specifically, and `operational-execution-reviewer`'s two-of-three bar means most plans of these types will not trip it — real, partial coverage where none existed before round 9, not a closed gap. `other` additionally has no fixed business-type-specific trigger at all beyond `technical-feasibility-reviewer`'s narrow carve-out for a hardware/deep-tech shape described in `business_type_notes`. |

  Update this table in the same change that adds or retargets any contextual-seat trigger in
  `run-review-council/SKILL.md`'s §3 — a trigger that exists in the skill but isn't reflected here
  is exactly the kind of drift this table exists to prevent.

See `docs/DE-24-STEPS.md` for the authoritative list of the 24 step keys/filenames.
