# Step 13: Map the Process to Acquire a Paying Customer

## DMU roles (from Step 12)
- Champion: ambiguous — sometimes the Director of Ops themself, sometimes a GM who escalates
- Economic buyer / decision maker: Director of Operations (or Owner/Operator for smaller groups)
- End user: GM/shift manager
- Influencer(s): peer Directors of Operations in Maria's franchise-association network
- Saboteur/blocker: franchisor IT/brand-standards team (brand-specific, not universal)
- Procurement/legal: not typically present at this unit-count band

## Acquisition process map
| Stage | DMU role(s) active | Trigger into this stage | What they need to believe | Objection | What kills the deal here | Unblocked by |
|---|---|---|---|---|---|---|
| 1. Awareness | Director of Ops | Hears about ShiftCover from a peer in the franchise-association network | "This is a real problem other operators like me are actually solving, not vaporware" | "I've heard pitches like this before" | No credible peer reference | A specific named peer group already using it (not yet true — pre-pilot) |
| 2. First conversation | Director of Ops, Maria | Director of Ops takes a call/demo | Demo shows the actual SMS flow working end-to-end | "Will my GMs actually use one more tool?" | Demo feels theoretical, not grounded in their actual roster/workflow | A live demo using their own roster structure (via the CSV import) |
| 3. Champion/internal buy-in | Champion (Director of Ops or an escalating GM), 1-2 other GMs informally consulted | Director of Ops floats it informally with a couple of GMs before committing | GMs don't roll their eyes at "one more corporate tool" | GM skepticism from past mandated-tool fatigue (Jordan's exact frustration, Step 5) | GMs push back hard enough that Director of Ops shelves it | Framing it explicitly as "this replaces your call list," not "one more system" |
| 4. Franchisor check (brand-dependent) | Franchisor IT/brand-standards (only if applicable) | Director of Ops checks whether third-party tools touching roster data need sign-off | Confirms no franchisor veto applies, or gets sign-off | Franchisor policy restricts data-sharing tools | Franchisor says no | Not yet known how to unblock — see `ka-012-franchisor-veto` |
| 5. Contract & pricing discussion | Director of Ops | Pricing presented per Step 16 | Price feels justified against Step 8's value case | "Why per-location, not one flat group fee?" | Perceived price doesn't match perceived value, especially before any pilot proof exists | A pilot period at a subset of locations before full-group commitment |
| 6. Signed & paid | Director of Ops | Contract signed, first payment processed | — | — | — | — |

## Open assumptions
- `ka-012-franchisor-veto`: carried from Step 12, directly affects Stage 4 above.
- New: `ka-013-pilot-needed`: see below.

```json
{ "id": "ka-013-pilot-needed", "statement": "Assumes Directors of Operations will want a paid pilot at a subset of locations before committing the full group, rather than signing a full-group contract outright — not yet tested with a real prospect.", "step_ref": "13_map_the_process_to_acquire_a_paying_customer", "confidence": "low", "test_plan": "Ask this directly in the first real sales conversation with prospect #1 (Alex Torres, Copperline Burgers).", "test_result": null }
```

## Notes for Step 18
Stage 3 (champion/internal buy-in) and Stage 4 (franchisor check) are the two stages most likely
to be the longest and riskiest to cost out — Stage 3 because it depends on informal GM sentiment
Maria can't directly control, and Stage 4 because it's binary and brand-specific (kills the deal
entirely for some brands, doesn't apply at all for others).
