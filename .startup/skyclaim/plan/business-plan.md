# SkyClaim — Business Plan (v1)

*Assembled from 24 Disciplined Entrepreneurship step files. This is a planning aid produced with
AI assistance grounded in the founder's own stated facts — it is not licensed financial, legal, or
investment advice, and it does not represent validation from a real investor, customer, or
regulatory body. See the Confidence & Validation Status section below and
`docs/AI-RISK-FRAMEWORK.md` for what this document does and does not verify.*

## Executive Summary

SkyClaim is a two-sided marketplace connecting FAA Part 107-certified drone pilots with
storm-damage insurance-claim roofing contractors across the TX/OK Hail Alley corridor, so a
contractor can summon a vetted pilot within a 30-mile radius to deliver an insurance-ready roof
inspection report within 24 hours of a hailstorm — instead of being bottlenecked by one in-house
pilot or manual ladder inspection. Founder Derek Osei has run a related, real business (Osei
Aerial) as a solo operator for 8 years and is pivoting it into this marketplace specifically
because storm surges create demand he personally cannot fill.

The beachhead pairs storm-restoration roofing contractors (10-50 crews, TX/OK) on demand with
freelance/small-shop drone pilots on supply — the only segment pairing where Derek has real,
warm reach on both sides simultaneously. **Supply is the binding constraint on the whole
business**: a bottom-up beachhead TAM sized on the thinner (supply) side comes to roughly $880K/
year, well below this plugin's own workable-beachhead heuristic — flagged honestly in Section 1
and treated as a real open question about the heuristic's fit for take-rate marketplace
businesses, not silently smoothed over.

Pricing is a marketplace take-rate: contractors pay $175/property (sourced from Derek's own
3-year Osei Aerial billing history — one of the strongest-sourced figures in this plan), SkyClaim
retains an 18% take rate, and pilots receive the rest. Demand-side unit economics look healthy on
a provisional basis (LTV ≈$3,750, COCA ≈$300 floor, ratio ≈12.5:1) — but this ratio is
**demand-side only**; no comparable figure exists for supply-side pilot acquisition (COCA
≈$225/pilot), because the standard LTV formula has no way to represent a marketplace side that
generates no direct revenue of its own. This is a real, demonstrated gap in how this plan's own
methodology handles a two-sided business, documented in full in Section 4.

The single biggest open risk: **whether insurance carriers will accept SkyClaim-formatted reports
as valid claim documentation** — an external veto-holder no amount of good product design or
pricing overcomes. No MVBP transaction has occurred yet; this plan is at the idea/pivot stage
with strong founder domain credibility but a business model not yet proven independent of Derek
personally.

**The ask:** Derek is raising outside seed capital (`business_basics.funding_intent:
raising_outside_capital`, stated directly during onboarding) to build the booking/dispatch
software, grow real pilot supply beyond the ~4 currently in real conversation, and reach
demonstrated liquidity before expanding to a second market.

## Confidence & Validation Status

**1. Validated claims.**
- The $175/property price point is grounded in 3 years of Derek's own real, invoiced Osei Aerial
  billing history — the strongest-sourced figure in this plan (though it has not been separately
  validated as a *marketplace* price where a take rate is visible/implied to the contractor; see
  `ka-015-take-rate-tolerance`).
- 4 of Derek's 6 existing Osei Aerial clients (Copperhead Roofing, Lone Star Storm Restoration,
  Red River Roofing, and one further prospect) are real, named, contacted demand-side
  relationships with a multi-year operating history behind them.
- Osei Aerial's own historical rebooking rate (~78% of 6 clients across 3 years) is real data
  about Derek personally as a service provider — explicitly *not* validated as marketplace
  evidence (see Step 23).

**2. Unvalidated assumptions still open** (full register: `key_assumptions`, 32 entries; the
leap-of-faith shortlist from Step 20/21):
- `ka-012-carrier-veto-unconfirmed` — no specific insurance carrier has confirmed SkyClaim's
  report format is acceptable claim documentation. Test plan: Ray Delgado's first real carrier
  conversation, not yet run.
- `ka-004-pilot-count` / `ka-009-supply-prospect-count` — the 350-pilot theoretical supply
  population is an unvalidated extrapolation; only ~4 pilots are in real, marketplace-specific
  conversation today. Test plan: cold outreach to pilots outside Derek's existing network.
- `ka-onboarding-pilot-pool-tolerance` — whether pilots will actually accept multi-client,
  surge-routed dispatch is untested. Test plan: ask directly in the next real pilot conversations.
- `ka-018-carrier-check-unmeasured` — the demand-side acquisition funnel's riskiest stage has zero
  time/cost data. Test plan: directly observable once a real report is tested with a carrier.
- `ka-016-take-rate-untested` — the 18% take rate has not been stated to a real prospect on either
  side. Test plan: state it explicitly in the next 5 conversations per side.
- `ka-017-churn` / `ka-017-arpu-unmeasured` — the entire demand-side LTV rests on a single N-of-1
  legacy relationship and one prospect's stated hopes, not measured booking data.
- Every other open entry is listed in full in the Appendix (Steps 20-21) and in
  `business-state.json.key_assumptions` — not repeated here for length, per that section's own
  design intent (this section states the highest-leverage subset; the full register is the
  standalone risk register).

**3. AI-risk findings still open** (`risk_log`, `type: ai_risk`, `status: open`):
- `ar-skyclaim-002` — advisory: Step 14's Pin 2 follow-on-TAM framing could read as clean
  incremental revenue to a skimming reader unless its supply-contention caveat is read in full.
- `ar-skyclaim-003` — advisory, structural: Steps 17 (LTV) and 18 (sales process costing) have no
  marketplace-specific guidance in their own skill definitions, unlike every other DE step this
  business touched. This forced undocumented scope decisions while drafting this plan and produced
  a real, demonstrated gap in Section 4 (a supply-side COCA with no corresponding LTV to compare
  it against). This is a finding about the planning tool's own methodology, not about SkyClaim's
  business fundamentals — but it means the unit-economics figures in Section 4 should be read with
  that limitation explicitly in mind, not assumed complete.
- (`ar-skyclaim-001` and `ar-skyclaim-004`, both false-precision findings against Steps 4 and 17,
  are `status: mitigated` — fixed and re-passed the gate; listed here per this section's own rule
  to mention all statuses, not omit resolved ones.)

**4. What this plan is not.** This is a planning aid produced with AI assistance grounded in
Derek's own stated facts and estimates — it is not licensed financial, legal, or investment
advice, not a substitute for real market research or a real insurance-carrier confirmation, and
passing any review layer in this plugin (including a future council review) does not mean this
business idea is validated in the real world. Entity formation, contractor-classification
questions (SkyClaim's pilots are independent contractors), and insurance-industry compliance are
real legal questions a real professional resolves, not this plugin.

---

## 1. Who Is Your Customer?

**Market segmentation (Step 1).** 13 candidate segments were generated by brainstorming supply
and demand sides separately, per marketplace convention — 6 supply-side (freelance operators,
small drone shops, hobbyists, retired ag/survey pilots, university program graduates, carrier
captive pilots — the last ruled out explicitly) and 7 demand-side (storm-damage roofing
contractors, independent public adjusters, carrier CAT teams, property management, solar
installers, general restoration contractors, real estate agents).

**Beachhead selection (Step 2).** Storm-damage roofing contractors (demand) paired with freelance/
small-shop pilots (supply), TX/OK Hail Alley corridor — the only pairing where Derek has real,
warm reach on **both** sides at once (scoring matrix totals: 35/40 demand, 33/40 supply, vs. 21
and 19 for runner-ups). A public-adjuster demand segment and a retired-ag-pilot supply segment
were both considered and set aside for thinner reach.

**End user profile (Step 3).** Two full profiles, per marketplace convention. **Supply:** Part
107-certified, commercially insured, willing to fly close-proximity roof work (the real filter,
not the certificate alone) — based on 8 real conversations, all within Derek's existing network
(flagged as a sampling-bias risk, `ka-003-thin-supply-sample`). **Demand:** 10-50 crew,
majority insurance-claim-driven roofing contractor — based on 6 real conversations, all existing
Osei Aerial clients (same sampling-bias caveat, `ka-003-demand-sample-is-existing-clients`).

**Beachhead TAM (Step 4).** Sized on the **binding (supply) side**, per marketplace methodology:
≈350 theoretical commercially-active pilots × ≈80 properties/pilot/year × $175/property × 18%
take rate ≈ **$880,000/year** (order-of-magnitude; an earlier draft's exact-dollar figure was
caught and corrected by the mandatory AI-risk gate as false precision — see `ar-skyclaim-001`).
The non-binding demand-side theoretical ceiling is roughly $23M/year GMV, over 4x larger — the gap
between the two is itself the central strategic fact about this business: **demand is not the
constraint, supply is.** This TAM falls well below this plugin's own stated workable-beachhead
heuristic (tens to low hundreds of millions/year); flagged as a possible methodology mismatch for
take-rate marketplace businesses generally (`ka-004-heuristic-mismatch`), not treated as silently
disqualifying.

**Persona (Step 5).** Primary: Marcus Webb, a real interviewed independent pilot — chosen because
supply is the harder-constraint side per Step 4. Secondary: Big Ray Delgado (demand side,
Copperhead Roofing), drafted for completeness though not required by this step.

## 2. What Can You Do For Your Customer?

**Full life cycle use case (Step 6).** Two separate 8-stage tracks (supply and demand) — they
meet only at the moment of a booked job. The single highest-leverage drop-off risk identified:
the demand-side "evaluation" stage, where a contractor checking for available nearby pilots during
a storm surge will disengage immediately if the pool looks empty — directly tying back to Step 4's
thin-supply finding.

**Product specification (Step 7).** Must-have v1 capabilities cover both sides: a supply-side job
board with one-tap accept, a demand-side booking flow with real-time pilot availability, and an
insurance-ready report delivery flow. Explicitly out of scope for v1: a native mobile app,
automated dispatch/matching, and direct carrier-system API integration.

**Quantified value proposition (Step 8).** Quantified separately per side, never blended.
**Supply:** ≈$300-525/month incremental income for an active pilot (roughly doubling current
informal overflow income) — judged marginal-to-sufficient. **Demand:** value is a capacity-unlock,
deliberately left unquantified to a single dollar figure rather than inventing one, since the
volume of currently-missed business is genuinely unknown.

## 3. How Does Your Customer Acquire Your Product?

**Next 10 customers (Step 9).** 10 real, named prospects (5 supply, 5 demand), 8 of 10 already
contacted or in conversation. Notably, **demand is Derek's stronger, more-validated network** (4
of 6 listed demand prospects are already-paying legacy clients) — the inverse of the general
early-marketplace pattern where supply is usually the harder side to win. This asymmetry is a
real, business-specific finding carried through the rest of this plan.

**Core (Step 10).** Honest finding: **SkyClaim has no durable Core yet.** Per marketplace
methodology, the textbook Core (liquidity/network effects) requires real liquidity to exist first,
which it does not. The current advantage — Derek's personal domain credibility and demand-side
relationships — passes Unique and Important but fails Grows (it doesn't compound the way a network
effect does, and evaporates if Derek is unavailable). This is called a moat, not a Core, explicitly.

**Competitive position (Step 11).** Two separate charts, since supply and demand face genuinely
different alternatives. Demand's real competitor is the status-quo in-house-pilot bottleneck (and,
notably, Osei Aerial itself — the business SkyClaim is replacing). Supply's real competitor is
informal word-of-mouth and general gig-drone platforms (which Marcus, the primary persona,
explicitly described as "a race to the bottom on price"). Neither targeted position is currently
defensible, tied directly to Step 10's no-Core finding.

**Acquisition process and DMU (Steps 12, 13, 18 combined).** Per this plan's required
reconciliation, Steps 13 and 18 are presented as one narrative below rather than two separate
write-ups.

*Supply-side:* the DMU collapses to one person (the pilot is their own end user, champion, and
economic buyer, with a minor exception at 2-3 person shops). The acquisition path is 5 stages
(awareness → evaluation → sign-up/vetting → first job → repeat engagement), costed at
≈$225/pilot in loaded founder time (no cash spend), with an estimated ≈30% aware-to-first-job
conversion — both founder estimates from a small (8-conversation), warm-network sample.

*Demand-side:* the DMU is genuinely multi-role — an ops manager (end user/champion) and an
owner/GM (economic buyer) inside the contractor's own organization, **plus a critical external
veto-holder: the insurance carrier or adjuster**, who must accept SkyClaim's report format as
valid claim documentation or the contractor won't adopt regardless of price or speed. The
acquisition path mirrors supply's 5-stage shape but inserts a "carrier-acceptance check" stage
between evaluation and first booking — flagged by Step 13 as the longest, riskiest stage, and
confirmed by Step 18 to have **zero real time or cost data**, an honest gap rather than an
estimate. Demand-side loaded founder-time cost to first booking is ≈$300 (a stated floor,
excluding the unmeasured carrier-check stage).

No disagreement exists between Steps 13 and 18 on stage count or DMU roles for either side (both
were drafted by the same builder in the same session, reusing Step 13's stages verbatim as
instructed) — this reconciliation surfaces no conflict to log, stated explicitly per this
section's own requirement to say so rather than silently assume agreement.

## 4. How Do You Make Money Off Your Product?

**Follow-on TAM (Step 14).** Pin 2 (independent public adjusters, TX/OK) reuses the *same* supply
pool already established as scarce — its ≈$150K/year take-rate TAM is flagged explicitly as
**demand-side revenue that competes with the beachhead for the same thin pilot capacity**, not
purely additive; pursuing it before beachhead supply grows would just spread scarcity thinner, not
capture new revenue cleanly. Pin 3 (Colorado Front Range, geographic expansion reusing the demand-
side category) is not sized — Derek has zero relationships there and no basis for a founder
estimate, stated honestly rather than invented by analogy.

**Business model (Step 15).** Marketplace take-rate, selected explicitly over subscription
(mismatched to either side's buying rhythm), a supply-side listing fee (rejected — would directly
suppress the already-scarce binding-constraint side), and fee-for-service (this is literally the
business being replaced). Demand pays the full job price; supply is charged nothing, protecting
the more fragile side of the network.

**Pricing (Step 16).** $175/property (demand pays — Derek's own 3-year operating history, one of
the best-sourced figures in this plan), 18% take rate (anchored to a 10-20% services-marketplace
benchmark, not yet tested with a real prospect on either side).

**TAM reconciliation (step 4 vs. step 14), per this plan's required reconciliation.** These two
TAM figures are **not compatible to sum into one headline number**: Step 4's ≈$880K/year is a
supply-constrained beachhead figure; Step 14's Pin 2 ≈$150K/year competes for the *same* supply,
so adding them would double-count against one scarce resource rather than represent two
independently-capturable markets. They are presented here side by side with their distinct scope,
not combined.

**LTV, COCA, and the LTV:COCA reconciliation (steps 17 vs. 19), per this plan's required
reconciliation — and the single most consequential methodology finding in this plan.**

Step 17 (LTV) computed a figure for the **demand-side contractor only** (≈$3,750, rounded from an
earlier false-precision draft caught by the AI-risk gate — see `ar-skyclaim-004`), because this
step's own skill definition contains **no marketplace-specific guidance** — unlike nearly every
other step in this plan — and gave no instruction for how to handle a two-sided "customer."

Step 19 (COCA), by contrast, **does** have explicit marketplace guidance requiring supply- and
demand-side acquisition cost to be computed **separately**, and produced two real figures:
demand-side COCA ≈$300/contractor (a stated floor, excluding the unmeasured carrier-check stage)
and supply-side COCA ≈$225/pilot.

**The reconciliation that results:** the demand-side comparison works cleanly — LTV ≈$3,750 /
COCA ≈$300 ≈ **12.5:1**, payback ≈3.8 months, provisional and likely to compress once the missing
carrier-check cost is added to COCA. This ratio, read alone, would look healthy against this
plugin's own reference bands. **But the supply-side COCA (≈$225/pilot) has no LTV to compare
against at all** — pilots generate no direct revenue to SkyClaim under the standard LTV formula
(SkyClaim pays them, not the reverse), so the ratio is reported here as **N/A**, not forced into a
number. A reader who takes the 12.5:1 demand-side ratio as "the" unit-economics verdict on this
business would be reading half the picture — the half that doesn't include the binding constraint
Section 1 already identified. This gap is a real, demonstrated limitation in how Steps 17-19 as
currently written handle a marketplace business, documented in full in `ar-skyclaim-003` and
carried into the DE-plugin QA findings for this round, not something this individual business plan
can resolve on its own.

## 5. How Do You Design and Build Your Product?

**Key assumptions (Steps 20-21).** 32-entry full register swept from Steps 1-19 plus three later
steps' own entries; 8 leap-of-faith assumptions shortlisted and given real test designs, all
currently deferred (idea/pivot stage, no MVBP transaction yet) — none prematurely marked
validated. Every non-shortlisted entry in the full inventory has a recorded disposition (folded,
accepted, or deferred with a trigger) per Step 21's full-inventory requirement.

**MVBP (Step 22).** Supply is sourced first (the harder liquidity problem, per Step 4/9's
findings), before demand is pushed beyond Derek's existing warm contacts — avoiding the "empty
availability map" failure mode flagged in Step 6. Real $175/property transactions, manual
concierge matching by Derek, explicit success bar: 3 real transactions in 6 weeks, at least 1
report actually submitted to and accepted by a real insurance carrier.

## 6. How Do You Scale Your Business?

**Usage evidence (Step 23).** Honestly **not yet measurable** — no MVBP transaction has closed.
Osei Aerial's own historical ~78% legacy-client rebooking rate is noted as directional context
about Derek personally, explicitly not marketplace evidence, since the whole point of the pivot is
that the marketplace mechanic (not Derek personally) needs to earn that trust independently.

**Product plan (Step 24).** Near-term roadmap gated entirely on executing the MVBP, validating
carrier acceptance (the single highest-leverage open risk on the whole plan), and growing real
supply beyond the ~4 pilots currently in real conversation — prioritized in parallel, since either
one failing could kill the business independent of the other. Pin 2 (adjacent demand category)
and Pin 3 (geographic expansion) are both explicitly gated behind demonstrated beachhead liquidity,
not pursued prematurely. An unresolved engineering-resourcing gap is flagged: no technical
co-founder or contractor is yet in place to build the automation the roadmap's later priorities
assume.

---

## Appendix — Step-by-step detail

*(Faithful, tightened summaries of all 24 `plan/NN-slug.md` files — see each file for full
derivations, tables, and sourcing.)*

**Step 1 — Market Segmentation:** 13 candidate segments (6 supply, 7 demand), brainstormed
separately per marketplace convention; 5 carried forward to Step 2.

**Step 2 — Beachhead Market:** Storm-damage roofing contractors × freelance/small-shop pilots,
TX/OK Hail Alley — the only pairing reachable on both sides at once (scoring: 35/40 demand, 33/40
supply vs. 21/19 runner-ups).

**Step 3 — End User Profile:** Two full profiles (supply: 8 conversations; demand: 6
conversations), both flagged for network-sampling bias.

**Step 4 — Beachhead TAM:** ≈$880K/year, supply-constrained; demand-side theoretical ceiling
≈$23M/year is 4x larger, confirming supply as the binding constraint. False-precision finding
caught and fixed (`ar-skyclaim-001`).

**Step 5 — Persona:** Marcus Webb (supply, primary, real interviewee); Big Ray Delgado (demand,
secondary).

**Step 6 — Full Life Cycle Use Case:** Two 8-stage tracks; biggest drop-off risk is demand-side
liquidity visibility.

**Step 7 — Product Specification:** 5 must-have capabilities across both sides; native app and
carrier-API integration explicitly out of scope for v1.

**Step 8 — Quantified Value Proposition:** Supply ≈$300-525/month incremental income; demand value
directional/unquantified.

**Step 9 — Next 10 Customers:** 10 named prospects (5/5 split), 8 real/contacted; demand is
Derek's stronger network, an inversion of the typical marketplace pattern.

**Step 10 — Core:** No durable Core yet (pre-liquidity marketplace); current advantage is a
personal moat, honestly labeled as such.

**Step 11 — Competitive Position:** Two separate charts (supply/demand face different
alternatives); neither target position defensible yet, tied to Step 10.

**Step 12 — DMU:** Supply collapses to 1 role; demand has 2-3 internal roles plus an external
carrier veto-holder.

**Step 13 — Acquisition Process Map:** Two parallel 5-stage processes; demand-side
carrier-acceptance check flagged as riskiest/longest.

**Step 14 — Follow-on TAM:** Pin 2 (adjacent demand category, same supply pool) ≈$150K/year,
flagged as supply-contention risk; Pin 3 (geographic) not sized.

**Step 15 — Business Model:** Marketplace take-rate; supply charged nothing to protect the
binding-constraint side.

**Step 16 — Pricing Framework:** $175/property (well-sourced), 18% take rate (untested).

**Step 17 — LTV:** ≈$3,750, demand-side only; no marketplace guidance in this step's own
definition, forcing an undocumented scope decision — see Section 4's reconciliation.

**Step 18 — Sales Process Costing:** Two separate costed funnels (supply ≈$225/pilot, demand
≈$300/contractor floor); also no marketplace guidance in this step's own definition.

**Step 19 — COCA:** Demand LTV:COCA ≈12.5:1 (provisional); supply-side COCA has no LTV
counterpart — reported N/A, not forced.

**Step 20 — Identify Key Assumptions:** 32-entry full register; top leap-of-faith item is carrier
acceptance (`ka-012-carrier-veto-unconfirmed`).

**Step 21 — Test Key Assumptions:** All 8 shortlisted items deferred (pre-MVBP); full-inventory
disposition recorded for every other entry.

**Step 22 — MVBP:** Real $175/property transactions, manual matching, supply sourced first;
success = 3 transactions in 6 weeks with 1 carrier-accepted report.

**Step 23 — Dogs Eating the Dog Food:** Not yet measurable; Osei Aerial's legacy rebooking rate
noted as directional context only.

**Step 24 — Product Plan:** Roadmap gated on MVBP execution, carrier validation, and real supply
growth; unresolved engineering-resourcing gap flagged.
