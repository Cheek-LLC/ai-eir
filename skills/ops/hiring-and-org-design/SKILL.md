---
name: hiring-and-org-design
description: >
  Use whenever a founder asks "should I hire someone," "who should I hire first," "what should I
  pay/offer," "should this be a contractor or a full-time hire," "write a job description for
  ___," "help me interview for ___," or when `agents/ops/people-lead.md` determines a hiring
  decision is live during `stage: operating` (or a late `gtm` key hire). Runs the should-we-hire
  decision against real runway math (never in isolation from `skills/ops/runway-and-burn-tracking`
  since a hire is the single biggest lever on burn), sequences first hires by
  `business_basics.business_type`, sets a comp/equity band against `funding_intent` and stage, and
  produces a real draft job description plus a structured interview scorecard for the specific
  role — not generic hiring advice. Produces
  `ops/hiring-plan-<role>-<timestamp>.md`. Flags hiring-outpaces-runway as a `risk_log` entry.
---

# Hiring and Org Design

## What this skill is

A hire is a permanent step-change in burn, made once, that this business then has to earn back in
runway every month afterward. The single most common failure mode this skill exists to prevent is
a founder deciding to hire off enthusiasm or a sense that "we need help" without ever running the
number that actually matters: does this business still have a survivable runway after this
person's fully-loaded cost lands on it? The second most common failure mode is hiring the *wrong*
role first — a generalist "ops" hire when what the business actually needs is delivery capacity,
or supply-side liquidity, or a second engineer. This skill forces both questions before producing
anything, and its concrete deliverable is a real job description and interview scorecard, not a
memo of platitudes.

This is a planning aid, not licensed employment, HR, immigration, or legal advice — stated once
here, not repeated per section. Actual offer letters, equity grants, and employment agreements
need the founder's real lawyer and payroll/cap-table tooling; this skill drafts the plan and the
JD, it does not execute a legally binding hire.

## Reads

- `business-state.json`: `business_basics` (`business_type`, `business_type_notes`,
  `funding_intent`, `venture_stage`), `stage` (confirm `operating`, or a late-`gtm` key hire the
  founder is explicitly asking about), `cadence`, `risk_log` (open entries, so a hiring-outpaces-
  runway finding isn't duplicated), `key_assumptions`/`quantitative_claims` tagged step_ref 17/19
  (LTV/COCA — relevant context if the role being considered is revenue-generating, e.g. a sales
  hire whose ramp should plausibly move COCA/payback, not just add cost).
- The most recent `ops/*-finance-metrics.md` (from `skills/ops/runway-and-burn-tracking`) —
  **mandatory** before recommending a hire. If none exists or the most recent one is stale (more
  than one check-in cycle old, or before the last cadence date), say so plainly and either ask the
  founder for a fresh cash/burn read or hand back to `finance-controller` to produce one — never
  run the should-we-hire math against a runway figure you're not confident is current.
- `plan/18-map-the-sales-process-to-acquire-a-customer.md` (if the role under consideration is
  sales-related — is there actually a repeatable process for a hire to execute, or is the founder
  still improvising it) and `plan/24-develop-a-product-plan.md` (if the role is engineering —
  what's actually on the roadmap that needs the headcount).
- Any prior `ops/hiring-plan-*.md` files — so sequencing/comp guidance stays consistent with what
  was already decided, and so this run can note what's changed since the last one.

## Step 1: The "should we hire" decision

Before any role-specific work, force this decision explicitly. Ask the founder (or infer from the
context that triggered this skill) what the actual unmet need is, then run it through:

### 1a. Is this actually a full-time-hire problem?

| Option | Right when | Wrong when |
|---|---|---|
| **Founder keeps doing it** | The task is occasional, or founder capacity genuinely isn't yet the binding constraint on the business's core loop (check what `operations-manager`'s retros have flagged as the actual bottleneck) | Founder's own time on this task is measurably crowding out the thing only the founder can do (selling, product direction, fundraising) — ask what the founder stopped doing to keep doing this |
| **Contractor / freelancer** | The need is project-scoped, spiky, or time-boxed (a one-off build, a seasonal push, a specialized one-time deliverable) | The need is sustained and recurring — a contractor relationship re-negotiated indefinitely is usually a signal the role should be a hire |
| **Fractional / part-time specialist** | Senior expertise is needed but not at full-time volume yet (fractional CFO, fractional Head of Marketing, 1-2 days/week) — common bridge between "founder does it" and a full-time exec hire | The role needs daily, integrated judgment calls alongside the rest of the team, not periodic specialist input |
| **Agency / retainer** | The work is specialized and benefits from an outside team's tooling/scale (paid-media buying, recruiting search, PR) | The capability needs to become in-house institutional knowledge the business can't function without long-term |
| **Full-time hire** | The need is sustained, core to the business, and requires daily integration with the team — the only option that builds lasting institutional capability | The need could be met by any option above at lower fixed cost and lower runway risk |

State explicitly which option this lands on and why. Default to the option one step less
permanent than the founder's first instinct if the "sustained and core" test above isn't clearly
met — a hire is much easier to make than to unmake.

### 1b. The runway math — mandatory, not optional

A hire is the biggest single lever on burn this business has. Run this before recommending one,
using the latest `ops/*-finance-metrics.md` as the current-state baseline (see `skills/ops/
runway-and-burn-tracking` for the underlying runway formula and thresholds — this section applies
that formula to a *proposed* change, it doesn't redefine it):

```
Fully-loaded monthly cost of the hire =
  (annual base cash comp × fully-loaded multiplier) / 12
```

Fully-loaded multiplier: ask the founder for their real number if known (varies by geography and
benefits offered); if unknown, use **1.25-1.4x base cash comp** as a commonly-cited US benchmark
covering employer payroll tax, benefits, and basic tooling/equipment — state clearly this is a
planning estimate, not the founder's actual number, and flag it as such in the output file.

```
Post-hire monthized net burn = latest monthized net burn (from finance-metrics.md)
                                + fully-loaded monthly cost of the hire
                                − any credible monthly revenue contribution from the role
                                  (only for a role with a direct, near-term revenue line —
                                  e.g. a sales hire against a costed step-18 process; never
                                  assume revenue contribution for a role that doesn't have one)

Post-hire runway = cash on hand / post-hire monthized net burn
```

Classify the **post-hire** runway against the same thresholds `runway-and-burn-tracking` uses
(Critical < 3mo, Warning 3-6mo, Watch 6-9mo, Healthy ≥9mo or cash-generative):

- **Post-hire runway lands Critical:** Do not recommend proceeding, unless the founder names a
  specific, contractually-committed funding event closing before the new shorter runway runs out
  — name it explicitly in the output file if that's the basis for proceeding anyway. Otherwise
  this is a hold, stated plainly, not softened.
- **Post-hire runway lands Warning:** Flag explicitly — this can still be the right call (e.g. a
  revenue-generating hire expected to lift the top line within the runway window), but say so
  and name the evidence, don't let it read as routine.
- **Post-hire runway stays Watch or Healthy:** No runway-side objection; proceed to sequencing.

If the founder proceeds despite a Critical or Warning post-hire read, this skill's job is to make
that visible, not to block it — the founder's call, logged (Step 5 below).

## Step 2: First-hire sequencing by `business_basics.business_type`

There is a real, well-known pattern to what an early team needs first, and it is not the same
across business types. Don't give one generic answer — check `business_type` and apply the
matching pattern, then confirm against what `operations-manager`'s retros have actually shown as
the binding constraint (the pattern below is a prior, not a substitute for the business's own
evidence):

- **`saas`.** If the founding team isn't technical (or shipping velocity is the retro's named
  constraint), the first hire is usually an engineer, not a generalist. If the team is technical
  and `plan/18-*`'s sales process is defined and shows early repeatability but founder-led sales
  is capacity-constrained (a common inflection point somewhere in the range of the first several
  hundred thousand dollars of ARR — varies by deal size, not a fixed number), the first hire is
  usually a dedicated salesperson/AE executing that process, not a "Head of Growth." **Common
  mistake:** hiring a VP of Sales or Head of Growth before founder-led sales has actually proven
  the motion is repeatable — that role has nothing repeatable to scale yet and tends to spend its
  first two quarters rebuilding the process the founder should have validated first. Customer
  success/support typically comes next, once `customer-success-lead`'s retention data shows
  response time or quality slipping under current headcount — a concrete trigger, not a vibe.
- **`marketplace`.** The first hire almost always goes to the harder side of the market — check
  the plan's beachhead notes (steps 1-2) for which side (supply or demand) is scarcer in the
  chosen beachhead — as a liquidity-focused ops/growth role in that single beachhead, not a
  generalist "marketplace ops" title spread across both sides. Trust & safety/operations support
  (disputes, quality, chargebacks) comes once transaction volume creates real operational load,
  evidenced by growth-analyst's volume metrics. **Common mistake:** hiring to expand into a
  second geography/vertical before liquidity (repeat-transaction or fill rate) is actually proven
  in the first beachhead — that's spending headcount to widen an unproven motion instead of
  deepening a working one.
- **`services`.** Revenue here is capacity-constrained by delivery hours, so the first hire is
  almost always delivery/production staff — someone doing the billable work — triggered when the
  founder's own billable hours are the bottleneck (check `weekly-metrics-review`/`customer-
  success-lead` utilization data if it exists). **Common mistake:** hiring a dedicated
  salesperson before delivery capacity can absorb the demand it would generate — selling work the
  business can't yet deliver damages the relationships step 9's "next 10 customers" work built.
  A junior ops/admin hire (scheduling, invoicing) is usually justified later, only once the
  founder's own admin time is demonstrably cutting into billable or selling time — quantify it,
  don't assume it.
- **`physical_product`.** First hire is typically fulfillment/ops/supply-chain support once order
  volume exceeds what the founder can personally pack/ship/manage supplier relationships for.
  Automating or outsourcing fulfillment (a 3PL) is usually the right move *before* building an
  internal ops team, per standard DTC-operator practice. A demand-gen/marketing hire is justified
  once a channel is proven (acquisition cost within the step-19 target) and just needs scaling
  spend/volume — not while channel-market-fit is still being searched for, which is founder work.
- **`consumer_app`.** If the founding team is already technical, the first hire tends to be
  growth/marketing (a generalist growth hire or a performance-marketing specialist); if the team
  isn't technical, it's usually an engineer first. **Common mistake:** hiring a
  community/support role before there's a real active user base large enough to need one.
- **`other`.** No default pattern applies — ask the founder directly what the actual operational
  bottleneck is (cite the most recent retro's findings if one exists) rather than force-fitting
  one of the patterns above.

## Step 3: Comp and equity bands

Tie the recommendation to `funding_intent` and `venture_stage` — comp posture is genuinely
different by funding path, not a single universal number.

- **`bootstrap`:** Often no formal option pool or priced-equity reference point exists yet, so
  cash tends to be closer to market (constrained by what revenue/cash actually supports) rather
  than below-market-plus-equity. Where equity or profit-share is offered at all, it's frequently a
  simpler mechanism (a documented profit-share or phantom-equity arrangement) rather than a formal
  option grant — flag that this needs the founder's actual lawyer/cap-table setup before anything
  is promised in writing.
- **`raising_outside_capital`:** The standard, well-known early pattern is below-market cash paired
  with meaningful equity — this is normal, not a red flag, because it substitutes real upside for
  cash the business doesn't have to spend, and it's how most funded early hires are actually
  compensated. Commonly-cited benchmark bands for a priced-round-track company (these are
  reference ranges from widely-used startup-equity guides, not a formula — always state as a
  planning estimate, confirm against current market data before an offer goes out):

  | Role tier (non-founder) | Typical equity range (fully-diluted, pre-Series-A) | Vesting |
  |---|---|---|
  | Early engineer/hire #2-5 | 1-2% | 4-year vest, 1-year cliff (standard) |
  | Engineer/generalist hire #6-15 | 0.25-1% | 4-year vest, 1-year cliff |
  | First salesperson/AE | 0.1-0.5% (often paired with base + commission/OTE rather than a large equity weight — sales comp usually leans more cash-forward than engineering comp at the same seniority) | 4-year vest, 1-year cliff |
  | First "Head of"/VP-level hire | 0.5-2% | 4-year vest, 1-year cliff — but see the org-design section below on whether this title is even warranted yet |
  | C-level hire, Series A+ | 1-3% | 4-year vest, 1-year cliff |

  Cash: a commonly-cited early pattern is **roughly 60-85% of comparable late-stage/big-company
  market cash comp**, with the gap closing as the company matures and raises larger rounds.

- **When below-market cash stops being appropriate.** Once the company has a priced round with
  real comparable market data (typically post-Series A) and can sustainably pay closer to market,
  below-market cash without a clear, current equity narrative becomes a retention risk rather than
  a founder-friendly efficiency — flag this explicitly if `funding_intent`/stage signals the
  company has crossed that line but comp posture in this plan hasn't caught up.
- **`undecided`:** Present both postures (bootstrap-leaning and funded-leaning) and say plainly
  that the comp decision is downstream of a funding decision the founder hasn't made yet — don't
  guess which one applies.

State once, clearly: these are planning-reference bands, not a substitute for the founder's own
counsel, a real cap-table/equity tool, or current market-comp data for their specific role,
geography, and competitive set.

## Step 4: Draft job description and interview scorecard (the concrete deliverable)

Once Steps 1-3 support proceeding, ask the founder for the specific role, then produce both of the
following inside the output file — not generic hiring advice, an actual usable draft:

**Job description**, covering: role title; one-paragraph mission (why this role exists, tied to
the Step 2 sequencing rationale); 3-5 outcomes/KPIs this person owns in the first 6-12 months
(specific and measurable — e.g. "close $X in new ARR per quarter against the step-18 process," not
"drive sales"); must-have requirements (keep short — 3-5 real must-haves, not a wish list);
nice-to-haves (clearly separated so they don't become a false bar); comp range (per Step 3,
disclosed or not per the founder's preference, but always drafted so the founder has a real number
in hand); reporting line.

**Interview scorecard**, covering: 3-4 structured interview stages appropriate to the role (e.g.
screen, working session/case, team/culture fit, reference checks — tailor stage count and content
to seniority, don't force a 5-stage loop on a junior hire); for each stage, 2-3 named evaluation
criteria tied directly to the outcomes/KPIs above (not generic "culture fit" alone); a explicit
no-hire bar stated in advance ("no" on any must-have criterion is a no, regardless of how strong
other signals are — decide this before interviewing anyone, not while rationalizing a borderline
candidate after the fact).

## Step 5: Org design as the team grows

Separate from any single hiring decision, note where the business sits on these two common
early-stage org-design failure points, if headcount or the founder's own reporting load has grown
since the last hiring-plan file:

- **Manager layer.** A commonly-cited span-of-control guideline is that a single manager
  (including a founder) stops being effective somewhere around 7-10 direct reports doing
  meaningfully different work — beyond that, quality of oversight degrades, not just the
  manager's calendar. If the founder (or any current lead) is approaching or past that, flag it
  as the trigger to introduce a manager layer, not a fixed headcount number in isolation.
- **DRI (directly responsible individual) structure.** Every function should have one clearly
  named owner of decisions in that area, even pre-hire (the founder, by default). As headcount
  grows, check that this stays true explicitly — a common early-stage failure is two people
  informally sharing ownership of a function with no one actually accountable when it goes wrong.
- **Common mistake: hiring a VP/Head-of too early.** A senior leadership hire needs an existing
  function with real people or process to lead — hiring one ahead of that (a "VP of Sales" with
  no reps yet, a "Head of Product" with no other engineers) tends to produce a senior person
  re-doing the founder-validation work that should have happened first (see Step 2's saas
  example). Name this explicitly if a founder is considering a senior title before the team/
  process it would lead exists.
- **Common mistake: hiring a generalist "ops" title as the first hire regardless of business
  type.** Step 2's sequencing exists specifically because the generalist-ops default is usually
  wrong — check it names the actual bottleneck, not a catch-all title.

## Output file: `ops/hiring-plan-<role>-<timestamp>.md`

Timestamp format `YYYY-MM-DD`; `<role>` a short kebab-case slug (e.g. `first-engineer`,
`ae-1`); append `-2`, `-3`... for a same-day rerun on the same role.

```markdown
# Hiring Plan — <role> — <business name> — <date>

_This is a planning aid, not licensed employment, HR, immigration, or legal advice._

## Should-we-hire decision
Option selected (founder-continues / contractor / fractional / agency / full-time hire) and why.

## Runway math
| Input | Value | Source |
|---|---|---|
| Latest cash on hand | $... | ops/<date>-finance-metrics.md |
| Latest monthized net burn | $... | ops/<date>-finance-metrics.md |
| Fully-loaded monthly cost of this hire | $... | founder-reported base × <multiplier used> |
| Credible monthly revenue contribution (if any) | $... or "none assumed" | ... |
| Post-hire monthized net burn | $... | computed |
| Post-hire runway | N.N months | computed |
| Threshold classification (post-hire) | Critical/Warning/Watch/Healthy | per runway-and-burn-tracking thresholds |

## Sequencing rationale
<Which business-type pattern applies, and the evidence — retro data, plan step reference — that
this is actually the right next role, not just the default pattern.>

## Comp and equity
<Range recommended, tied to funding_intent/stage, cash/equity split, vesting terms, and the
"planning reference, not final" caveat.>

## Job description (draft)
<Full JD per Step 4.>

## Interview scorecard (draft)
<Full scorecard per Step 4, including the stated no-hire bar.>

## Org design notes
<Manager-layer / DRI / VP-too-early flags, if applicable this run — "none flagged" if not.>

## Risk flagged
<If post-hire runway is Critical or Warning and the founder is proceeding anyway, state it here
and reference the risk_log id. Otherwise "none.">
```

## Update `business-state.json`

Append the new file to `ops.cadence_metrics_files`. If post-hire runway lands **Critical**, or
lands **Warning** and the founder proceeds anyway, append a `risk_log` entry:

```json
{
  "id": "ops-<slug>-<sequential-number>",
  "type": "business",
  "raised_by": "people-lead",
  "description": "string — the role, the fully-loaded monthly cost, the post-hire runway figure and its threshold classification, and whether/why the founder is proceeding anyway",
  "status": "open"
}
```

Increment from the highest existing `ops-<slug>-*` id already in `risk_log`. Read-modify-write the
whole file; never set `status` to anything but `open` yourself; preserve every other key.

## Done means

- The should-we-hire decision (Step 1a) was actually made explicit, not assumed.
- Post-hire runway was computed against the *latest* finance-metrics figure, not a stale one, and
  classified against the same thresholds `runway-and-burn-tracking` uses.
- Sequencing recommendation cites the specific `business_type` pattern and the retro/plan evidence
  behind it, not a generic answer.
- Comp/equity guidance is tied to `funding_intent` and stated as a planning band, not a promise.
- A real, usable draft job description and interview scorecard exist for the specific role.
- `ops/hiring-plan-<role>-<timestamp>.md` is written and registered; a Critical/proceeded-Warning
  runway read has a `risk_log` entry.
