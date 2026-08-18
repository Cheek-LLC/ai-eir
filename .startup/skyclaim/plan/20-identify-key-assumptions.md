# Step 20: Identify Key Assumptions

## Full assumption & low-confidence claim inventory
| ID | Statement | Originating step | Impact | Uncertainty | Leap of faith? |
|---|---|---|---|---|---|
| ka-onboarding-pilot-pool-tolerance | Pilots will accept multi-client dispatch and surge routing | onboarding | High | High | Yes |
| ka-002-existing-clients-marketplace-adoption | Existing clients will adopt the marketplace flow | 02 | High | Medium | Yes |
| ka-003-thin-supply-sample | Supply profile biased toward Derek's existing network | 03 | Medium | High | Yes |
| ka-003-demand-sample-is-existing-clients | Demand profile is entirely existing-client-based | 03 | Medium | Medium | No |
| ka-004-pilot-count | 350-pilot supply estimate unvalidated | 04 | High | High | Yes |
| ka-004-heuristic-mismatch | TAM sanity-check heuristic may not fit take-rate marketplaces | 04 | Low (methodology note, not business risk) | High | No |
| ka-005-marcus-representativeness | Primary persona may not represent broader pilot population | 05 | Medium | Medium | No |
| ka-006-liquidity-visibility | Real-time availability display assumed necessary for demand trust | 06 | Medium | Medium | No |
| ka-007-report-format | Report format assumed carrier-acceptable | 07 | High | High | Yes |
| ka-008-demand-value-unquantified | Demand-side value not reduced to a number | 08 | Medium | High | No |
| ka-009-supply-prospect-count | Real in-conversation supply is thinner than theoretical pool | 09 | High | Medium | Yes |
| ka-010-no-core-yet | No durable Core exists yet | 10 | High | Low (this is a confirmed finding, not uncertain) | No |
| ka-011-competitor-positions-unverified | Competitor positions estimated, not researched | 11 | Low | Medium | No |
| ka-012-carrier-veto-unconfirmed | No specific carrier has confirmed report acceptance | 12 | High | High | Yes |
| ka-013-carrier-check-informal | Carrier-check process shape assumed | 13 | Medium | High | No (subsumed by ka-012/ka-007) |
| ka-014-pin2-supply-contention | Pin 2 TAM may double-count scarce supply | 14 | Medium | Medium | No |
| ka-014-pin3-nosize | Pin 3 not sized | 14 | Low | High | No |
| ka-015-take-rate-tolerance | Pricing structure acceptance untested on both sides | 15 | Medium | Medium | No |
| ka-016-take-rate-untested | 18% take rate untested with real prospects | 16 | High | High | Yes |
| ka-016-surge-pricing-undefined | No surge pricing model yet | 16 | Low | High | No |
| ka-017-churn | Churn assumption from N-of-1 legacy relationship | 17 | High | High | Yes |
| ka-017-arpu-unmeasured | ARPU assumption from one prospect conversation | 17 | High | High | Yes |
| ka-017-no-marketplace-guidance | Step 17 has no marketplace branching (methodology gap) | 17 | Low (methodology note) | High | No |
| ka-018-supply-conversion | Supply funnel conversion from small warm sample | 18 | Medium | Medium | No |
| ka-018-carrier-check-unmeasured | No data on the riskiest demand-side stage | 18 | High | High | Yes |
| ka-018-no-marketplace-guidance | Step 18 has no marketplace branching (methodology gap) | 18 | Low (methodology note) | High | No |
| ka-019-founder-rate | $75/hr placeholder unvalidated | 19 | Medium | Medium | No |
| ka-019-demand-coca-incomplete | Demand COCA excludes unmeasured carrier-check cost | 19 | Medium | High | No |
| ka-019-supply-ltv-gap | No LTV exists for supply side (methodology gap) | 19 | Low (methodology note) | High | No |
| qc-04-tam | Beachhead TAM ≈$880K/year, all low-confidence inputs | 04 | High | High | Yes (via ka-004-pilot-count) |
| qc-017-ltv | Demand-side LTV ≈$3,750 | 17 | High | High | Yes (via ka-017-churn/ka-017-arpu-unmeasured) |

## Newly logged gaps found during this sweep
No previously-unlogged gaps found — every step from 1-19 that hit a genuine unknown logged it in
real time rather than stating it as settled fact in prose. This is a positive finding worth
stating plainly, not just an absence of new entries.

## Top leap-of-faith assumptions (ranked, for Step 21)
1. **ka-012-carrier-veto-unconfirmed** — the single highest-leverage risk on the entire plan: if
   insurance carriers won't accept SkyClaim-formatted reports, the demand-side value proposition
   collapses regardless of everything else being right.
2. **ka-004-pilot-count / ka-009-supply-prospect-count** (linked) — the entire beachhead TAM and
   liquidity story rests on a 350-pilot theoretical population of which only ~4 are in real
   conversation.
3. **ka-onboarding-pilot-pool-tolerance** — whether pilots will actually accept multi-client,
   surge-routed dispatch is foundational to whether the marketplace mechanic works at all.
4. **ka-018-carrier-check-unmeasured** — the demand-side acquisition funnel's riskiest stage has
   zero real data.
5. **ka-016-take-rate-untested** — pricing acceptance on both sides is unverified.
6. **ka-017-churn / ka-017-arpu-unmeasured** (linked) — the entire demand-side LTV rests on a
   single N-of-1 legacy data point and one prospect's stated hopes.
7. **ka-007-report-format** — subsumed under ka-012 but distinct enough to test separately (format
   design vs. carrier acceptance of that format).
8. **ka-003-thin-supply-sample** — supply-side research itself may be systematically biased
   toward pilots who already like Derek.

## Update business-state.json
`20_identify_key_assumptions`: `status: "drafted"`, summary references the 30-entry register and
top-3 leap-of-faith items above.
