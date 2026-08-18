# Step 13: Map the Process to Acquire a Paying Customer

Business-type branching used: **Consumer app** — "almost always a single-person, self-serve
funnel with no DMU roles beyond the one user." Confirmed against Step 12's DMU (collapsed to one
person, with a real Influencer/Recommender role feeding the top of the funnel).

## DMU roles (from Step 12)

- Champion / End User / Economic Buyer: same person (the installing user)
- Influencer/Recommender: the friend who invites her, or the community (Discord/Reddit) where she
  discovers it
- No saboteur/blocker, no procurement — collapsed per Step 12

## Acquisition process map

| Stage | DMU role(s) active | Trigger into this stage | What they need to believe | Objection | What kills the deal here | Unblocked by |
|---|---|---|---|---|---|---|
| 1. Discovery | Influencer/Recommender (friend, or a Discord/Reddit post) + the user | Friend's invite link, or seeing a post in a community she's already in | "This might actually be different from the last thing I tried" | "I've tried this before and it didn't stick" (skepticism from a prior failed attempt) | A generic-looking pitch that reads like every other streak app | A friend's personal invite (much stronger than an ad or a cold post) |
| 2. Install | User | Taps the App Store link | "Free to try, low risk" | None material — free install is low-friction | App Store friction (slow load, bad reviews visible) | Clean App Store listing, real (not manufactured) reviews once they exist |
| 3. First prompt (pre-signup) | User | App opens directly to today's prompt | "Did this actually feel different in the first 60 seconds?" | "Another signup wall / another thing asking for my email before I even see anything" | A signup wall before the first prompt (explicitly avoided per Step 7) | The prompt-before-signup flow itself |
| 4. Circle formation | User + real friends (Influencer/Recommender role, now activated) | Prompted right after first submission to invite 2-3 real people | "Will my friends actually join, or will I look weird asking?" | Social awkwardness of inviting friends to a new app | No one accepts the invite; user ends up in the founder-curated "starter circle" of strangers (untested, `ka-007-starter-circle`) | A low-friction, personal-feeling invite flow ("who do you want to see this?") |
| 5. Paid conversion | User | Hits the free-tier single-discipline limit, or wants to remove ads | "Is $6.99/mo or $49.99/yr worth it for what I'm actually getting" | Untested price point (`ka-016-price-point`) — genuinely unknown whether this converts | Price resistance, or simply never hitting the limit because engagement fades first | Demonstrated value from weeks of real circle engagement before the paywall is hit |

## Open assumptions

- `ka-013-circle-invite-friction` — statement: "Assumes users will accept the social awkwardness of
  inviting real friends to a new, unproven app; this is untested outside the pilot's pre-existing
  WhatsApp group, where the group already existed before the 'ask.'" `step_ref:
  13_map_the_process_to_acquire_a_paying_customer`, `confidence: low`, `test_plan: "measure the
  actual invite-acceptance rate in the MVBP beta cohort, since the pilot never tested a cold
  in-app invite flow"`, `test_result: null`.

## Notes for Step 18

Stage 4 (circle formation) is the stage most likely to be the longest and riskiest to cost out —
it's the one stage where product mechanics (not just marketing spend) determine whether the funnel
actually converts into the differentiated behavior this whole business is betting on.
