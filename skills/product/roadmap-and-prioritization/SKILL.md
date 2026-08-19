---
name: roadmap-and-prioritization
description: >
  Use once a business reaches `stage: operating` (or late in `gtm`, once a beta/early-access
  cohort exists to generate real signal) to build or refresh an actual product roadmap. Triggers:
  "what should we build next," "help us prioritize the backlog," "set up our roadmap," "customers
  keep asking for X, should we build it," "does our roadmap still match the plan." Runs a real
  RICE-based scoring pass (Reach × Impact × Confidence / Effort) over roadmap-item intake pulled
  from churn reasons, support/feature requests, and funnel drop-off data — never a vibes-based
  "prioritize by impact." Every item is also tagged Core-vs-Context (plan step 10) and
  beachhead-aligned-vs-off-segment (plan steps 3/5) so the roadmap can't silently drift from the
  plan's actual strategy without that drift being named. Produces
  `ops/product-roadmap-<timestamp>.md`.
---

# Roadmap and Prioritization

## What this skill is

A "roadmap" that's just a founder's running wish list, reordered by whatever feels most urgent
this week, is not a roadmap — it's a mood. This skill turns roadmap-building into the same
disciplined, sourced, falsifiable exercise the rest of this plugin applies to market sizing and
unit economics: every item's priority traces to a real number (a customer count, a churn-reason
tally, a revenue-at-risk estimate), every item is checked against what the plan actually says this
business is for (its Core, per step 10, and its beachhead persona, per steps 3/5), and every gap
between "what we're building" and "what the plan says we're building" gets named, not absorbed
silently into next week's backlog.

## Reads

- `.startup/<slug>/business-state.json` — `business_basics`, `stage` (confirm `operating`, or a
  late-`gtm` beta cohort exists, **or `ops.status: "active"`/`gtm.status: "launched"` even if
  `stage` currently reads `de_steps_in_progress`** — a pivot reopening a subset of DE steps per
  `agents/orchestrator.md`'s Phase 6 leaves ops/gtm running in parallel; `stage` and ops/gtm
  liveness are independent signals, and this skill is safe to run whenever the business is
  actually live, regardless of what `stage` says about DE-step progress), `quantitative_claims`/
  `key_assumptions` tagged `step_ref` 03, 05,
  07, 08, 10, 24, `risk_log` (open `business`-type entries — you don't want to re-surface a drift
  finding another agent already logged as if it were new).
- `plan/03-build-an-end-user-profile.md`, `plan/05-profile-the-persona-for-the-beachhead-market.md`
  — required. The concrete beachhead profile/persona every intake item gets checked against.
- `plan/07-high-level-product-specification.md`, `plan/08-quantify-the-value-proposition.md` —
  required. What the plan says the product actually is, and which specific, quantified value
  driver step 8 said mattered most — the yardstick for "is this roadmap still building the thing
  the plan quantified value around."
- `plan/10-define-your-core.md` — required. The plan's own Core-vs-Context distinction (Geoffrey
  Moore's framing, as Aulet uses it): the specific, defensible capability this business is actually
  built on, versus necessary-but-undifferentiated work around it.
- `plan/24-develop-a-product-plan.md` — the founder's own prior product-plan thinking from the DE
  steps; this skill extends and operationalizes it, it does not replace or contradict it silently.
  If this roadmap run points somewhere step 24 didn't anticipate, say so explicitly rather than
  quietly diverging.
- `ops/kpi-dashboard.md` if present — tells you the business's real metrics vocabulary (which
  metric "impact" should be stated against).
- Every `ops/*-retention-metrics.md` (churn/retention reasons and segment-fit reads),
  `ops/*-growth-metrics.md` (funnel drop-off points), and `ops/*-retro.md` (operations-manager's
  synthesized findings) — these are your primary intake sources, not just background reading.
- The most recent `ops/product-roadmap-*.md` if one exists (list `ops/product-roadmap-*.md` and
  take the latest by timestamp — there is no `business-state.json` pointer to it, see the note at
  the end of this file) — you are revising a running roadmap, not starting from nothing each time;
  carry forward any unshipped item still worth carrying, and mark what shipped since.

## Step 1 — Establish the anchor: Core and beachhead, in your own words

Before touching a single backlog item, write two or three sentences each, pulled directly from the
plan (cite the file):

- **The Core** (from step 10): the specific capability this business is actually defensible on —
  not a mission statement, the actual thing.
- **The beachhead persona** (from step 5, grounded in step 3's profile): who this product is for,
  their specific need/trigger, in the plan's own terms.

Every item scored below gets checked against these two anchors. If step 10 or step 5 is thin,
missing, or clearly stale against how the founder now describes the business, say so plainly and
recommend those steps get revisited before treating the roadmap's Core/beachhead tags as
meaningful — a roadmap checked against a vague Core is not actually anchored to anything.

## Step 2 — Intake: turn signals into roadmap items with a real evidence trail

Pull from every source below that has data this period. An item with no real evidence behind it
still goes on the list (founders have real instincts) but gets tagged `confidence: low` and must
carry an explicit note of what evidence would raise it — never let a hunch get scored as if it were
observed.

| Source | What to pull | Evidence that goes on the item |
|---|---|---|
| `ops/*-retention-metrics.md` (customer-success-lead) | Every named churn reason this period and cumulatively, tallied by theme | Count of customers citing that reason, the file(s) it came from |
| `ops/*-growth-metrics.md` (growth-analyst) | Any specific funnel step named as a leak/drop-off point | The drop-off rate and period it was observed |
| `ops/*-retro.md` (operations-manager) | Any recommended action or data gap that's actually a product change | The retro's own citation |
| Founder-reported feature requests / support tickets | A specific ask, tallied by distinct requester count if tracked anywhere (a support tool, a spreadsheet, even informal notes) | The count, and where it's tracked — "not tracked anywhere" is itself a finding, not silently skipped |
| Sales-lost reasons (if the founder tracks them against step 18's process) | A specific gap prospects cited for not buying | The count and source |
| Prior `ops/product-roadmap-*.md` | Unshipped items still worth carrying forward | Carried status, original evidence preserved |
| Founder brainstorm this session | New ideas raised directly | Ask for the evidence behind each — see the pushback table below |

Give every intake item a short id (`ri-<slug>-NN`, incrementing from the highest id in the prior
roadmap file if one exists), a one-line description, its source, and the raw evidence — before any
scoring happens. This intake log is itself part of the output file; don't discard it once scores
are computed.

## Step 3 — Score with RICE, honestly

Use RICE (Reach × Impact × Confidence ÷ Effort) — pick this framework and use it consistently
every cycle so scores are comparable period over period. Do not substitute a different framework
mid-stream without saying so and re-scoring the carried-forward backlog under the new one.

- **Reach** — the number of distinct customers/users this item affects, over a stated period (e.g.
  "per month" or "cumulative to date"). Must trace to an actual count from Step 2's evidence
  column. If no real count exists, write "not measurable yet" and hold the item out of ranking
  (list it in an "Unscored — needs data" section) rather than inventing a plausible-sounding reach
  number.
- **Impact** — the standard RICE ordinal scale per user reached: `3` massive, `2` high, `1` medium,
  `0.5` low, `0.25` minimal. Every score must name the specific metric it should move (a KPI from
  `ops/kpi-dashboard.md`, a revenue-at-risk dollar figure, an activation/conversion rate) and cite
  the baseline it's measured against. Never assign `3` without naming the metric and the reasoning
  — "this feels important" is not impact justification.
- **Confidence** — `100%` direct strong evidence (e.g. a double-digit count of customers citing the
  identical reason, a hard ticket count), `80%` good but partial evidence, `50%` a real but
  thin-evidence hunch. Pick the nearest band; don't invent intermediate precision like "73%."
- **Effort** — founder/dev-estimated person-weeks of build effort. Always labeled as an estimate
  (state who gave it), never presented as a measured fact.

`RICE score = (Reach × Impact × Confidence) / Effort`. Compute it for every scored item and rank
descending — but ranking is not the final sequencing step; see Step 5.

## Step 4 — Tag Core/Context and beachhead-alignment

For every item, using Step 1's anchors:

- **Core-reinforcing** vs **Context**: does this item strengthen the specific capability plan/10
  names as the Core, or is it necessary-but-undifferentiated work around it (UI polish, a standard
  integration, table-stakes functionality)? Context work can still be worth doing — it's often
  what unblocks Core work from mattering — but it should never quietly dominate the roadmap without
  that being visible.
- **Beachhead-aligned** vs **Off-segment**: does this item serve the step-5 persona's actual
  need/trigger, or does it mostly serve a customer/request pattern that doesn't match the step-3
  profile (a vocal outlier customer, an adjacent segment the plan didn't target)? Ask the founder
  directly when it's ambiguous — don't infer segment fit from a feature description alone, the
  same discipline `customer-success-lead` applies to churned-customer segment fit.

**Drift flag.** If, in this cycle's "Now" bucket (Step 5), a majority of items are tagged Context
and/or Off-segment, name that explicitly in the output file's Flags section — this is the specific,
checkable signal `agents/product/product-lead.md` uses for its own periodic Core/beachhead drift
check. Don't bury it in prose; state the fraction.

## Step 5 — Sequence into Now / Next / Later, capacity-constrained

Ask the founder for real available build capacity this cycle (person-weeks). Do not let the "Now"
bucket be an arbitrarily long list sorted by RICE score alone — cut it to fit the stated capacity,
taking items in RICE-score order but never letting an unscored ("needs data") item skip ahead of a
scored one just because it's exciting. Next = next cycle's likely candidates. Later = real items,
explicitly deprioritized, not a dumping ground — every Later item keeps its score and tags so it's
re-evaluated on the same footing next cycle, not forgotten.

## Pushing back on vague inputs

Apply the same discipline `skills/interview/onboarding-interview` applies to vague founder answers
— don't write a hunch into the record as if it were a number:

| Signal says | Push back with |
|---|---|
| "A lot of customers want this" | "How many, exactly, and over what period? Pull it from support tickets, churn-reason tallies, or sales-lost reasons if tracked; if not, give me your best count and we log it `confidence: low`." |
| "This will really move the needle" | "Which metric, specifically, and by roughly how much? Tie it to something on `ops/kpi-dashboard.md` or a dollar figure — not a general sense of importance." |
| "It's basically free to build" | "Give me a real person-weeks estimate, even rough. 'Basically free' isn't a number I can divide by." |
| "Everyone will love it" | "Love it enough to pay more, use it more, or stop churning — which specific behavior change are you expecting, and how would we measure it next cycle?" |
| One vocal customer's request framed as broad demand | "Is this one customer's ask, or has more than one independently asked? A single loud voice is real — Reach = 1 — but it isn't 'a lot of customers' until more than one shows up." |
| "It's obviously part of our Core" | "Walk me through why — what does it strengthen that plan/10 actually names, specifically? If it doesn't map to that language, it's Context, and that's fine, but let's call it what it is." |

One probing follow-up per vague input is proportionate — same rule as onboarding-interview. If the
founder still can't get specific, score it `confidence: low` and move on; don't interrogate past
usefulness.

## Output file: `ops/product-roadmap-<timestamp>.md`

Timestamp format `YYYY-MM-DD`; suffix `-2`, `-3` for a same-day re-run.

```markdown
# Product Roadmap — <business name> — <date>

## Anchor
**Core (plan/10):** <2-3 sentences, cited>
**Beachhead persona (plan/03 & 05):** <2-3 sentences, cited>

## Intake log
| ID | Description | Source | Evidence |
|---|---|---|---|
| ri-<slug>-01 | ... | ops/<file> / founder-reported / prior roadmap | <count + citation> |

## Scored items
| ID | Description | Reach | Impact | Confidence | Effort (person-wk) | RICE score | Core/Context | Beachhead/Off-segment |
|---|---|---|---|---|---|---|---|---|
| ri-<slug>-01 | ... | ... | ... | ... | ... | ... | ... | ... |

## Unscored — needs data
<Items with no real Reach number yet — named, not scored, with what data would unblock them.>

## Sequencing
**Capacity this cycle:** <person-weeks, founder-stated>

### Now
<Items that fit stated capacity, in RICE order, with running person-week total shown against capacity.>

### Next
### Later

## Flags
<Core/Context and beachhead/off-segment split of the "Now" bucket, stated as a fraction. If a
majority of "Now" is Context and/or off-segment, say so explicitly — this is the input
product-lead's drift check reads.>

## Shipped since last roadmap (<date of prior file, or "first roadmap">)
<Items from the prior roadmap that shipped, carried items that didn't.>
```

## Update `business-state.json`

This skill does **not** add a new top-level key, and does **not** append its output file to
`ops.cadence_metrics_files` — that field is for periodic quantitative snapshots
(growth/finance/retention metrics), and a roadmap is a re-prioritized planning artifact, not a
numbers snapshot, even though it's timestamped like one. If, in the same session, you also touch
another key you already own for another reason, bump `updated_at`; otherwise leave
`business-state.json` untouched. Locate the latest roadmap by listing `ops/product-roadmap-*.md`
and taking the most recent timestamp — there is currently no `business-state.json` field pointing
to it (see the forward note below).

**Forward note for a future extension.** A field mirroring `ops.last_retro_file` — e.g.
`ops.last_roadmap_file` — would let other agents (`operations-manager`, `scaling-strategist`) find
the current roadmap without a directory glob, the same way `last_retro_file` already works. This
skill deliberately does not add that field itself; it's a `docs/DATA-CONTRACT.md` change and gets
proposed to the maintainer rather than invented here.

## Never fabricate

Every Reach number, every Impact justification, every churn-reason tally traces to a founder
statement or an actual ops file this cycle or a prior one. An item with no real evidence stays in
"Unscored — needs data," explicitly, rather than being assigned a plausible-sounding score to make
the table look complete. This is the same discipline `agents/risk/ai-risk-analyst.md` enforces on
the plan's own `quantitative_claims` — it applies here with the same weight.

This roadmap is a planning aid, not a commitment to customers or a guarantee of business outcomes
— state that once if the founder is about to share it externally, not repeatedly.

## Done means

- The Core and beachhead anchors are stated in the founder's actual plan language, cited.
- Every intake item has a real source and evidence trail; every scored item's Reach/Impact/
  Confidence/Effort traces to something real, with unscored items named rather than guessed.
- Core/Context and beachhead/off-segment tags are applied to every item, and the Flags section
  states the "Now" bucket's split as an explicit fraction — not left implicit in the table alone.
- `ops/product-roadmap-<timestamp>.md` is written with all sections populated (or explicitly
  marked empty/not-applicable — never silently omitted).
