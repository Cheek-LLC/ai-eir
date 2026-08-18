# Step 14: TAM for Follow-on Markets

Business-type branching used: **Consumer app** — the branch's core distinction (existing-user
ARPU-expansion vs. genuinely new TAM) was directly load-bearing here and is applied explicitly
below.

## Bowling pin sequence

Beachhead (sketch-a-day, Step 2) → Pin 2: daily creative writers → Pin 3: daily instrument practice

## Follow-on market candidates

### Pin 2: Daily creative writers

- **Adjacency logic:** Reuses the exact same core mechanic (prompt → artifact → circle) and the
  app's technical infrastructure; the artifact type changes from an image to text, which per Step
  7's out-of-scope note is a real but modest engineering lift. **Community access does not
  transfer** — Priya has zero standing in writing communities today (Step 2's scoring already
  flagged this at "reach: 2").
- **Two distinct sub-effects, kept separate per this branch's explicit warning:**
  1. **ARPU expansion within the existing beachhead user base** — if a sketch-circle user also
     wants writing prompts, that's incremental subscription revenue from someone already counted in
     Step 4's TAM, not new TAM. This is really a Step 17 LTV-expansion question, not a Step 14 TAM
     question, and I am not double-counting it here.
  2. **Genuinely new TAM** — people who would never have found a "sketch habit" app but would find
     a "writing habit" app, reached through entirely different (writing-community) channels. This
     is the actual pin-2 TAM being sized below.
- **TAM calculation (bottom-up, same blended-ARPU method as Step 4, since — as noted there — this
  step's own guidance doesn't specify a consumer-app method any more than Step 4's does, so the
  same borrowed method is reused consistently):** reference population of U.S. adults who journal
  or write creatively as a hobby, founder estimate ~10M (lower than sketching — writing habit apps
  already have more entrenched alternatives like Day One and Notion, which may suppress switching);
  fit fraction (tried-and-abandoned, community-connected) ~12% (slightly lower than sketching's 15%,
  since Priya has less confidence reading this community) ≈ 1.2M end users; same blended ARPU
  logic (~$2.60/yr, unvalidated, carried over from Step 4/17 pending its own separate validation) →
  **TAM ≈ ~$3M/year, genuinely new (not double-counted with the beachhead).**
- **Trigger condition to pursue:** per Step 24, only after the sketch-only beachhead shows a stable
  (non-decaying) retention curve and the circle-formation mechanic is confirmed to work with real
  strangers, not just pre-existing friends.

### Pin 3: Daily instrument practice

- **Adjacency logic:** Same accountability mechanic, but the artifact becomes an audio clip or a
  logged practice session rather than a photo — the biggest engineering lift of the three pins
  (audio capture/playback is a materially different technical surface than photo capture). Priya
  has zero community access here (Step 2: "reach: 1," "right to win: 1") — this pin is explicitly
  the longest-lead, hardest-access candidate of the three, named honestly as such rather than
  glossed over because "the mechanic transfers."
- **TAM calculation:** Not computed in detail this round — flagged as out of scope until pin 2 is
  underway, per this step's own guidance to size 2-4 candidates without inventing precision for
  the least-near-term one. A placeholder order-of-magnitude estimate (using the same method,
  reference population of amateur adult instrumentalists ~8M, fit fraction ~10%) would land in the
  same low-single-digit-millions range as pin 2 — stated as a rough placeholder only, not logged as
  a `quantitative_claims` entry since it wasn't actually computed with real inputs this session.

## Quantitative claims logged

```json
{ "id": "qc-014-pin2-tam", "claim": "TAM for follow-on market: daily creative writers (genuinely new, not ARPU expansion)", "value": "~$3M/year = ~1.2M end users x ~$2.60/yr blended ARPU", "step_ref": "14_calculate_the_tam_for_follow_on_markets", "source": "founder estimate — bottom-up from a 10M reference population and 12% fit fraction, both unvalidated; needs independent verification; no external search attempted this session", "confidence": "low", "ai_risk_flag": true }
```

## Open assumptions

- `ka-014-pin2-arpu-vs-tam` — statement: "Pin 2's ARPU-expansion effect on existing beachhead users
  (a Step 17 LTV question) and its genuinely-new-TAM effect (this step's question) are kept
  conceptually distinct here per this branch's explicit warning, but neither has been tested — the
  split itself is a modeling choice, not an observed fact." `step_ref:
  14_calculate_the_tam_for_follow_on_markets`, `confidence: low`, `test_plan: "once pin 2 is live,
  measure what share of pin-2 revenue actually comes from existing beachhead accounts vs. genuinely
  new writing-community signups"`, `test_result: null`.

No external search was attempted this session for either reference population — stated explicitly.

## Mandatory AI-risk gate

Invoked `skills/risk/ai-risk-review` against this file plus `kindling` on completion. **Result:
PASS.** The TAM figure is rounded to one significant figure, sourced honestly as an unvalidated
founder estimate, and the ARPU-expansion-vs-new-TAM distinction is stated explicitly rather than
conflated. No blocking finding, and no advisory finding either — the analyst reported a clean pass
explicitly (per its own contract, a `risk_log` entry is written only when an issue is actually
found; "nothing found" is stated plainly in its report rather than manufacturing an entry for the
sake of one).
