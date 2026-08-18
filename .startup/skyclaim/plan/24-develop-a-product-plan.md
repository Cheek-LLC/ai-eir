# Step 24: Product Plan

## Near-term roadmap (next 1-2 quarters)
| Item | Justification (Step 22 trigger / Step 23 evidence / spec gap) | Priority |
|---|---|---|
| Execute the MVBP: 3 real transactions, both sides, within 6 weeks | Step 22's defined success bar — nothing else on this roadmap matters until this happens | 1 |
| Instrument job-acceptance and rebooking data | Step 23 found zero usage evidence exists — this is the direct fix | 2 |
| Validate carrier acceptance of the report format with a real carrier contact | ka-012, the single highest-leverage open risk on the whole plan (Step 20/21) | 1 (parallel with MVBP) |
| Cold-outreach campaign to 5+ pilots outside Derek's existing network | ka-004/ka-009 — real supply is thinner than the theoretical 350-pilot pool; this is the actual binding constraint on the business | 1 (parallel with MVBP) |
| Build a basic live availability display (replacing Derek's manual tracking) | Automation trigger from Step 22: more concurrent jobs than one person can track by hand | 3 (after MVBP proves the mechanic works manually first) |
| Automate payment split | Automation trigger from Step 22: transaction volume exceeds manual reconciliation capacity | 3 |
| Design and test surge pricing | ka-016-surge-pricing-undefined — deferred from Step 16/21, revisit once real storm-surge data exists | 4 |

Explicitly deprioritized: a native mobile app and carrier-system API integration (Step 7's
"Won't have" list) — acceptable near-term risk since the MVBP's manual delivery process doesn't
need either to prove the core mechanic.

## Follow-on market readiness (Step 14 bowling pins)
Pin 2 (public adjusters) trigger condition: beachhead supply has grown meaningfully past the
current ~4-in-real-conversation state. Current distance to trigger: not yet met — cold-outreach
campaign above is the direct path to closing this gap. Pin 3 (Colorado) trigger condition:
demonstrated beachhead liquidity (a measurable fill rate, not just signed contracts). Current
distance: far — no MVBP transaction has occurred yet.

## Sequencing rationale
Everything is gated on the MVBP actually running, and within that, supply-side growth and carrier
validation are prioritized equally alongside it — both are the two findings (Step 20's #1 and #2
leap-of-faith assumptions) most likely to kill the business if wrong, so neither should wait for
the other to resolve first.

## Resourcing reality check
This roadmap assumes Derek continues doing all matching, vetting, and carrier-relationship work
personally through the MVBP phase — no hire has been made or identified. Building the availability
display and payment-split automation (priority 3 items) will require either Derek learning to
build them, a technical co-founder, or a contractor — not yet resolved, and flagged as a real gap
the raise (per `business_basics.funding_intent`) is intended to help close.

## Handoff briefs

### To GTM
Once the MVBP proves out, GTM needs: a positioning brief distinguishing SkyClaim from general
gig-drone platforms (Step 11's differentiation) for both supply-side pilot recruitment and demand-
side contractor acquisition — these are two different audiences needing two different messages,
not one blended pitch. Given `business_basics.funding_intent: raising_outside_capital`, a
fundraising-deck brief should also draw on this file's honest risk framing (ka-012, ka-004/009)
rather than presenting the plan as more de-risked than it is.

### To Ops/Scaling
Once real transaction volume exists, ops needs: a KPI dashboard tracking supply-side fill rate and
demand-side rebooking rate *separately* (per the marketplace-wide pattern established across this
whole plan — never blend the two sides into one metric), and a retro process specifically checking
whether COCA/LTV assumptions (Step 17/19) are holding against real data.

## Open assumptions
- `ka-024-eng-resourcing`: "No step in this plan (1-23) established who actually builds the
  availability-display and payment-split automation beyond Derek's own manual process — no
  technical co-founder or contractor identified yet." `step_ref`: `24_develop_a_product_plan`,
  `confidence`: `low`, `test_plan`: "Founder needs to resolve this before Priority 3 roadmap items
  are credible — either learn to build a minimal version, bring on a technical co-founder, or hire
  a contractor, likely funded by the outside capital raise," `test_result`: `null`.

## Update business-state.json
`24_develop_a_product_plan`: `status: "drafted"`, summary states the top near-term priorities
(execute MVBP, validate carrier acceptance, grow real supply) and the Pin 2/3 readiness gates.
