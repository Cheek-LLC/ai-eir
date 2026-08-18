# Step 4: TAM for the Beachhead Market

**Note on business-type branching — the most significant gap hit in this whole 24-step pass.**
This step's own SKILL.md "Business-type branching" section lists exactly four types: SaaS,
Physical product, Marketplace, Services. **There is no `consumer_app` bullet at all** — the one
business type this round exists to test is the one business type this specific step gives zero
guidance for, despite Step 4 being one of the five DE steps this round was explicitly asked to
scrutinize. Concretely, this step's stated method — "annual revenue per user = price × purchase
frequency" — has no answer for a **freemium** consumer app, where "the price" isn't one number:
most end users generate ad revenue only, a small minority pay a subscription, and the step gives no
instruction on whether TAM should be sized off a naive full-price/full-conversion assumption or a
realistic blended figure. I had to improvise by borrowing Step 17's blended-ARPU logic (which *is*
specified, for LTV) sideways into this step. See `docs/QA-FINDINGS-ROUND5.md` for the full writeup
— this is reported as the round's headline Step 4 finding.

## Counting unit

From Step 3: one U.S. adult matching the End User Profile — has attempted and abandoned a
self-directed daily sketch practice in the last 12 months, is still loosely connected to an online
or in-person art-hobbyist community, owns drawing tools already.

## Bottom-up calculation

- **Reference population & source:** ~13M U.S. adults who sketch/draw as a hobby at least
  occasionally. This is a founder gut estimate (Priya's own sense from years in hobbyist-art
  communities), **not from a cited external source** — no WebSearch was attempted this session
  (see the "no external search attempted" note below). `confidence: low`.
- **Density/fit fraction & rationale:** of hobbyist sketchers, an estimated 15% match the specific
  "tried and abandoned a self-directed streak in the last 12 months, still community-connected"
  profile — narrower than "everyone who sketches" but not a number either of us can source; another
  founder gut estimate. `confidence: low`.
- **Estimated end-user count:** 13M × 15% ≈ **~2M** end users in the beachhead as defined.
- **Two different "annual revenue per end user" figures, because this step gives no instruction on
  which one a freemium consumer app should use:**
  1. **Naive full-conversion ceiling** (treating this like a SaaS ACV — "what if 100% of the
     beachhead paid full price"): 2M × $49.99/yr ≈ **~$100M/year**. This is the number a
     mechanical application of this step's stated formula produces, and it is not a realistic
     revenue figure for a freemium product — nobody expects 100% of a free-tier-eligible user base
     to convert to paid.
  2. **Realistic blended figure** (borrowing Step 17's blended-ARPU method: ad revenue for the ~96%
     who stay free + subscription revenue for the ~4% modeled payer-conversion rate — see Step 16
     for the price and Step 17 for the conversion-rate assumption, `ka-016-price-point` and
     `ka-017-payer-conversion`): blended ARPU ≈ **~$2.60/year** per end user → 2M × $2.60 ≈
     **~$5M/year**.
- **Beachhead TAM (number of record): ~$5M/year**, using the realistic blended figure — the $100M
  naive figure is reported above only to show why it would be the wrong number to lead with for
  this business shape, per the same discipline Step 4's marketplace branch applies to GMV vs.
  take-rate revenue (a structurally similar "which side of the multiplier is the real one"
  problem, just for freemium rather than two-sidedness).

## Top-down cross-check

None available — no WebSearch attempted this session (see honest-fallback note below).

## Sanity check

This step's stated heuristic: "a workable beachhead TAM is typically in the tens to low hundreds
of millions of dollars per year." The realistic $5M/year figure falls **well below** that range;
the naive $100M ceiling falls at the low end of it. Per the same logic the marketplace branch
above this section applies to GMV vs. take-rate revenue, **this reads as a structural artifact of
freemium blended-ARPU math, not necessarily evidence the beachhead itself is too small** — but
unlike the marketplace case, this step's heuristic carries no explicit caveat saying so for a
freemium consumer app, so I am flagging this as a genuine open question rather than asserting
confidently that it's fine. It may also, honestly, be a real signal that the beachhead is
under-monetized at these price/conversion assumptions and the pin-2/pin-3 expansion (Step 14) is
doing real work the beachhead alone can't. Flagged for the founder and for Step 14/20.

## Quantitative claims logged

```json
{ "id": "qc-004-tam-population", "claim": "Reference population — U.S. hobbyist sketch/drawing adults", "value": "~13M", "step_ref": "04_calculate_the_tam_for_the_beachhead_market", "source": "founder estimate, unvalidated — no external search attempted this session", "confidence": "low", "ai_risk_flag": true }
```
```json
{ "id": "qc-004-tam-fitfraction", "claim": "Fit fraction — share of hobbyist sketchers matching the tried-and-abandoned, community-connected profile", "value": "~15%", "step_ref": "04_calculate_the_tam_for_the_beachhead_market", "source": "founder estimate, unvalidated", "confidence": "low", "ai_risk_flag": true }
```
```json
{ "id": "qc-004-tam-naive-ceiling", "claim": "Beachhead TAM, naive full-conversion ceiling (not the number of record)", "value": "~$100M/year = ~2M end users × $49.99/yr", "step_ref": "04_calculate_the_tam_for_the_beachhead_market", "source": "computed from qc-004-tam-population, qc-004-tam-fitfraction, and qc-016-price", "confidence": "low", "ai_risk_flag": true }
```
```json
{ "id": "qc-004-tam-realistic", "claim": "Beachhead TAM, realistic blended-ARPU figure (number of record)", "value": "~$5M/year = ~2M end users × ~$2.60/yr blended ARPU", "step_ref": "04_calculate_the_tam_for_the_beachhead_market", "source": "computed from qc-004-tam-population, qc-004-tam-fitfraction, and the blended-ARPU derivation in plan/17-calculate-the-ltv-of-a-customer.md", "confidence": "low", "ai_risk_flag": true }
```

## Assumptions flagged

- `ka-004-tam-count` — statement: "The 13M reference population and 15% fit fraction are both
  founder gut estimates with no external source." `step_ref:
  04_calculate_the_tam_for_the_beachhead_market`, `confidence: low`, `test_plan: "search for a
  published hobbyist-participation benchmark (e.g. an arts-participation survey) and replace the
  gut estimate; alternatively validate directionally via MVBP beta waitlist signups from cold
  community-seeding"`, `test_result: null`.
- `ka-004-arpu-method` — statement: "No guidance exists in this step for how a freemium
  consumer-app TAM should be sized (naive full-price vs. realistic blended ARPU); the blended
  figure was chosen by analogy to Step 17's LTV method, not by this step's own instructions."
  `step_ref: 04_calculate_the_tam_for_the_beachhead_market`, `confidence: low`, `test_plan:
  "flagged for a future round to add explicit consumer_app branching to this step, per
  docs/QA-FINDINGS-ROUND5.md"`, `test_result: null`.

No external search was attempted this session for either the reference population or a top-down
cross-check figure — stated explicitly per this step's own "honest fallback vs. skipped search"
discipline.

*This is a planning aid, not financial, legal, or tax advice.*

## Mandatory AI-risk gate

Invoked `skills/risk/ai-risk-review` against this file plus the `kindling` slug on completion.
**Result: PASS.** No blocking finding — both TAM figures are rounded to one significant figure
(no false precision), every input has a `quantitative_claims` entry with an honest
`founder estimate, unvalidated` source (not laundered as research), and the naive-vs-realistic
distinction is stated plainly rather than presented as settled. One advisory note from the
analyst: consider sourcing the 13M reference population externally before this figure is
presented to any outside party. Logged to `risk_log` as `ar-kindling-001` (advisory).
