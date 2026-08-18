# Step 2: Select a Beachhead Market

## Candidates carried from Step 1
- Demand: Segment 7 (storm-damage roofing contractors, 10-50 crews) vs. Segment 8 (independent
  public adjusters)
- Supply: Segments 1+2 (freelance operators + small drone shops) vs. Segment 4 (retired
  ag/survey pilots)

Per the marketplace branching rule, reach is scored **per side**, and a segment pairing is only a
real beachhead candidate if both sides are plausibly reachable at the same time — not just the
more attractive side.

## Scoring matrix
| Segment (Side) | Reach | Sizing fit | Reason to buy | Word of mouth | Right to win | Follow-on path | Values fit | Competitive intensity | Total |
|---|---|---|---|---|---|---|---|---|---|
| Storm-damage roofing contractors, TX/OK Hail Alley (demand) | 5 — Derek has 6 existing direct clients here, all willing to try the marketplace | 3 — real but modest at beachhead scope (see Step 4) | 5 — urgent, event-driven, existential during storm surge | 4 — tight-knit trade-association community (Roofing Contractors Association of Texas chapter) | 5 — 8 years of direct operating credibility in exactly this niche | 4 — clear pins (adjusters, CAT teams, property mgmt) | 5 — Derek's stated mission is literally "stop being the bottleneck" | 4 — fragmented; only general-purpose gig drone platforms (DroneBase-style) compete, not roof/claims-specialized | 35 |
| Independent public adjusters (demand) | 2 — zero existing relationships, unknown community structure | 2 — smaller average order size, unclear volume | 4 — real but less structurally urgent than contractor segment | 2 — unknown whether adjusters reference each other the way contractors do | 2 — no domain credibility with adjusters specifically | 3 — plausible pin from the roofing beachhead later | 3 — neutral | 3 — unknown, not researched | 21 |
| Freelance operators + small drone shops (supply) | 5 — ~12 known pilots, several already informally willing | 4 — enough density in one metro to start; regional expansion path clear | 4 — real income-diversification motive, not urgent but genuine | 4 — active regional Facebook groups and a DFW drone meetup Derek already attends | 5 — Derek is a peer in this exact community, not an outsider | 4 — same supply pool serves multiple demand pins | 4 — good fit, no major concerns | 3 — some competition from general gig-drone platforms for pilot attention | 33 |
| Retired ag/survey pilots (supply) | 2 — only 1 named contact (Tom Whitfield), reached via a warm intro, not a direct network | 2 — unclear how many exist in-region | 3 — plausible but unconfirmed motive fit | 2 — no known community structure for this specific sub-group | 2 — Derek has no ag/survey industry background | 2 — unclear | 3 — neutral | 3 — unknown | 19 |

## Selected beachhead market
**Storm-damage insurance-claim roofing contractors (demand, 10-50 crews, TX/OK Hail Alley
corridor) paired with full-time freelance drone operators and small drone-service companies
(supply, same geography).** This pairing wins decisively on both sides' totals (35 and 33 vs. 21
and 19 for the runner-ups) and — critically for a marketplace — is the *only* pairing where
Derek has real, warm reach on **both** sides simultaneously: existing direct clients on demand,
existing peer relationships on supply. Per the marketplace branching rule, a segment reachable on
only one side is not yet a real beachhead candidate; this is the one pairing that clears that bar
on both sides at once.

## Runner-ups and why they were not selected
- **Independent public adjusters (demand):** real need, but zero existing relationships and an
  unresearched community structure make it a weaker near-term beachhead than the roofing-
  contractor segment where Derek already has 6 live client relationships.
- **Retired ag/survey pilots (supply):** only one named contact; insufficient density to seed a
  reliable early supply pool on its own, though worth continuing to explore as a secondary
  channel alongside the primary supply beachhead.

## Bowling-pin path
Beachhead (storm-damage roofing contractors × freelance/small-shop pilots, TX/OK) → Pin 2:
independent public adjusters as a new demand category on the *same* pilot supply pool → Pin 3:
geographic expansion of the same two-sided category (roofing contractors + freelance pilots) into
a new hail-prone corridor (e.g., Colorado Front Range). Both pins reuse an already-solved side per
the marketplace adjacency logic (see Step 14).

## Assumptions flagged
- The "reach" score of 5/5 on the demand side rests on Derek's 6 existing clients being willing to
  route bookings through a marketplace instead of calling him personally — confirmed informally,
  not yet tested with a real marketplace booking flow. `key_assumptions` entry:
  `ka-002-existing-clients-marketplace-adoption` — "Assumes Derek's 6 existing direct clients will
  adopt the marketplace booking flow rather than continuing to call Derek personally," `step_ref`:
  `02_select_a_beachhead_market`, `confidence`: `low`, `test_plan`: "Route the next real storm-
  season booking from an existing client through the marketplace flow instead of a direct call and
  observe whether they accept it," `test_result`: `null`.
