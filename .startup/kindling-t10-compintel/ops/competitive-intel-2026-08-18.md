# Competitive Intelligence — Kindling — 2026-08-18

## QA note on applicability (read before the rest of this file)
`business-state.json.stage` is `"revising"` (plan v1 was REJECTed by the balanced council panel;
no MVBP has launched; `gtm.status` is `not_started`). The skill's own stated scope is "an operating
business (`stage: operating`, or late `gtm` post-soft-launch)." Neither condition holds here. This
pass was run anyway, at the parent QA task's explicit direction, to exercise the skill's mechanics
(roster build, monitoring sweep, win/loss taxonomy, drift-detection threshold) — **not** as a
claim that this pass would legitimately fire in real operation at this stage. See
`docs/QA-FINDINGS-COMPETITIVEINTEL-ROUND10.md` for the applicability-gap finding this surfaced.

## Pass type
First-ever pass (roster build-out) — founder/QA-initiated ad hoc pass (cadence is `manual`, so per
Step 2 there is no scheduled date to align to). Includes one event-triggered win/loss entry
captured in the same session rather than held for a later pass, per Step 2's rule that win/loss
entries are logged immediately.

**All competitive-development content below that is not a WebSearch/WebFetch citation is a
role-played test scenario, invented for this dry run, and is labeled ROLE-PLAYED explicitly
wherever it appears. It is not a claim about anything Duolingo, Procreate, or Streaks has actually
done.**

## Competitor roster
| Competitor | Source (Step 11 / discovered \<date\>, how) | Status quo? |
|---|---|---|
| Status quo (solo Instagram posting / doing nothing) | Step 11 | Yes |
| Procreate | Step 11 | No |
| Duolingo | Step 11 | No |
| Streaks app | Step 11 | No |
| r/SketchDaily | Step 11 | No |

No new entrants discovered this pass beyond Step 11's roster (real search) plus one ROLE-PLAYED
hypothetical Duolingo feature, below — the hypothetical does not add a new roster row since
Duolingo is already on the roster.

## Monitoring pass — this period

| Competitor | Pricing | Feature launches | Messaging | Funding/hiring signal | Reviews/ratings | Net read vs. last pass |
|---|---|---|---|---|---|---|
| Status quo (Instagram) | Not checked — status quo is a behavior, not a company with a pricing/feature/marketing surface to monitor. | Not checked — same reason. | Not checked — same reason. | Not checked — same reason. | Not checked — same reason. | No baseline to compare against (first pass); still the default "do nothing" alternative. |
| Procreate | Not checked — WebFetch to `apps.apple.com` was blocked by this session's network egress proxy (`EGRESS_BLOCKED`); no alternate pricing source attempted this pass. | Sourced, dated 2026-08-18 (WebSearch): 5.4 update (June 2026) added 180 new brushes + brush-library search/folders/iCloud sync; improved palm rejection/pressure sensitivity; animation-tool improvements; Procreate 6 for Mac announced as upcoming; publicly reaffirmed no generative-AI features. | Not checked this pass. | Not checked this pass. | Not checked this pass. | Deepens single-discipline tool strength (Y-axis); does not touch accountability/social layer (X-axis stays Low). No axis change vs. Step 11's plotted position — **note it and move on**. |
| Duolingo | Sourced, dated 2026-08-18 (WebSearch): Free/Super (~$95.99/yr US)/Max (~$167.99/yr US)/Family tiers unchanged in structure from what Step 11 assumed; no new tier or list-price move identified this pass. | **ROLE-PLAYED, not real:** hypothetical "Duolingo Sketch" pilot — a new content vertical for daily sketch practice with small "accountability pods" (3-6 users, streak visibility + nudges), explicitly reusing Duolingo's proven streak/social mechanic in a new creative domain. Invented for this test; see drift analysis below. | Not checked this pass (real). | Sourced, dated 2026-08-18 (WebSearch): ~56 open roles per Glassdoor/aggregator listings; live Sales/Marketing/Partnerships roles including an Ad Sales Lead and a Senior Account Executive for Duolingo Ads; also actively hiring AI/ML engineers for monetization and personalization. Read as: **momentum proxy only** — sales hiring signals continued monetization push, not evidence of the ROLE-PLAYED sketch feature; ML hiring is monetization/personalization-focused, not a specific signal of a creative-content push. | Not checked this pass. | Real signals: no material change vs. Step 11 (still High accountability / Low breadth). **ROLE-PLAYED hypothetical feature, if real, would move Duolingo's Y-axis position — see drift analysis below.** |
| Streaks app | Sourced, dated 2026-08-18 (WebSearch, multiple aggregator sources): one-time-purchase price increased to **$5.99** (from a prior ~$4.99), reported as of ~July 2026; still a one-time purchase, no subscription, no free trial. **This is a real, ~20% list-price move on Streaks' only tier — see the threshold-ambiguity note below.** | Not checked this pass — no changelog/release-notes search attempted. | Not checked this pass. | Not checked this pass. | Sourced, dated 2026-08-18 (WebSearch): ~27,000+ ratings, 4.82 stars average; ~3.0M estimated iOS downloads, ~782K estimated MAU (third-party estimate, not an official Apple figure — flagged as estimated). No material rating-theme signal surfaced in this search depth. | Price move noted (see below); no axis-position change (still Medium accountability / Low breadth, per Step 11) — **note it and move on**, with the threshold-ambiguity flagged separately. |
| r/SketchDaily | Not checked — no pricing surface (community, not a company). | Not checked this pass — no search attempted. | Not checked this pass. | Not checked — not applicable (community, not a company). | Not checked this pass. | No observation this pass; carried forward unchanged from Step 11. |

**Threshold-ambiguity note (real, not role-played):** Streaks' sourced ~$4.99→$5.99 move is a
single-tier repricing over the note-it bucket's own "~15%" illustrative figure, but it does not
close any gap on either of Step 11's two axes (Streaks stays Medium accountability / Low breadth
either way) — and none of Step 4's four numbered RE-REVIEW criteria mention price magnitude on its
own; "repricing" only appears inside criterion 2, which requires a **both-axis** gap closure. Read
literally, this means **no dollar or percentage price move, by itself, with no axis effect, can
ever cross this skill's re-review threshold** — the "~15%" figure in the note-it bucket is
illustrative color, not an independent trigger. Applying that literal reading: **note it and move
on.** Flagged in the QA findings file as evidence the threshold's own wording is easy to misread as
"a big-enough price move alone escalates," when in practice only an axis-moving price move does.

## Win/loss log — this period
| Date | Deal | Won/Lost | Competitor named | Primary reason | Secondary reason | Source |
|---|---|---|---|---|---|---|
| 2026-08-18 | **ROLE-PLAYED, not real:** closed-beta interest decline — a second-sketch-meetup-group contact Priya had personally invited to the MVBP beta waitlist | Lost | Duolingo (specifically the ROLE-PLAYED "Duolingo Sketch" pods feature above) | Feature gap — the prospect said Duolingo's new pods feature now covers the specific accountability mechanic Kindling was pitching | Relationship/incumbent switching cost — prospect is already a daily Duolingo user; adopting Duolingo's new feature had zero switching cost vs. installing a new app | Direct quote (role-played), attributed to the prospect via DM: "I already started a sketch streak with two friends inside Duolingo's new thing — don't think I need two apps for the same habit right now." |

## Win/loss pattern — trailing ~90 days, cumulative across prior passes
No prior `competitive-intel-*.md` files exist for this business (`ops.cadence_metrics_files` was
empty before this pass) — this is the entire trailing-90-day window. **Count: Duolingo × Feature
gap = 1.** This is a single data point, explicitly **not** a pattern per the skill's fixed 3+/90-day
threshold. Correctly does not trigger the Step 3 escalation — flagged here only so the counting
mechanism itself is visibly exercised, not asserted as a real trend from one entry.

## Positioning-drift read

**Procreate** — Step 11: Low accountability / High breadth. This pass's real, sourced feature
activity (brush tooling, performance, animation, upcoming Mac version) deepens the High-breadth
side further but adds no accountability/social layer. No axis-position change. **Note it and move
on.**

**Streaks** — Step 11: Medium accountability / Low breadth. Real, sourced price increase only; no
axis-position change. **Note it and move on** (see threshold-ambiguity note above).

**r/SketchDaily, status quo** — no material observation this pass; carried forward unchanged.

**Duolingo — ROLE-PLAYED scenario only.** Step 11 plots Duolingo at High accountability / Low
breadth ("structurally similar mechanic, entirely different content"). The invented "Duolingo
Sketch" pods feature would, if real, plausibly move Duolingo's **Y-axis (creative breadth)**
upward into the sketching domain specifically, while its **X-axis (accountability)** stays High —
it was already tied with Kindling's own High rating on that axis, per Step 11's chart.

Applying Step 4's criteria literally surfaces a real gap in how to score this: criterion 2 requires
a move that "closes the gap on **both** axes at once, not just one." Here, X was never a gap to
close — Duolingo and Kindling are already both plotted High — so only Y actually moves. Read most
literally, that's a one-axis move, which the note-it bucket's parenthetical would treat as
non-escalating "unless it was the axis carrying the whole differentiated position." But Step 11's
own "Your differentiated position" section explicitly frames Kindling's differentiation as the
**combination** of both axes together, not either axis alone carrying it — so the skill's "the axis
carrying the whole differentiated position" language has no clean referent for a chart drawn this
way. There is no way to answer "which axis carries the position" as asked, because Step 11 itself
says neither one does alone.

**Judgment call made for this pass (stated explicitly, not left implicit):** because Duolingo was
already at parity with Kindling on X, a Y-axis-only move that also closes real distance on Y leaves
Kindling with *no axis where it is still clearly, uniquely ahead* — functionally the same end state
as criterion 2's both-axes case, even though only one axis technically "moved." Scored as
**RE-REVIEW WARRANTED, criterion 2**, on that reasoning, with the ambiguity spelled out rather than
resolved silently.

**Verdict:** RE-REVIEW WARRANTED: criterion 2 (Duolingo's ROLE-PLAYED sketch-pods feature would
close the remaining gap on creative breadth while already matching Kindling on accountability
structure, per Step 11's own axes) — **contingent on this being a role-played test scenario, not a
real observation; see risk_log entry below, which states that plainly.**

## Feed to positioning-and-messaging
None this period — the single Duolingo win/loss entry (1 of 1) does not cross the 3+/90-day
pattern threshold, so no positioning-and-messaging hand-off is warranted from Step 3 this pass.

## Time spent this pass
~40 minutes: 3 initial WebSearches (Duolingo pricing, Streaks pricing, Procreate features), 1
blocked WebFetch attempt (Procreate App Store page), 2 follow-up WebSearches (Duolingo hiring,
Streaks ratings), plus roster build-out, win/loss and drift-detection reasoning, and this file. At
the upper edge of the ~30-45 minute budget, consistent with the skill's explicit carve-out for a
first-ever roster build-out pass.

## Next scheduled pass
No fixed date — `cadence.check_in_frequency` is `manual`, so per Step 2's cadence rule the next
pass runs "when the founder asks or at a natural milestone" (e.g., MVBP beta launch). Separately:
per the applicability-gap QA note at the top of this file, a real next pass arguably shouldn't be
scheduled at all until `stage` reaches `operating` or late `gtm`.
