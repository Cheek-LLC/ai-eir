---
name: operations-and-fulfillment-playbook
description: >
  Advanced COO-level operations playbook for physical_product, marketplace, and services
  businesses once business-state.json.stage is operating (or gtm post-soft-launch). Delegated to
  by agents/ops/operations-manager.md as part of a recurring check-in, or run directly when a
  founder asks about reorder points/safety stock, supplier defect rates and when to dual-source,
  fulfillment cost-per-order, marketplace supply-side vetting and liquidity health, delivery-
  capacity/utilization planning, staffing-vs-pricing decisions, or writing down a process before it
  only lives in the founder's head. Branches entirely on business_basics.business_type — reads the
  plan's stated unit economics (steps 15-19) and checks real operational numbers against them.
  Writes ops/operations-review-<timestamp>.md and logs any material operational-quality risk
  (rising defect rate, delivery utilization over 100%, liquidity subsidy not decreasing, etc.) to
  risk_log. Not applicable to saas/consumer_app/other — those carry no physical-fulfillment,
  supply-side, or delivery-capacity operations layer for this skill to run against.
---

# Operations & Fulfillment Playbook

## What this skill is

The ongoing-operations execution layer for the operational disciplines that only apply once a
business actually ships something, matches two sides, or delivers billable work — as distinct
from the general growth/finance/retention math `growth-analyst`, `finance-controller`, and
`customer-success-lead` already own. Those three run identically regardless of `business_type`;
this skill exists precisely because operations means something structurally different for a
`physical_product`, a `marketplace`, and a `services` business, and none of the existing ops
specialists carry SOPs for inventory, supplier quality, fulfillment cost, supply-side vetting,
liquidity operations, or delivery-capacity planning. A check-in that skips this for an applicable
business type is missing the operational layer most likely to actually break the business between
check-ins — a stockout, a defect-rate spiral, a liquidity engine that never weans off founder
subsidy, or a delivery team burning out past 100% utilization.

**Gate on `business_basics.business_type` before anything else.** This skill applies to
`physical_product`, `marketplace`, and `services` only. For `saas`, `consumer_app`, or `other`,
say so in one line and stop — do not force a fulfillment or capacity analysis onto a business type
that has neither.

**Cadence.** Run every check-in for an applicable business type, same as `finance-controller` —
inventory, supplier quality, liquidity health, and delivery utilization can each independently sink
a business between check-ins, so this isn't a "when there's time" specialist.

## What you read

- `.startup/<slug>/business-state.json` in full — `business_basics.business_type` (the gate above)
  and `business_type_notes` (channel mix for physical_product, single- vs. multi-sided confirmation
  for marketplace, team size for services), `risk_log` (all `open` entries tagged `business` from a
  prior run of this skill, so you don't re-raise a duplicate), `ops.cadence_metrics_files` (prior
  `operations-review-*.md` files, for trend).
- `plan/15-design-a-business-model.md` and `plan/16-set-your-pricing-framework.md` — the stated
  business-model shape and pricing logic this period's actuals get checked against.
- `plan/17-calculate-the-ltv-of-a-customer.md` — specifically its stated gross-margin assumption;
  physical_product fulfillment economics erode this margin directly, and services capacity ceilings
  determine whether the assumed customer lifetime is even deliverable.
- `plan/19-calculate-the-coca.md` — for services, whether founder/staff delivery time is already
  folded into cost assumptions the way `services-unit-economics-reviewer` checked at plan stage.
- Every prior `ops/operations-review-*.md` file, in date order — this skill runs on trend (a
  defect rate climbing over three shipments, utilization creeping past 100%), not a single
  snapshot.
- Real numbers from the founder this period, per business type (see each section below) — you do
  not fabricate a defect rate, a fill rate, or a utilization number. "Not tracked this period" is
  the honest output when the founder doesn't have it, exactly as `agents/ops/operations-manager.md`
  requires of every specialist it delegates to.

## What you write

`.startup/<slug>/ops/operations-review-<timestamp>.md` (template below), and — for any finding
that clears the materiality bar stated in each section — a `risk_log` entry, `type: "business"`,
using the **exact same schema and shared id sequence** `agents/ops/operations-manager.md` already
defines (`ops-<slug>-<sequential-number>`, increment from the highest existing `ops-<slug>-*` id in
`risk_log` — this skill does not start a second numbering pool). `raised_by: "operations-manager"`.
Never set `status` to anything but `open` — mitigation/acceptance is the founder's call, logged
later, never silently overwritten. You also update `business-state.json.ops.cadence_metrics_files`
by appending this file's path.

---

## `physical_product` — inventory, supplier quality, fulfillment economics

### 1. Inventory management: reorder points and safety stock, per SKU

Ask the founder, per active SKU: average daily unit sales over the period, current on-hand units,
the supplier's *quoted* lead time, and the *actual* realized lead time on the last 2-3 orders
(these diverge more often than founders expect — track both).

```
Reorder Point (ROP) = (Average Daily Sales × Realized Lead Time in Days) + Safety Stock
Safety Stock        = (Max Daily Sales × Max Realized Lead Time) − (Average Daily Sales × Average Realized Lead Time)
```

This is the standard max-min buffering method — a planning-aid heuristic, not a precision
forecasting model, and state it as such. Compute both per SKU. Flag any SKU where **current
on-hand is already below its computed ROP** — that SKU is at active stockout risk before the next
reorder cycle closes, not a future concern.

Also compute **Days of Inventory On Hand** = on-hand units ÷ average daily sales, per SKU. This is
the mirror-image risk: too low courts a stockout, too high ties up working capital that
`finance-controller`'s runway tracking needs to know about — cross-reference using the same
**working-capital burn** vocabulary `agents/council/hardware-physical-product-operator.md`
established (working-capital burn tied up in inventory, tracked separately from operating burn), so
a finding here reads consistently with what finance already tracks.

**Material →** any SKU with on-hand below its computed ROP with no reorder already placed, or
Days of Inventory On Hand more than ~2x the realized lead time (working capital sitting idle in
stock beyond any reasonable buffer). Tag `[INVENTORY]`.

### 2. Vendor/supplier management and quality control

Ask the founder, per supplier/SKU: units received this period, units that failed incoming QC or
were returned as defective.

```
Defect Rate = Units Failed QC ÷ Units Received (per shipment)
```

Track this across the last 3+ shipments per supplier, not a single shipment — one bad shipment is
noise, a trend isn't. For receiving inspection itself, a simple sampling heuristic (not a
substitute for a real AQL/ANSI-Z1.4 sampling plan once volume justifies one): sample roughly
√(shipment size) units, minimum 15, and inspect 100% of any shipment under ~50 units — cheap enough
to do every time at low volume, and it's exactly the discipline that catches a drifting defect rate
before it reaches the customer.

**When to dual-source a critical component or supplier** — this is the single highest-value call
in this section, and founders default to single-sourcing because it's simpler until it isn't. Treat
any of the following, sustained (not a one-off), as the trigger to actively qualify a second source:
- Defect rate exceeds ~2% sustained across 2+ consecutive shipments for a component load-bearing to
  the finished product (adjust the threshold down for a safety-critical or regulated component —
  state the adjustment explicitly if applicable, don't apply a flat 2% to every category).
- Realized lead time has exceeded the quoted lead time by more than ~50% on 2+ of the last 3 orders
  — a supplier whose lead time is unreliable is an inventory-buffering problem today and a
  stockout-causing single point of failure tomorrow.
- The supplier represents an unaddressed single point of failure the plan already named (per
  `hardware-physical-product-operator`'s Step 7/22 review) and the business has now been operating
  for multiple periods with revenue actually flowing through that dependency with still no backup
  qualified — the plan-stage flag becoming a live, uncapitalized-on operational risk is itself
  worth naming, distinct from the plan-stage finding it descends from.

**Material →** any dual-source trigger above met. Tag `[SUPPLY-CHAIN]`.

### 3. Fulfillment/shipping economics: real cost-per-order vs. the plan's unit economics

Ask the founder for actual, invoiced/logged numbers this period, not estimates:

```
Cost-Per-Order = Pick/Pack Labor + Packaging Materials + Outbound Shipping + Amortized Returns/Damage
```

Compare this to the fulfillment-cost assumption implied by the plan's own numbers: `plan/15-*`'s
business-model COGS structure and/or the gross-margin percentage `plan/17-*` used to compute LTV
(`LTV = ARPU × gross margin % × lifetime`) implicitly assumes some per-order fulfillment cost baked
into COGS. Back out what that implied figure was, and compare it to this period's real
cost-per-order.

**Material →** actual cost-per-order exceeds the plan's implied figure by more than ~15%. This is
not just a fulfillment-line finding — it means gross margin, and therefore LTV, is running lower
than step 17 assumed, which feeds directly into `operations-manager`'s own LTV-drift check (item 1
of its drift comparison). Say so explicitly in the finding: name the `quantitative_claims` LTV id
this explains, so the operations-manager retro can cite root cause rather than just re-stating the
LTV gap as unexplained drift. Tag `[FULFILLMENT-ECONOMICS]`.

---

## `marketplace` — supply-side operations and liquidity execution

This section is the **ongoing-operations execution** of what
`agents/council/marketplace-liquidity-specialist.md` assessed at the plan stage — that persona
reviewed whether the plan's cold-start sequencing and take-rate logic were sound *on paper*; this
skill checks whether liquidity is actually materializing *in operation*, period over period. Don't
re-derive that persona's segmentation/DMU/take-rate rubric here — cite it by name when relevant and
stay in your own lane: supply-side operations discipline and whether liquidity is real.

### 1. Supply-side onboarding and vetting

Ask the founder: how many supply-side applicants this period, how many approved, what the
verification steps actually are (identity check, credential/license check if the category requires
one, sample-work or portfolio review), and time-to-approve. A vetting process that exists only as
"we look at their profile" is not a quality bar — name the actual steps or flag that none exist.

**Material →** no vetting process exists at all for a category where supply-side quality is
load-bearing to trust (anything involving in-person service, safety, or money changing hands), or
approval rate is ~100% with no rejections ever recorded (a vetting step that never actually filters
anyone isn't a filter). Tag `[SUPPLY-QUALITY]`.

### 2. Quality and trust mechanisms

Ask for: the % of completed transactions that receive a rating/review, the average rating trend
across the last 3 periods, the dispute rate, and the actual first-response time on disputes against
whatever SLA the founder has stated (or "no stated SLA" if none exists). Track supply-side
deactivations this period and the trigger that caused each one — if no deactivation has ever
happened despite disputes existing, ask directly whether underperforming supply is actually being
removed or just tolerated.

**Material →** average rating trending down across 2+ periods, dispute rate rising, or a
demonstrated pattern of disputes with no deactivation ever following. Tag `[SUPPLY-QUALITY]`.

### 3. Liquidity operations

The concrete, measurable question `marketplace-liquidity-specialist` named at plan stage — does a
listing reliably find a match inside a customer's patience window — now gets checked against real
transaction data:

```
Fill/Match Rate = Matched Transactions ÷ Total Search-or-Listing Attempts (in the beachhead)
```

Also ask: of this period's matches, what share required the founder or staff to manually intervene
to make the match happen (direct outreach, manual pairing, ad-hoc subsidy) versus happening
organically through the platform mechanism itself? This is the operational signal for whether the
plan's cold-start story is actually resolving into self-sustaining liquidity or still running on
founder effort — the same "binding constraint side" concept `marketplace-liquidity-specialist`
evaluated on paper, now tracked as a real, trending percentage.

**Material →** fill rate trending down across 2+ periods, or the founder-manual-intervention share
is not decreasing as transaction volume grows (liquidity that only exists because the founder is
still personally making it happen isn't liquidity — it's a founder doing manual labor at
increasing scale). Tag `[LIQUIDITY-OPS]`. This is exactly the kind of finding that should also
inform `operations-manager`'s pivot-signal judgment if it persists across several periods — name
that explicitly in the review if it's trending that direction.

---

## `services` — delivery capacity and quality consistency

### 1. Utilization rate discipline

Ask the founder (and each delivery staff member/contractor, if beyond the founder): billable hours
delivered this period, and total available hours.

```
Utilization Rate = Billable Hours Delivered ÷ Total Available Hours
```

Use the same anchor `agents/council/services-unit-economics-reviewer.md` established at plan
stage — roughly 20-30 truly billable hours/week is a realistic ceiling for a solo operator once
sales, delivery-management, and admin time are accounted for, which against a nominal 40-hour week
puts a **sustainable utilization band around 50-75%**. State this as a planning-aid heuristic and
adjust explicitly for a business with real staff beyond the founder (their sustainable ceiling may
differ, especially without founder-level sales/admin overhead riding on the same hours).

- **Utilization sustained above ~85-90% for 2+ periods** is not efficiency to celebrate — it's a
  business with no slack for sales, quality review, or absorbing a bad week, and it is the direct
  operational cause of missed deadlines and quality slips before either shows up anywhere else.
- **Utilization above 100%** (delivered hours exceeding stated available hours) means commitments
  already exceed capacity — this is always material, not a trend to wait out.

### 2. When to add delivery staff vs. raise prices

A concrete decision framework, not a vibe — ask both questions before recommending either:

- **Utilization sustained >85% AND pipeline/demand is exceeding capacity** (qualified leads being
  turned away, or a booking backlog growing period over period) → **add delivery capacity**
  (hire/subcontract). Price increases alone don't solve a hard capacity ceiling when demand keeps
  outstripping supply regardless of price.
- **Utilization sustained >85% but demand is not overflowing** (fully booked, not turning away
  qualified work) → **raise prices first.** This expands margin and self-selects toward
  higher-value engagements without committing to fixed hiring cost ahead of confirmed demand —
  hiring ahead of demand that hasn't actually shown up is the more expensive, harder-to-reverse
  mistake of the two.
- **Utilization sustained below ~50%** → this is not a capacity problem at all. Don't recommend
  hiring or pricing moves to fix a demand gap — route the finding to `growth-analyst`/pipeline
  instead and say so plainly in the review.

**Material →** utilization sustained >90% for 2+ periods with growing backlog and no hiring plan in
motion (a live capacity ceiling with no response), or utilization already over 100%. Tag
`[CAPACITY]`.

### 3. Service-quality consistency across whoever's delivering

Once delivery involves more than the founder, quality can silently diverge by deliverer. Ask for
client satisfaction scores (or the founder's honest qualitative read, if no formal scoring exists)
broken out **per deliverer**, not just blended. Spot-check: does the founder actually sample-review
a percentage of engagements per deliverer per period, or is quality only checked when a client
complains?

**Material →** satisfaction-score variance across deliverers wide enough to suggest an inconsistent
delivery standard (name the specific deliverer, don't anonymize it away as "some clients are just
picky"), or no quality-review sampling process exists at all once a second deliverer is active. Tag
`[SERVICE-QUALITY]`.

---

## Cross-type: process documentation discipline

This applies regardless of `business_basics.business_type` whenever the team is more than the
founder alone (a hire, a contractor, a co-founder taking on an operational role).

**The rule: the moment a process has been executed successfully twice, write it down before doing
it a third time from memory.** Two successful runs is enough to know the steps are real and
repeatable; waiting for a "someday" documentation pass almost never happens, and the process stays
trapped in the founder's head exactly when the business most needs it not to be — the point growth
starts requiring someone besides the founder to execute it correctly without live supervision.

Ask the founder directly which processes have now been run twice or more without a written-down
version — prioritize anything operationally load-bearing per business type: reorder/reordering a
supplier (physical_product), a refund/return handling flow (physical_product), supply-side
onboarding or deactivation (marketplace), dispute resolution (marketplace), a service-delivery
checklist or client-onboarding sequence (services).

For each one flagged, either confirm a runbook exists (`ops/runbook-<process-slug>.md`) or record
that it doesn't. A runbook's minimum shape:

```markdown
# Runbook: <process name>
**Trigger:** <what starts this process>
**Owner:** <role, not necessarily "the founder">
**Steps:**
1. ...
**Inputs needed:** <accounts, tools, information>
**Exceptions / escalation:** <what to do when it doesn't go as planned, and who decides>
**Last validated:** <date>
```

**Material →** a load-bearing process (per the list above) has been run 2+ times, a second person
besides the founder is now executing operational work, and no runbook exists for it. This is
process debt that becomes a real operational risk exactly at the point a second person is relying
on tribal knowledge to do it right — tag `[PROCESS-DEBT]`. If the team is still solo-founder, note
it in the Watch List instead of `risk_log` — it's real but not yet material at that team size.

---

## Output file: `ops/operations-review-<timestamp>.md`

Timestamp format `YYYY-MM-DD`; suffix `-2`, `-3`... for a same-day rerun.

```markdown
# Operations & Fulfillment Review — <business name> — <date>

## Business type: <physical_product | marketplace | services>
<One line: which sections below applied, and cadence context — first review, or Nth, with trend
context from prior operations-review files.>

## physical_product: Inventory (if applicable)
| SKU | On-hand | Avg daily sales | Realized lead time | ROP | Safety stock | Days on hand | Status |
|---|---|---|---|---|---|---|---|

## physical_product: Supplier quality (if applicable)
| Supplier/SKU | Units received | Defect rate this shipment | 3-shipment trend | Dual-source status |
|---|---|---|---|---|

## physical_product: Fulfillment economics (if applicable)
<Actual cost-per-order this period, vs. the plan's implied fulfillment-cost figure, % drift,
whether this explains any LTV drift already tracked by operations-manager.>

## marketplace: Supply-side operations (if applicable)
<Onboarding/vetting activity, quality/trust metrics, deactivations and triggers.>

## marketplace: Liquidity operations (if applicable)
<Fill/match rate this period and trend, founder-manual-intervention share and trend.>

## services: Capacity (if applicable)
| Deliverer | Billable hours | Available hours | Utilization | Trend |
|---|---|---|---|---|
<Add-staff-vs-raise-prices read, per the decision framework, if utilization is out of band.>

## services: Quality consistency (if applicable)
<Satisfaction scores per deliverer, sampling process status.>

## Process documentation
<Which load-bearing processes have run 2+ times; runbook status for each; new risk_log entry if
material per the team-size gate above.>

## Risks logged this period
<List each new risk_log id + one-line description with its tag. "None this period" if genuinely
none — don't pad.>

## Watch list
<Real but not-yet-material trends — noted so the next review has the trend, not manufactured into
a risk_log entry before they're material.>

## Data gaps
<Anything the founder didn't have this period, named plainly.>
```

## Update `business-state.json`

Append `ops/operations-review-<timestamp>.md` to `ops.cadence_metrics_files` (don't duplicate prior
entries). Append any `risk_log` entries per the schema above. Preserve every other key untouched.
Update `updated_at`.

## Done means

- The business-type gate was checked first, and only the applicable section(s) ran.
- Every metric traces to a founder-reported number this period or an explicit "not tracked" —
  never a fabricated or estimated figure standing in for real data.
- Every materiality bar in this file was checked explicitly, not skipped because the founder seemed
  fine — a material finding gets a `risk_log` entry, not just review prose.
- `ops/operations-review-<timestamp>.md` is written and registered in `business-state.json`.
