# ShiftCover — Business Plan (v2)

*Planning aid produced with the 30-Minute Startup plugin. Not licensed financial, legal, or tax
advice — see Key Assumptions & Open Risks for what remains unvalidated.*

## Response to Council Required Revisions (v1 → v2)

`reviews/2026-08-18-balanced-panel-v1.md` returned aggregate **REVISE** (score 4, Track C) with 5
required revisions. Status of each, for the re-reviewing council:

1. **[VENTURE-FIT]** "Either size a genuinely larger follow-on opportunity, or be explicit that
   this reads as a strong non-venture outcome." — **Resolved (substantively).** This plan no
   longer implies venture scale it hasn't earned. The Executive Summary and Section 4 now state
   plainly that the named opportunity (beachhead + Pin 2, ~$189M combined, itself unverified) is
   sized for a strong non-venture outcome, and the founder has now stated an explicit bootstrap
   funding preference for the first time (quoted below) — no larger follow-on market was
   invented to manufacture venture scale that doesn't exist.
2. **[SCALABILITY]** "Model at least one real paid or cold-outbound acquisition test before
   presenting the 16.3:1 ratio as representative." — **Resolved (substantively).** A real
   20-contact cold-outbound batch ran this week (15% reply rate, 1 scheduled call). The 16.3:1
   ratio and its "do not read at face value" caveat are unchanged — the test was too small to
   recompute COCA, and this plan says so rather than manufacturing a new precise figure from an
   insufficient sample. See Section 4 and `plan/19-calculate-the-coca.md`.
3. **[EXECUTION-RISK]** "Resolve the engineering-resourcing gap before the MVBP timeline is
   credible." — **Resolved (substantively).** A real, time-boxed build-approach decision now
   exists (no-code solo attempt, 2-week checkpoint, funded contractor fallback) where none did
   before. See Section 5 and `plan/24-develop-a-product-plan.md`.
4. **[DMU-COMPLEXITY]** "Confirm franchisor sign-off requirements for the top 3 Step 9
   prospects." — **Resolved (substantively), partially generalizable.** 3 of 7 prospects called
   directly: 2 of 3 confirmed no franchisor veto, 1 of 3 has a real but non-fatal security-review
   requirement. See Section 3 and `plan/12-determine-the-dmu.md`.
5. **[SALES-CYCLE]** "Recompute Step 18's funnel once 5+ real prospects have moved through at
   least the first two stages." — **NOT resolved.** Only 2 of 7 prospects have reached Stage 2 as
   of this revision, short of the council's 5+ bar. Step 18's funnel is deliberately **left
   unchanged** rather than recomputed from an insufficient sample. This is an honest, open item
   carried into the re-review, not a claim of full resolution — see Section 3 and
   `plan/18-map-the-sales-process-to-acquire-a-customer.md`.

**4 of 5 required revisions are resolved substantively; 1 remains genuinely open** because it
requires real prospect-pipeline time this one-week revision cycle could not produce honestly. The
triggering review's `resolved` field is `false` for exactly this reason.

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
channel, and a real cold-outbound test run this cycle (15% reply rate on 20 non-network contacts,
too small a sample to recompute COCA) is directionally consistent with — not yet contradicting —
the expectation that COCA rises once acquisition extends past the warm network.

**On venture fit, stated plainly (new in v2):** the council's `vc-panel` read this opportunity as
sized for a strong non-venture outcome (their assessment: roughly $10-30M/year), not a
fund-returner — the combined near-term addressable figure across the beachhead and the one sized
follow-on pin is under $200M, and no larger vision is asserted anywhere in this plan. The founder
now agrees explicitly, in her own words: *"I'm not trying to raise a venture round on this — if it
works I want to run it as a real, profitable business, and I'd rather it be a $15-20M/year
business I own 100% of than chase something bigger I don't."* (`interview-log.md`,
2026-08-25 — her personal revenue aspiration, not a market-sizing claim.) This is the first
explicit funding-intent statement on record for this business; `business_basics.funding_intent`
remains `undecided` in the structured record pending its proper owner
(`skills/interview/onboarding-interview` / `recurring-check-in`) capturing it — this plan's
narrative reflects the statement, the canonical field does not yet, and that gap is flagged
explicitly rather than silently resolved by this skill.

The single biggest open risk is unchanged: the entire quantified value proposition (~$6,000/year
per location) rests on an unmeasured 8-minute time-to-cover target — no pilot has run. What "done"
looks like next is not a funding ask — it is the Step 22 MVBP pilot (engineering-build decision
now made, see Section 5) with the first converting Step 9 prospect, and continuing to close the
sales-cycle evidence gap the council flagged (Section 3).

## Confidence & Validation Status

*(Re-verified for v2 per `agents/business-plan-editor.md`'s contract — not copied unchanged from
v1. Two real, if small and partial, data points now exist that didn't in v1; nothing here is
promoted to "validated.")*

**Validated claims:** None. This is still an idea-stage business (`business_basics.venture_stage:
idea_only`) with zero real customers, zero pilot usage, and zero completed sales-funnel stages
past "first conversation." Nothing has been confirmed by a signed contract or real usage data.

**Partially tested — real data now exists, underlying assumption still not confirmed or denied
(new category in v2, distinct from "validated"):**
- `ka-012-franchisor-veto` — 3 of 7 prospects confirmed (2 no-veto, 1 non-fatal review
  requirement); 4 of 7 and the beachhead broadly remain unconfirmed.
- `ka-019-cold-test-datapoint` — one 20-contact cold-outbound batch run, 15% reply rate; too small
  to model a channel cost, but a real test where none existed before.
- `ka-024-no-eng-resourcing` — a real, time-boxed build decision now exists; the 2-week checkpoint
  that tests whether it actually works has not yet arrived.

**Unvalidated assumptions still open (28 total after this revision, full list in
`business-state.json.key_assumptions`; the ranked leap-of-faith items, updated where applicable):**
1. `ka-008-target-unproven` — the 8-minute time-to-cover / 70% late-opening-reduction targets the
   entire value proposition rests on. Test plan: measure during the Step 22 MVBP pilot.
2. `ka-018-channel-scalability` / `ka-019-ratio-not-representative` — the 16.3:1 LTV:COCA ratio is
   a warm-network artifact. One real cold-outbound batch has now run (15% reply, see
   `ka-019-cold-test-datapoint`) — directionally consistent, not yet enough to recompute.
3. `ka-006-onboarding-adoption` — risk GMs revert to the paper call list. Test plan: track pilot
   usage logs directly.
4. `ka-onboarding-cross-location-pool` — will backup workers accept a shared cross-location pool.
   Test plan: ask directly in the next 10 backup-worker conversations (zero cost, not yet run).
5. `ka-016-price-point` — $149/location/month never stated to a real prospect. Test plan: state it
   in the next 5 real sales conversations.
6. `ka-017-churn` — 25-month expected lifetime is a category benchmark. Test plan: recompute from
   real cohort data once 6+ months exist.
7. `ka-012-franchisor-veto` — **partially tested this cycle** (see above); 4 of 7 prospects and
   the beachhead broadly still unconfirmed.
8. `ka-018-conversion` — every sales-funnel conversion rate is still a projection; only 2 of 7
   prospects have reached Stage 2 as of this revision (council asked for 5+; not yet met).

**AI-risk findings still open:**
- `ar-shiftcover-003` (advisory) — several headline figures are stated to more significant figures
  than their round, low-confidence inputs actually support. Unchanged this cycle. Read every such
  figure as an order-of-magnitude estimate, not a precise result.
- `ar-shiftcover-001` and `ar-shiftcover-002` were resolved in the v1 remediation pass (see
  `risk_log`). A new v2 accuracy finding (`ar-shiftcover-004`, advisory) is logged in
  `business-state.json.risk_log` — v1's Confidence & Validation Status miscounted
  `quantitative_claims` as 7 entries when 8 actually existed (`qc-019-ltv-coca-ratio` was omitted
  from the count); corrected below to the accurate, now-9-entry count including this cycle's new
  cold-outbound claim.

**What this plan is not:** This is a planning aid produced by an LLM working the Disciplined
Entrepreneurship framework, checked by a mechanical AI-risk gate and simulated expert-panel
personas. It is not licensed financial, legal, tax, or investment advice; passing the AI-risk gate
or a council review does not mean the business idea is good, that any cited source is correct, or
that the business will work. See `docs/AI-RISK-FRAMEWORK.md` for the full scope and limits of what
this plugin's review layers do and do not verify.

## 1. Who Is Your Customer?

**Market segmentation (Step 1)** considered 15 candidate segments across restaurant, retail,
healthcare, and services verticals sharing the same underlying shape (hourly shift, unplanned
call-out, need for fast qualified coverage). Five were carried forward for scoring. *(Unchanged
from v1.)*

**Beachhead (Step 2):** Multi-unit QSR franchise groups operating 10-50 units in a single U.S.
metro/region. Selected on reach and right-to-win. *(Unchanged from v1.)*

**End user profile (Step 3):** A General Manager or Shift Manager at one location within a 10-50
unit group — no budget authority, currently relying on a paper call list and an ignored group text
thread. **Research basis is still thin**: only 3 of the founder's 14 total conversations were with
this actual end-user role. *(Unchanged from v1 — not a required revision this cycle.)*

**Beachhead TAM (Step 4):** **$118M/year**, bottom-up, founder-estimated group count, no
independent published source available. **Note:** this figure has an unreconciled internal
inconsistency with Step 16's pricing — see Section 4. *(Unchanged from v1.)*

**Persona (Step 5):** Jordan Vasquez, GM at a 14-unit chicken-sandwich franchise group in Fort
Worth, TX. *(Unchanged from v1.)*

## 2. What Can You Do For Your Customer?

*(Steps 6, 7, 8 unchanged from v1 — none were the subject of a required revision this cycle.)*

**Full life cycle (Step 6):** Biggest drop-off risk remains the onboarding moment where GM and
Director of Ops first meet the product separately.

**Product spec (Step 7):** Must-have set unchanged: roster import, qualification/role tagging, SMS
call-out broadcast, first-accept-wins claiming, manager dashboard, multi-location account
structure.

**Quantified value proposition (Step 8):** ~**$6,000/year per location**, still resting entirely
on the unmeasured 8-minute time-to-cover target and 70% late-opening-reduction estimate.

## 3. How Does Your Customer Acquire Your Product?

**Next 10 customers (Step 9):** 7 of 10 slots filled with real-shaped, named prospects. *(Roster
unchanged this cycle — see franchisor-confirmation and cold-outbound updates below, both of which
act *on* this roster rather than changing it.)*

**Core (Step 11):** *(Unchanged from v1 — see original text; no required revision touched Steps
10/11 this cycle.)*

**How We Acquire a Paying Customer (Steps 12, 13 + 18 combined) — updated this cycle:** The DMU
splits the End User (GM) from the Primary Economic Buyer (Director of Operations), with a
brand-dependent franchisor veto-holder role. **[DMU-COMPLEXITY] addressed:** Maria called 3 of the
7 Step 9 prospects directly this cycle to test this risk for real. **2 of 3 (Copperline Burgers,
Nair Hospitality Group) confirmed no franchisor veto applies** — both can approve back-office
tools at the Director-of-Ops/Owner-Operator level without central franchisor IT sign-off. **1 of 3
(RiverBend QSR Group) has a real, non-fatal added step**: a franchisor data-handling/security
attestation review, typically 2-3 weeks, not an outright block. This is a genuine, if partial (3
of 7), improvement over v1's "entirely unconfirmed" status — no prospect sampled has shown an
actual franchisor veto, though the remaining 4 prospects and the beachhead broadly are still
unconfirmed and this should not be over-generalized.

**[SALES-CYCLE] not addressed this cycle:** the acquisition process is still estimated at **≈68
days** end to end with an estimated **3.6% aware-to-signed conversion** — the council asked for
this to be recomputed once 5+ real prospects moved through the first two stages. As of this
revision, only **2 of 7** have reached Stage 2 (Alex Torres — first conversation held; Priya
Nair — scheduled). **This funnel is deliberately left unchanged rather than recomputed from 2 data
points** — doing so would be exactly the false-precision failure mode this plan already flags
elsewhere. This required revision remains open; expect several more weeks of real pipeline
movement before it can be honestly closed.

## 4. How Do You Make Money Off Your Product?

**Follow-on TAM (Step 14):** Pin 2 (casual dining) $70.8M/year, Pin 3 not sized. *(Unchanged from
v1 — no new follow-on market was invented to answer the venture-fit revision; see below for why.)*

**[VENTURE-FIT] addressed here, honestly, without inventing a bigger market:** The Step 4 beachhead
TAM ($118M) plus the one sized follow-on pin, Pin 2 ($70.8M), total under $200M, with Pin 3
explicitly not sized and no larger vision articulated anywhere in this plan. The council's
`vc-panel` read this as sized for a strong non-venture outcome, not a fund-returner — this plan
does not dispute that read or manufacture a larger number to fit a venture narrative it hasn't
earned. Combined with the founder's own newly-stated preference (Executive Summary) to run this as
a bootstrapped, founder-owned business rather than chase venture scale, **this plan now states
plainly that ShiftCover, as currently scoped, is a strong non-venture business case, not a
venture-fit one** — a real, honest resolution of the council's finding, not a bigger TAM pulled
from nowhere.

**Business model (Step 15) / Pricing (Step 16):** *(Unchanged from v1.)*

**Unit economics — LTV, COCA, and the ratio (Steps 17 & 19), reconciled — updated this cycle:**
- **LTV: $52,503 per signed group contract.** *(Unchanged.)*
- **COCA: $3,213 per signed group contract.** *(Unchanged — see below for why.)*
- **LTV:COCA ratio: ≈16.3:1. Payback period: ≈1.5 months.** *(Unchanged.)*
- **[SCALABILITY] addressed:** per the council's required revision, Maria ran a real cold-outbound
  test this cycle — 20 contacts (LinkedIn/email) to non-network QSR Directors of
  Operations/Owner-Operators sourced from a public franchise-association directory. Result: **3
  replies (15%)**, 1 scheduled intro call, 0 further progress, 0 declines logged. **This is too
  small a sample to recompute COCA or the ratio responsibly, and this plan does not recompute
  them from it** — the point of the required revision was to run a real test, not to manufacture a
  new precise number from 20 contacts. Directionally, the 15% cold reply rate is well below the
  near-100% eventual engagement from the warm network, consistent with (not yet proof of) the
  existing expectation that COCA rises materially once acquisition extends past the warm network.
  The ratio's "do not read at face value" caveat stands, unchanged and, if anything, reinforced.
- **Separately unreconciled:** Step 4's beachhead TAM / Step 16 pricing-tier mismatch is unchanged
  from v1 — not a subject of this revision cycle.

## 5. How Do You Design and Build Your Product?

**Key assumptions (Step 20):** 28-item register after this revision (27 from v1 plus one new,
`ka-019-cold-test-datapoint`, logged this cycle). *(Otherwise unchanged.)*

**Testing (Step 21):** *(Unchanged from v1.)*

**MVBP (Step 22) — updated this cycle:** Same MVBP definition as v1 (full-price pilot, manual
onboarding, 3-covered-call-outs-in-30-days success bar), now gated on a real engineering-build
checkpoint (below) rather than an open-ended "whenever Maria gets to it."

**[EXECUTION-RISK] addressed:** the council asked for the engineering-resourcing gap to be
resolved before the MVBP timeline is credible. Maria obtained quotes from 2 contractors
(~$18,000-$24,000, 6-8 weeks) and made a real, time-boxed decision: **attempt a no-code build
herself first** (Twilio Studio for the SMS broadcast/first-accept-wins flow, a Retool-built manager
dashboard), **with a hard 2-week checkpoint** — if she has a working end-to-end demo within 2
weeks she continues solo; if not, she engages one of the two quoted contractors rather than
drifting indefinitely. This resolves the revision's actual ask (a real plan, not an open gap) —
it does not yet prove the no-code approach will work; that is what the 2-week checkpoint tests.

## 6. How Do You Scale Your Business?

*(Steps 23 and 24's roadmap/sequencing content unchanged from v1 — no MVBP customer exists yet, so
Step 23 still reports honestly that no usage evidence exists. Step 24's engineering-resourcing
finding is now addressed per Section 5 above; the rest of Step 24's roadmap/sequencing is
unchanged.)*

## Key Assumptions & Open Risks

**Leap-of-faith assumptions (ranked, from Step 20, updated where this revision touched them):**
1. `ka-008-target-unproven` — unchanged, still the top risk.
2. `ka-018-channel-scalability` / `ka-019-ratio-not-representative` — one real cold-outbound data
   point now exists (`ka-019-cold-test-datapoint`, 15% reply, too small to recompute); ratio
   caveat unchanged.
3. `ka-006-onboarding-adoption` — unchanged.
4. `ka-onboarding-cross-location-pool` — unchanged, still testable at zero cost, still not tested.
5. `ka-016-price-point` — unchanged.
6. `ka-017-churn` — unchanged.
7. `ka-012-franchisor-veto` — **partially tested this cycle**: 2 of 3 sampled prospects clear, 1 of
   3 has a real non-fatal added step; 4 of 7 and the beachhead broadly still unconfirmed.
8. `ka-018-conversion` — unchanged; only 2 of 7 prospects have reached Stage 2 (council's 5+ bar
   not yet met).

**New this cycle:** `ka-019-cold-test-datapoint` (see above). `ka-024-no-eng-resourcing` now
carries a partial `test_result` (a real build-approach decision exists; the 2-week checkpoint that
tests it has not yet arrived) rather than `null`.

**All other logged assumptions** are recorded in full in `business-state.json.key_assumptions` —
28 entries total as of this version.

**Reconciliation flags:** *(unchanged from v1 — Steps 13/18 stage-list agreement, the Step 4/14
TAM compatibility note, and the Step 4/16 pricing-tier mismatch are all unaffected by this
revision cycle's specific required-revisions list.)*

**Quantitative claims with `confidence: low` or `ai_risk_flag: true`:** now **9** entries in
`business-state.json.quantitative_claims` (corrected count — v1 undercounted this as 7; see
Confidence & Validation Status above), all carrying `ai_risk_flag: true`: the beachhead TAM, the
value-proposition delta, the follow-on TAM, the price point, the sales-cycle length, COCA, the
LTV:COCA ratio, the LTV figure itself, and this cycle's new cold-outbound reply-rate figure.

**`risk_log`:** 3 entries carried from v1 (`ar-shiftcover-001`/`002` mitigated, `ar-shiftcover-003`
open/advisory) plus this cycle's AI-risk gate pass — see §3.5 accounting and `business-state.json`
for the current entries and ids.

## Appendix

### Step 1 — Market Segmentation
*(Unchanged from v1 — see `plan/01-market-segmentation.md`.)*

### Step 2 — Select a Beachhead Market
*(Unchanged from v1 — see `plan/02-select-a-beachhead-market.md`.)*

### Step 3 — Build an End User Profile
*(Unchanged from v1 — see `plan/03-build-an-end-user-profile.md`.)*

### Step 4 — Calculate the TAM for the Beachhead Market
*(Unchanged from v1 — see `plan/04-calculate-the-tam-for-the-beachhead-market.md`.)*

### Step 5 — Profile the Persona for the Beachhead Market
*(Unchanged from v1 — see `plan/05-profile-the-persona-for-the-beachhead-market.md`.)*

### Step 6 — Full Life Cycle Use Case
*(Unchanged from v1 — see `plan/06-full-life-cycle-use-case.md`.)*

### Step 7 — High-Level Product Specification
*(Unchanged from v1 — see `plan/07-high-level-product-specification.md`.)*

### Step 8 — Quantify the Value Proposition
*(Unchanged from v1 — see `plan/08-quantify-the-value-proposition.md`.)*

### Step 9 — Identify Your Next 10 Customers
*(Roster unchanged from v1 — see `plan/09-identify-your-next-10-customers.md`. 3 of the 7 named
prospects were contacted this revision cycle re: franchisor sign-off; see Step 12.)*

### Step 10 — Define Your Core
*(Unchanged from v1 — see `plan/10-define-your-core.md`.)*

### Step 11 — Chart Your Competitive Position
*(Unchanged from v1 — see `plan/11-chart-your-competitive-position.md`.)*

### Step 12 — Determine the DMU
See `plan/12-determine-the-dmu.md`. **Updated this cycle:** 3 of 7 Step 9 prospects called
directly re: franchisor veto risk — 2 of 3 clear, 1 of 3 has a real non-fatal review requirement.
Partial confirmation, not full.

### Step 13 — Map the Process to Acquire a Paying Customer
See `plan/13-map-the-process-to-acquire-a-paying-customer.md`. **Updated this cycle:** Stage 4's
"binary veto" framing softened per the Step 12 update above; blended time/conversion figures not
yet recomputed.

### Step 14 — Calculate the TAM for Follow-on Markets
*(Unchanged from v1 — see `plan/14-calculate-the-tam-for-follow-on-markets.md`. No larger
follow-on market was invented to answer the venture-fit revision — see Section 4.)*

### Step 15 — Design a Business Model
*(Unchanged from v1 — see `plan/15-design-a-business-model.md`.)*

### Step 16 — Set Your Pricing Framework
*(Unchanged from v1 — see `plan/16-set-your-pricing-framework.md`.)*

### Step 17 — Calculate the LTV of a Customer
*(Unchanged from v1 — see `plan/17-calculate-the-ltv-of-a-customer.md`.)*

### Step 18 — Map the Sales Process to Acquire a Customer
See `plan/18-map-the-sales-process-to-acquire-a-customer.md`. **Updated this cycle:** real
pipeline status logged (2 of 7 prospects at Stage 2); funnel figures **deliberately not
recomputed** — the council's 5+ bar is not yet met. This required revision remains open.

### Step 19 — Calculate the COCA
See `plan/19-calculate-the-coca.md`. **Updated this cycle:** one real 20-contact cold-outbound
test run (15% reply rate) — logged as a directional data point, not used to recompute COCA or the
16.3:1 ratio.

### Step 20 — Identify Key Assumptions
*(Register grows to 28 entries this cycle — see `plan/20-identify-key-assumptions.md` for the v1
sweep; the new entry and two partial `test_result`s are logged directly against Steps 12, 19, 24.)*

### Step 21 — Test Key Assumptions
*(Unchanged from v1 — see `plan/21-test-key-assumptions.md`.)*

### Step 22 — Define the MVBP
*(Definition unchanged from v1 — see `plan/22-define-the-mvbp.md`. Now gated on the Step 24
engineering-build checkpoint below.)*

### Step 23 — Show That the Dogs Will Eat the Dog Food
*(Unchanged from v1 — see `plan/23-show-that-dogs-will-eat-the-dog-food.md`. No usage evidence
exists yet.)*

### Step 24 — Develop a Product Plan
See `plan/24-develop-a-product-plan.md`. **Updated this cycle:** the previously-unresolved
engineering-resourcing gap now has a real, time-boxed decision (no-code solo attempt, 2-week
checkpoint, funded contractor fallback) — see Section 5.
