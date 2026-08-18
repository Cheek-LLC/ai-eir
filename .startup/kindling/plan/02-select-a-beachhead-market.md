# Step 2: Select a Beachhead Market

**Note on business-type branching:** this step's SKILL.md "Business-type branching" section also
lists only SaaS / Physical product / Marketplace / Services — no `consumer_app` bullet, and unlike
Step 1 there isn't even a generic B2C fallback question here. Scored "reach" and "competitive
intensity" using the consumer-app-specific prompts Steps 5/9/11 *do* carry (personal network +
online community access; other apps competing for the same attention slice) since nothing in this
step itself told me what "reach" means for a consumer app. Flagged for the QA record.

## Candidates carried from Step 1

Segment 1 (sketch-a-day artists), Segment 2 (daily creative writers), Segment 4 (daily instrument
practice), Segment 9 (photo-a-day, general).

## Scoring matrix

| Segment | Reach | Sizing fit | Reason to buy | Word of mouth | Right to win | Follow-on path | Values fit | Competitive intensity | Total |
|---|---|---|---|---|---|---|---|---|---|
| 1. Sketch-a-day artists | 5 | 3 | 4 | 5 | 5 | 5 | 5 | 4 | **36** |
| 2. Daily creative writers | 2 | 3 | 4 | 3 | 2 | 4 | 4 | 3 | 25 |
| 4. Daily instrument practice | 1 | 3 | 3 | 3 | 1 | 3 | 3 | 3 | 20 |
| 9. Photo-a-day, general | 2 | 3 | 3 | 3 | 2 | 3 | 3 | 2 | 21 |

Scoring notes:
- **Reach** for segment 1 scores 5 because Priya is personally embedded in two active local
  sketch-meetup groups and several art Discord servers — she can plausibly reach real people this
  week, and did (the pilot). Segments 2/4/9 score low because she has no comparable personal
  standing in writing, music, or photography communities — she'd be a cold outsider there.
- **Right to win** for segment 1 scores 5: she's a hobbyist illustrator herself, ran the pilot in
  exactly this community, and has credibility other founders wouldn't. Segment 4 scores 1 — she
  doesn't play an instrument and has zero standing in that community.
- **Competitive intensity** for segment 1 (4, favorable) reflects that no product currently
  combines creative-specific streak mechanics with small-group accountability; general habit apps
  (Streaks, Duolingo) and pure creative tools (Procreate) both exist but neither does this.

## Selected beachhead market

**Segment 1: hobbyist sketch/drawing practitioners in the US, active in online or in-person art
communities, who have attempted and abandoned a self-directed daily sketch practice in the past 12
months.** This wins overwhelmingly on reach and right-to-win — the two criteria that matter most
at idea stage, when the founder's own access is the binding constraint, not raw market size. The
informal pilot is direct evidence this segment responds to the core mechanic (accountability
pods), not a guess.

## Runner-ups and why they were not selected

- **Segment 2 (daily creative writers)** — real mechanic fit, but zero founder reach into that
  community today; selecting it now would mean starting from zero on distribution, the opposite of
  what a beachhead is for. Kept as the leading pin-2 candidate (Step 14).
- **Segment 9 (photo-a-day)** — mechanically closest to segment 1, but the existing community
  (general photography hobbyists) is larger, more fragmented, and Priya has no standing in it; the
  artifact (a photo) is also a lower bar to produce than a sketch, which may make the "abandon
  within 2-3 weeks" pain less acute — untested, flagged.

## Bowling-pin path

Beachhead (sketch-a-day) → Pin 2: daily creative writers (same accountability-circle mechanic,
reuses the app's core tech, founder would need to build community credibility from scratch) → Pin
3: daily instrument practice (mechanic still transfers — proof-of-completion becomes an audio clip
or a logged practice session instead of a photo — but the biggest lift of the three, since neither
the mechanic's audio-artifact handling nor the founder's community access exist yet).

## Assumptions flagged

- `ka-002-segment2-reach` — statement: "Assumes the accountability-circle mechanic transfers
  cleanly to a text-based creative-writing artifact without material product changes." `step_ref:
  02_select_a_beachhead_market`, `confidence: low`, `test_plan: "prototype a text-submission
  variant of the daily check-in with a small writing-community pilot before committing engineering
  time to pin 2"`, `test_result: null`.
