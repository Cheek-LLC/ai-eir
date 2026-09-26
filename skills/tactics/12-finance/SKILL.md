---
name: 12-finance
description: >
  Use once the business is genuinely operating and needs its first real operating financial model
  and real cash infrastructure — Tactic 12 of Paul Cheek's 15 Tactics: Path to Greatness: Building
  the Financial Model and Setting Up the Piggy Bank. Triggers: "build our real financial model,"
  "set up our business bank account," "we need real bookkeeping," "what's our actual burn model
  now that we have customers," "turn our COCA into a real spend plan." Distinct from
  `skills/ops/runway-and-burn-tracking` (the recurring monthly snapshot) and `skills/ops/pricing-
  and-monetization-optimization` (the ongoing pricing check) — this tactic is the one-time build
  of the model and bank infrastructure those two skills then track and optimize against. Builds
  the model's CAC line directly from DE Step 19's COCA output.
---

# Tactic 12: Finance — Path to Greatness

## What this tactic is, and what it isn't

DE Steps 17 and 19 produced **plan-stage** projections — LTV and COCA computed from Step 18's
costed sales-process *map*, before the business had a single real operating dollar moving through
it. This tactic is the moment those projections get replaced by a **real operating financial
model**: actual bank accounts, actual bookkeeping, actual cash management, built once the business
has genuine revenue and spend to model — the "setting up the piggy bank" half of this tactic's own
title, which is just as much this tactic's job as the model itself.

This tactic does **not** duplicate two skills that already own their own ongoing mechanics:

- **`skills/ops/runway-and-burn-tracking`** owns the recurring cadence check — ask the founder for
  real current cash/spend/revenue, compute net burn and runway, classify against thresholds, escalate
  on Critical. That skill runs every check-in, forever, once this tactic's model and bank setup
  exist to report from.
- **`skills/ops/pricing-and-monetization-optimization`** owns the ongoing pricing-review mechanics
  once real usage data exists. This tactic's model consumes that skill's pricing figures as an
  input line; it doesn't re-run its trigger analysis.

Cross-reference both by name for their mechanics — this tactic's own job is narrower and comes
first: **build** the model and the cash infrastructure those two skills then operate against.

**Scope boundary — stated once:** everything here is a planning aid, not licensed accounting,
financial, or tax advice — the same framing `runway-and-burn-tracking` already states. A real
bookkeeper or accountant should review the chart of accounts and any tax-filing decisions; this
tactic gets the founder to that review with real infrastructure already in place, not through it.

## What you read

- `.startup/<slug>/business-state.json` → confirm `stage` is `operating` (or a founder explicitly
  asking ahead of that because revenue/spend is already real). Read `business_basics.business_type`
  and `founder.notes` for the confirmed entity/bank-readiness state from Tactic 11
  (`skills/tactics/11-legal`) — a business bank account requires the EIN and formation documents
  that tactic's checklist produces; if that hasn't happened yet, say so and stop, this tactic has
  no account to set up around.
- `.startup/<slug>/plan/19-calculate-the-coca.md` — **required**. This is the direct, confirmed
  integration point (per `docs/TACTICS-15.md`): Step 19's COCA figure feeds this tactic's model.
  See §2 below for exactly how.
- `.startup/<slug>/plan/17-calculate-the-ltv-of-a-customer.md` and `plan/16-set-your-pricing-
  framework.md` — the LTV and pricing figures the model's revenue lines are built from.
- `.startup/<slug>/business-state.json` `quantitative_claims` entries tagged `step_ref`
  `19_calculate_the_coca` and `17_calculate_the_ltv_of_a_customer` — the sourced figures and
  their confidence, not just the plan prose.
- The most recent `.startup/<slug>/ops/*-finance-metrics.md`, if one exists — real operating
  cash/burn data to calibrate the model against once it's live, and to confirm this isn't the
  business's very first cash data point.
- `.startup/<slug>/tactics/12-finance.md`, if it already exists — for what's already built, so
  this run refreshes rather than rebuilds from scratch.

## What you write

- `.startup/<slug>/tactics/12-finance.md` — the model and piggy-bank setup record below.
- You do **not** write `business-state.json.tactics` yourself. Report your output file and a
  one-line summary back to whoever invoked you; the orchestrator updates
  `business-state.json.tactics.12_finance` after confirming the file output.

## 1. Setting up the piggy bank — real cash infrastructure

This is infrastructure, not analysis, and it has to exist before the model in §2 has anything real
to report against.

- **A real business bank account, separate from personal.** Requires the EIN and formation
  documents from Tactic 11. Mixing personal and business funds ("commingling") is the single most
  common early-stage bookkeeping mistake — it makes every downstream number in this model
  unreliable, and it undermines the liability protection the entity choice was supposed to provide
  in the first place. Pick a provider suited to the business's actual banking needs: a
  startup-focused bank/fintech (offers API-friendly banking, virtual cards, easy sub-accounts) for
  a `saas`/`consumer_app`/`marketplace` business moving money digitally; a traditional local
  business bank for a `physical_product`/`services` business that needs in-person deposits,
  merchant services, or a business line of credit sooner.
- **A real bookkeeping system**, chosen for the business's actual complexity, not the fanciest
  option available: a spreadsheet-based system is genuinely fine pre-revenue or in the first months
  of real revenue with low transaction volume; a real bookkeeping tool (the kind of software that
  connects to the bank feed and categorizes transactions automatically) becomes worth the cost the
  moment transaction volume or investor/tax reporting needs outgrow manual tracking. Set up a chart
  of accounts tailored to `business_basics.business_type` from day one — retroactively
  reclassifying a year of transactions is real, avoidable pain: a `physical_product` business needs
  a real COGS/inventory account structure from the start; a `saas` business needs deferred-revenue
  tracking if billing annually; a `marketplace` needs supply-side payouts tracked separately from
  the business's own take-rate revenue, not blended.
- **A cash-management policy, stated explicitly, not left implicit.** How much stays in an
  immediately-liquid operating account versus a separate reserve (a high-yield business savings
  account or treasury product) earning something on cash not needed for the next 60-90 days of
  spend. State the actual split as a number, tied to the runway figure `runway-and-burn-tracking`
  most recently reported — don't park cash in something illiquid if runway is already inside the
  Warning band.
- **A minimal internal-controls check**, even at team-of-one or team-of-two size: a stated dollar
  threshold above which a second person (a co-founder, or an advisor/board member if solo) has to
  see and approve a spend before it goes out. This is not bureaucracy for its own sake — it's the
  cheapest real fraud/error control available at this stage, and it costs nothing to set up before
  it's needed.

## 2. Building the real operating financial model

This is a rolling 12-18 month model with real line items, replacing the plan-stage projections with
figures now grounded in what the business is actually doing.

**Revenue.** Built from the real pricing in effect (`plan/16-set-your-pricing-framework.md`, or the
updated figure if `skills/ops/pricing-and-monetization-optimization` has since tested a change —
check for a more recent `ops/pricing-review-*.md` before defaulting to the plan-stage number) times
actual or near-term-credible customer counts. State clearly which months are actuals (from real
`ops/*-finance-metrics.md` data) and which are forward projection — never blend the two into one
undifferentiated line.

**COGS and opex.** The standard lines: cost of goods/services delivered, payroll (fully-loaded,
matching the multiplier convention `skills/ops/hiring-and-org-design` uses for any hire this model
should already reflect), tools/software, rent, and any `business_type`-specific driver
`runway-and-burn-tracking` Step 1a already identifies (inventory/working-capital burn for
`physical_product`, supply/demand incentive spend for `marketplace`, people-cost for `services`).

**Customer-acquisition-cost line — built directly from DE Step 19's COCA. This is the concrete,
confirmed integration point.** Do not re-derive a fresh CAC estimate here. Pull the actual figure:

1. Open `plan/19-calculate-the-coca.md` and read the **blended COCA** (and any per-channel COCA, if
   the business has multiple acquisition channels — Step 19 computes both where data allows).
2. Take this model's assumed or actual **new customers acquired per month** for the period being
   modeled.
3. **Monthly CAC spend line = COCA (per Step 19) × new customers that month.** If Step 19 reported
   per-channel COCA, build one line per channel and sum, rather than applying a single blended
   figure to a customer mix that Step 19 itself said was uneven across channels.
4. **Worked example:** Step 19 reports a blended COCA of $1,410 (as in that step's own worked
   example) and this model assumes 12 new customers in a given month. That month's CAC spend line
   is `$1,410 × 12 = $16,920`. If Step 19 also reported a paid-channel COCA of $2,100 and a
   founder-led-sales COCA of $650 for 5 and 7 of those 12 customers respectively, the line splits
   to `$2,100 × 5 = $10,500` (paid) and `$650 × 7 = $4,550` (founder-led), summing to the same
   $15,050 — use the split whenever Step 19 supports it; it's a materially more honest spend model
   than one blended number, especially once actual channel mix diverges from what Step 19 assumed.
5. **Once real operating data exists, recompute a live COCA from actual spend ÷ actual new
   customers for the period, and compare it explicitly against Step 19's plan-stage figure in this
   model.** A material, sustained gap between the two is exactly the kind of post-launch drift
   `docs/DATA-CONTRACT.md` names as a `risk_log` entry (`type: "business"`) — that logging is
   `skills/ops/runway-and-burn-tracking`'s and the ops layer's job going forward, not this tactic's
   one-time build, but this tactic's model is where the comparison first becomes visible, so state
   it plainly in the output file rather than silently carrying the plan figure forward unchecked.
6. **Confidence carries forward.** If Step 19's COCA figure (or its `quantitative_claims` entry)
   is marked `confidence: "low"` or rests on an unvalidated `key_assumptions` placeholder (e.g. an
   unsourced founder-time hourly rate), say so explicitly next to this model's CAC line — a
   downstream model inherits its input's uncertainty, it doesn't launder it into a clean number by
   virtue of being in a spreadsheet.

**Cash-flow projection.** Roll revenue minus COGS/opex/CAC forward against the current cash balance
(from the most recent `ops/*-finance-metrics.md`) to produce a projected month-by-month cash
position — this is the forward-looking companion to `runway-and-burn-tracking`'s trailing,
backward-looking runway snapshot; state explicitly that this model is the planning tool and that
skill's recurring check-in remains the source of truth for "what's our runway right now."

## 3. Numbers discipline

Every figure in this model that rests on a plan-stage step (`16`, `17`, `19`) must trace to that
step's `quantitative_claims` entry, exactly like every other numeric artifact in this plugin. A
figure this model updates with real operating data (a recomputed live COCA, a tested new price) is
a new sourced number — flag it in the output file so a later `quantitative_claims` update (owned by
`pricing-and-monetization-optimization` for pricing, and by the ops layer generally for COCA drift)
has something concrete to act on; this tactic does not edit `quantitative_claims` itself.

## Output file: `tactics/12-finance.md`

```markdown
# Tactic 12: Finance — <business name> — <date>

_Planning aid, not licensed accounting, financial, or tax advice._

## Piggy bank setup
| Item | Status | Provider/detail |
|---|---|---|
| Business bank account | ... | ... |
| Bookkeeping system | ... | ... |
| Chart of accounts (business-type-tailored) | ... | ... |
| Cash-management split (liquid vs. reserve) | ... | ... |
| Internal-controls threshold | ... | ... |

## Operating financial model (12-18 month rolling)
| Month | Revenue | COGS | Opex (payroll/tools/rent) | CAC spend | Net | Cash position |
|---|---|---|---|---|---|---|
| ... | ... | ... | ... | ... | ... | ... |

## CAC line — Step 19 COCA integration
Step 19 COCA used: $... (blended) <per-channel breakdown if applicable>
This model's new-customer assumption: N/month
CAC line = COCA x new customers = $...
Confidence carried from Step 19: <low/medium/high, with the reason>
Live vs. plan COCA (once real data exists): <plan figure vs. recomputed actual, and the gap>

## Notes for the ops layer
<Any material COCA drift or pricing-figure staleness flagged here for `runway-and-burn-tracking`/
`pricing-and-monetization-optimization` to pick up going forward — this tactic does not act on it
beyond flagging it.>
```

## Done means

- The business bank account, bookkeeping system, and cash-management policy are real and set up
  (or the specific blocker is named — e.g. Tactic 11's incorporation isn't complete yet).
- The operating model's CAC line is built explicitly from Step 19's COCA figure, with the
  arithmetic shown (COCA × new customers, per-channel where Step 19 supports it), not a fresh
  guess at acquisition cost.
- Step 19's confidence/`key_assumptions` caveats carry forward visibly onto this model's CAC line.
- Once real operating data exists, the model states the live-vs-plan COCA comparison explicitly
  rather than silently carrying the plan-stage figure forward unchecked.
- `tactics/12-finance.md` is written. `business-state.json.tactics` is left to the orchestrator.
