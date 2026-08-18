# Step 15: Design a Business Model

## Value capture logic (from Step 8)
Value metric: incremental income (supply) / capacity-unlock (demand). Value quantified: ≈$300-525/
month per active pilot (supply); directional, unquantified capacity value (demand).

## Archetypes considered
| Archetype | Fits? | Why / why not | Effect on COCA | Effect on LTV | Operational requirement |
|---|---|---|---|---|---|
| Subscription (either side) | No | Neither side thinks in subscription terms — contractors buy per-job during spiky demand, pilots are paid per-flight; a subscription fights the natural buying rhythm of both sides | Would likely raise COCA (harder sell) | Unclear — subscription revenue is more predictable but mismatched to actual usage pattern | Billing infrastructure for recurring charges |
| Usage-based / take-rate (marketplace commission) | **Yes — selected** | Matches both sides' existing mental models exactly: contractors already pay Osei Aerial per job today, pilots are already paid per flight | Lower COCA — no unfamiliar buying motion to sell against | LTV scales naturally with actual usage, not a flat guess | Payment split/escrow infrastructure (collect from demand, remit to supply minus take rate) |
| Listing/subscription fee on supply | No — explicitly rejected | Charging pilots to list would actively suppress the exact thing SkyClaim needs most right now (more supply) — directly contradicts Step 4's finding that supply is the binding constraint | Would raise supply-side COCA further, worsening the binding constraint | N/A — actively harmful to the more urgent problem | N/A |
| Freemium / advertising | No | No third party to advertise to yet; not a content/attention product | N/A | N/A | N/A |
| Franchise | No | Not a replicable local-operator model in the relevant sense | N/A | N/A | N/A |
| Fee-for-service (project-based) | No — this is what's being replaced | This is literally Osei Aerial's current model (Derek personally billing per job) — the pivot exists specifically to move past this, since it doesn't scale beyond one pilot | N/A | N/A | N/A |

Per this step's marketplace guidance ("which side pays is the actual decision, and it's rarely
symmetric — state explicitly which side is price-sensitive enough that charging them would kill
liquidity, and price the other side instead"): **supply (pilots) is the price-sensitive,
liquidity-critical side** per Step 4/9's findings — charging them anything would work directly
against the binding constraint. **Demand (contractors) pays the full job price**, already
comfortable with per-job billing from 3 years of paying Derek the same way.

## Selected model
**Marketplace take-rate: demand-side contractor pays the full job price to SkyClaim; SkyClaim
remits the pilot's payout (job price minus take rate) to the pilot.** No fee charged to supply.
Decisive rationale: matches both sides' existing mental models (lowest-friction adoption path per
Step 13's acquisition maps), and avoids suppressing the side Step 4 already identified as the
binding constraint on the whole business.

## Open assumptions
- `ka-015-take-rate-tolerance`: "Assumes contractors will tolerate the marketplace's take rate
  being invisible to them (they see one job price, same as paying Derek directly today) while
  pilots will tolerate seeing the take rate deducted from their payout — not yet tested with a
  real transaction on either side." `step_ref`: `15_design_a_business_model`, `confidence`: `low`,
  `test_plan`: "Run the first 3 real MVBP transactions (Step 22) and ask both sides directly how
  the pricing/payout structure felt," `test_result`: `null`.

## Dependencies flagged for Step 22 (MVBP)
- Payment split/escrow capability (or, for the MVBP, a manual invoice-and-Venmo-style workaround)
  must exist before a real transaction can close end to end.
