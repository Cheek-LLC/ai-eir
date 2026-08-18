# Step 1: Market Segmentation

**Note on business-type branching:** `docs/DE-24-STEPS.md`/this step's own SKILL.md
"Business-type branching" section lists SaaS, Physical product, Marketplace, and Services —
**no `consumer_app` bullet exists here.** Fell back to the generic B2C interview question
("What demographics, life stages, occasions, or use contexts could plausibly buy this?") since
that's the only consumer-facing prompt this step offers. Flagged for the QA record; see
`docs/QA-FINDINGS-ROUND5.md`.

## Starting point

Market pull, not tech push: Priya didn't build technology looking for a use — she personally
struggled to keep a solo sketching habit going, then watched an informal accountability pod
(WhatsApp + spreadsheet) work where solo effort hadn't. The product exists to reproduce that pod
effect deliberately, for other people, in other creative disciplines.

## Candidate segments

| # | Segment name | End user | Distinct need | Why it's heterogeneous from other segments | Source |
|---|---|---|---|---|---|
| 1 | Aspiring sketch-a-day artists (Instagram/TikTok art-challenge followers who quit within 2-3 weeks) | Hobbyist visual artists, 22-45, own a tablet or sketchbook | Accountability to sustain a daily practice they've already tried and dropped | Tried-and-abandoned pattern + strong existing online community (hashtags, Discords) to seed through | founder-identified |
| 2 | Amateur creative writers trying to journal/write daily | Adults attempting "morning pages" / daily fiction practice | Same accountability gap, different discipline and community (r/writing, NaNoWriMo Discord) | Different content format (text vs. image), different community norms | candidate — needs validation |
| 3 | New parents trying to maintain a photography habit documenting their kids | New parents, 28-40 | Wants a "photo a day" record but loses steam by month 2 | Motivation is documentation/memory, not skill-building — different value prop entirely | candidate — needs validation |
| 4 | Musicians practicing an instrument daily | Adult amateur instrumentalists returning to an instrument | Same accountability gap, but practice sessions are audio/time-based, not a single artifact | Different proof-of-completion mechanic (a recording or a timer, not a photo) | candidate — needs validation |
| 5 | College students building a study-habit streak (Pomodoro/study accountability) | Undergrads, 18-22 | Academic discipline, not creative — adjacent mechanic, very different motivation | Studying isn't a creative practice; different distinguishing characteristic (grades, not joy) | candidate — needs validation |
| 6 | Home cooks trying a new-recipe-per-week habit | Adults 25-55 who cook | Weekly not daily cadence; artifact is a meal, not shareable the same way | Cadence mismatch (weekly vs. daily) makes the core streak mechanic behave differently | candidate — needs validation |
| 7 | Meditation/mindfulness dabblers | Broad adult population | Habit-formation need, but category is already dominated (Headspace, Calm) | Adjacent mechanic, saturated incumbent category, no creative/social-artifact component | candidate — needs validation |
| 8 | Knitting/needlework hobbyists maintaining a project-a-day pace | Adults, skews 35-65 | Slower per-session completion (a project spans days, not one artifact/day) | Streak unit doesn't map cleanly to "one thing finished per day" the way sketching does | candidate — needs validation |
| 9 | Amateur photographers doing "photo a day" challenges (not parent-specific) | Adult hobbyist photographers | Similar to segment 1 but artifact is a photo, existing community is r/photography-adjacent | Different existing community and different skill-development arc than drawing | candidate — needs validation |
| 10 | Fitness streak trackers (running/workout habit) | General fitness hobbyists | Habit-formation need, but category is saturated (Strava, Duolingo-style streak apps) and not creative | Explicitly rejected from the candidate pool early — see note below | founder-identified |
| 11 | Journaling for early sobriety/recovery support, structured daily check-ins | Adults in early recovery | Real accountability need, but centers on sensitive personal health/recovery data | **Not pursued.** Priya has no lived expertise in recovery support, and this would require handling sensitive personal health data and a compliance posture this business isn't scoped for. Surfaced during brainstorming (a friend mentioned a recovery app) and explicitly set aside — see Step 2. | candidate — needs validation, explicitly rejected |
| 12 | Language-learning hobbyists (daily practice streak) | Adults learning a new language | Habit-formation need, but category is dominated by Duolingo specifically, and the "artifact" (a completed lesson) isn't personally expressive the way a sketch or a paragraph is | Different mechanic (lesson completion vs. creative output) and an entrenched incumbent | candidate — needs validation |
| 13 | Amateur woodworkers/makers logging shop-time projects | Adults, skews male, 30-60 | Project cadence mismatch similar to segment 8; artifact isn't quick to produce or photograph mid-process | Slow-cadence mismatch, plus a real existing community (r/woodworking) that behaves differently | candidate — needs validation |

## Segments carried forward to Step 2

- **Segment 1 (sketch-a-day artists)** — the segment the informal pilot already validated directly;
  strongest reach, strongest founder credibility.
- **Segment 2 (daily creative writers)** — same core mechanic, second discipline planned for
  launch, real adjacent community.
- **Segment 4 (daily instrument practice)** — same mechanic, distinct community, plausible pin 3.
- **Segment 9 (photo-a-day, general)** — same mechanic as segment 1, different artifact type,
  worth scoring against segment 1 directly since they could compete for the same beachhead slot.

## Assumptions flagged

- `ka-001-segment-breadth` — statement: "Segments 2-9 and 12-13 beyond segment 1 are candidate
  extrapolations from the founder's own reasoning about adjacent creative-practice communities,
  not independently validated with real conversations in those communities." `step_ref:
  01_market_segmentation`, `confidence: low`, `test_plan: "run 5 exploratory conversations in each
  of the top 2-3 non-segment-1 candidates before treating any of them as a real pin-2/pin-3
  choice"`, `test_result: null`.
