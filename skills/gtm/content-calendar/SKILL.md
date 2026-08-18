---
name: content-calendar
description: >
  Use when `agents/gtm/marketing-strategist.md` needs an actual, dated, channel-specific content
  and social calendar for launch — not general "post consistently" guidance. Requires
  `gtm/positioning.md` to already exist (run `positioning-and-messaging` first if it doesn't) and
  builds every post's topic directly off its messaging pillars. Reads the plan's beachhead
  channels (step 2), persona media habits (steps 3/5), and next-10-customers list (step 9) to
  choose real channels instead of defaulting to generic social platforms. Produces
  `.startup/<slug>/gtm/content-calendar.md`: a specific multi-week table (channel, format,
  topic, CTA, owner per post) covering pre-launch through the first month post-launch, plus a
  repeatable ongoing weekly cadence. Trigger on requests for a content calendar, social
  calendar, or content plan for launch.
---

# Content calendar

You are producing a calendar someone could execute from tomorrow morning without asking "wait,
post what, where?" Every row needs a real topic, a real channel chosen because the persona is
actually there, and a real call to action — not "engage with audience."

## Required precondition

Read `.startup/<slug>/gtm/positioning.md`. If it doesn't exist, stop and report that
`positioning-and-messaging` must run first — do not draft content topics from a fresh read of the
plan; they must derive from the finished messaging pillars so all GTM content stays on-message.

## What you read

- `gtm/positioning.md` — messaging pillars (each becomes a content theme/pillar in the calendar)
  and the elevator pitches (source material for launch-day posts).
- `plan/02-select-a-beachhead-market.md` — where this specific beachhead actually spends
  attention (trade publications, communities, forums, events, specific platforms named in the
  plan). Use these over defaulting to "LinkedIn + Twitter/X" — if the plan says the beachhead
  lives in a specific Slack community, a vertical trade newsletter, or a subreddit, that outranks
  generic social.
- `plan/03-build-an-end-user-profile.md` and `plan/05-profile-the-persona-for-the-beachhead-market.md`
  — the persona's actual media consumption habits and where they look for solutions.
  `plan/09-identify-your-next-10-customers.md` — if it names specific people/companies, at least
  one touchpoint in the calendar should be a direct, personalized outreach tie-in (not a cold
  broadcast) coordinated with `outbound-sales-playbook`'s sequence, so content and outbound
  reinforce each other rather than running as separate motions.

If the plan gives no real evidence of where this beachhead spends attention, don't default
silently to generic channels — flag the gap and pick the most defensible option given whatever
partial evidence exists (e.g. "step 2 doesn't name a specific channel, but the persona's day-in-
the-life in step 5 mentions checking industry newsletter X — using that as the primary channel
pending founder confirmation").

## Deliverable: `.startup/<slug>/gtm/content-calendar.md`

### 1. Content pillars

Map each `gtm/positioning.md` messaging pillar to a content pillar (a recurring theme), 1:1 or
close to it. State the split (e.g. "40% value-prop proof, 30% competitive differentiation, 20%
credibility/traction, 10% behind-the-scenes/founder voice") and why that mix fits this business
stage (a pre-launch business leans more credibility-building; a business with real step-23
traction leans more proof).

### 2. The calendar — 6 weeks, dated, one row per post

A real table: `Week | Date | Channel | Format | Topic / Headline | CTA | Owner | Pillar`.

- Cover: 2 weeks pre-launch, launch week, 3 weeks post-launch (6 weeks total minimum — extend if
  the launch plan's pre-launch phase is longer).
- **Channel**: name the actual platform/publication/community, not "social media."
- **Format**: be specific — "carousel post," "600-word LinkedIn article," "founder video (60s),"
  "email to waitlist," "guest post pitch," "community AMA thread" — not "content."
- **Topic/Headline**: an actual draft headline or subject line, not a category label.
- **CTA**: the specific action the post drives ("join waitlist at [X]," "reply with your biggest
  [pain point]," "book a 15-min demo," "reply for early access code") — every post needs one,
  even awareness-stage posts (CTA can be "reply/comment" to build the algorithm signal, but state
  that's the intent).
- **Owner**: `founder` unless there's a clear reason another role would post it.
- At least 2 posts per week minimum during pre-launch/launch, tapering to a sustainable post-
  launch cadence — do not pad the table with filler posts just to hit a count; fewer, sharper
  posts beat volume.

### 3. Launch-day sequence

Call out launch day specifically: the exact sequence of posts across channels that day (order
matters — e.g. owned channel/email first to the warmest audience, then broader platforms), each
tied to a specific elevator pitch length from `positioning.md`.

### 4. Ongoing cadence template (post 6-week window)

A repeatable weekly template (not dated) for content ops to continue past the initial push: e.g.
"1x proof-point post, 1x educational/how-to post, 1x community engagement, 1x founder-voice post"
— with the same channel-specificity as above. State explicitly that this is what
`marketing-strategist` (or the founder) executes going forward; it's a template, not itself a
schedule with dates.

## Write-back

Write `.startup/<slug>/gtm/content-calendar.md`. Report back to `marketing-strategist` that it's
complete (or what's blocking it — most likely a missing `positioning.md`). This skill does not
update `business-state.json` itself.
