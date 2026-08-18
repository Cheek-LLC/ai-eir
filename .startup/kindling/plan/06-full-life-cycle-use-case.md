# Step 6: Full Life Cycle Use Case

Business-type branching used: **Consumer app.**

## Persona

Maya Torres (Step 5) — a hobbyist sketcher who's tried and dropped a solo streak before.

## Stage-by-stage map

| Stage | Who's involved | What happens | Persona's state of mind | Product's role/touchpoint | Drop-off risk |
|---|---|---|---|---|---|
| Trigger | Maya, no one else | Sees a friend's post in the app or hears about it from her meetup group; recalls her own abandoned streak | "Maybe this time it'll actually stick" — hopeful, slightly skeptical from past failure | App-store listing / word-of-mouth mention | Skepticism from a prior failed attempt |
| Search/discovery | Maya, possibly a friend who invites her | App Store search, or a direct link from a friend's invite; niche communities (Discord/Reddit) for cold discovery | Curious but low-commitment | App Store listing, a friend's invite link | Low — discovery is cheap for this persona |
| Evaluation | Maya | Reads the app-store description, sees it's free to start | "What's the catch / will this actually be different" | Free tier framing, no paywall before first value | Bouncing before install if the pitch reads like "just another streak app" |
| Decision & purchase (install) | Maya | Installs; no payment required yet (free tier) | Low friction — "worst case I delete it" | App Store install flow | Standard app-store install drop-off |
| Onboarding/first use | Maya | Picks "sketching," sees today's prompt immediately with **no signup wall before the first prompt** | This is the highest-risk moment in the whole life cycle — she's deciding in the first 60 seconds whether this feels different from the last app she tried | First-prompt-before-signup flow (see Step 7's consumer-app branch) | **Single highest drop-off point** — if the first 60 seconds don't feel different from a generic streak app, she uninstalls |
| Ongoing use | Maya + her circle (once joined) | Daily prompt, photo check-in, sees circle members' check-ins, occasional nudge notification if she's about to miss a day | Motivated by visibility to real people, not by the app itself | Daily prompt + circle feed + streak-freeze token | Circle not yet joined (see below) is the second highest drop-off risk |
| Support/service | Maya | Rarely needed at this scale — no support staff yet; manual founder-handled if she emails | Low expectations for support from a small app | Founder-monitored inbox (manual, unscalable, flagged in Step 22) | N/A at this stage |
| Renewal/expansion/disposal | Maya | **No formal renewal moment for the free tier at all** — engagement just quietly decays toward an uninstall if the habit doesn't stick, or converts to paid if she hits the free-tier discipline limit and wants more | Either "this became a real habit" or a slow fade with no single decision point | Paid-conversion prompt at the free-tier discipline limit; otherwise nothing forces a decision | Silent decay — this is explicitly named as the risk pattern this business-type branch warns about, rather than assuming a subscription-style renewal event exists |

## Narrative walkthrough

The single most consequential change from a generic "habit app" life cycle is that **joining a
circle is not part of onboarding — it happens after the first prompt is completed**, deliberately,
per Step 7's product-spec decision. That means the life cycle has two distinct "make or break"
moments rather than one: the first 60 seconds (does the first prompt feel worth continuing), and
the first circle-join (does she actually invite or accept real people, or does she stay solo and
quietly behave like she would have on a generic streak app). The pilot data (Step 8/17) suggests
the second moment is where the real behavior difference from "just another streak app" shows up —
solo pilot dropouts averaged ~12 days before quitting; circle members averaged 34+ days and several
were still going at the pilot's end.

## Biggest drop-off risk

**Onboarding/first use**, specifically the decision of whether the first prompt feels
differentiated enough in the first 60 seconds to keep going — and, second, whether she actually
forms or joins a circle at all, since the whole differentiated value proposition depends on that
step happening, and nothing in the free flow currently forces it.

## Assumptions flagged

- `ka-006-circle-join-rate` — statement: "No real data yet on what share of new users actually
  form/join a circle after their first prompt, versus staying solo (and behaving like a generic
  streak-app user with no accountability effect)." `step_ref: 06_full_life_cycle_use_case`,
  `confidence: low`, `test_plan: "instrument this specific funnel step in the MVBP beta and measure
  it directly — this is one of the two things Step 22's MVBP is explicitly designed to prove"`,
  `test_result: null`.
