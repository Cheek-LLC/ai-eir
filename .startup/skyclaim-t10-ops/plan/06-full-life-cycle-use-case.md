# Step 6: Full Life Cycle Use Case

## Persona
Marcus Webb (supply, primary) and Big Ray Delgado (demand, secondary) — Step 5.

## Stage-by-stage map — SUPPLY TRACK (Marcus)
| Stage | Who's involved | What happens | Persona's state of mind | Product's role/touchpoint | Drop-off risk |
|---|---|---|---|---|---|
| Trigger | Marcus | A slow week in his real-estate business, or a storm alert circulates in his network | "I have open capacity, is there paid work?" | Push notification of nearby open jobs (not yet built) | High — if no jobs are visible when he checks, he disengages and doesn't come back |
| Search/discovery | Marcus | Checks SkyClaim (today: checks the Facebook group / waits for Derek to call) | Skeptical, been burned by a race-to-the-bottom gig platform before | Job board / listing screen | Medium — first impression of job quality/pricing sets trust |
| Evaluation | Marcus | Reviews job details: location, property count, pay rate, deadline | "Is this worth my Saturday?" | Clear job posting with real pay shown up front | Medium — vague or lowball postings lose him |
| Decision & purchase | Marcus | Accepts the job | Committed, but still can back out if something better comes up | One-tap accept | Low once he's this far, if the accept flow is simple |
| Onboarding/first use | Marcus | First flight, uploads imagery/report | Focused on doing the job well — reputation matters to him | Upload/report-submission flow | High — a clunky upload process on job #1 could sour a good pilot on ever coming back |
| Ongoing use | Marcus | Repeat job acceptance over subsequent weeks/storms | Building trust in the marketplace as a real income source | Repeat job visibility, ratings/reputation | Medium — depends on job volume staying real |
| Support/service | Marcus | Payment questions, dispute over a rejected report | Wants to be paid fast and fairly | Payout tracking, dispute process | High — a slow or unfair payout dispute is the single fastest way to lose a pilot permanently |
| Renewal/expansion/disposal | Marcus | Keeps checking the app weekly, or stops if jobs dry up | "Is this still worth checking?" | Ongoing job flow / re-engagement prompts | High — thin, spiky demand (storm-driven) means long quiet stretches are a real disposal risk |

## Stage-by-stage map — DEMAND TRACK (Big Ray)
| Stage | Who's involved | What happens | Persona's state of mind | Product's role/touchpoint | Drop-off risk |
|---|---|---|---|---|---|
| Trigger | Ray, his ops manager | A hailstorm hits his operating area | Urgency, "how fast can I get roofs documented" | Storm-alert-aware booking prompt (not yet built) | Low — trigger is externally forced, not discretionary |
| Search/discovery | Ray's ops manager | Opens SkyClaim instead of calling Derek directly | "Will this actually be faster than calling Derek?" | Booking flow that's at least as fast as a phone call | High — if the marketplace flow is slower than "just call Derek," it loses on its own value prop |
| Evaluation | Ops manager | Checks whether enough pilots are available in the affected radius | "Will someone actually show up today?" | Real-time pilot-availability display | High — the core liquidity risk; an empty-looking map kills trust immediately |
| Decision & purchase | Ops manager, sometimes Ray (owner) for a new vendor relationship | Posts the job, sets deadline | Wants confidence it'll be covered | Job-posting flow with clear pricing | Medium |
| Onboarding/first use | Ops manager | Receives first delivered report | Judges whether the report is "insurance-ready" | Report format/quality | High — if the report doesn't hold up with a carrier adjuster, the whole value prop collapses (this is the veto-holder risk carried into Step 12) |
| Ongoing use | Ops manager | Books repeatedly across a storm season | Building a habit of using SkyClaim over the old method | Consistent job fulfillment | Medium |
| Support/service | Ops manager | Handles a rare no-show or quality dispute | Risk-averse, low tolerance for failure during a claim-window crunch | Dispute/resolution process, backup pilot assignment | High |
| Renewal/expansion/disposal | Ray, ops manager | Next storm season, or a quiet off-season stretch | "Do I default back to my old in-house-pilot process?" | Off-season engagement / readiness signal | Medium — off-season demand may genuinely be near-zero, a real seasonality fact, not a drop-off failure |

## Narrative walkthrough
The two tracks meet only at the moment of a booked job — everything before and after diverges
sharply, exactly as the marketplace branching guidance warns. The single highest-leverage
touchpoint on the whole map is the demand-side "evaluation" stage (does the availability map show
real, nearby pilots) — if supply liquidity is thin, that stage fails silently and no amount of
good product design downstream fixes it.

## Biggest drop-off risk
**Demand-side evaluation stage (liquidity visibility).** A contractor who opens the app during a
storm surge and sees no available pilots nearby will not wait around — they'll call Derek
directly (undermining the marketplace) or default to their in-house pilot/ladder crew. This is
the single point where thin early supply (Step 4's binding constraint) directly threatens
demand-side adoption, tying this step's finding straight back to Step 4's TAM math.

## Assumptions flagged
- `ka-006-liquidity-visibility`: "Assumes a real-time pilot-availability display is what demand-
  side users actually need to trust the marketplace (vs., e.g., a guaranteed-response-time
  promise instead) — not yet tested with a real product." `step_ref`:
  `06_full_life_cycle_use_case`, `confidence`: `low`, `test_plan`: "Test both approaches (live map
  vs. guaranteed SLA) with the first 5 real demand-side bookings during Step 22's MVBP," `test_result`: `null`.
