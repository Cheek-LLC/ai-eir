---
name: investor-updates-and-cap-table-basics
description: >
  Use once a business has actually raised or is actively raising outside capital and needs
  ongoing investor relations — a recurring monthly/quarterly investor update, or founder
  questions about ownership dilution, option pools, or how a SAFE/convertible note converts.
  This is the sequel to `skills/gtm/fundraising-deck-prep`: that skill builds the initial pitch
  deck to win the round, this skill runs the relationship after money is in the door. Drafts a
  real, named investor-update format (Headline, Key Metrics, Wins, Challenges & Asks, What's
  Next) using only numbers already on record in `ops.cadence_metrics_files` and
  `quantitative_claims` — never invented figures — and teaches fully-diluted vs. non-diluted
  ownership, option-pool-refresh mechanics, and SAFE/note conversion math plainly enough for a
  founder to not get blindsided by their own cap table. Produces
  `.startup/<slug>/gtm/investor-update-<timestamp>.md`. States once that real cap-table
  management needs a licensed cap-table tool or lawyer, not this plugin.
---

# Investor Updates and Cap-Table Basics

## What this skill is

The pitch deck gets you the money. This skill runs the relationship after that — the recurring
update that keeps investors informed and useful instead of anxious and silent, plus enough
cap-table literacy that a founder understands what they actually own before a term sheet forces
them to find out the hard way. Two distinct jobs, one skill, because they share the same
discipline: every number stated has to be real and sourced, and ownership math is unforgiving of
hand-waving.

This runs whether or not `gtm.funding_strategy` is currently `raising_outside_capital` — a
business that already closed a round keeps sending updates to its existing investors regardless
of whether it's actively raising again. Confirm with the founder that there are investors to
update (a prior round closed, or `gtm/fundraising-deck-brief.md` exists and a raise is underway)
before running Step 1; if neither is true, there's no audience for an investor update yet and
this skill isn't applicable.

## What you read

- `.startup/<slug>/business-state.json` `ops.cadence_metrics_files` — the most recent entry is
  the update's entire factual basis for metrics. If it's more than one full cadence period old
  (per `cadence.check_in_frequency`), say so in the update rather than presenting stale numbers
  as current.
- `.startup/<slug>/business-state.json` `quantitative_claims` — any plan-level number referenced
  (TAM, LTV:COCA, pricing) must trace to a sourced entry here, same discipline as
  `fundraising-deck-prep`.
- `.startup/<slug>/business-state.json` `gtm.funding_strategy` — confirms this business's capital
  strategy; also check `gtm.artifacts` for an existing `fundraising-deck-brief` or `pitch-deck` so
  the update's narrative doesn't contradict what investors were already told.
- The most recent prior `.startup/<slug>/gtm/investor-update-*.md`, if one exists — for
  period-over-period continuity (a metric that was "watch this" last time needs a follow-up this
  time, not silence).
- `.startup/<slug>/ops/*-finance-metrics.md` (most recent) — runway and burn belong in every
  update; pull the classification (`Critical`/`Warning`/`Watch`/`Healthy`) directly from
  `runway-and-burn-tracking`'s output rather than recomputing it.
- `.startup/<slug>/risk_log` entries with `status: "open"` and `type: "business"` — a material
  drift finding investors should hear about from the founder, in the update, not discover later.

Never invent a metric that isn't in one of these files. If the founder wants a number in the
update that isn't tracked anywhere, that's a live gap — name it as "not yet tracked" in the
update and flag it to `operations-manager`/`weekly-metrics-review`'s next run, don't estimate one
to fill the space.

---

## Part 1: The investor update

### The format

Use this five-part structure — it's the shape that shows up, independently, across almost every
credible operator's and investor's own advice on the subject (YC's own guidance to portfolio
companies, and the "boring, consistent, honest" advice repeated by seed investors who actually
read these things), because it optimizes for the one thing investors are actually trying to do
with an update: decide in under two minutes whether the company is on track, and know exactly
what to do if they want to help.

1. **Headline** — one sentence, the single most important thing that happened this period. Not
   a summary of everything; the one fact that would matter if the reader stopped there. If the
   period was bad, the headline says so plainly ("Churn spiked to 9% this month, here's what we
   found and what we're doing") — it does not open with a vanity metric to soften what's coming
   two sections down.
2. **Key metrics** — a small table, period-over-period, pulled directly from the most recent
   `ops/*-metrics.md` file(s): the 3-6 numbers that actually indicate whether the business is
   working (not every metric on the dashboard — the ones that matter). Include the plan-vs-actual
   comparison where one exists (e.g. actual COCA vs. the step-19 figure) because investors weight
   a founder who tracks against their own stated model far more than one who reports raw numbers
   with no reference point. Runway and its classification go here every time, not just when it's
   bad.
3. **Wins** — real, specific, dated. "Closed our first two enterprise pilots (Acme Co, Beta
   Corp)" beats "great momentum this month." If there's a genuinely quiet period with no wins,
   say "no major wins this period" rather than manufacturing one — investors notice manufactured
   wins fast and it costs more credibility than an honest quiet month ever does.
4. **Challenges & asks** — the two things founders skip and shouldn't:
   - **The real challenge**, not a softened version of it. If churn is up, say the number, say
     the likely cause if known, say what's being done. This is the section most founders bury or
     omit, and it's exactly the section investors trust most when it's there and distrust the
     whole update for when it's missing — a founder update with zero challenges, ever, reads as
     either dishonest or not paying attention, and experienced investors treat it that way.
   - **The ask**, stated as a specific request with a specific action, not a vague "let us know if
     you can help." See "How to ask for help beyond money" below — an update with no ask when the
     founder actually needs something is a missed use of a channel that exists specifically for
     this.
5. **What's next** — the 2-4 things the team is focused on before the next update, concrete
   enough that the next update can honestly report against them (this is what turns updates into
   an accountability loop instead of a monthly PR exercise).

### What NOT to do

- **Do not bury a bad number.** A declining metric goes in Key Metrics at full visibility, and in
  the Headline if it's the most important fact this period — not softened into a subordinate
  clause in paragraph four, not omitted with the hope no one asks in the next board call. Investors
  who find a hidden bad number later trust every subsequent update less, permanently. Surfacing it
  yourself, with a plan, is the entire value of sending updates at all.
- **Do not send an update with no ask when the founder actually needs something.** Silence reads
  as "everything's fine, don't bother us" even when it isn't true — the founder loses access to
  exactly the help investors are positioned to give (see Part 3). If there's genuinely nothing
  needed this period, say "no specific ask this period" explicitly rather than leaving the section
  blank — a blank section looks like an oversight, not a deliberate "we're fine."
- **Do not pad Key Metrics with vanity numbers that don't map to anything in `quantitative_claims`
  or `ops.cadence_metrics_files`.** Total signups-ever, app downloads, or press mentions are not a
  substitute for the metrics that show the business model working.
- **Do not skip an update because the period was bad.** A missed update during a rough patch is
  the single strongest signal to an investor that something is wrong — worse than the bad number
  itself would have been.
- **Do not let the update run long.** Two minutes to read, in full. If the founder wants to say
  more, that's what a reply or a call is for — the update's job is the fast, honest scan.

### Output file: `gtm/investor-update-<timestamp>.md`

Timestamp format `YYYY-MM-DD`; append `-2`, `-3`... for a same-day rerun.

```markdown
# Investor Update — <business name> — <date>

_Planning aid drafted from this business's own tracked metrics — not financial, legal, or
securities-compliance advice. Verify every figure before sending._

## Headline
<one sentence>

## Key metrics
| Metric | This period | Last period | Plan comparison (if applicable) | Source |
|---|---|---|---|---|
| ... | ... | ... | ... | ops/<file> or quantitative_claims id |
| Runway | N.N months | ... | — | ops/<finance-metrics file>, classification: <...> |

## Wins
- <specific, dated, sourced — or "no major wins this period">

## Challenges & asks
**Challenge:** <the real one, plainly stated, with what's being done>
**Ask:** <specific request — see "how to ask" below — or "no specific ask this period">

## What's next
- <2-4 concrete commitments the next update will report against>

## Open items from last update
<Follow-up on anything flagged "watch this" or asked-for last time — or "n/a, first update">
```

### Update `business-state.json`

Append `{ "type": "investor-update", "file": "gtm/investor-update-<timestamp>.md" }` to
`gtm.artifacts`, preserving the rest of the array. This skill does not touch `stage`, `plan`,
`reviews`, `risk_log`, or `ops.cadence_metrics_files` itself — it only reads those.

---

## Part 2: Cap-table literacy basics

This section is founder education, not a cap-table record. It exists so a founder can read a
term sheet, an option grant, or a SAFE conversion notice and understand what it actually does to
their ownership — not so this plugin can track real shares. See the boundary at the end.

### Fully-diluted vs. non-diluted ownership

**Non-diluted (or "outstanding") ownership** is the percentage based only on shares actually
issued today — founders' shares, investors' shares already converted, options already granted and
exercised. **Fully-diluted ownership** adds everything that *could* become shares: the entire
authorized-but-unissued option pool, unexercised options already granted, and every outstanding
SAFE/convertible note as if it converted today.

A founder who only tracks non-diluted ownership sees a bigger number than they actually have.
Fully-diluted is the number that matters for every real decision — what a founder's stake is
worth in an acquisition, what percentage a new option grant actually costs to fund, what a
new investor's percentage really works out to. Always ask "diluted by what?" when a percentage is
quoted, and default to fully-diluted for any planning decision.

### What an option pool refresh does to existing holders

An option pool is shares set aside for future employee grants. Two things matter about it:

1. **A pool refresh dilutes only existing shareholders, not new money, when it's created
   pre-money (before a new investment lands).** This is standard, expected, and often demanded
   by the incoming investor as a term — but founders routinely underestimate how much it costs
   them specifically, because the dilution is baked into the pre-money valuation rather than
   shown as a separate line.

2. **Worked example.** Founders hold 8,000,000 shares (100% today, no pool). A new investor
   offers to invest at terms that give them 20% of the company post-money, and requires a
   15%-of-post-money unallocated option pool, created *before* their investment (the standard
   structure):

   ```
   Investor share:      20%  →  new money
   New option pool:      15%  →  created pre-money, dilutes existing holders only
   Founders' remaining:  65%  →  must equal their 8,000,000 shares
   ```

   Total post-money share count: `8,000,000 ÷ 0.65 = 12,307,692` shares.
   - Investor receives `20% × 12,307,692 = 2,461,538` shares.
   - New pool receives `15% × 12,307,692 = 1,846,154` shares.
   - Founders still hold 8,000,000 shares — but that's now **65%**, not the 80% a naive
     "we're selling 20%" read would suggest. The pool refresh, not the investment itself, cost
     the founders the other 15 points.

   Compare: if that same 15% pool were instead created *after* the investment (post-money, pro
   rata across everyone including the new investor), the new investor would also absorb some of
   that dilution and founders would retain more. Whether the pool is pre- or post-money is a
   negotiated term, not a formality — it is worth asking about explicitly, every round, because
   the difference is real percentage points of the founders' own company.

### SAFE / convertible note conversion, explained plainly

A SAFE (Simple Agreement for Future Equity) or convertible note is not equity yet — it's a
promise that the investor's money converts into equity later, at the next priced round, on terms
set now. The two terms that matter:

- **Valuation cap** — the maximum company valuation the investor's money converts at, regardless
  of what the priced round actually values the company at. Protects the investor from a much
  higher valuation diluting their early money down to nothing.
- **Discount** — a flat percentage off the priced round's per-share price, as a floor benefit even
  if the cap doesn't end up being the binding term.

Most SAFEs pay the investor **whichever of the two produces more shares** (the lower effective
price per share).

**Worked example.** A SAFE investor put in $250,000 with a $5,000,000 cap and a 20% discount. The
company later raises a priced round at a $10,000,000 pre-money valuation, $2.00/share, on
10,000,000 fully-diluted shares outstanding at signing.

```
Cap price       = $5,000,000 cap ÷ 10,000,000 shares  = $0.50/share
Discount price  = $2.00/share × (1 − 20%)              = $1.60/share
SAFE converts at the LOWER price → $0.50/share (the cap wins here)
Shares issued to SAFE holder = $250,000 ÷ $0.50 = 500,000 shares
```

That investor ends up with meaningfully more shares — and more dilution to everyone else — than
their $250,000 at the new round's $2.00 headline price would suggest. This is normal and
expected; it's the compensation for taking risk before the company had a priced valuation. The
part founders miss is the next point.

**Why this matters before there's even a fundraise to track.** Multiple SAFEs stacked from
several pre-seed/angel checks compound this effect — each one converts independently, at its own
cap/discount, against the same future priced round. A founder who has raised $400K across four
SAFEs at different caps, and never modeled "what happens if all of these convert today," can be
genuinely surprised at how much of the fully-diluted cap table those SAFEs represent the moment a
priced round forces the conversion math to actually run. **Model the "if every outstanding SAFE
and note converted today" scenario before it's forced on you by a term sheet** — this is the
single most common reason founders discover their real ownership is lower than they believed, and
it is entirely avoidable by tracking it as SAFEs are signed, not after.

### Why track this pre-fundraise, not just after

Every point above — fully-diluted math, pool refreshes, SAFE stacking — is invisible in a simple
"who owns what" spreadsheet that only lists issued shares. A founder who starts tracking
fully-diluted ownership (including unissued pool and as-converted SAFEs) from the very first
SAFE, rather than waiting until a priced round forces a real cap table into existence, never gets
a percentage-ownership surprise in a term sheet negotiation — because they already know their own
number going in.

### The boundary — state once

*This section explains how ownership math works so a founder can read their own documents
correctly. It is not a cap-table record, does not track this business's actual share issuances,
and produces no legally binding ownership document. Real cap-table management — the authoritative
record of who owns what — needs a dedicated cap-table tool (e.g. Carta, Pulley, Ledgy) and, for
anything beyond basic bookkeeping (pool sizing, SAFE terms, a priced round's actual paperwork), a
qualified startup attorney. This is a planning aid, not licensed financial, legal, or tax advice.*

---

## Part 3: How to ask investors for help beyond money

Investors are most useful for three things beyond the check they already wrote, and the update
(Part 1's "Challenges & asks" section) is the right channel for all three — but only if the ask
is specific.

- **Intros.** Name the exact target, not the category. "Intro to a Head of Growth at a
  marketplace who scaled 0→$5M GMV" gets forwarded to a specific person by name within a day. "Any
  intros in growth would be appreciated" gets skimmed and forgotten. If a specific target company
  or person is known, name it; if not, name the precise profile (role, company stage, what they'd
  need to have done) tightly enough that an investor can pattern-match it against their own
  network without guessing.
- **Hiring.** Name the exact role, level, and the one or two things that make someone great for
  it — enough for an investor to forward the ask directly to a candidate, not just repost a job
  link. Say explicitly whether this is "help me find this person" or "just visibility, we're
  already interviewing" — investors triage differently for each.
- **Follow-on / bridge signaling.** Before going external for a next round or a bridge, ask
  existing investors directly and with a deadline: "let us know by <date> if you want to
  participate in [round/bridge] — we're starting outside conversations after that." This is a
  distinct ask from a general update and deserves its own line, not folded into "let us know if
  interested" language that doesn't force a real answer.
- **Customer/design-partner intros.** Name the ICP precisely (industry, company size, role of the
  buyer) the same way as the growth-hire ask above — a vague "customer intros welcome" produces
  nothing.

**One rule that matters more than any of the above: one or two asks per update, prioritized, not
a wish list.** An update with five asks reads as unfocused and gets none of them acted on; an
update with one specific, well-scoped ask gets that one thing done.

## Done means

- `ops.cadence_metrics_files` (most recent) and `quantitative_claims` were actually read, and
  every number in the update traces to one of them, `finance-metrics`, or a prior update — never
  invented.
- The update follows the five-part Headline / Key Metrics / Wins / Challenges & Asks / What's Next
  structure in full, with an explicit ask or an explicit "no specific ask this period."
- If a `risk_log` entry (`type: "business"`, `status: "open"`) or a Critical/Warning runway
  classification exists, it's visible in the update — not omitted.
- Cap-table questions, if the founder asked any, were answered with the plain mechanics above
  (not deflected to "consult a lawyer" as a first resort) *and* the boundary was stated once.
- `gtm/investor-update-<timestamp>.md` is written and registered in `business-state.json`
  `gtm.artifacts`.
