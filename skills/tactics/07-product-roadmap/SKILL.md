---
name: 07-product-roadmap
description: >
  Use once `business-state.json.stage` reaches `approved` and go-to-market work is starting (or
  already underway) to build the founder's first real, sequenced product roadmap — the moment DE
  Steps 6-8's product spec and Step 24's forward-looking sketch become an actual prioritized
  execution plan with real customers to source signal from. Triggers: "build our roadmap," "what
  do we actually build first," "turn the plan into a backlog," "tactic 7," "product roadmap
  tactic." Distinct from `skills/product/roadmap-and-prioritization`'s ongoing, round-over-round
  refresh cadence during `stage: operating` — this tactic is "build the first one," that skill is
  "keep refreshing it," and this tactic delegates to it for the actual scoring mechanics rather
  than re-implementing them.
---

# Tactic 7: Product Roadmap — Building Your Product's Roadmap

## What this tactic is (and isn't)

Aulet's frame for the Product Development tactics: the 24 steps got the founder to a rigorous
plan; Steps 6-8 defined what the product actually is (the full life-cycle use case, the high-level
spec, the quantified value proposition), and Step 24 sketched a forward-looking, evidence-grounded
near-term roadmap once the MVBP had real usage data behind it. What none of that produced is a
**live, prioritized, capacity-constrained roadmap built the way this plugin builds every other
prioritized artifact** — scored, sourced, checked against Core and beachhead, sequenced into
Now/Next/Later. That's this tactic's job, and it happens exactly once as a distinct event: the
first time the founder has enough real signal (early customers, an MVBP in market, GTM under way)
to run `skills/product/roadmap-and-prioritization`'s RICE-based process for real instead of
sketching from plan analysis alone.

Three things this tactic is explicitly **not**:

1. **It is not a redo of Step 24.** Step 24 already sequenced near-term work against Step 23's
   usage evidence and Step 14's bowling-pin trigger. This tactic doesn't re-derive that thinking —
   it takes Step 24's sketch as one input among several and puts it through a real, comparable,
   round-over-round scoring process for the first time.
2. **It is not the roadmap refresh cadence.** `skills/product/roadmap-and-prioritization`
   (delegated to by `agents/product/product-lead.md`) is the *ongoing* skill that reruns every
   cycle once the business is operating — RICE scoring, Core/Context tagging, beachhead-alignment
   checks, drift detection across cycles. This tactic is the **first invocation** of that machinery.
   Every refresh after this one is that skill's job, run directly by `product-lead`, not this
   tactic file again. Put plainly: **Tactic 7 builds the first one. `roadmap-and-prioritization`
   keeps refreshing it.**
3. **It is not a new scoring methodology.** This tactic does not invent its own prioritization
   framework. It delegates the actual mechanics — RICE scoring, Core/Context and beachhead
   tagging, Now/Next/Later sequencing — entirely to `skills/product/roadmap-and-prioritization`.
   This tactic's own distinct job is confirming the moment is right, assembling the seed intake a
   plan-only business doesn't yet have real ops data for, invoking that skill, and recording the
   tactic as done.

## What you read

- `.startup/<slug>/business-state.json` (whole file). Confirm `stage` is `approved` or further
  along (`gtm`, `operating`) — this tactic cannot start before the plan is approved. Read
  `business_basics` (type-specific framing below) and `tactics.07_product_roadmap` if already
  present (don't re-run a completed tactic without the founder asking for a fresh first-roadmap
  reset, which would be unusual — more likely they want a refresh, which is
  `roadmap-and-prioritization`'s job, not this tactic's).
- `plan/06-full-life-cycle-use-case.md`, `plan/07-high-level-product-specification.md`,
  `plan/08-quantify-the-value-proposition.md`, `plan/10-define-your-core.md` — the product's
  actual scope, quantified value driver, and Core, exactly as `roadmap-and-prioritization` itself
  requires as anchors.
- `plan/22-define-the-mvbp.md` — what was deliberately excluded from the MVBP and the stated
  automation triggers; deferred-scope items are real, evidence-backed candidate roadmap items even
  before any customer complains about their absence.
- `plan/24-develop-a-product-plan.md` — the founder's own prior near-term roadmap thinking. Treat
  every item there as a candidate for this tactic's intake, not as an already-final answer.
- List `ops/product-roadmap-*.md` — if any file already exists, this tactic has already run (see
  "Is this genuinely the first roadmap" below).

## What you write

- `tactics/07-product-roadmap.md` — this tactic's own record (template below): confirms the
  first-roadmap event happened, cites the real artifact, and hands the ongoing cadence forward.
- Via delegation: `ops/product-roadmap-<timestamp>.md`, produced by
  `skills/product/roadmap-and-prioritization` when you invoke it in Step 3 below. That skill's own
  file is the actual roadmap — this tactic does not duplicate its content.
- This skill does **not** write `business-state.json.tactics` itself. Write only the two files
  above. The orchestrator (`agents/orchestrator.md`) confirms `tactics/07-product-roadmap.md` was
  written and updates `business-state.json.tactics.07_product_roadmap` accordingly.

## Step 1 — Confirm this is genuinely the first roadmap

Glob `ops/product-roadmap-*.md`. If one or more already exist, this tactic's job is already done —
tell the founder plainly: "You already have a roadmap from `<file>`. What you want now is a
refresh, which is `agents/product/product-lead.md`'s job, not this tactic." Do not proceed further
under this tactic; hand off to that agent instead. If none exist, continue.

Also confirm `stage` supports it: `skills/product/roadmap-and-prioritization` itself gates on
`stage: operating`, a late-`gtm` beta/early-access cohort, or `ops.status: "active"`/
`gtm.status: "launched"`. If the founder is `approved` but hasn't started GTM at all yet — no
early customers, no beta cohort, nothing sold — say so plainly: there isn't yet a beachhead
customer or usage signal to build a *real* roadmap against, and the honest move is to wait until
at least the MVBP (Step 22) is in front of real prospects, or run this tactic now on a
plan-analysis-only basis and mark most items `confidence: low` per that skill's own discipline
(never invent a Reach number that doesn't exist). Ask the founder which they'd rather do; don't
silently pick for them.

## Step 2 — Assemble the seed intake a plan-only business doesn't yet have

`roadmap-and-prioritization`'s own intake step (its Step 2) expects churn reasons, growth-funnel
drop-off, and retention data — a business running this tactic for the first time usually has none
of that yet, or only a handful of early data points. Before invoking the skill, assemble a seed
intake list from what genuinely does exist at this point, so the roadmap isn't scored against an
empty table:

| Source | What to pull |
|---|---|
| Step 22 MVBP | Every explicitly deferred scope item and its stated automation trigger — check whether any trigger has already fired |
| Step 24 | Every near-term roadmap item already proposed, with its original justification preserved |
| Step 7 spec | Any capability the full spec names that the MVBP doesn't yet deliver |
| Early GTM signal (if any exists) | Real prospect objections, early-customer requests, sales-lost reasons — however thin, tagged with an honest count |
| Founder brainstorm | New ideas raised directly, tagged `confidence: low` unless real evidence backs them |

Hand this seed list to the delegated skill as its starting intake rather than leaving Step 2 to
find nothing. Every item still needs a real source citation — a seed item with no real backing
gets the same `confidence: low` / "Unscored — needs data" treatment that skill already applies to
weak signal; this tactic does not get to skip that discipline just because it's the first cycle.

## Step 3 — Invoke `skills/product/roadmap-and-prioritization`

Run it via `Skill`, handing it the seed intake from Step 2 alongside its own required reads. It
owns RICE scoring, Core/Context and beachhead tagging, and Now/Next/Later sequencing — do not
re-implement any of that here. Expect (and accept) a roadmap with more "Unscored — needs data"
items and lower average confidence than a mature refresh cycle will have; that's an honest
reflection of how little usage data exists this early, not a flaw in this run.

## Step 4 — Write `tactics/07-product-roadmap.md`

```markdown
# Tactic 7: Product Roadmap — Building Your Product's Roadmap

## First-roadmap event
Date: <date>
Roadmap artifact: `ops/product-roadmap-<timestamp>.md` (built via `skills/product/roadmap-and-
prioritization`)

## What fed the first cut
- Step 22 deferred-scope items carried in: <count, and which fired their automation trigger>
- Step 24 near-term items carried in: <count>
- Step 7 spec gaps identified: <count>
- Real early GTM/sales signal available at this point: <honest description — thin is fine, say so>

## Headline "Now" bucket
<2-3 sentence summary of what's actually being built first, pulled from the roadmap file>

## Honest state of the evidence
<State plainly how much of this first roadmap rests on real signal vs. founder judgment/plan
analysis — this is expected to be thinner than a mature cycle and should say so, not overstate
its own rigor.>

## What happens next
This is the founder's **first** roadmap, not their last. Every future roadmap cycle is
`agents/product/product-lead.md`'s job via `skills/product/roadmap-and-prioritization` directly —
this tactic file is not re-run for refreshes.
```

## Done means

- Confirmed via Step 1 that this was genuinely the first roadmap (or explicitly redirected the
  founder to `product-lead` if one already existed).
- `skills/product/roadmap-and-prioritization` was actually invoked and produced
  `ops/product-roadmap-<timestamp>.md` — this tactic never fabricates a roadmap summary without
  that real artifact existing.
- `tactics/07-product-roadmap.md` written, citing the real roadmap file, honestly describing how
  thin or solid the evidence behind the first cut is, and stating explicitly that future cycles run
  through `product-lead`/`roadmap-and-prioritization` directly, not this tactic again.
- `business-state.json.tactics` was **not** written by this skill — left to the orchestrator.
