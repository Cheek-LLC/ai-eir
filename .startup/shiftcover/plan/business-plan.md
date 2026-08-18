# ShiftCover — Business Plan (v1)

*Planning aid produced with the 30-Minute Startup plugin. Not licensed financial, legal, or tax
advice — see Key Assumptions & Open Risks for what remains unvalidated.*

## Executive Summary

ShiftCover is a B2B SaaS tool that lets shift managers at multi-location QSR franchise groups
(10-50 units) text a qualified backup-worker pool the moment an hourly employee calls out sick,
replacing a manual phone/paper call list that currently takes 30-75 minutes to resolve. The
beachhead customer is a Director of Operations at a 10-50 unit franchise group (economic buyer),
serving a General Manager end user (Jordan Vasquez, the plan's persona) who has no budget
authority but lives the pain daily. The beachhead TAM is estimated at $118M/year (founder
estimate, unvalidated — see below); pricing is $129-149/location/month. Blended LTV is estimated
at $52,503 per signed group contract against a $3,213 COCA — a 16.3:1 ratio that this plan states
plainly should **not** be taken at face value: it is built entirely from a warm-network sales
channel that Step 9's own prospecting exercise showed tops out around 7-28 leads, with no paid or
cold-outbound channel tested yet. The single biggest open risk is that the entire quantified value
proposition (~$6,000/year per location) rests on an unmeasured 8-minute time-to-cover target — no
pilot has run. Venture stage: idea-only. Funding intent: not stated by the founder in any
conversation logged to date (`gtm.funding_strategy` remains `undecided`). What "done" looks like
next is not a funding ask — it is running the Step 22 MVBP pilot with the first converting Step 9
prospect and testing the two cheapest, highest-leverage open assumptions (the cross-location
backup-pool question, and the price point) directly.

## Confidence & Validation Status

*(Added as part of the QA remediation pass — see docs/QA-FINDINGS-ROUND2.md. This section is
required by docs/AI-RISK-FRAMEWORK.md and was missing from the original v1 draft; see risk_log
ar-shiftcover-001.)*

**Validated claims:** None. This is an idea-stage business (`business_basics.venture_stage:
idea_only`) with zero real customers, zero pilot usage, and zero measured funnel data. Every
figure in this plan is a founder estimate, a category benchmark, or a target — nothing here has
been confirmed by a signed contract, real usage data, or a completed assumption test.

**Unvalidated assumptions still open (27 total, full list in `business-state.json.key_assumptions`;
the 8 ranked highest-impact/highest-uncertainty are repeated here):**
1. `ka-008-target-unproven` — the 8-minute time-to-cover / 70% late-opening-reduction targets the
   entire value proposition rests on. Test plan: measure during the Step 22 MVBP pilot.
2. `ka-018-channel-scalability` / `ka-019-ratio-not-representative` — the 16.3:1 LTV:COCA ratio
   is a warm-network artifact. Test plan: run one real cold/paid outbound batch and compare COCA.
3. `ka-006-onboarding-adoption` — risk GMs revert to the paper call list. Test plan: track pilot
   usage logs directly.
4. `ka-onboarding-cross-location-pool` — will backup workers accept a shared cross-location pool.
   Test plan: ask directly in the next 10 backup-worker conversations (zero cost, not yet run).
5. `ka-016-price-point` — $149/location/month never stated to a real prospect. Test plan: state it
   in the next 5 real sales conversations.
6. `ka-017-churn` — 25-month expected lifetime is a category benchmark. Test plan: recompute from
   real cohort data once 6+ months exist.
7. `ka-012-franchisor-veto` — unconfirmed brand-level veto risk. Test plan: ask prospect #1 directly.
8. `ka-018-conversion` — every sales-funnel conversion rate is a projection. Test plan: recompute
   once 5+ real prospects have moved through the pipeline.

**AI-risk findings still open:**
- `ar-shiftcover-003` (advisory) — several headline figures ($52,503 LTV, $118M TAM, $70.8M
  follow-on TAM, $6,000/yr value proposition) are stated to more significant figures than their
  round, low-confidence inputs actually support. Read every such figure as an order-of-magnitude
  estimate, not a precise result.
- `ar-shiftcover-001` and `ar-shiftcover-002` (both raised against v1 of this plan) were resolved
  by this remediation pass — see their `status` in `business-state.json.risk_log` for the
  resolution note.

**What this plan is not:** This is a planning aid produced by an LLM working the Disciplined
Entrepreneurship framework, checked by a mechanical AI-risk gate and simulated expert-panel
personas. It is not licensed financial, legal, tax, or investment advice; passing the AI-risk gate
or a council review does not mean the business idea is good, that any cited source is correct, or
that the business will work. See `docs/AI-RISK-FRAMEWORK.md` for the full scope and limits of what
this plugin's review layers do and do not verify.

## 1. Who Is Your Customer?

**Market segmentation (Step 1)** considered 15 candidate segments across restaurant, retail,
healthcare, and services verticals sharing the same underlying shape (hourly shift, unplanned
call-out, need for fast qualified coverage). Five were carried forward for scoring.

**Beachhead (Step 2):** Multi-unit QSR franchise groups operating 10-50 units in a single U.S.
metro/region. Selected on reach and right-to-win (the founder's decade of direct QSR-operations
experience and existing peer network), scoring well above casual dining, convenience retail, home
health, and school-district substitute coverage (the last rejected specifically for entrenched
incumbents — SubFinder, Frontline — despite attractive raw size).

**End user profile (Step 3):** A General Manager or Shift Manager at one location within a 10-50
unit group — no budget authority, measured on labor-cost % and on-time-opening compliance,
currently relying on a paper call list and an ignored group text thread. **Research basis is
thin**: only 3 of the founder's 14 total conversations were with this actual end-user role (the
other 11 were peer Directors of Operations) — stated honestly, not smoothed over.

**Beachhead TAM (Step 4):** **$118M/year**, bottom-up (3,000 franchise groups × 22 locations/group
× $1,788/location/year), founder-estimated group count, no independent published source available.
**Note:** this figure has an unreconciled internal inconsistency with Step 16's pricing — see
Section 4 and Key Assumptions below.

**Persona (Step 5):** Jordan Vasquez, GM at a 14-unit chicken-sandwich franchise group in Fort
Worth, TX — a real interviewed individual (not a composite), representative of the still-thin
end-user research base above. Her stated pain: "By the time I get through my call list it's
already a crisis, not a fix."

## 2. What Can You Do For Your Customer?

**Full life cycle (Step 6):** The life cycle has a structural split baked in from stage one — the
person who feels the pain (the GM) is never the person who discovers, evaluates, or buys the
product (the Director of Ops); they only meet at onboarding. The single biggest drop-off risk
identified is exactly that onboarding moment: a GM burned before by corporate-mandated tools may
quietly revert to the paper call list, and the Director of Ops may not find out until renewal.

**Product spec (Step 7):** Must-have set: roster import (CSV from 7shifts/HotSchedules),
qualification/role tagging, SMS call-out broadcast, first-accept-wins claiming, manager dashboard,
multi-location account structure. Explicitly out of scope for v1: live API integrations, payroll,
predictive no-show scoring, and full schedule replacement — 7shifts/HotSchedules remain system of
record for the base schedule.

**Quantified value proposition (Step 8):** ~**$6,000/year per location** (manager time reclaimed
+ reduced late-opening risk), against a status-quo (not a named competitor) baseline of 45 minutes
average time-to-cover, 3 call-outs/week. **This figure rests entirely on an unproven founder
target** — an 8-minute time-to-cover goal and a 70% late-opening-incident reduction, neither
measured in a real pilot. Judged "marginal-to-sufficient" against the proposed price, explicitly
conditional on that target holding.

## 3. How Does Your Customer Acquire Your Product?

**Next 10 customers (Step 9):** 7 of 10 slots filled with real-shaped, named prospects and a
stated access path; 3 honestly left unfilled rather than padded. This is itself a finding: the
founder's warm network appears to run about 7 organizations deep, thinner than Step 2's "reach"
score of 5/5 implied — flagged for that score to be revisited.

**Core (Step 10):** The intended durable Core — a cross-location, qualification-matched
backup-labor reliability dataset that improves per-metro as more locations join — **does not exist
yet**. With zero real usage to date, this is a design bet, not an earned asset. The only real
advantage that exists today is the founder's personal network, which is a moat, not a Core, and is
replicable by a well-resourced competitor who hires comparable domain expertise.

**Competitive position (Step 11):** Axes chosen from persona priorities — speed of coverage vs.
cross-location reach. ShiftCover's targeted position (high on both) appears open relative to
7shifts/HotSchedules' native open-shift features, Sling, and Deputy — but **every non-status-quo
competitor position on this chart is estimated from general category familiarity, not verified**
(no direct product trial or web research was performed).

**How We Acquire a Paying Customer (Steps 12, 13 + 18 combined):** The DMU splits the End User
(GM, no budget authority) from the Primary Economic Buyer (Director of Operations, or
Owner/Operator for smaller groups), with a brand-dependent franchisor IT/brand-standards
veto-holder role whose applicability is not yet confirmed for any specific franchise brand. The
acquisition process (six stages: awareness → first conversation → champion/internal buy-in →
franchisor check → contract/pricing → signed) is estimated at **≈68 days** end to end with an
estimated **3.6% aware-to-signed conversion**, requiring roughly 28 "aware" leads to close one
customer at these assumed rates — **no real deal has closed yet, so every rate in this funnel is
a projection.** Steps 13 and 18 agree on the stage list (18 extends 13 directly, no disagreement
to flag). **Franchisor veto risk (Stage 4) and champion buy-in (Stage 3) are the two stages judged
most likely to be the longest and riskiest**, and neither is currently costed with any real data.

## 4. How Do You Make Money Off Your Product?

**Follow-on TAM (Step 14):** Pin 2 (multi-location casual-dining chains) estimated at
**$70.8M/year** (same unverified-founder-estimate method as Step 4). Pin 3 (convenience retail)
was **not sized** — the founder has no basis for an estimate there yet and this plan does not
force one. **The Step 4 beachhead TAM ($118M) and Pin 2 TAM ($70.8M) use compatible methodologies
and timeframes and could in principle be summed to a combined near-term addressable figure of
~$188.8M — this plan does not state that combined figure as fact**, because both group-count
inputs independently rest on unverified founder estimates; see Key Assumptions.

**Business model (Step 15):** Per-location monthly subscription, sold at the franchise-group
level via the Director of Operations — selected over usage-based, freemium, fee-for-service, and
marketplace/take-rate archetypes. The take-rate model was explicitly rejected partly on a real
wage-and-hour compliance concern the founder raised but that was not otherwise logged anywhere in
this plan until the Step 20 assumption sweep caught it (see Key Assumptions).

**Pricing (Step 16):** $149/location/month standard, $129/location/month volume tier (11+
locations) — **never stated out loud to a real prospect.**

**Unit economics — LTV, COCA, and the ratio (Steps 17 & 19), reconciled:**
- **LTV: $52,503 per signed group contract** (blended ARPU $2,838/month at the 22-location average
  group size and the $129 volume tier, 74% gross margin, 25-month expected lifetime from an
  assumed 4%/month churn — a category benchmark, not measured cohort data).
- **COCA: $3,213 per signed group contract** (built entirely from Step 18's founder-time-only cost
  buildup at an $85/hr placeholder rate; zero paid-marketing spend included, because none exists).
- **LTV:COCA ratio: ≈16.3:1. Payback period: ≈1.5 months.**
- **This plan states plainly that this ratio should not be read at face value.** It is an artifact
  of a warm-network-only acquisition channel that Step 9 already showed is limited to roughly
  7-28 leads. Once acquisition has to extend into paid or cold-outbound channels, COCA should be
  expected to rise substantially and this ratio should be expected to compress — no data exists
  yet on what that looks like. A 16.3:1 ratio built on two low-confidence, unmeasured inputs (LTV's
  churn/margin assumptions, COCA's founder-time-only cost base) is **provisional, not settled.**
- **Separately unreconciled:** Step 4's beachhead TAM used the flat $149/location/month rate for
  all locations, while the LTV calculation above correctly applies the $129 volume-tier rate that
  the 22-location average group actually qualifies for under Step 16's own pricing tiers. The TAM
  figure in Section 1 is therefore modestly overstated relative to the pricing framework this plan
  itself sets — not yet corrected, flagged here and in Key Assumptions rather than silently fixed.

## 5. How Do You Design and Build Your Product?

**Key assumptions (Step 20):** A 29-item register was swept from Steps 1-19 (existing entries plus
one newly-discovered gap — the wage-and-hour observation above). Eight were ranked as
"leap-of-faith" (high impact, high uncertainty): the unproven value-prop target, the
non-scalable warm-network COCA/ratio, GM onboarding adoption, the cross-location backup-pool
tolerance question, the untested price point, the churn/lifetime benchmark, the franchisor-veto
risk, and the untested sales-funnel conversion rates.

**Testing (Step 21):** All eight remain **deferred**, honestly — this is an idea-stage business
with no pilot live yet, not a failure of this step. One stands out as avoidable: the
cross-location-pool question requires no product and no budget to test and simply has not been
asked yet in a structured way. This is called out as the single highest-leverage, lowest-cost next
action available to the founder today.

**MVBP (Step 22):** A real, full-price pilot ($129-149/location/month, no discount) for one Step 9
prospect group, with manual (not self-serve) roster onboarding delivered personally by the
founder. Success is defined as 3 real call-outs covered within 30 days with the pilot GM reporting
the process felt faster than the old call list — a falsifiable bar, not a vibe check.

## 6. How Do You Scale Your Business?

**Dogs eating the dog food (Step 23):** **No usage evidence exists.** No MVBP customer has been
sold yet. This plan states that plainly rather than substituting founder enthusiasm or prospect
sentiment for real usage data.

**Product plan (Step 24):** The near-term roadmap is entirely gated on the MVBP shipping and the
cross-location-pool question being tested — nothing beyond the Step 7 Must-have set is prioritized
until real evidence exists. A previously-unflagged gap surfaced here: **no step in this plan
establishes who actually builds the product** — the founder's background is operations, not
engineering, and no technical co-founder or contractor has been identified anywhere in Steps 1-23.
Follow-on market work (Pin 2) is explicitly not triggered until the beachhead pipeline shows real
conversion and the tipped-staff incentive question is resolved with real casual-dining
conversations.

## Key Assumptions & Open Risks

**Leap-of-faith assumptions (ranked, from Step 20):**
1. `ka-008-target-unproven` — the 8-minute time-to-cover / 70% late-opening-reduction targets the
   entire value proposition rests on.
2. `ka-018-channel-scalability` / `ka-019-ratio-not-representative` — the headline 16.3:1
   LTV:COCA ratio is a warm-network artifact, not representative at scale.
3. `ka-006-onboarding-adoption` — risk that GMs revert to the paper call list.
4. `ka-onboarding-cross-location-pool` — will backup workers accept a shared cross-location pool;
   testable today at zero cost, not yet tested.
5. `ka-016-price-point` — $149/location/month never stated to a real prospect.
6. `ka-017-churn` — 25-month expected lifetime is a category benchmark, not this business's data.
7. `ka-012-franchisor-veto` — a single brand-level policy could kill deals wholesale; unconfirmed.
8. `ka-018-conversion` — every sales-funnel conversion rate is a projection; zero real deals have
   moved through it.

**All other logged assumptions** (research thinness on Steps 1-3, competitor positions unverified
on Step 11, TAM group-counts unverified on Steps 4/14, the newly-surfaced wage-and-hour note from
Step 15, the engineering-resourcing gap from Step 24, and others) are recorded in full in
`business-state.json.key_assumptions` — 27 entries total as of this version, none with a
`test_result` yet.

**Reconciliation flags:**
- Steps 13 and 18 agree on the acquisition-process stage list; no disagreement to report.
- Step 4 (beachhead TAM, $118M) and Step 14 (Pin 2 TAM, $70.8M) use compatible bottom-up methods
  and timeframes; not combined into a single headline figure in this plan because both inputs are
  independently unverified founder estimates.
- The LTV:COCA ratio (16.3:1) is computed and stated explicitly per the Data Contract's
  requirement, but flagged as **not representative** of unit economics beyond the current
  warm-network channel — see Section 4.
- **A separate, unreconciled figure mismatch**: Step 4's TAM used the standard $149/location/month
  rate uniformly; the LTV calculation (correctly) applies the $129 volume-tier rate the average
  beachhead group actually qualifies for. Step 4 has not been recomputed to match.

**Quantitative claims with `confidence: low` or `ai_risk_flag: true`:** all 7 entries in
`business-state.json.quantitative_claims` carry `ai_risk_flag: true` — the beachhead TAM, the
value-proposition delta, the follow-on TAM, the price point, the sales-cycle length, COCA, and the
LTV:COCA ratio. None has been independently verified beyond founder estimate/judgment.

**`risk_log`:** empty as of this plan version — no AI-risk or privacy gate has been run against
this artifact yet (see the QA findings document for what that gate found when it was run).

## Appendix

### Step 1 — Market Segmentation
See `plan/01-market-segmentation.md`. 15 candidate segments generated across restaurant, retail,
healthcare, and services verticals; 5 shortlisted (QSR franchise groups, casual dining,
convenience retail, home health, school districts) for Step 2 scoring.

### Step 2 — Select a Beachhead Market
See `plan/02-select-a-beachhead-market.md`. QSR franchise groups (10-50 units) selected, scoring
37/40 vs. 28/40 (casual dining) and 17-21/40 for the other three candidates — driven by reach and
right-to-win specifically, both scored on the founder's direct network and domain background.

### Step 3 — Build an End User Profile
See `plan/03-build-an-end-user-profile.md`. GM/shift manager profile built from only 3 real
end-user conversations (out of 14 total, the rest being peer Directors of Operations) — stated as
thin research, not papered over.

### Step 4 — Calculate the TAM for the Beachhead Market
See `plan/04-calculate-the-tam-for-the-beachhead-market.md`. $118M/year bottom-up, no top-down
cross-check available, founder-estimated group count flagged low confidence.

### Step 5 — Profile the Persona for the Beachhead Market
See `plan/05-profile-the-persona-for-the-beachhead-market.md`. Jordan Vasquez, real interviewed
GM, 14-unit group, Fort Worth TX.

### Step 6 — Full Life Cycle Use Case
See `plan/06-full-life-cycle-use-case.md`. 8 stages mapped; biggest drop-off risk is onboarding,
where buyer (Director of Ops) and user (GM) experience the product for the first time separately.

### Step 7 — High-Level Product Specification
See `plan/07-high-level-product-specification.md`. 6 Must-have capabilities traced to FLCUC
stages; live API integrations, payroll, and predictive scoring explicitly out of scope for v1.

### Step 8 — Quantify the Value Proposition
See `plan/08-quantify-the-value-proposition.md`. ~$6,000/year/location, resting on an unproven
8-minute target and 70% late-opening reduction estimate.

### Step 9 — Identify Your Next 10 Customers
See `plan/09-identify-your-next-10-customers.md`. 7 of 10 real-shaped named prospects identified
honestly; 3 slots left unfilled.

### Step 10 — Define Your Core
See `plan/10-define-your-core.md`. Intended Core (cross-location reliability data) does not exist
yet; current real advantage is founder network (a moat, not a Core).

### Step 11 — Chart Your Competitive Position
See `plan/11-chart-your-competitive-position.md`. Axes: speed of coverage vs. cross-location
reach; all competitor positions estimated, not independently verified this session.

### Step 12 — Determine the DMU
See `plan/12-determine-the-dmu.md`. End user (GM) ≠ economic buyer (Director of Ops); brand-
dependent franchisor veto risk unconfirmed.

### Step 13 — Map the Process to Acquire a Paying Customer
See `plan/13-map-the-process-to-acquire-a-paying-customer.md`. 6-stage qualitative map; riskiest
stages are champion buy-in and the franchisor check.

### Step 14 — Calculate the TAM for Follow-on Markets
See `plan/14-calculate-the-tam-for-follow-on-markets.md`. Pin 2 (casual dining) $70.8M/yr; Pin 3
(convenience retail) not sized.

### Step 15 — Design a Business Model
See `plan/15-design-a-business-model.md`. Per-location subscription selected; take-rate model
rejected partly on an unlogged (until Step 20) wage-and-hour compliance concern.

### Step 16 — Set Your Pricing Framework
See `plan/16-set-your-pricing-framework.md`. $149/$129 per-location tiers, untested with any real
prospect.

### Step 17 — Calculate the LTV of a Customer
See `plan/17-calculate-the-ltv-of-a-customer.md`. $52,503/customer blended LTV; flags an
unreconciled Step 4 pricing mismatch.

### Step 18 — Map the Sales Process to Acquire a Customer
See `plan/18-map-the-sales-process-to-acquire-a-customer.md`. ~68-day cycle, 3.6% conversion,
~37.8 founder-hours per closed customer — entirely warm-network-sourced.

### Step 19 — Calculate the COCA
See `plan/19-calculate-the-coca.md`. $3,213 COCA, 16.3:1 LTV:COCA ratio flagged as not
representative of acquisition at scale.

### Step 20 — Identify Key Assumptions
See `plan/20-identify-key-assumptions.md`. 29-item register; 8 ranked leap-of-faith items; 1
newly-discovered gap (wage-and-hour note) surfaced during the sweep.

### Step 21 — Test Key Assumptions
See `plan/21-test-key-assumptions.md`. All 8 leap-of-faith items deferred; cross-location-pool
question flagged as testable today at zero cost and not yet tested.

### Step 22 — Define the MVBP
See `plan/22-define-the-mvbp.md`. Full-price pilot, manual onboarding, 3-covered-call-outs-in-30-
days success bar.

### Step 23 — Show That the Dogs Will Eat the Dog Food
See `plan/23-show-that-dogs-will-eat-the-dog-food.md`. No usage evidence exists — no MVBP customer
sold yet.

### Step 24 — Develop a Product Plan
See `plan/24-develop-a-product-plan.md`. Roadmap gated on MVBP + cross-location-pool test;
surfaces an unresolved engineering-resourcing gap spanning the entire plan.
