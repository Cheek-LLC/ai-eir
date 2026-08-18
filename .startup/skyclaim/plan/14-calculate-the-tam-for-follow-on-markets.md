# Step 14: TAM for Follow-on Markets

## Bowling pin sequence
Beachhead (storm-damage roofing contractors × freelance/small-shop pilots, TX/OK) → Pin 2:
independent public adjusters, same pilot supply → Pin 3: geographic expansion of the same
roofing-contractor/pilot pairing into a new hail corridor (Colorado Front Range).

## Follow-on market candidates

### Pin 2: Independent public adjusters (from Step 1's Segment 8)
- Adjacency logic: **reuses the supply side entirely** (the same vetted pilot pool) while adding a
  new demand-side category. Per this step's marketplace guidance, this is the highest-leverage
  kind of adjacency — solving the harder side once and monetizing it twice.
- TAM calculation (bottom-up, same GMV × take-rate method as Step 4): founder estimate — roughly
  120 independent public adjusters active in the TX/OK corridor (source: Derek's general industry
  familiarity, not independently verified), averaging an estimated ~40 properties/year each at the
  same $175/property rate = 120 × 40 × $175 ≈ **$840,000/year GMV**. Since this pin reuses the
  *same* supply pool already counted as the binding constraint in Step 4, this GMV is **additive
  demand against already-scarce supply, not incremental supply-side capacity** — flagged explicitly
  below, since simply adding this pin's take-rate revenue to the beachhead TAM would double-count
  against the same 350-pilot ceiling rather than expand it.
- TAM (take-rate, order-of-magnitude): ≈$150,000/year (18% of ≈$840K GMV) — **but this number is
  only real if Pin 2 doesn't simply crowd out beachhead demand for the same scarce pilot hours**;
  see flagged assumption.
- Trigger condition to pursue: once beachhead supply (pilot count) has grown meaningfully beyond
  the current ~4-in-conversation reality — pursuing Pin 2 before then would just compete with the
  beachhead for the same thin pilot pool.

### Pin 3: Geographic expansion — Colorado Front Range hail corridor
- Adjacency logic: reuses the *demand-side* category and business model exactly (same segment
  definition, same take-rate structure) while requiring an entirely new supply pool in a new
  geography — the inverse adjacency pattern from Pin 2.
- TAM calculation: not sized — Derek has zero existing relationships in Colorado on either side,
  and no founder-estimate basis exists yet for pilot or contractor counts there. Stated honestly as
  not yet sizeable rather than inventing a number by analogy to the TX/OK figures.
- Trigger condition to pursue: after the TX/OK beachhead reaches demonstrated liquidity (a
  measurable fill rate, not just signed contracts) — expanding geography before solving liquidity
  once would replicate the same unsolved problem in a second market simultaneously.

## Open assumptions
- `ka-014-pin2-supply-contention`: "Pin 2's follow-on TAM assumes new demand-side revenue without
  accounting for the fact that it competes with the beachhead for the same scarce supply pool —
  the additive TAM figure may overstate what's actually capturable without first growing total
  pilot supply." `step_ref`: `14_calculate_the_tam_for_follow_on_markets`, `confidence`: `low`,
  `test_plan`: "Model Pin 2 only once beachhead supply has grown past current levels; track actual
  pilot utilization/idle-capacity rate on the beachhead first," `test_result`: `null`.
- `ka-014-pin3-nosize`: "Pin 3 (Colorado) TAM was not calculated — no basis for pilot or
  contractor counts exists yet in that geography." `step_ref`:
  `14_calculate_the_tam_for_follow_on_markets`, `confidence`: `low`, `test_plan`: "Revisit only
  once the TX/OK beachhead has demonstrated real liquidity," `test_result`: `null`.

## Quantitative claims logged
```json
{ "id": "qc-014-pin2-tam", "claim": "TAM for follow-on market: independent public adjusters, TX/OK", "value": "≈$150,000/year (order-of-magnitude) = ~120 adjusters x ~40 properties/year x $175/property x 18% take rate", "step_ref": "14_calculate_the_tam_for_follow_on_markets", "source": "founder estimate, general industry familiarity — not independently verified; shares the same supply-contention caveat as ka-014-pin2-supply-contention", "confidence": "low", "ai_risk_flag": true }
```

## Mandatory AI-risk gate — before this step is reported done
Invoked `skills/risk/ai-risk-review` against this file plus the business-slug. **PASS**, with one
advisory (non-blocking) finding: `qc-014-pin2-tam` is correctly rounded to order-of-magnitude, but
the automation-bias check flagged that the "additive TAM" framing in the Pin 2 write-up could
still read as a clean incremental number to a skimming reader unless the supply-contention caveat
is read in full — recommended (not required) making that caveat more prominent if this file is
excerpted into the assembled plan. Logged as `ar-skyclaim-002`, `status: open`, advisory. No
blocking findings — Pin 3's absence of a number is stated honestly rather than invented, and the
false-precision discipline from Step 4's first-pass finding was applied proactively here.
