# Step 21: Test Key Assumptions

## Test plans and outcomes

### ka-012-carrier-veto-unconfirmed — Will carriers accept SkyClaim's report format?
- Test method: ask Ray Delgado (Copperhead Roofing) directly which carriers he works with most,
  and request he informally run a sample report by one carrier contact.
- Success metric / threshold: at least one named carrier contact confirms (even informally) the
  report format is acceptable claim documentation.
- Cost / timeline: zero cash cost, ~2 weeks depending on Ray's carrier contact's availability.
- **Outcome:** Deferred until <Ray's first real conversation with his carrier contact — no MVBP
  booking has occurred yet to even produce a sample report>. Not yet testable in isolation from
  Step 22's MVBP.

### ka-004-pilot-count / ka-009-supply-prospect-count — Is real supply thicker than 4 pilots?
- Test method: direct outreach to at least 5 pilots outside Derek's existing network via a public
  post in the two regional Facebook groups.
- Success metric / threshold: at least 3 of 5 cold-contacted pilots express real interest
  (defined as agreeing to submit vetting documents, not just "sounds interesting").
- Cost / timeline: ~1 week, founder time only.
- **Outcome:** Deferred until <the first public outreach post is made> — not yet attempted.

### ka-onboarding-pilot-pool-tolerance — Will pilots accept multi-client, surge-routed dispatch?
- Test method: ask directly in the next 5 real pilot conversations (both warm and cold).
- Success metric / threshold: at least 4 of 5 say they'd accept it, or state a specific condition
  under which they would.
- Cost / timeline: immediate, zero cost — can be asked in existing conversations.
- **Outcome: Inconclusive.** Of the 4 pilots already in real conversation (Step 9), none has been
  asked this specific question yet — flagged honestly rather than treating "informally agreed to
  try it" as equivalent to "agreed to the surge-routing mechanic specifically."

### ka-018-carrier-check-unmeasured — How long/costly is the carrier-acceptance stage?
- Test method: directly observable once Ray (or another demand-side prospect) actually attempts
  the check.
- Success metric / threshold: N/A — this produces a measurement, not a pass/fail.
- Cost / timeline: unknown until attempted.
- **Outcome:** Deferred until <Step 22's MVBP produces a first real report to test with a carrier>.

### ka-016-take-rate-untested — Will both sides accept the 18% take rate?
- Test method: state the rate explicitly in the next 5 conversations on each side.
- Success metric / threshold: no more than 1 of 5 on either side raises the take rate as a
  deal-breaking objection.
- Cost / timeline: immediate, zero cost.
- **Outcome:** Deferred until <the next round of prospect conversations, post-onboarding>.

### ka-017-churn / ka-017-arpu-unmeasured — Are the demand-side LTV inputs realistic?
- Test method: track real booking volume and retention across the first full storm season on the
  MVBP.
- Success metric / threshold: N/A — produces measured data, not pass/fail.
- Cost / timeline: one full storm season (likely 3-6 months from MVBP launch).
- **Outcome:** Deferred until <first full storm season of real MVBP data exists>.

### ka-003-thin-supply-sample — Is the supply-side profile biased toward Derek's existing network?
- Test method: interview at least 5 pilots with no prior relationship to Derek.
- Success metric / threshold: their stated motivations/frustrations substantially match Marcus
  Webb's (Step 5) profile.
- Cost / timeline: ~2 weeks.
- **Outcome:** Deferred until <cold outreach begins, same trigger as ka-004/ka-009's test>.

## Full-inventory disposition (non-shortlisted items)
| ID | Statement | Disposition |
|---|---|---|
| ka-002-existing-clients-marketplace-adoption | Existing clients will adopt marketplace flow | Folded into Step 22 MVBP's first real transaction test — directly observable there |
| ka-003-demand-sample-is-existing-clients | Demand profile is existing-client-based | Folded into the same test as ka-003-thin-supply-sample's demand-side analog — deferred until non-client demand prospects are interviewed |
| ka-004-heuristic-mismatch | TAM heuristic methodology question | Accepted — not a business risk to test, a plugin-methodology question; carried to QA findings, not re-tested here |
| ka-005-marcus-representativeness | Persona representativeness | Folded into ka-003-thin-supply-sample's test |
| ka-006-liquidity-visibility | Availability-display necessity | Deferred until MVBP product exists to A/B against an SLA-promise alternative |
| ka-007-report-format | Report format carrier-acceptability | Folded into ka-012's test — same underlying question, format is the artifact being tested |
| ka-008-demand-value-unquantified | Demand value not quantified | Accepted — low urgency to force a number; will resolve naturally once real booking volume exists (same trigger as ka-017 tests) |
| ka-010-no-core-yet | No durable Core yet | Accepted — this is a confirmed finding (Step 10), not an assumption needing a test; trigger to revisit: first full storm season of real two-sided liquidity data |
| ka-011-competitor-positions-unverified | Competitor positions unverified | Deferred until a WebSearch pass is run — low priority relative to the leap-of-faith list |
| ka-013-carrier-check-informal | Carrier-check process shape | Folded into ka-018-carrier-check-unmeasured's test |
| ka-014-pin2-supply-contention | Pin 2 TAM double-count risk | Deferred until beachhead supply has grown — explicit trigger already stated in Step 14 |
| ka-014-pin3-nosize | Pin 3 not sized | Deferred until beachhead liquidity is demonstrated — explicit trigger already stated in Step 14 |
| ka-015-take-rate-tolerance | Pricing structure acceptance | Folded into ka-016-take-rate-untested's test |
| ka-016-surge-pricing-undefined | No surge pricing model | Accepted — deferred to Step 24's roadmap, not urgent pre-MVBP |
| ka-017-no-marketplace-guidance | Step 17 methodology gap | Accepted — not a business risk to test, a plugin-methodology question; carried to QA findings |
| ka-018-no-marketplace-guidance | Step 18 methodology gap | Accepted — same disposition as ka-017-no-marketplace-guidance |
| ka-019-founder-rate | $75/hr placeholder | Deferred until a sourced local market rate is looked up — low urgency, mechanical fix |
| ka-019-demand-coca-incomplete | Demand COCA excludes carrier-check cost | Folded into ka-018-carrier-check-unmeasured's test — same missing data point |
| ka-019-supply-ltv-gap | No supply-side LTV (methodology gap) | Accepted — not a business risk to test, a plugin-methodology question; carried to QA findings |
| qc-04-tam | Beachhead TAM | Tracked via linked ka-004-pilot-count / ka-009-supply-prospect-count tests above |
| qc-017-ltv | Demand-side LTV | Tracked via linked ka-017-churn / ka-017-arpu-unmeasured tests above |

## Unresolved risk carried forward
All 8 shortlisted leap-of-faith assumptions remain deferred (idea/pivot stage, no MVBP live yet) —
none invalidated, none prematurely marked validated. The single biggest open risk carried forward
into Step 22: **ka-012-carrier-veto-unconfirmed** — the MVBP's design should be shaped specifically
to test this at the earliest possible real transaction, not treated as a later concern.

## Update business-state.json
`21_test_key_assumptions`: `status: "drafted"`, summary states 0 validated / 0 invalidated / 8
deferred (shortlist) with full-inventory disposition recorded for every other item, and names
ka-012-carrier-veto-unconfirmed as the single biggest open risk carried forward.
