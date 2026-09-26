---
name: 14-fundraising
description: >
  Use once a business is actively running a real fundraising process, not just preparing for one
  — Tactic 14 of Paul Cheek's 15 Tactics: Executing Your Venture's Fundraising Plan. Triggers:
  "let's actually start raising," "build our investor pipeline," "who should we pitch first,"
  "how many investors do we need to meet," "we got a term sheet," "how do we close this round,"
  "an investor passed, what now." Distinct from `agents/gtm/fundraising-advisor.md` (the broader,
  ongoing relationship mandate — narrative, deck, and post-close investor relations) and
  `skills/gtm/investor-updates-and-cap-table-basics` (post-close update cadence and cap-table
  literacy) — this tactic is the concrete, end-to-end mechanics of running the raise itself:
  pipeline, meeting cadence, negotiation basics, and closing.
---

# Tactic 14: Fundraising — Executing Your Venture's Fundraising Plan

## What this tactic is, and what it isn't

`agents/gtm/fundraising-advisor.md` builds the pitch — the narrative, the deck, the numbers that
survive investor scrutiny — and continues past the raise into ongoing investor relations.
`skills/gtm/investor-updates-and-cap-table-basics` teaches a founder to read their own cap table
and run investor updates once money is in the door. **Neither of them runs the actual process of
getting from "we have a deck" to "we have a signed term sheet and closed funds."** That's this
tactic: a real pipeline, a real meeting-to-close funnel with honest conversion expectations,
negotiation basics, and the concrete mechanics of closing.

Confirm before starting: `gtm.funding_strategy` is `raising_outside_capital`, and a deck/brief
already exists (`gtm.artifacts` has a `fundraising-deck-brief` or `pitch-deck` entry — via
`fundraising-advisor`). If neither is true, hand off there first; this tactic has no material to
pitch with otherwise.

**Scope boundary — stated once:** this is execution guidance for running the process, not legal,
financial, or securities-compliance advice. It does not draft or negotiate binding legal terms
(that's real counsel, per `skills/risk/legal-structure-and-ip-basics` §4) and it does not replace a
real cap-table tool. This tactic gets the founder through the process informed; it is not a
substitute for counsel once a term sheet is on the table.

## What you read

- `.startup/<slug>/business-state.json` → `gtm.funding_strategy` (must be
  `raising_outside_capital`), `gtm.artifacts` (the deck/brief to actually pitch from),
  `founder.notes` (entity/equity state from Tactic 11 — an investor's diligence will ask).
- `.startup/<slug>/gtm/fundraising-deck-brief.md` and the most recent `reviews/*-vc-panel-*.md` —
  the honest-risks and anticipated-objection material this tactic's meetings will actually run
  into; use it to prep for real pushback, not generic ones.
- `.startup/<slug>/tactics/14-fundraising.md`, if it already exists — the standing pipeline and
  funnel state, so this run updates it rather than starting a new pipeline from zero.
- `.startup/<slug>/plan/04-...beachhead-market.md` / `14-...follow-on-markets.md`,
  `17-calculate-the-ltv-of-a-customer.md`, `19-calculate-the-coca.md` — the numbers investors will
  actually probe in a meeting; know the LTV:COCA ratio and its confidence cold before the first
  meeting, not just have it written down in the brief.

## What you write

- `.startup/<slug>/tactics/14-fundraising.md` — the pipeline, funnel, and closing record below.
- You do **not** write `business-state.json.tactics` yourself. Report your output file and a
  one-line summary back to whoever invoked you; the orchestrator updates
  `business-state.json.tactics.14_fundraising` after confirming the file output.

## 1. Build the investor pipeline

**Source order, in priority:**

1. **Warm intros first** — existing investors/advisors, any angel already on the cap table, and
   the founder's own professional network. A warm intro converts to a first meeting at a
   materially higher rate than any cold outreach, and it's free.
2. **A targeted list built from real fit criteria**, not "every VC that funds startups": check
   size fit to this specific round size, stage fit (a firm that leads Series A rarely writes a
   $500K pre-seed check, regardless of interest), sector/thesis fit (read the fund's own stated
   thesis and recent portfolio — a firm with zero portfolio companies in this business's category
   is a low-probability target regardless of how prestigious the name is), and lead-vs-follow
   behavior (does this fund typically lead rounds and set terms, or only follow an already-priced
   round — pitching a follow-only fund for a lead check wastes a meeting on both sides).
3. **Size the list realistically.** A real seed-stage pipeline commonly runs **80-150 targeted
   investors** to reach a small handful of term sheets — state this as a reference range, not a
   guarantee, and set the founder's expectations against it explicitly before the first outreach
   goes out. A founder expecting a term sheet from the first 10 meetings is optimizing against the
   wrong number.

**Pipeline/CRM discipline — track every investor, not just the ones who reply:**

| Field | Why it matters |
|---|---|
| Name, fund, check-size/stage/sector fit | The filter from above, recorded so it isn't re-judged every time |
| Warm-intro path (if any) | Who can make the intro, and whether it's been asked for yet |
| Status | not contacted / intro requested / first meeting / second meeting / diligence / passed / committed |
| Last touchpoint date | The single most common execution failure is letting a live conversation go silent without either side noticing |
| Next action + date | Every active row needs one — "waiting on them" without a follow-up date is how deals quietly die |

A spreadsheet is genuinely sufficient for this at seed stage; a real CRM (the kind of tool
`docs/CONNECTORS-CATALOG.md`'s `crm` category names) is worth it once the list is large enough that
status tracking itself becomes the bottleneck. If a real CRM connector is wanted, that's a
connector moment — delegate through `agents/connectors-liaison.md` the same way
`fundraising-advisor` already does for investor-pipeline tooling; this tactic's own discipline
(the fields above, updated every time a status changes) matters regardless of which tool holds it.

## 2. The meeting-to-close funnel — real conversion expectations

State these as reference bands from typical seed-stage practice, not universal guarantees, and
recompute this business's own actual rates once real data exists rather than treating the bands as
permanent:

| Stage | Typical conversion to next stage |
|---|---|
| Outreach → first meeting | Roughly 30-40% from a warm-ish targeted list; materially lower from pure cold outreach |
| First meeting → second meeting | Roughly 30-50% |
| Second meeting → partner meeting (if the fund has partner-approval mechanics) | Roughly 30-50% |
| Partner meeting → term sheet | Meaningfully lower than the stages above — a real pipeline commonly ends with a **single-digit-percent** overall conversion from full target list to signed term sheet |

**The point of stating this explicitly:** a founder who doesn't know these bands reads a string of
"no"s as a signal the pitch is broken, when it may just be the normal shape of the funnel. Recommend
recomputing this business's own actual conversion at each stage once ~15-20 first meetings have
happened — a small sample says little, but a real, business-specific funnel read at that point is
far more useful than the generic bands above, and should replace them in this tactic's output going
forward.

**Meeting cadence mechanics, concretely:**

- **Every meeting's goal is the next meeting, not a check.** A first meeting that tries to close is
  usually a first meeting that gets a slow no instead.
- **Follow up within 24 hours of every meeting**, every time — send the promised answer, the
  requested data, or simply a thank-you plus next step. Slow follow-up loses deals to founders with
  a worse product but tighter execution; this is one of the highest-leverage, lowest-cost habits in
  the whole process.
- **Sequence outreach in tiers — closest-fit and warmest first, broader list second.** Burning the
  best-fit, most reputationally-connected investors on an early, not-yet-dialed-in pitch is a real
  and avoidable mistake: investor networks talk, and a sloppy first impression with a top-tier
  target can precede the founder to the next fund on the list (**signal risk**). Let the pitch get
  sharper against the lower-priority tier before it reaches the highest-priority targets.
- **Manage timing deliberately — never fabricate urgency, but don't let a process drift
  indefinitely either.** A real second term sheet, a real close date the founder has actually
  committed to, or genuine multi-investor interest are legitimate tools to bring a process to a
  decision point. Inventing a deadline or a competing offer that doesn't exist is a credibility risk
  that outlasts this one raise — investor networks compare notes.

## 3. Negotiation basics

Execution-level judgment, not legal drafting — the actual negotiation and its binding language is
counsel's job (per `skills/risk/legal-structure-and-ip-basics` §4).

- **Know the walk-away position before the first term sheet arrives**, not while reacting to one:
  an acceptable valuation range, real dilution tolerance, and a stated position on board
  composition. Deciding these under the time pressure of an active term sheet produces worse
  outcomes than deciding them in advance.
- **Know the handful of terms that actually matter**, beyond the headline valuation number:
  **board composition** (who controls board votes as the cap table grows), **liquidation
  preference** (1x non-participating is the standard, founder-reasonable term; anything with a
  multiple above 1x or a participating feature is a real red flag worth pushing back on directly),
  and **pro-rata rights** (an existing investor's right to maintain their ownership percentage in
  future rounds — standard and reasonable within limits, worth understanding before signing).
- **The single most effective lever is real competing interest** — a second term sheet, or a
  credible, genuine prospect of one, changes every term's negotiating leverage more than any
  argument about the numbers alone. This is the direct payoff of running a real pipeline (§1) rather
  than pursuing one investor at a time.
- **Bring in the real lawyer at the term-sheet stage, not after signing.** This tactic gets the
  founder to the negotiation informed about what the terms mean; it does not negotiate or draft
  binding language, and a founder should not sign a term sheet without counsel having reviewed it.

## 4. Closing — the concrete last mile

1. **Signed term sheet.** Non-binding on price/terms in most respects, but the real start of a
   time-boxed process — most term sheets carry an implicit or explicit exclusivity/no-shop period.
2. **Diligence request list.** Have the data room ready *before* it's asked for, not after: the cap
   table (current and fully-diluted, per `skills/gtm/investor-updates-and-cap-table-basics`),
   financials and the operating model (Tactic 12, `skills/tactics/12-finance`), material contracts,
   and every signed IP assignment (Tactic 11, `skills/tactics/11-legal`) for every founder,
   contractor, and employee who's touched the product. A diligence request that surfaces a missing
   IP assignment mid-process is a real, avoidable delay — this is exactly why Tactics 11 and 12 come
   before this one in the sequence.
3. **Legal docs drafting.** Attorney-led on both sides — the stock purchase agreement, certificate
   of designations (for a priced round), or the SAFE itself if that's the instrument. This tactic
   tracks that it's happening and on what timeline; it does not draft these documents.
4. **Signature and funding logistics.** E-signature on final docs, then the actual wire — track
   real dates, not "should be soon," since a round is not closed until funds have actually landed.
5. **Close the loop with every passed investor**, briefly and professionally — a short note thanking
   them for their time. This preserves the relationship for a future round; a founder who ghosts a
   "no" burns a door that might open again in 18 months.

## Output file: `tactics/14-fundraising.md`

```markdown
# Tactic 14: Fundraising — <business name> — <date>

_Execution guidance, not legal, financial, or securities-compliance advice._

## Pipeline
| Investor | Fund | Fit (size/stage/sector) | Warm-intro path | Status | Last touch | Next action |
|---|---|---|---|---|---|---|
| ... | ... | ... | ... | ... | ... | ... |

## Funnel this period
Outreach: N | First meetings: N | Second meetings: N | Partner meetings: N | Term sheets: N
Conversion vs. reference bands (or this business's own recomputed rate, if ≥15-20 meetings in): ...

## Negotiation status (if a term sheet is live)
Walk-away position stated: <valuation range, dilution tolerance, board position>
Term sheet terms of note: <liquidation preference, board seats, pro-rata — any red flag named>
Counsel engaged: yes/no

## Closing checklist (if a term sheet is signed)
Diligence data room ready: <cap table / financials / contracts / IP assignments — status each>
Legal docs status: ... | Signature/funding status: ...

## Passed investors this period
<Names, and confirmation each got a professional close-out.>
```

## Done means

- The pipeline reflects real, named investors with a real fit rationale, not a generic "reach out
  to VCs" list, and every active row has a next action and date.
- Realistic conversion expectations (or this business's own recomputed rates, once enough data
  exists) are stated explicitly, not implied.
- If a term sheet is live: the walk-away position was set before negotiation, the handful of terms
  that matter were checked by name, and counsel is engaged before signature.
- If a round closed: the diligence data room, legal docs, and funding logistics are tracked to
  actual completion, not "should be done soon."
- `tactics/14-fundraising.md` is written. `business-state.json.tactics` is left to the orchestrator.
