# Step 20: Identify Key Assumptions

## Full assumption & low-confidence claim inventory
| ID | Statement (short) | Originating step | Impact | Uncertainty | Leap of faith? |
|---|---|---|---|---|---|
| ka-onboarding-cross-location-pool | Backup workers will tolerate a shared cross-location (even cross-owner) on-call pool | onboarding | High | High | **Yes** |
| ka-002-competitive-intensity | Convenience-retail/home-health competitive intensity estimated, not researched | 02 | Low (not the beachhead) | Medium | No |
| ka-003-thin-research | End-user profile based on only 3 real GM conversations | 03 | Medium | Medium | No |
| ka-004-group-count | Beachhead group-count (3,000) and locations/group (22) are unverified founder estimates | 04 | Medium | Medium | No |
| ka-006-onboarding-adoption | GMs will actually adopt the tool rather than reverting to the paper call list | 06 | High | High | **Yes** |
| ka-007-csv-only | CSV-only import (no live API) is acceptable to buyers | 07 | Medium | Medium | No |
| ka-008-target-unproven | 8-minute time-to-cover target and 70% late-opening reduction (the entire value prop) | 08 | High | High | **Yes** |
| ka-009-prospect-count | Only 7 of 10 next-customers identified; network depth thinner than Step 2 implied | 09 | Medium | Medium | No |
| ka-010-core-unearned | The "Core" (reliability-data network effect) doesn't exist yet — no usage to generate it | 10 | Medium | High | No (impact is medium until scale, not yet betting the whole plan on it) |
| ka-011-competitor-positions-unverified | Competitor feature/pricing positions estimated, not researched | 11 | Medium | Medium | No |
| ka-012-franchisor-veto | Franchisor IT/brand-standards veto risk, unconfirmed per brand | 12 | High | Medium | **Yes** |
| ka-013-pilot-needed | Buyers will want a paid pilot before full-group commitment | 13 | Medium | Medium | No |
| ka-014-pin2-groupcount | Pin 2 (casual dining) TAM inputs unverified | 14 | Low (follow-on, not beachhead) | Medium | No |
| ka-014-pin3-nosize | Pin 3 (convenience retail) TAM not computed at all | 14 | Low | High | No |
| ka-015-model-fit | Per-location pricing preferred over flat group fee, untested | 15 | Medium | Medium | No |
| ka-016-price-point | $149/location/month untested with any real prospect | 16 | High | Medium | **Yes** |
| ka-017-churn | 4%/mo churn (25-month lifetime) is a category benchmark, not founder data | 17 | High | Medium | **Yes** |
| ka-017-margin | 74% gross margin unmodeled, no real SMS vendor quote | 17 | Medium | Medium | No |
| ka-017-step4-price-mismatch | Step 4 TAM used $149 flat; actual avg group qualifies for $129 volume tier — unreconciled | 17 | Medium | Low (this is a known, fixable arithmetic gap, not an uncertain belief) | No |
| ka-018-conversion | All Step 18 funnel conversion rates are estimates; zero real deals have moved through it | 18 | High | High | **Yes** |
| ka-018-channel-scalability | COCA/LTV:COCA model is built entirely on a non-scalable warm-network channel | 18 | High | High | **Yes** |
| ka-019-founder-rate | $85/hr founder-time rate is an unvalidated placeholder | 19 | Low | Low | No |
| ka-019-ratio-not-representative | 16.3:1 ratio is an artifact of the warm-network-only channel, not representative at scale | 19 | High | High | **Yes** (restates ka-018-channel-scalability's implication for the headline ratio specifically — kept as a separate entry since it's the number a reader will actually see first) |
| qc-04-tam | Beachhead TAM $118M, founder estimate | 04 | Medium | Medium | No |
| qc-08-value-delta | ~$6,000/yr value per location | 08 | High | High | Same underlying bet as ka-008-target-unproven |
| qc-014-pin2-tam | Pin 2 TAM $70.8M | 14 | Low | Medium | No |
| qc-016-price | $149/$129 per-location pricing | 16 | High | Medium | Same underlying bet as ka-016-price-point |
| qc-018-cycle-length | ~68 day sales cycle | 18 | Medium | High | Same underlying bet as ka-018-conversion |
| qc-019-coca / qc-019-ltv-coca-ratio | COCA $3,213, ratio 16.3:1 | 19 | High | High | Same underlying bet as ka-019-ratio-not-representative |

## Newly logged gaps found during this sweep
| ID | Statement | Originating step (unlogged before now) |
|---|---|---|
| ka-020-wage-hour-risk | Step 15's file states, in prose only, that a marketplace/take-rate model "likely violates wage-and-hour norms the founder is not positioned to evaluate" when rejecting that archetype — this is a real legal/compliance risk observation that was never captured as a structured `key_assumptions` or `risk_log` entry, only mentioned in passing prose. Logging it now so it doesn't stay invisible to anyone who reads `business-state.json` without reading every step file's prose. | 15 |

```json
{ "id": "ka-020-wage-hour-risk", "statement": "Step 15 noted, in prose only, that a marketplace/take-rate business model would likely raise wage-and-hour compliance questions given backup workers are existing employees of the franchise group — this was never logged as a structured assumption or risk_log entry until this sweep. The chosen model (subscription) avoids this specific issue, but the observation itself was at risk of being lost.", "step_ref": "15_design_a_business_model", "confidence": "low", "test_plan": "No action needed unless a future pivot reconsiders a take-rate/marketplace model — if so, get real legal review before proceeding, not an AI-generated compliance read.", "test_result": null }
```

## Top leap-of-faith assumptions (ranked, for Step 21)
1. **ka-008-target-unproven** — the entire quantified value proposition (Step 8) rests on an
   8-minute time-to-cover target and a 70% late-opening reduction that have never been measured.
   If this is wrong, the price-to-value case (Step 16) and the whole plan's pitch collapses.
2. **ka-018-channel-scalability / ka-019-ratio-not-representative** — the headline 16.3:1
   LTV:COCA ratio is an artifact of a warm-network channel that Step 9 already showed tops out
   around 7-28 leads; this is the single most likely number in the plan to mislead a reader who
   takes it at face value.
3. **ka-006-onboarding-adoption** — if GMs like Jordan revert to the paper call list during
   onboarding, the product never gets used regardless of what the Director of Ops signed.
4. **ka-onboarding-cross-location-pool** — the core product mechanic (cross-location backup pool)
   depends on backup workers accepting a shared on-call list; this was flagged as a genuine
   unknown at the very first conversation of onboarding and has not been resolved since.
5. **ka-016-price-point** — $149/location/month has never been said out loud to a real prospect.
6. **ka-017-churn** — LTV's 25-month expected lifetime is a category benchmark, not this
   business's data, and LTV is the numerator of the ratio in #2 above.
7. **ka-012-franchisor-veto** — a single brand-level franchisor policy could kill deals wholesale
   in a way none of the sales-process modeling (Step 18) currently accounts for.
8. **ka-018-conversion** — every stage conversion rate in the sales-cycle model (Step 18) is a
   guess; zero real prospects have moved past "in conversation" (Step 9).
