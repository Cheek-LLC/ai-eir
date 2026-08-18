# Interview Log — Kindling

## 2026-08-18 — Onboarding interview

**Opening.** Delivered the "30-Minute Startup" expectations framing verbatim in spirit (this is a
hook, not a 30-minute promise; real rigor takes real time). Founder acknowledged and was ready to
proceed across one long session.

**Phase 1 — Founder & business basics**

- Business name: **Kindling** (founder already had this name; confirmed, no rename needed).
- Founder: **Priya Shah**. No email offered; not required, did not ask.
- One-liner, first pass: "It's an app that helps people keep up a creative hobby." — flagged as a
  platitude per the vague-answer playbook ("small businesses"-shaped: no named customer, no named
  problem). Pushed back: "If you could only sell to one specific type of person for the next six
  months, who would it be?" Second pass, accepted: *"A daily-practice app for people trying to
  build a creative habit — sketching first — who keep quitting alone. Small 'circles' of real
  friends see your streak and nudge you back when you miss a day."* Names a real customer type
  (solo hobbyist creatives who've tried and dropped a self-directed practice) and a real problem
  (quitting alone). Recorded as `business_basics.one_liner`.
- Venture stage: **idea_only**, with one important qualifier — Priya ran an informal, non-app
  pilot: a private WhatsApp group ("Sketch Streak Squad") + a shared Google Sheet, recruited 14
  friends from two local sketch-meetup groups she's active in, ran it Jan 6–Feb 16, 2026 (6 weeks).
  9 of 14 kept posting a daily sketch photo at ≥5 days/week through the full 6 weeks; 5 dropped by
  week 3. No app exists yet — this was entirely manual. Captured as the follow-up per the
  venture-stage protocol.
- Funding intent: asked directly. Priya hasn't formed a view — "I genuinely don't know yet, I
  haven't thought about whether this needs outside money or could just grow slowly." Recorded
  `funding_intent: undecided` per the "don't push for a decision they haven't made" instruction.

**Mandatory privacy notice.** Ran `skills/risk/privacy-check` Mode A immediately after business
basics, before any business-type framing question. Delivered the local-storage/legal-scope notice
in full (everything stored in `.startup/kindling/`, nothing transmits externally without an
explicit later connector action, this is a planning aid not legal/financial/tax advice, and a
plain ask not to paste in real people's sensitive personal data). Priya acknowledged. Logged
`privacy-onboarding-kindling` to `risk_log`, `status: accepted`.

**Phase 2 — Business-type framing**

Offered the five categories. Priya picked **consumer app** immediately — "mobile app, people pay
for it themselves, no B2B sales process at all."

Differentiator follow-ups (consumer app track):
- *How does it make money?* Freemium: ad-supported free tier (one discipline — sketching — plus
  basic streak tracking, banner ads + an occasional interstitial after check-in) and a paid tier
  ($6.99/mo or $49.99/yr) that removes ads, unlocks all disciplines (sketching, writing,
  photography at launch), unlocks 30-day themed "premium challenges," and adds 2 streak-freeze
  tokens/month.
- *How do people find it?* Personal network first (Priya's own two sketch-meetup communities and a
  handful of art Discord servers she's in), then niche community seeding (r/SketchDaily, art
  Discord servers, a Product Hunt launch) — explicitly **not** paid acquisition to start; Priya
  has no paid-UA budget or experience yet and said so plainly.

Recorded `business_basics.business_type: consumer_app`, and the full detail above into
`business_basics.business_type_notes`.

**Notable pushback moments during onboarding**

- When asked about competitors, first answer was "there's nothing else like it." Pushed back per
  the "we have no competitors" row. Second pass: named Procreate (drawing tool, no habit/social
  layer), Duolingo and the Streaks app (habit/streak mechanics, wrong domain), and — after a
  further nudge — "honestly, just posting to my own Instagram alone, or the SketchDaily subreddit
  itself with no product wrapped around it" as the real status quo. This became real input to
  Step 11.
- Pricing: first answer was "we'll figure that out later." Applied the "give me a real number
  anyway" push. Priya named $6.99/mo "because that's what a lot of habit apps charge," self-
  described as an anchor guess, not tested. Logged as low-confidence going into Step 16.

**Key assumptions logged during onboarding**

- `ka-000-pricing-anchor` — statement: "Founder's $6.99/mo price anchor is copied from comparable
  apps' pricing, not tested with any real prospect." `step_ref: onboarding`, `confidence: low`,
  `test_plan: "state the real price during the MVBP beta (Step 22) and observe conversion"`,
  `test_result: null`. (Carried forward into Step 16's own assumption register rather than
  duplicated.)

**Closing.** Read back the summary: Kindling, consumer app, idea_only with an informal 14-person
manual pilot, funding intent undecided. Priya confirmed accuracy. Told her what's next (Step 1,
market segmentation) and that this would span a long session, not 30 minutes. She elected to keep
going now. `stage` left at `"interview"` for the orchestrator to advance.
