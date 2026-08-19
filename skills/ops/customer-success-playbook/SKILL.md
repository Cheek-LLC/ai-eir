---
name: customer-success-playbook
description: >
  Use once a business has active customers to run (or update) the proactive customer-success
  motion — health scoring, onboarding-to-value tracking, expansion/upsell identification, and
  save plays for at-risk accounts. Triggers: "how healthy are our accounts," "who's at risk of
  churning," "are we onboarding people well," "who should we upsell," "set up a health score,"
  "run a save play," or any `customer-success-lead` invocation that isn't specifically a
  post-hoc churn/retention-rate computation. This is the *proactive* half of customer success —
  the health-scoring framework, the onboarding motion, expansion triggers, and save-play
  discipline that aim to prevent churn and grow accounts before the fact. It does not compute
  churn rate, segment-fit against the step-3/5 beachhead profile, or diagnose why customers who
  already left actually left — that is `skills/ops/retention-and-churn-analysis`'s job, and this
  skill hands off to it explicitly (see Escalation, below) rather than duplicating it. Tailors
  the health signals, onboarding definition, and expansion motion to
  `business_basics.business_type` — a SaaS onboarding motion, a marketplace's, and a services
  firm's are not interchangeable. Produces `ops/customer-success-<timestamp>.md`. Never invents
  a health-score threshold, an onboarding benchmark, or an expansion tier the founder's own data
  or pricing plan doesn't actually support.
---

# Customer Success Playbook

## What this skill is, and what it is not

`skills/ops/retention-and-churn-analysis` looks backward: it computes what already happened
(churn rate, segment fit against the beachhead profile) after the fact, once a period has
closed. This skill looks forward: it scores account health *now*, defines what "successfully
onboarded" concretely means before a customer is at risk, flags accounts ready to expand, and
runs a disciplined save play the moment an account tips yellow or red — the machinery that
should make a future retention-and-churn-analysis run find less to explain. The two are
companions, not duplicates. Never fold a churn-rate computation or a segment-fit judgment into
this skill's output — hand that work to `retention-and-churn-analysis` by name.

## Reads

- `.startup/<slug>/business-state.json` — `business_basics.business_type` and
  `business_type_notes` (which onboarding/health/expansion pattern applies), `ops.status`,
  `risk_log` (open findings this account motion should be aware of).
- `.startup/<slug>/plan/22-define-the-mvbp.md` — required where it exists. The MVBP's own
  definition of the core loop / first-value action is the anchor for "what does onboarded
  actually mean" below — don't invent a separate "aha moment" that contradicts what the plan
  already defined as the product's minimum viable proof point.
- `.startup/<slug>/plan/16-set-your-pricing-framework.md` — required before writing any
  expansion/upsell recommendation. The actual tiers, price points, and pricing metric this
  business charges on — expansion suggestions must name a real tier or add-on that exists in
  this file, never an invented one. If this file doesn't exist yet, say so explicitly and limit
  expansion output to a qualitative flag ("this account shows expansion signal; no priced
  upsell path exists yet to point them to").
- `.startup/<slug>/plan/03-build-an-end-user-profile.md`,
  `.startup/<slug>/plan/05-profile-the-persona-for-the-beachhead-market.md` — useful context for
  reading *why* an account might be disengaging (an off-segment account behaves differently from
  an on-segment one), but this skill does not itself compute the segment-fit split —
  `retention-and-churn-analysis` owns that.
- `.startup/<slug>/ops/kpi-dashboard.md` if present — tells you what's actually instrumented
  (billing system, support tool, analytics) vs. founder-manual-tracked, which determines which
  health signals below are real vs. "recommended, not yet trackable."
- The most recent prior `.startup/<slug>/ops/customer-success-*.md`, if one exists — health tiers
  and thresholds carry forward; you are updating a standing model, not starting cold each period.

## Part 1 — The health-scoring framework

### Step 1: Inventory which signals this business actually has

Not every early business has all of these instrumented. Ask the founder which are real (a
number they can report or pull from a tool) vs. not yet tracked, and mark each accordingly —
never silently assume a signal exists.

| Signal category | What it concretely measures | Typical source |
|---|---|---|
| Usage frequency & depth | How often, and how much of the core product, the account actually uses — tailored by type below | Product analytics, founder's own login/usage log, manual check for early-stage |
| Support-ticket sentiment & volume | Ticket count trend, unresolved-ticket age, escalation/complaint language vs. routine questions | Support inbox/helpdesk, or founder's own inbox if no formal tool yet |
| NPS / CSAT, if collected | Most recent score and its trend, detractor (0-6 on NPS) flag | Survey tool, or founder-run manual survey |
| Payment / renewal behavior | Late payments, failed charges, downgrade requests, non-response near a renewal date | Billing system, or founder's own AR tracking |
| Relationship / engagement signal | For B2B: champion turnover, response rate to CS outreach, meeting-cadence adherence. For B2C/consumer: response to lifecycle emails/notifications | CRM notes, founder's own account log |

### Step 2: Set thresholds from this business's own data — never an invented default

This is the step most health-scoring advice gets wrong: it hands the founder an industry
benchmark ("healthy SaaS accounts log in 3x/week") that has no relationship to this specific
business's actual customers. Instead, for every trackable signal:

1. Ask the founder to name their **known-good** accounts (renewed, expanded, or vocally happy)
   and their **known-bad** accounts (already churned, or the founder already worries about) —
   at least a handful of each if volume allows.
2. For each signal, ask what that signal actually reads for the known-good group vs. the
   known-bad group. The gap between those two real distributions — not a generic benchmark — is
   where the yellow/red threshold line goes.
3. Where volume is too low for this yet (a handful of total customers), say so explicitly and
   set a *provisional* threshold from the founder's own judgment of "this would worry me,"
   labeled provisional, to be replaced with the real-data method above once enough accounts
   exist to compare.
4. Write the resulting threshold down explicitly in the output file per signal (see template)
   so it's inspectable and revisable — not a black-box score.

### Step 3: Weight and combine into a tier

Default to equal weighting across every signal marked trackable in Step 1, unless the founder
has a specific, stated reason to weight one more heavily (e.g., a B2B SaaS with monthly billing
and a visible payment-behavior signal may reasonably weight payment behavior higher than a
prepaid-annual business would). State the weighting used, and why, in the output file.

Combine into three tiers per account:

- **Green** — no signal crosses its at-risk threshold; account is healthy.
- **Yellow** — one signal has crossed its threshold, or several are trending toward it, but the
  account has not yet shown a hard risk indicator (payment failure, explicit cancellation
  intent, a strongly negative support escalation).
- **Red** — a hard risk indicator has fired (payment failure, explicit cancellation/downgrade
  request, a strongly negative escalation, or multiple signals simultaneously past threshold).

Never assign green to an account carrying an unresolved hard risk indicator regardless of how
the weighted score nets out — a hard indicator overrides the blended score, the same way one
credible blocking finding overrides an averaged council score (CONVENTIONS.md §6's logic
applies here too).

## Part 2 — Onboarding motion, by business type

"Successfully onboarded" is not the same question for every business, and a vague "they seem to
be using it" is not a concrete answer. Check `business_basics.business_type` and use the
matching definition below, anchored to the plan's own MVBP/core-loop definition where step 22
exists:

- **`saas`**: onboarded = the account has completed the specific first-value action step 22's
  MVBP names as the core loop (name it explicitly, don't paraphrase vaguely) **within a stated
  window from signup** (ask the founder what window is realistic for this product — don't
  assume 7 or 14 days by default), **and** shows at least a second and third session engaging
  that same core loop within 30 days — one successful action alone doesn't prove the habit is
  forming.
- **`marketplace`**: onboarded is tracked **separately per side**. Supply-side: first listing
  live *and* that listing receives its first match/sale within a stated window. Demand-side:
  first completed transaction *and* a second transaction within a stated window (a single
  transaction doesn't yet prove repeat intent — see the Expansion section's supply/demand split,
  same logic as `retention-and-churn-analysis`'s own supply/demand split).
- **`services`**: onboarded = kickoff completed, the first agreed deliverable/milestone accepted
  by the client without a dispute, and — for recurring/retainer engagements specifically — the
  relationship has reached its first renewal decision point without friction. For project-based,
  one-off engagements, "onboarded" converges with "delivered" — track it as project-completion
  quality (on time, in scope, accepted) rather than forcing a renewal frame that doesn't apply.
- **`physical_product`**: onboarded = first order fulfilled and received, plus — where the
  business model has a repeat-purchase or consumable/refill component — the first repeat
  purchase completed within the defined repeat-purchase window from `retention-and-churn-analysis`
  or `ops/kpi-dashboard.md`. For a genuinely one-time-purchase item, "onboarded" is simply
  fulfillment quality (delivered correctly, no return/complaint) — say so rather than forcing a
  repeat-purchase frame onto a product that doesn't have one.
- **`consumer_app`**: onboarded = the specific activation event step 22's MVBP defines as the
  "aha moment" was completed, **and** the cohort retained to D7 (per
  `retention-and-churn-analysis`'s D1/D7/D30 cohort convention) — a single activation event
  without D7 retention is a false positive, not a completed onboarding.
- **`other`**: ask the founder directly what a customer being "successfully onboarded" concretely
  means for this business, get a specific action and window, and record it explicitly so future
  periods reuse the same definition instead of re-litigating it.

Track, per current customer cohort: % onboarded within the stated window, and for anyone past
the window who hasn't hit the bar, flag them as an immediate yellow-tier candidate regardless of
what the blended health score in Part 1 says — a customer who never onboarded is a distinct risk
category from one who onboarded and then disengaged, and the save play differs (see Part 4).

## Part 3 — Expansion / upsell motion

### Who's expansion-ready

An account is expansion-ready when **both** are true:

1. It is currently **green tier** (Part 1) — never propose expansion to a yellow or red account;
   asking a struggling account to spend more reads as tone-deaf and can accelerate churn. A
   yellow/red account goes through Part 4's save play first, full stop.
2. It shows a concrete expansion trigger, tailored by type:
   - `saas`: usage against current plan's actual limits (seats, usage quota, feature-tier gate)
     — genuinely approaching or exceeding the ceiling the current tier allows, not just "using it
     a lot."
   - `marketplace`: supply-side — listing volume or transaction volume growing account-over-time
     and outpacing the current fee/tier structure; demand-side — order frequency or basket size
     trending up.
   - `services`: client requesting scope beyond the current engagement, or utilization of the
     current retainer's hours consistently maxing out before the period ends.
   - `physical_product`: repeat-purchase frequency or basket size trending up, or the customer
     asking about a bundle/subscription the current one-time-purchase relationship doesn't offer.
   - `consumer_app`: sustained high engagement against a paywall/feature gate (approaching a free
     tier's usage limit, or high-frequency use of features gated to a paid tier).

### What to actually recommend

Read `plan/16-set-your-pricing-framework.md` and name the **specific existing tier, add-on, or
pricing-metric increment** this account's trigger maps to — never invent a tier that isn't in
that file. If the pricing framework doesn't yet have a tier that fits the observed expansion
pattern (e.g., every green account is maxing out the top tier and asking for more), that's a
real finding worth surfacing to the founder as a pricing-framework gap — name it explicitly as
"no existing tier covers this demand" rather than inventing one on the spot.

## Part 4 — Save-play discipline for yellow/red accounts

A save play is a staged, diagnostic intervention — not "reach out and ask what's wrong."

### Stage 1 — Diagnose from what's already known, before contacting the account

Before any outreach, look at *which specific signal(s)* tipped the account yellow/red and
review the existing record (support history, usage log, payment history) so the founder isn't
asking the customer to re-explain something already documented. Classify the likely root cause
into one of four categories — this classification determines which save motion applies next:

1. **Adoption gap** — the account never fully onboarded (Part 2) or usage dropped after
   onboarding; the product isn't the problem, engagement with it is.
2. **Product-fit gap** — a specific, named feature/workflow gap the account has raised (via
   support tickets or direct feedback), not a vague dissatisfaction.
3. **Financial/budget signal** — late payment, downgrade request, or explicit budget-cut
   mention; the relationship may be healthy but the account's ability/willingness to pay
   at the current level has changed.
4. **Relationship/org-change signal** — champion turnover, reorg, or a build-up of unanswered
   outreach; the product relationship may be intact but the human relationship has broken.

### Stage 2 — The matched save motion

- **Adoption gap** → a hands-on re-onboarding touch: walk the account through the specific
  first-value action from Part 2 again, don't just "check in." Set a concrete re-engagement
  checkpoint (a specific action, by a specific date).
- **Product-fit gap** → confirm the specific gap with the account, then route it explicitly to
  product/roadmap (do not promise a fix timeline the founder hasn't actually committed to) and
  tell the account what was heard and what happens next, even if the answer is "not on the
  roadmap yet, here's the workaround."
- **Financial/budget signal** → a direct conversation about the actual constraint — a
  temporary discount, a pause option, or a downshift to a lower existing tier (per
  `plan/16-set-your-pricing-framework.md` — never invent a discount tier that doesn't exist in
  the pricing framework without the founder's explicit sign-off) is a legitimate save outcome,
  not a failure; losing the account entirely is worse than a temporarily lower-revenue save.
- **Relationship/org-change signal** → multi-thread the account: identify and build a
  relationship with a second contact so the relationship doesn't depend on one person, rather
  than only re-pursuing the original champion.

### Stage 3 — Time-box it and re-measure

Every save play gets an explicit checkpoint date (the founder sets it — typically 2-4 weeks,
tailored to this business's natural usage/billing cycle) at which the account's health score is
re-run. Don't leave a save play open-ended with no re-check.

### Escalation to `retention-and-churn-analysis`

A single account's save play stays inside this skill. Escalate to a full
`retention-and-churn-analysis` pass — recommend it explicitly to whoever invoked you — when
**any** of these fire:

- More than one account this period shows the **same** root-cause category (Stage 1) — a
  pattern, not an isolated case, which is exactly what segment-fit analysis is built to
  diagnose.
- The red-tier account count crosses a threshold the founder sets from their own base size (e.g.
  "more than 10% of active accounts red" for a founder with enough volume for that to be
  meaningful; for a handful of total customers, any second red account in a period is enough to
  warrant the check).
- A save play is attempted and **fails** (the account churns anyway) — every failed save is a
  real churn event and belongs in the next `retention-and-churn-analysis` run, including its
  segment-fit judgment.

## Output file: `ops/customer-success-<timestamp>.md`

Timestamp format `YYYY-MM-DD`; append `-2`, `-3`... for a same-day rerun.

```markdown
# Customer Success Playbook — <business name> — <date>

## Business type & motion used
`business_basics.business_type`: <...> | Onboarding definition applied: <the specific
first-value action + window, from Part 2> | Pricing framework on file: <yes, plan/16-... / no —
expansion limited to qualitative flags>

## Health-scoring model
| Signal | Trackable? | Known-good reading | Known-bad reading | Threshold set (yellow / red) | Weight |
|---|---|---|---|---|---|
| Usage frequency & depth | Yes/No | ... | ... | ... | ... |
| Support ticket sentiment/volume | Yes/No | ... | ... | ... | ... |
| NPS/CSAT | Yes/No/not collected | ... | ... | ... | ... |
| Payment/renewal behavior | Yes/No | ... | ... | ... | ... |
| Relationship/engagement signal | Yes/No | ... | ... | ... | ... |

_Thresholds sourced from: <this business's own known-good/known-bad comparison, or "provisional
— founder judgment, insufficient volume for a real comparison yet">._

## Account health snapshot
| Account | Onboarded? (Part 2 bar) | Signals past threshold | Hard risk indicator? | Tier | Notes |
|---|---|---|---|---|---|
| ... | Yes/No/In-window | ... | Yes/No | Green/Yellow/Red | ... |

## Onboarding status this period
% of current-cohort accounts onboarded within window: ...%. Accounts past window, not yet
onboarded (auto-yellow regardless of blended score): <list>.

## Expansion-ready accounts
| Account | Trigger observed | Mapped tier/add-on (plan/16-...) | Recommended action |
|---|---|---|---|
| ... | ... | ... (or "no existing tier covers this — pricing-framework gap") | ... |

## Save plays in progress or opened this period
| Account | Root-cause category (Stage 1) | Save motion applied | Checkpoint date | Status |
|---|---|---|---|---|
| ... | Adoption / Product-fit / Financial / Relationship | ... | ... | Open/Saved/Churned |

## Escalation to retention-and-churn-analysis
<State explicitly whether any escalation trigger fired this period, which one, and that
retention-and-churn-analysis should be run next — or "none fired this period.">

## Trend vs. prior period
<Tier distribution and onboarding % vs. the last customer-success snapshot, if one exists.>
```

## Update `business-state.json`

Append `ops/customer-success-<timestamp>.md` to `ops.cadence_metrics_files`. If an escalation
trigger fired (see above) or a red-tier concentration is material, append a `risk_log` entry —
read-modify-write the whole file, preserve every other key, never set `status` to anything but
`open` yourself:

```json
{
  "id": "ops-<slug>-<sequential-number>",
  "type": "business",
  "raised_by": "customer-success-lead",
  "description": "string — the specific trigger (root-cause pattern, red-tier count/threshold, or a failed save that churned), the affected account(s) or count, and the explicit recommendation to run retention-and-churn-analysis next",
  "status": "open"
}
```

Increment from the highest existing `ops-<slug>-*` id.

## Never fabricate

Health-score thresholds, onboarding windows, and expansion-tier mappings all come from this
business's own data (known-good/known-bad comparison), the founder's direct input, or
`plan/16-set-your-pricing-framework.md`'s actual pricing structure — never an invented industry
benchmark. Where a signal isn't tracked, isn't enough volume to compare, or a pricing framework
doesn't exist yet, say so plainly in the output rather than filling the gap with a
plausible-sounding number.

## Done means

- Every trackable signal has a threshold sourced from this business's own known-good/known-bad
  comparison (or is explicitly marked provisional), not an invented default.
- Every current account has an explicit tier, and every onboarding-window miss is flagged
  yellow regardless of blended score.
- Every expansion recommendation names a real tier/add-on from `plan/16-set-your-pricing-framework.md`,
  or explicitly flags a pricing-framework gap.
- Every yellow/red account has a root-cause category and a matched save motion, not a generic
  "reach out" instruction.
- Any escalation trigger to `retention-and-churn-analysis` is named explicitly, not left
  implicit.
- `ops/customer-success-<timestamp>.md` is written and registered in `business-state.json`.
