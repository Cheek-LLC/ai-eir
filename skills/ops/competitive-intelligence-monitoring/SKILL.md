---
name: competitive-intelligence-monitoring
description: >
  Use on an operating business (`stage: operating`, or late `gtm` post-soft-launch) to run a
  bounded, recurring competitive-intelligence pass against the specific competitors named in
  Step 11's chart: pricing changes, feature launches, messaging shifts, funding/hiring momentum
  signals, and review/rating trends. Also the place structured win/loss reason capture happens
  ("we lost to Competitor X" is not a finding — price vs. feature gap vs. brand trust vs. timing
  is), and where positioning drift against the Step 11 chart gets detected and scored against an
  explicit re-review threshold. Trigger phrases: "how are competitors doing," "check on
  <competitor>," "we lost a deal to," "is our positioning still right," "competitive check-in."
  Produces `.startup/<slug>/ops/competitive-intel-<timestamp>.md`. Bounded by design — includes an
  explicit time budget and anti-obsession discipline; this is not a mandate to watch competitors
  continuously.
---

# Competitive Intelligence Monitoring

## What this skill is

Step 11 (`skills/disciplined-entrepreneurship/11-chart-your-competitive-position`) produces a
one-time, plan-stage snapshot: a 2x2 chart plotting named competitors and the status quo against
the two axes Persona actually cares about. That snapshot goes stale the moment the market keeps
moving after the plan is written — a competitor ships a feature, cuts price, raises a round, or a
new entrant appears nobody had reason to name at the time. This skill is the ongoing discipline
that catches that staleness before it quietly invalidates the plan's competitive-position claim,
using real, dated, sourced observations — not a vague sense that "the market feels more crowded."

It does three distinct jobs, every pass: (1) monitor the named competitor roster on a fixed
cadence, (2) capture win/loss reasons in a structured, non-vibes way and watch for a pattern, and
(3) score whether what's been observed crosses an explicit threshold for "the plan needs a
re-review" versus "note it and move on." It also actively bounds itself — see the anti-pattern
discipline at the end — because unbounded competitor-watching is itself a way to avoid building.

## Reads

- `.startup/<slug>/business-state.json` in full — `business_basics` (business type, one-liner,
  drives which signal categories are even applicable, e.g. app-store ratings only for
  `consumer_app`), `stage` (confirm `operating`, or an explicit late-`gtm` founder request),
  `cadence.check_in_frequency` (this skill's own pass frequency is derived from it, see Step 2 —
  never run more often than that cadence allows without a real trigger event), `risk_log` (open
  entries, so a drift finding already logged isn't silently duplicated).
- `.startup/<slug>/plan/11-chart-your-competitive-position.md` — **required**. The named
  competitor roster, the chosen axes, the founder's own product position, and the defensibility
  judgment. This is the baseline every pass compares against.
- `.startup/<slug>/plan/10-define-your-core.md` — the specific defensibility claim a competitor's
  move might undermine (see Step 4 below).
- `.startup/<slug>/gtm/positioning.md`, if it exists — read-only, so a win/loss pattern finding can
  point at the exact section (objection handling, messaging pillars) that should be revisited,
  without this skill editing it itself.
- Every prior `.startup/<slug>/ops/competitive-intel-*.md`, in date order — required for the
  win/loss pattern aggregation in Step 3 and the drift trend in Step 4; a single pass in isolation
  cannot tell a one-off wobble from a real pattern.

## Step 1: Build or refresh the competitor roster

First pass: pull every named alternative from Step 11's "Alternatives considered" table, including
the status quo/do-nothing entry — that is the roster. Do not narrow it to "direct competitors
only"; Step 11 already established that the status quo is frequently the toughest competitor, and
this skill inherits that discipline rather than re-litigating it.

Every later pass: carry the roster forward, and add any genuinely new entrant discovered this
period (a competitor mentioned in a lost deal, surfaced by a WebSearch pass, or named by the
founder) with the date it was added and how it surfaced. A roster that only ever shrinks or never
grows across many passes is itself worth a one-line note — it usually means monitoring has gone
passive rather than the market has actually gone static.

## Step 2: Monitoring cadence — what to check, how often, where

**Cadence rule.** Run a full scheduled pass **no more often than monthly**, regardless of a
tighter `cadence.check_in_frequency` (weekly/biweekly check-ins do not need a competitive pass
every time — this mirrors `scaling-strategist`'s own "at most monthly" discipline, for the same
reason: forcing a fresh read on noisy, slow-moving signals produces false precision, not insight).
If `cadence.check_in_frequency` is `monthly` or slower, align the pass with that check-in
directly. If `manual`, run it when the founder asks or at a natural milestone (post-launch, after
a funding/pricing change of the founder's own).

**Event-triggered entries are separate from the scheduled pass and happen anytime.** A deal won or
lost against a named competitor gets logged in the win/loss log (Step 3) the moment it happens —
don't hold it for the next scheduled pass. Only the roster-wide pricing/feature/messaging/hiring
sweep is bound to the monthly cadence.

For each competitor on the roster, at each scheduled pass, check:

| Signal | What to check | Where | Read as |
|---|---|---|---|
| Pricing | Current published pricing tiers/rates vs. last pass's snapshot | Competitor's own pricing page (WebSearch/WebFetch) | A tier added/removed, or a >~15% list-price move on a tier Persona would actually buy |
| Feature launches | Changelog, product blog, release notes, or (for consumer-facing products) app store "what's new" | Competitor's own changelog/blog; WebSearch for "\<competitor\> changelog/release notes" | Does the shipped feature move the competitor's plotted position on either of Step 11's two axes — not just "did they ship something" |
| Messaging shifts | Homepage headline, subhead, and primary CTA | Competitor's homepage (WebSearch/WebFetch) | A reframed value prop, a new named enemy/alternative in their copy, or a pivot in who they claim to serve |
| Funding/hiring momentum | Funding announcements; open-role count and function mix on the careers page | Press/WebSearch for funding; competitor's own careers page for hiring | Used as a **momentum proxy only** — a funding round or a hiring surge in sales/GTM roles signals resourcing to compete harder, not a claim about product quality; a hiring surge concentrated in engineering suggests a feature push is coming, worth flagging ahead of the next pass |
| Reviews/ratings | Aggregate rating and recent review themes | G2/Capterra/Trustpilot for B2B software; App Store/Play Store for `consumer_app`; skip entirely and say so for business types with no public review surface (most `services`, many `physical_product`) | A material rating move (≳0.3 stars) or a recurring theme in recent reviews that names a gap your product could exploit, or a strength you're underestimating |

Every cell gets one of three states: a **sourced, dated observation** (what changed, with the URL
or search query used and the date checked), **"no change observed since \<last pass date\>,"** or
**"not checked this pass — \<reason, e.g. no public review surface for this business type\>."**
Never leave a cell blank — an unchecked cell and a checked-and-unchanged cell must not look the
same in the output, exactly as Step 11 itself requires for unverified competitor claims.

## Step 3: Win/loss capture — structured, not vibes

"We lost to Competitor X" is not a finding. The finding is *why*, in the prospect's or founder's
own words, mapped to a fixed reason taxonomy so patterns are actually countable across periods
instead of living as scattered anecdotes:

**Reason taxonomy (pick the primary one, a secondary if genuinely present):**
- **Price** — lost/won on cost, not capability.
- **Feature gap** — a specific named capability the competitor has and you don't (or vice versa).
- **Brand trust** — incumbent's reputation, references, or perceived risk of an unknown vendor.
- **Timing** — the prospect's need or budget cycle didn't align, not a product/price factor.
- **Relationship/incumbent switching cost** — already using the competitor, cost of migration.
- **Product fit/use case mismatch** — the prospect's actual use case wasn't what either product
  was really built for.
- **Other** — name it specifically; never leave a loss reason as an unlabeled "other."

For every deal won or lost this period where a named competitor was in play, capture: date, which
competitor, won/lost, primary reason, secondary reason (if any), and the **source** — a direct
quote from the prospect, sales-call notes, an exit survey, or the founder's own read if no
prospect conversation happened (label it "founder's read, no prospect confirmation" explicitly —
that's a materially weaker source than a prospect's own words, and the output must not blur the
two together).

**Never infer a reason from deal size, industry, or a guess.** If the founder genuinely doesn't
know why a deal was lost, record "unknown — no exit conversation happened" — that is itself a
finding (a process gap: the business isn't capturing why it loses), not something to paper over
with a plausible-sounding guess.

**Aggregate across periods, not just this pass.** Pull every win/loss entry from prior
`competitive-intel-*.md` files plus this period's, over a trailing ~90-day window, and count by
competitor × reason. **Three or more losses to the same named competitor citing the same primary
reason within that window is a pattern**, not noise — name it explicitly.

**Feed a real pattern back to positioning, by name.** When a pattern crosses that 3+ threshold,
the recommendation is concrete and names the exact place to act: "Re-run
`skills/gtm/positioning-and-messaging` — specifically its objection-handling section — with the
new evidence that \<Competitor\> is beating us on \<reason\> in \<N\> of the last \<M\> deals." Do
not just note the pattern and stop; say what should happen with it. This skill does not edit
`gtm/positioning.md` itself — that stays `marketing-strategist`'s and
`positioning-and-messaging`'s job — it hands off the finding with enough specificity to act on
directly.

## Step 4: Positioning-drift detection — an explicit threshold

Compare this pass's observations against Step 11's plotted chart, one competitor at a time, and
decide which bucket applies. This is a judgment call made against explicit criteria, not a feeling
that "things seem more competitive lately."

**Note it and move on — log one line in this pass's file, no `risk_log` entry, no escalation:**
- An isolated price move under ~15% on a single tier.
- A shipped feature that doesn't change the competitor's position on either of Step 11's two axes
  (it's still clearly behind on the axis Persona cares about).
- A single win or loss citing a competitor — one data point, not yet a pattern.
- Normal hiring/funding activity with no material change to the competitor's ability to compete on
  the two chosen axes specifically.

**Re-review warranted — append a `risk_log` entry (schema below) and escalate explicitly.** Any
**one** of the following crosses the line (they don't all need to co-occur):
1. A new entrant — not on the original Step 11 chart — now plots inside the founder's own stated
   differentiated quadrant on **both** axes.
2. A named incumbent's move (a shipped feature, a repricing, a funding round that visibly funds a
   price war) closes the gap on **both** axes at once, not just one — a one-axis move is a "note
   it" unless it was the axis carrying the whole differentiated position.
3. The win/loss pattern in Step 3 crosses its 3+/90-day threshold against the same competitor and
   reason.
4. A competitor's move directly undercuts the specific defensibility claim named in Step 10's
   Core — e.g. the Core is "faster time-to-value" and a competitor ships the exact onboarding
   automation that closes that gap. This is the live-market version of exactly what
   `competitive-strategy-reviewer` would flag as `[DEFENSIBILITY]` or `[COMPETITIVE-BLIND-SPOT]`
   if Step 11's chart were resubmitted unchanged today — hold this pass to that same bar.

**What "re-review warranted" means, concretely — and what it doesn't.** This skill does not decide
a pivot, does not redraw the Step 11 chart, and does not rewrite `plan/10-define-your-core.md` or
`plan/11-chart-your-competitive-position.md` itself — same boundary `operations-manager` holds on
TAM/segment drift. It names the specific criterion crossed, the evidence, and hands off. A
competitive shift material enough to invalidate the stated Core or beachhead position is, in
substance, the same category of pivot signal `operations-manager` already watches for (persistent
TAM/segment drift, on-segment churn) — this skill is the source that feeds that same escalation
path when the signal is competitive rather than internal-metrics-driven, logged the same way (a
`risk_log` entry, `type: "business"`) so the orchestrator or a later `operations-manager` pass
can weigh it alongside its own findings rather than this skill trying to act on it unilaterally.

**One crossed criterion is enough to escalate; it is not automatically a pivot.** Say plainly which
criterion fired and cite the evidence — whether it *becomes* a pivot (reopening Step 10/11, or
further back) is a call for the founder and the orchestrator, weighing this alongside whatever else
is happening in the business, not a threshold this skill crosses alone.

## Step 5: The anti-pattern — bounding this work

**Name it: "competitor-chasing."** Obsessive competitor-watching — checking daily, reacting to
every individual feature tweet with a roadmap conversation, treating every competitor blog post as
urgent — is not diligence. It is a socially-acceptable way to avoid the harder work of building,
and it produces worse decisions than a disciplined monthly pass does, because it optimizes for
reacting to noise instead of reading real signal.

**The discipline:**
- **A fixed time budget: ~30–45 minutes per scheduled pass.** State the actual time spent in the
  output file. If a pass runs materially over budget, say why (first-ever roster build-out, a
  genuine re-review-threshold event needing more digging) — don't let "just a bit more checking"
  become the default.
- **The "next 30 days" test.** Before writing more than one line about any single observation, ask:
  would this actually change what the founder ships or says in the next 30 days? If no, it's a
  one-line "note it and move on" entry — not a paragraph, not a flagged discussion topic.
- **This skill does not drive product decisions.** A competitor's feature launch is an input to
  `agents/product/*`'s own prioritization process, never a same-session trigger for an ad hoc
  roadmap change here. This skill's job ends at naming and logging the finding.
- **No daily/real-time alerting as an operating habit.** A founder is free to set up an automated
  watch (e.g. a page-change alert) for convenience, but *reviewing* it happens at the scheduled
  pass, not as a running distraction throughout the week.
- **Silence is a fine result.** If three consecutive scheduled passes produce zero re-review
  findings, the correct response is to keep the same monthly cadence, not to tighten it "just in
  case" — a quiet market is real information, not a sign of insufficient vigilance.

## Output file: `ops/competitive-intel-<timestamp>.md`

Timestamp format `YYYY-MM-DD`; append `-2`, `-3`… for a same-day rerun (e.g. an event-triggered
win/loss entry logged outside the scheduled pass).

```markdown
# Competitive Intelligence — <business name> — <date>

## Pass type
<Scheduled monthly pass | Event-triggered win/loss entry only>

## Competitor roster
| Competitor | Source (Step 11 / discovered <date>, how) | Status quo? |
|---|---|---|

## Monitoring pass — this period
| Competitor | Pricing | Feature launches | Messaging | Funding/hiring signal | Reviews/ratings | Net read vs. last pass |
|---|---|---|---|---|---|---|

(Every cell: a sourced dated observation, "no change observed since <date>," or "not checked this
pass — <reason>." Never leave a cell blank.)

## Win/loss log — this period
| Date | Deal | Won/Lost | Competitor named | Primary reason | Secondary reason | Source |
|---|---|---|---|---|---|---|

## Win/loss pattern — trailing ~90 days, cumulative across prior passes
<Count by competitor × reason. Explicitly flag any competitor/reason pair at 3+ within the window.>

## Positioning-drift read
<For each competitor/entrant with a material observation this pass: Step 11's plotted position vs.
this pass's read, per axis. State plainly which bucket applies per competitor — "note it and move
on" or the specific re-review criterion (1-4 above) crossed.>

**Verdict:** <"No material drift — note and move on" | "RE-REVIEW WARRANTED: <criterion number and
one-line evidence>">

## Feed to positioning-and-messaging
<If a win/loss pattern crossed the 3+/90-day threshold this pass, name the exact recommendation
per Step 3. Otherwise: "none this period.">

## Time spent this pass
<Stated plainly against the ~30-45 minute budget; explain any material overrun.>

## Next scheduled pass
<Date, per the cadence rule in Step 2.>
```

## Update `business-state.json`

Append `ops/competitive-intel-<timestamp>.md` to `ops.cadence_metrics_files`. If this pass's
verdict is **RE-REVIEW WARRANTED**, append a `risk_log` entry (never duplicate one already `open`
for the same competitor/criterion — check first):

```json
{
  "id": "ops-<slug>-<sequential-number>",
  "type": "business",
  "raised_by": "competitive-intelligence-lead",
  "description": "string — name the competitor/entrant, the specific criterion crossed (1-4 above), the sourced evidence, the Step 11 axis or Step 10 Core claim it implicates, and what a re-review should check first",
  "status": "open"
}
```

Increment `<sequential-number>` from the highest existing `ops-<slug>-*` id. Read-modify-write the
whole file; preserve every other key untouched; update `updated_at`. Never set `status` to
anything but `open` yourself.

## Never fabricate

- Win/loss reasons are the founder's or prospect's actual words this period, or "unknown — no exit
  conversation happened." Never infer a reason from deal size, industry guess, or pattern-matching
  to a prior loss.
- Any competitor pricing, feature, or metric claim stated as fact needs a source (URL + date
  checked) via WebSearch/WebFetch. Where a claim can't be verified this pass, mark it "estimated —
  unverified" in the table — the same convention Step 11 itself uses for unsourced competitor
  positions — and say explicitly whether a search was attempted and failed to confirm, or wasn't
  attempted this pass; a skipped check and an inconclusive one must not read the same.

## Done means

- The roster traces to Step 11 (plus any dated, sourced additions).
- Every monitoring-pass cell is a sourced observation, an explicit "no change," or an explicit
  "not checked" with a reason — never blank.
- Every win/loss entry has a primary reason from the fixed taxonomy and a labeled source (or
  "unknown," honestly).
- The cumulative win/loss pattern was actually computed across prior files, not just this period.
- The positioning-drift verdict is stated explicitly against the four numbered criteria, not as a
  vague impression.
- Time spent is stated against the ~30-45 minute budget.
- `ops/competitive-intel-<timestamp>.md` is written and registered in `business-state.json`; a
  `risk_log` entry exists for every RE-REVIEW WARRANTED verdict, never left as file-only prose.
