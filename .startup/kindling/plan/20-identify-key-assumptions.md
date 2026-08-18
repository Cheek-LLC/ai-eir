# Step 20: Identify Key Assumptions

Business-type branching used: **Consumer app** — pointed directly at retention-curve assumptions,
virality/K-factor claims, freemium-conversion assumptions, and platform-dependency risk as where
unlogged gaps cluster. All four categories were checked; only the first three were actually present
(no virality/K-factor claim exists anywhere in this plan — engagement is modeled as
invite-driven, not viral, and no unlogged K-factor assumption was hiding anywhere; platform
dependency is addressed explicitly below as a newly-logged gap).

## Full assumption & low-confidence claim inventory

| ID | Statement (short) | Originating step | Impact | Uncertainty | Leap of faith? |
|---|---|---|---|---|---|
| ka-001-segment-breadth | Segments 2-13 beyond #1 are extrapolated, not validated | 01 | Low | Medium | No |
| ka-002-segment2-reach | Circle mechanic assumed to transfer to writing | 02 | Medium | Medium | No |
| ka-003-friends-and-family-sample | All pilot data from founder's own network | 03 | Medium | Medium | No |
| ka-004-tam-count | 13M reference population, 15% fit fraction, unsourced | 04 | High | High | **Yes** |
| ka-004-arpu-method | No step guidance for freemium TAM method; improvised | 04 | Medium | Medium | No |
| qc-004-tam-realistic | Realistic TAM (~$5M/yr) unsourced, low confidence | 04 | High | High | **Yes** |
| ka-006-circle-join-rate | No real data on circle-formation rate | 06 | High | High | **Yes** |
| ka-007-starter-circle | Stranger-grouped "starter circle" untested | 07 | Medium | High | No |
| ka-008-selfselection | 3x streak-length delta may be self-selection, not causal | 08 | High | High | **Yes** |
| ka-009-shortfall | Only 8 of 10 next-customers reached | 09 | Low | Low | No |
| ka-010-core-not-found | No durable Core identified yet | 10 | Medium | High | No |
| ka-011-competitor-verification | Competitor positions unverified via search | 11 | Low | Low | No |
| ka-013-circle-invite-friction | Cold in-app invite acceptance untested | 13 | High | High | **Yes** |
| ka-014-pin2-arpu-vs-tam | Pin-2 ARPU-expansion vs. new-TAM split unmeasured | 14 | Low | Medium | No |
| ka-015-model-fit | Subscription vs. one-time-IAP model unvalidated | 15 | Medium | Medium | No |
| ka-016-price-point | $6.99/$49.99 price untested with any prospect | 16 | High | High | **Yes** |
| ka-016-conversion-rate | 4% payer-conversion assumption untested | 16 | High | High | **Yes** |
| ka-017-retention-curve | Entire retention curve is an unsourced category benchmark | 17 | High | High | **Yes** |
| ka-017-payer-lifetime | ~10-month payer lifetime is a separate placeholder | 17 | Medium | High | No |
| ka-017-margin | 75% margin unbenchmarked against real infra cost | 17 | Medium | Medium | No |
| ka-018-discovery-conversion | Discovery/install/first-prompt conversion rates unmeasured | 18 | Medium | High | No |
| ka-018-conversion-inconsistency | Step 16's 4% vs. Step 18's chained ~1.5-2% disagree | 18/16 | High | Medium | No |
| ka-019-founder-rate | $50/hr founder-time placeholder unsourced | 19 | Medium | Medium | No |
| ka-019-install-estimate | 800-install launch estimate is a loose extrapolation | 19 | Medium | High | No |

## Newly logged gaps found during this sweep

| ID | Statement | Originating step (unlogged before now) |
|---|---|---|
| ka-020-platform-dependency | No prior step names App Store policy/fee-change risk or the risk of an Apple review rejection delaying or blocking launch, despite Step 22's MVBP being entirely dependent on Apple's in-app purchase system | 22 (platform dependency should have been named explicitly when Step 22 committed to Apple IAP as a hard requirement; it wasn't) |
| ka-020-founder-bandwidth | No prior step explicitly names that Priya is running this alongside a full-time job, which caps how much community-seeding/support time is realistically available regardless of what Step 19's cost buildup assumes | 19/22 (implicit throughout, never stated as its own risk until this sweep) |

## Top leap-of-faith assumptions (ranked, for Step 21)

1. **ka-016-conversion-rate** — the 4% payer-conversion assumption is the single input most
   load-bearing across Steps 4, 17, and 19 simultaneously (it drives the realistic TAM, half of the
   blended LTV, and the COCA-per-payer denominator all at once), and it is entirely untested.
2. **ka-017-retention-curve** — drives both LTV figures and has zero real data behind it at all
   (not even thin data — none).
3. **ka-013-circle-invite-friction** — the entire differentiated value proposition (Step 8's 3x
   streak-length claim) depends on circles actually forming from cold in-app invites, which the
   pilot never tested (the pilot's WhatsApp group pre-existed the "ask").
4. **ka-008-selfselection** — if the 3x delta is mostly self-selection rather than a caused effect,
   the core value proposition itself is weaker than stated.
5. **ka-016-price-point** — untested price, but ranked below the conversion-rate and retention
   assumptions since a wrong price is more directly and cheaply correctable than a wrong retention
   or conversion assumption.
6. **ka-020-founder-bandwidth** — newly surfaced this sweep; a real constraint on whether any of
   the above can even be tested on the stated timeline.

## Update business-state.json

Both newly-logged gap entries above (`ka-020-platform-dependency`, `ka-020-founder-bandwidth`) are
appended to `key_assumptions` with `step_ref` pointing to their originating steps (22 and
19/22 respectively) — kept in the top-level array per this step's own instruction.
