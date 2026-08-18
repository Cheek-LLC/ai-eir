# Outbound Sales Playbook — Vantage Point Search

*This is a planning aid built from the founder's own research and assumptions, not licensed
sales-compliance advice — cold-call and commercial-email rules (e.g. TCPA, CAN-SPAM, and their
non-US equivalents) vary by jurisdiction and channel; Jordan should confirm compliance for his
specific situation. Stated once here, not per script.*

Produced by `skills/gtm/outbound-sales-playbook`, delegated from `agents/gtm/sales-lead.md`. Reads
`plan/09-...`, `plan/12-determine-the-dmu.md`, `plan/13-...` + `plan/18-...` (treated as one
process per convention), `business-state.json` `quantitative_claims`, `gtm/positioning.md`.

## A note before the tier decision: this playbook does not try to out-run the plan's own capacity
constraint

The plan's own central finding (Section 4/6 of `plan/business-plan.md`) is that acquiring customers
was never the bottleneck — delivering the work is. This playbook is sized against that reality: the
weekly activity targets in §6 are set to roughly match Jordan's *historical* closing pace, not to
maximize volume. A playbook that pushed for 3x the historical outbound volume would be actively
wrong for this business right now — more signed engagements than Jordan (solo, no associate hired
yet) can deliver would just push guarantee-invocation risk and delivery quality down, not grow the
business. This is stated once here rather than re-litigated in every section below.

## Tier derivation (shown, not asserted)

1. **Distinct DMU roles, Step 12:** 4 rows with real, distinct titles — champion (Dana-type),
   economic buyer (CEO or Head of Talent), budget/comp approver (board/CFO, real veto confirmed on
   2 of 6 closed engagements), internal candidate-slate reviewer (soft input only, no hard veto in
   any observed case).
2. **Procurement/legal stage in Step 13:** yes — stage 4, "internal budget check," is a real
   procurement-shaped stage, confirmed adding 1-2 weeks at larger clients.
3. **Step 18 cycle length:** 5-9 weeks (35-63 days) — the upper end exceeds the light-touch tier's
   ~45-day ceiling.
4. **Tier, per the decision table (first matching row wins):** row 1 (PLG) doesn't match — multiple
   DMU roles, a real procurement-shaped stage. Row 2 (light-touch, 2-3 roles) doesn't match on role
   count alone. Row 3 (**Enterprise/multi-touch**) matches on all three of its independent triggers
   (4+ roles, a procurement-shaped stage present, and cycle length exceeding 45 days at the upper
   end) — this is not a marginal call.

**Tier: Enterprise / multi-touch.** Full 5+ touch sequence over the cycle length, multi-persona
messaging (champion vs. economic buyer get separate openers), an explicit budget-check-stage touch,
and a champion-enablement asset (something Dana can forward internally to the economic buyer).

## 1. Target tracker

Seeded with the real Step 9 list (company-level detail, anonymized per the onboarding privacy
notice — no individually identifying candidate data).

| Company/Prospect | Why them (Step 9) | DMU role reached | Stage | Next action | Owner |
|---|---|---|---|---|---|
| #1 Series C devtools co. (~140 emp) | Referral — past client's VC talent partner, warm intro | Champion (hiring CTO) | Discovery call scheduled | Hold discovery call; bring §4 framework | founder |
| #2 Series B fintech infra co. (~80 emp) | Referral — past candidate, now hiring manager | Champion + economic buyer | Proposal sent, awaiting board budget sign-off | Follow up at budget-check stage per §3 Day-8 touch | founder |
| #3 Series C observability co. (~200 emp) | Jordan's own LinkedIn outreach | Champion | Discovery call held | Send proposal; competing against one other search firm — see objection #2 | founder |
| #4 Series B healthtech infra co. (~60 emp) | Referral — same client as #2's talent partner | Champion (early) | First conversation only | Book discovery call | founder |
| #5 Series D data-infra co. (~350 emp) | Repeat client, 2nd search | Economic buyer (repeat, already trusts Jordan) | **Engagement signed** | Move to delivery (Step 22) — outside this playbook's scope | founder |
| #6 Series B security co. (~95 emp) | Jordan's own LinkedIn outreach | Champion | First conversation, no follow-up yet — 2 unanswered follow-ups | Send Day-14 breakup email (§3); do not keep pushing past that without a new angle | founder |
| #7 Series C API-platform co. (~170 emp) | Referral — candidate now works there | Champion (expected) | Discovery call scheduled | Hold discovery call | founder |
| #8 Series B ML-infra co. (~55 emp) | Cold inbound (via a placed candidate's LinkedIn post) | Champion (early) | First conversation only | Book discovery call — this is a real non-referral channel signal, worth a distinct source tag going forward | founder |
| #9 Series C logistics-tech co. (~220 emp) | Referral — VC talent partner (same as #1) | Champion | Discovery call held, then went quiet (3 weeks) | One respectful re-engagement touch, then mark lost if no response — do not chase past that | founder |
| #10 Series D e-commerce infra co. (~400 emp) | Jordan's own LinkedIn outreach | Champion (early) | First conversation only | **Flagged, not pursued as-is:** comp band discussed is above this beachhead's typical range (Step 9's own note) — confirm fit before investing more discovery time, may be off-segment | founder |

**Connector status — CRM logging (pending):** this tracker currently lives in this markdown file
only. Operationalizing it into a real CRM (so stage/DMU-role/next-action updates don't require
hand-editing this file every time) was checked with `agents/connectors-liaison.md` this session —
**status: `needs_manual_setup`**, no CRM connector (HubSpot/Salesforce/Pipedrive-class tool) is
available in this environment. See `business-state.json.connectors.needed_not_installed` for the
logged entry and `gtm/launch-plan.md`'s readiness snapshot for the founder-facing summary. **This
does not block using the playbook** — the table above is fully real and usable today; only the
"sync it to a real CRM" convenience is pending.

## 2. DMU-mapped messaging

| DMU role | What they care about (Step 12) | Opening hook |
|---|---|---|
| **Champion (Dana-type hiring CTO/eng lead)** | Candidate technical bar, speed, not having to manage the search herself | "You've probably already screened 30-40 LinkedIn profiles for this and found maybe 3-4 worth a real conversation. I run the same search you're running, but it's the only thing on my plate, and I've screened for exactly this architectural bar before as an in-house recruiter, not just as an outside vendor." (Pillar 1) |
| **Economic buyer (CEO, sub-100 emp; Head of Talent, 100+ emp)** | Fee, payment terms, guarantee, vendor track record/references | "30% of first-year base, split across three installments so you're not fronting the whole fee before you see a slate, plus a 90-day guarantee. Six placements in 14 months — happy to give you two references directly." (Pillar 4) |
| **Budget/comp approver (board/CFO, larger clients)** | Whether the comp band and fee are within approved budget | "Here's the fee as a percentage of the actual comp band we're targeting, benchmarked against what a 2-3 month vacancy at this level costs in lost velocity — I can walk the board through this directly if that's useful." (ties to Step 8's value-prop framing, kept honest about its low-confidence range) |
| **Internal candidate-slate reviewer (peer VP, soft input)** | Candidate's cross-functional fit | Not a primary outreach target — this role enters during the interview loop itself (Step 13, post-signing), not the acquisition sequence; no cold-outreach touch needed. |

## 3. Multi-touch outbound sequence (for new prospects entering the funnel; existing tracker rows
above are mid-sequence and use the "next action" column instead)

**Day 1 — Cold email (champion).**
Subject: "VP Engineering search — from someone who's done this in-house"
Body: "Hi [Name] — saw [specific, real trigger: e.g. a funding announcement, a job posting still
open after 60+ days]. I run retained searches specifically for VP/Director of Engineering hires at
Series B-D venture-backed companies — I spent 11 years as an in-house technical recruiter before
going independent, so I'm not learning to screen for this on your dime. If the role's been open a
while and your own network's tapped out, I'd like 20 minutes to see if I can help. No pressure if
timing's wrong — happy to just be a resource either way."

**Day 3 — LinkedIn connection note (champion).**
"Following up on my email — even if now's not the right time, wanted to connect. I post about
technical-screening specifics for eng-leadership hires if that's useful regardless of whether we
ever work together."

**Day 5 — Call script (champion), plus voicemail.**
Opener: "Thanks for making time — I know a VP Eng search is competing with your actual day job."
Discovery questions: (1) "How long has the role been open, and what have you tried so far?" (2)
"What's the specific technical bar the last few candidates didn't clear?" (3) "Who else needs to be
in this decision besides you — is there a budget/board step?" (ties directly to Step 12's DMU map).
Close: "Based on what you've described, this sounds like a fit for what I do — I'd like to send a
scoped proposal. Who else should see it alongside you?"
Voicemail (no answer): "Hi [Name], Jordan Reyes — I sent a note about the VP Engineering search,
wanted to follow up by phone too. No pressure, I'll follow up by email with a bit more detail."

**Day 8 — Follow-up email (champion + cc economic buyer once identified).**
"Following up with a specific data point: my last engagement at a similar-stage company went from
signed to a 5-candidate slate in 27 days [or the real comparable figure for a genuinely similar
past engagement — do not invent a number for a prospect this specific unless it's true]. Also
attaching a one-page reference sheet you can forward internally." (This is the champion-enablement
asset the Enterprise tier calls for — see below.)

**Day 15 — Budget-check-stage touch (economic buyer + budget approver, Enterprise-tier addition).**
Only sent once a proposal has gone to internal budget review (Step 13 stage 4): "Wanted to check in
ahead of your budget conversation — happy to join a short call with your board/CFO directly if that
would help move this faster, or to send a one-pager benchmarking the fee against the cost of the
vacancy itself." This is the explicit procurement-stage touch the tier decision above requires.

**Day 21 — Breakup email (champion).**
"I don't want to keep filling your inbox if the timing's wrong — I'll step back unless I hear
otherwise. If the search reopens later, happy to pick this back up." (Extended from the standard
Day-14 breakup to Day 21 given the real 5-9 week cycle length this business actually sees — a
14-day breakup would be premature against a process this long.)

**Champion-enablement asset:** a one-page reference sheet (fee structure, guarantee terms, 2
reference contacts, the Step 11 competitive-positioning chart) that Dana can forward to the
economic buyer/budget approver without having to translate the pitch herself — this is what the
Enterprise tier's multi-persona requirement calls for structurally, not just a longer email chain.

## 4. Discovery call framework

**Agenda:** (1) Rapport + role context (2 min). (2) Qualification questions (10 min, see below).
(3) Value articulation — tie directly to Pillar 1/2 from `positioning.md`, using the prospect's own
words from the qualification answers (5 min). (4) Next-step ask — proposal, or a joint call with
the economic buyer if not already on the call (3 min).

**Qualification questions:**
1. "How long has this role been open, and what's the current sourcing approach?"
2. "What's the specific technical bar the strongest candidate so far didn't clear?"
3. "Who else is part of this decision — budget approval, board visibility?" (maps directly to
   Step 12's DMU, determines which tier-3 touches apply)
4. "Is there a timeline pressure — a board update, a product milestone — driving urgency?"
5. "Have you talked to another search firm or recruiter about this role?" (surfaces objection #2
   scenarios early rather than discovering them at proposal stage)
6. "What would make this search a clear success for you, six months from now?"

## 5. Objection handling script bank

(Pulls directly from `gtm/positioning.md` §5, expanded with call-specific phrasing; items 6-7 are
new, DMU-process-specific objections not covered in the positioning doc.)

1–5. See `gtm/positioning.md` §5 (DIY-vs-hire, fee-vs-contingency, small-sample-track-record,
guarantee-terms, VC-intro-competition) — not duplicated here verbatim, reused as-is per this
skill's instruction to stay on-message with the finished positioning doc.

6. **"We need board sign-off before any spend over $X — that could take weeks."** (budget approver,
   Step 12) — Genuine response, not a pressure tactic: "That's normal at your stage — 2 of my last 6
   closed engagements went through exactly that step, and it added 1-2 weeks, not months. I'm happy
   to send a one-pager the board can review async, or join a call directly if that moves faster."
   Honest about the real historical timeline (Step 18), doesn't pretend the process will be instant.

7. **"How is this different from the last recruiter we used, who also promised technical
   screening?"** (skeptical champion who's been burned before) — Honest response: "Fair question —
   I can't verify what another firm actually did in their screen. What I can tell you concretely is
   what mine covers: [specific architecture/scaling-judgment questions, not a vague 'rigorous
   process' claim], and I can walk you through exactly how I screened the last candidate I placed at
   a comparable-stage company." Doesn't disparage the prior recruiter by name or assumption — just
   states the concrete difference.

## 6. Costed weekly activity targets

**Target:** 2-3 new signed engagements over the next 10-12 weeks from combined referral + targeted
outbound — this is set to *match*, not exceed, Jordan's historical closing pace (8 signed / 14
months ≈ 0.57/month, i.e. roughly 1.4-1.7 over a 10-12 week window from the referral channel alone;
targeted outbound is additive on top of that pace, not a replacement for it), consistent with the
capacity-constraint note at the top of this file.

**Arithmetic, shown:**
- Overall conversation → signed conversion: 23% (`qc-018-cycle-length`'s underlying data, Step 13:
  8/35 over 14 months).
- To land ~1 additional signed engagement from outbound specifically (on top of the referral
  baseline) over 10-12 weeks: 1 ÷ 0.23 ≈ **4-5 real conversations needed** from outbound sourcing
  specifically.
- Stage 1→2 conversion (74%) and 2→3 (69%): to generate 4-5 real conversations that advance past
  first contact, budget for roughly **6-7 outbound touches (Day-1 emails) per prospect batch**,
  sent in small batches of 2-3 new prospects every 2 weeks rather than a large one-time blast — this
  matches Jordan's actual available BD time (Step 18: ~45 hrs/engagement total, of which only ~16
  hrs maps to discrete funnel stages; the rest is relationship maintenance, not new-prospect
  outreach volume).
- **Weekly target: 1-2 new outbound touches (Day-1 emails to new prospects) + working the existing
  10-prospect tracker's next actions above.** This is deliberately modest — a higher volume target
  would outrun the ~16 hrs/engagement of stage-mapped BD time Step 18 actually costs, before even
  accounting for delivery hours on searches already signed.

**Sourced:** conversion rates from `qc-018-cycle-length` and Step 13's underlying counts (founder-
tracked, not a CRM export — see `ka-013-conversion-sample`, still open). If a future period's real
close rate diverges materially from 23%, this target should be recomputed, not left stale.
