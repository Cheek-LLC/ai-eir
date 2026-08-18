---
name: runway-and-burn-tracking
description: >
  Use at every recurring ops check-in, or immediately any time the founder mentions cash, burn,
  funding, payroll, or asks "how much runway do we have." Asks the founder directly for real
  current cash-on-hand, last period's spend, and last period's revenue — never estimates or
  carries forward a stale figure as current — computes net burn and runway in months, classifies
  it against explicit thresholds, and proactively escalates outside the normal check-in cadence
  when runway crosses a warning (3-6 months) or critical (under 3 months) threshold. Produces
  `ops/<timestamp>-finance-metrics.md`. This is a planning aid, not licensed accounting,
  financial, or tax advice — stated once here, not repeated per line item.
---

# Runway and Burn Tracking

## What this skill is

Runway is the one metric in this whole ops layer where a stale or fabricated number is not just
misleading, it's actively dangerous — a founder can make a real payroll decision off it. This
skill's entire discipline is: ask for the real current numbers every time, do the arithmetic
plainly, and say clearly when the answer means "act now."

## Reads

- `.startup/<slug>/business-state.json` — `cadence` (for period length), `business_basics.
  business_type` (what's likely driving burn — see Step 1a), `quantitative_claims` tagged
  step_ref 15/16 (revenue model shape, for context only — never a substitute for the founder's
  actual reported revenue).
- The most recent prior `.startup/<slug>/ops/*-finance-metrics.md`, if one exists — for trend and
  as a sanity check (a wildly inconsistent jump in reported cash from one period to the next is
  worth asking about), never as a stand-in for today's number.

## Step 1: Ask the founder, every time, for real numbers

1. **Cash on hand today.** The actual current balance, not a projection.
2. **Total spend last period** (burn): payroll, contractor payments, tools/subscriptions, rent,
   everything that left the account.
3. **Total revenue collected last period**: actual cash collected, not invoiced or booked.
4. **Any known one-time event coming**: new funding about to close, a large one-time expense
   planned, a headcount change already decided — noted separately, not blended into the trailing
   burn calculation (a one-time event shouldn't distort the ongoing-burn read).

If the founder can't or won't give a number, record **"not provided by founder"** explicitly for
that field. Do not estimate a plausible figure in its place. A finance-metrics file with an
honest gap is useful; one with a fabricated number that happens to look reasonable is not — it's
the single worst place in this plugin to guess.

## Step 1a: What's actually driving burn, by business type

The runway formula in Step 2 never changes — this section adds context on what's *behind* the
spend number, not an alternate calculation. Check `business_basics.business_type` and, when it
applies, ask the founder to break last period's total spend into the lines below as a follow-up to
Step 1's question 2, so the finance-metrics file separates a deliberate or structural spend
pattern from an undifferentiated "burn is high" read:

- **`physical_product`**: inventory-heavy businesses tie up real cash in stock. Ask what fraction
  of last period's spend went to building/holding inventory versus ongoing operating costs
  (payroll, rent, tools). Report **working-capital burn** (spend on inventory/stock) as its own
  line, separate from **operating burn** (everything else) — a period that looks like heavy burn
  might actually be inventory being built ahead of a real sales ramp, which reads very differently
  from the same dollar amount spent on ongoing opex with nothing to show for it.
- **`marketplace`**: burn is often driven by supply-side and/or demand-side incentives (referral
  bonuses, below-cost pricing, subsidies used to seed liquidity) — these are a deliberate,
  temporary spend to bootstrap the marketplace, not a cost-structure problem, and should never be
  buried inside core opex. Ask what fraction of last period's spend was incentive/subsidy spend.
  Report the blended net burn (unchanged, feeds the Step 2 runway formula) **and**, separately, a
  reference figure for burn excluding incentives — the second number is what tells the founder
  whether the underlying cost structure works once subsidies eventually taper, which the blended
  runway figure alone can't show.
- **`services`**: burn here is typically dominated by people-cost. Ask what fraction of last
  period's spend was payroll/contractor cost, and — if a recent `weekly-metrics-review` snapshot
  reports billable utilization — note it alongside burn as context. Low utilization paired with
  high people-cost spend is a specific, actionable finding (paid capacity sitting on the bench),
  distinct from "burn is just high" and worth naming explicitly rather than folding into the
  blended figure.
- **`saas`** / **`consumer_app`**: burn is typically driven fairly evenly by team headcount and
  infra/tooling costs — the standard Step 1 breakdown (payroll, tools, rent, contractors) usually
  already captures what's driving it; no additional split is needed here.
- **`other`**: ask the founder directly what's actually driving spend this period before assuming
  any category above applies — record it in the founder's own terms.

## Step 2: Compute net burn and runway

```
Net burn = spend − revenue (this period)
```

- If net burn > 0: `runway_months = cash_on_hand / net_burn`. State to one decimal place.
- If net burn ≤ 0 (revenue ≥ spend): state runway as **"not applicable — cash-generative this
  period"**, not an infinite number or a divide-by-zero artifact. Still show the actual net
  figure (e.g. "+$4,200 net this period").
- If cash-on-hand or spend or revenue is "not provided," do not compute a partial or estimated
  runway figure — state plainly that runway cannot be computed this period and name exactly which
  input is missing.

## Step 3: Classify against explicit thresholds

| Runway | Classification | Action |
|---|---|---|
| < 3 months | **Critical** | Proactive escalation now (see Step 4) — do not wait for the retro or next scheduled check-in |
| 3–6 months | **Warning** | Flag explicitly in this file and in the retro's risks section |
| 6–9 months | **Watch** | Note in the file; no proactive interrupt |
| ≥ 9 months, or cash-generative | **Healthy** | Note only |

These bands are a planning reference, stated explicitly so classification isn't a judgment call —
not a claim that any specific number guarantees an outcome.

## Step 4: Proactive escalation on Critical (and act on Warning)

- **Critical:** Say so directly and plainly in this session, regardless of who's present. If this
  is running as part of an automated/scheduled check-in with no founder actually in the
  conversation, check whatever scheduling/trigger capability is available in the current
  environment (the same kind of check the orchestrator's own cadence section makes — a
  routine/trigger tool, a "send later" tool, whatever's actually available; don't assume a fixed
  tool name or that none exists) and use it to push an explicit message to the founder now rather
  than letting this sit until the next scheduled session discovers it.
- **Warning:** Not an immediate interrupt, but must not be buried — call it out explicitly to
  whoever invoked this skill (`finance-controller`, which surfaces it to `operations-manager` for
  the retro's risks section) rather than left as a routine line in a metrics table.

## Output file: `ops/<timestamp>-finance-metrics.md`

Timestamp format `YYYY-MM-DD`; append `-2`, `-3`... for a same-day rerun.

```markdown
# Finance Metrics — <business name> — <date>

_This is a planning aid, not licensed accounting, financial, or tax advice._

## Period covered
<start> to <end>

## Founder-reported inputs
| Input | Value | Source |
|---|---|---|
| Cash on hand | $... | founder-reported <date> (or "not provided") |
| Spend last period | $... | founder-reported <date> (or "not provided") |
| Revenue last period | $... | founder-reported <date> (or "not provided") |
| One-time items noted | ... | founder-reported <date> (or "none") |

## Net burn and runway
Net burn: $... | Runway: N.N months (or "not applicable — cash-generative" or "cannot be
computed — missing <input>")

## Burn composition (physical_product, marketplace, and services only — omit for other types)
<physical_product: working-capital burn (inventory/stock spend) $... vs. operating burn $... |
marketplace: blended net burn $... (unchanged, feeds the figure above) vs. burn excluding
supply/demand incentive spend $... | services: people-cost spend $... as a share of total spend,
noted alongside this period's billable utilization if known. Omit this section entirely for saas,
consumer_app, or other unless the founder specifically flagged a comparable structural spend line.>

## Classification
<Critical / Warning / Watch / Healthy>, per the thresholds above.

## Trend vs. prior snapshot
<Cash, burn, revenue vs. last period's figures — direction and magnitude.>

## Escalation
<If Critical: state what was done this session — told the founder directly, and/or used
<tool name> to send a proactive message, or "no scheduling capability available — founder must be
told this now, this session, in whatever channel is active." If Warning: confirm this is flagged
for the retro. Otherwise: "none needed.">
```

## Update `business-state.json`

Append `ops/<timestamp>-finance-metrics.md` to `ops.cadence_metrics_files`. If Critical or
Warning, append a `risk_log` entry (type `business`, `raised_by: "finance-controller"`, `status:
"open"`) per the schema in `agents/ops/finance-controller.md` — read-modify-write the whole file,
preserve every other key.

## Done means

- Every input is founder-reported this period or explicitly "not provided" — never estimated.
- Runway is computed correctly (or explicitly not computed, with the missing input named) and
  classified against the stated thresholds.
- A Critical runway triggered an actual escalation this session, not just a file entry.
- `ops/<timestamp>-finance-metrics.md` is written and registered in `business-state.json`.
