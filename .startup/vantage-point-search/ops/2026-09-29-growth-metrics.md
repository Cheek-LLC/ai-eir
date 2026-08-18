# Growth Metrics — Vantage Point Search — 2026-09-29

Produced by `skills/ops/weekly-metrics-review`, delegated from `agents/ops/growth-analyst.md`, as
part of `agents/ops/operations-manager.md`'s **second** post-launch check-in. `ops/kpi-dashboard.md`
re-checked against `plan/15-...`/`plan/16-...` revision dates — unchanged since 2026-09-15, no
`kpi-dashboard-setup` re-run needed.

## Period covered

2026-09-15 to 2026-09-29 (second check-in period, biweekly cadence).

## Founder-reported inputs

| Metric | This period | Source |
|---|---|---|
| Outbound touches sent | 6 | founder-reported 2026-09-29 — cadence resumed per the 2026-09-15 retro's recommended action #1 |
| New qualified prospects entering the funnel (first conversation) | 3 (#11 Series C fintech, ~150 employees, referral via the same VC talent partner as #1/#9; #12 Series D devtools, ~300 employees, outbound; #13 Series B early-stage, ~70 employees, outbound) | founder-reported 2026-09-29 |
| New paying customers closed this period | 0 | founder-reported 2026-09-29 — still inside the 5-9 week cycle window (`qc-018-cycle-length`); the earliest launch-motion prospects (first conversation on/after 2026-09-01) are ~4 weeks in, at the low end of the range |
| Total acquisition spend this period | $95 (LinkedIn Recruiter subscription, prorated 2 weeks; no paid ads) | founder-reported 2026-09-29 |
| Channel breakdown | 6 touches: 4 direct outbound (LinkedIn), 2 referral follow-up | founder-reported 2026-09-29 |

## Funnel movement this period — not a templated field in this skill, recorded because it's the material finding

The dashboard's standard fields (new prospects in, new customers closed) don't have a place for
**prospects that left the funnel and why** — flagging that gap below in "Flags for
operations-manager" — but the reasons are real, founder-reported, and load-bearing this period, so
recording them here rather than only in prose to whoever reads this file next:

| # | Prospect | Outcome | Date | Reason (founder-reported, direct) |
|---|---|---|---|---|
| #2 | Series B fintech infra, ~80 employees | **Declined** at internal budget check | 2026-09-24 | Economic buyer: can't justify a 30% retained-search fee for a first VP-level hire at this size; will try own network + a contingency recruiter instead |
| #4 | Series B healthtech infra, ~60 employees | **Declined** after 3+ weeks silence, following Jordan's direct follow-up | 2026-09-26 | CEO: any outside spend over $10K needs personal approval; a $60K+ retained fee "isn't something we're set up to approve for a first senior hire" — will try promoting internally |
| #3 | Series C observability, ~200 employees | **Lost to competitor** (the parallel search firm named in Step 9) | 2026-09-20 | Genuine competitive loss — unrelated to budget size or fee justification |
| #9 | Series C logistics-tech, ~220 employees | **Resolved (`ka-011-vc-intro-competition` test)** | 2026-09-27 | Jordan's direct follow-up got a real answer: role was filled via a free VC-talent-partner intro, no paid search at all |
| #1 | Series C devtools, ~140 employees | Progressing | 2026-09-17 / 09-25 | Discovery call held, proposal sent, awaiting internal budget check |
| #7 | Series C API-platform, ~170 employees | Progressing | 2026-09-22 | Discovery call held, moving toward proposal |

**The pattern, stated plainly:** of the prospects that reached the internal-budget-check stage this
period, the two smallest companies in the active pipeline (#2 at ~80 employees, #4 at ~60
employees — both at the low end of Step 2's stated 50-500 employee band) both declined, both
citing the same underlying mechanism: inability to justify a 30% retained-search fee for a
first-time senior hire without a formal external-spend approval process. The Series C/D losses this
period (#3, #9) were for unrelated reasons (a named competitor, a free VC-intro channel). 2 of 2 is
a small sample on its own — see the retro and `interview-log.md` for how this combines with Jordan's
own direct read of it.

## Business-type follow-up (services)

| Metric | This period | Source |
|---|---|---|
| Billable utilization | ~22 delivery hours ÷ ~80 available capacity hours ≈ **28%** (up from 22%) | founder-reported 2026-09-29 — still founder-estimated, not logged (`ka-016-delivery-hours-estimate` still open, now asked about with no movement across **2 consecutive check-ins** — see retro) |
| Pipeline value (open, not-yet-closed) | 5 active prospects (#1, #7, #11, #12, #13) × $70,500 avg fee = $352,500 gross; risk-adjusted at 23% ≈ **~$81,075** | founder-reported tracker + `qc-016-price` |
| Engagement completion rate | N/A — the #5 engagement's candidate-slate-delivery milestone landed 2026-09-22 (a mid-search milestone, not completion); no engagement scheduled to complete this period | founder-reported 2026-09-29 |

**Worth flagging on its own, not buried in the table above:** the risk-adjusted pipeline-value
headline (~$81,075) is essentially unchanged from the prior period's ~$81,000 — read on its own,
that number says "flat, nothing happening." It hides the real story: 3 of the 5 prospects behind
that number this period are not the same 3 as last period (2 declined, 1 lost to a competitor, 3
new entered) and the composition shifted toward larger companies. A single blended pipeline-value
figure is blind to a segment-composition shift underneath it — this is the same number, arrived at
two structurally different ways, one period apart.

## Derived metrics

| Metric | Value | Note |
|---|---|---|
| Stage 1→2 conversion (this period) | Still too small a sample (3 new first-conversations plus 2 carried-forward, none with enough volume) | Sample-size note |
| Actual COCA (this period) | **Insufficient data — 0 new paying customers this period.** | Same as period 1 |
| Actual COCA (rolling, 2 periods) | **Insufficient data — $185 combined spend ($90+$95) ÷ 0 combined new paying customers across both periods.** Cannot compute a meaningful rolling figure from two zero-close periods; stated honestly rather than as $0 or an undefined ratio. | First period this rolling figure was even computable, and it's still not computable |

## Plan comparison

Plan COCA (Step 19, `qc-019-coca`): ~$5,200 (range $4,900-$5,400) | Actual (this period and rolling):
**not computable — 0 new paying customers closed in either period to date.** Still expected, not a
red flag: even the earliest launch-motion prospect (first conversation ~2026-09-01) is only ~4 weeks
into a 5-9 week cycle. Will reassess starting mid-October. | Trend vs. prior snapshot: unchanged
(still insufficient data both periods).

## Trend vs. prior period

- Outbound touches: 3 → 6 (+100%, cadence resumed as recommended).
- New qualified prospects entering funnel: 2 → 3.
- Billable utilization: 22% → 28%.
- Active pipeline count: 5 → 5 (flat count, but see the composition note above — not the same 5).
- Pipeline value: ~$81,000 → ~$81,075 (flat, same caveat).

## Data gaps

- Billable utilization is still founder-estimated, not logged from real time-tracking
  (`ka-016-delivery-hours-estimate`) — recommended again last period, still not started. Now a
  2-check-ins-running pattern with no movement, worth naming plainly rather than recommending a
  third time in the same words (see retro).
- Channel-level spend tracking remains informal — same root cause as the still-pending CRM
  connector (`business-state.json.connectors.needed_not_installed`).
- **New this period:** this skill's standard field set (Step 1 of `weekly-metrics-review`) has no
  structured place to record *why* a prospect left the funnel — the table above was added ad hoc
  because the reason was the material finding this period, not because the skill's template
  prompted for it. Flagged in "Flags for operations-manager" below as a real template gap, not
  invented data.

## Flags for operations-manager

1. **The segment/loss-reason pattern above is the headline finding this period**, even though it
   doesn't move any of the plan-vs-actual numbers operations-manager's drift comparison formally
   tracks (TAM/segment drift is formally defined over *acquired* customers' profile match, and 0
   customers were acquired this period either). This is real signal that the current
   plan-vs-actual mechanism has no numeric hook for — reporting it here in full rather than
   omitting it because it doesn't fit a formal drift threshold.
2. `ka-016-delivery-hours-estimate` — 2 consecutive check-ins with the same recommendation and no
   founder action. Worth a more direct question next time than a third repeat of "start
   time-tracking."
3. `skills/ops/weekly-metrics-review/SKILL.md` Step 1's field list has no lost-deal/reason capture
   — recommend adding one given how material it was this period (see the growth-analyst agent file
   note and the QA findings doc for the specific fix suggested).
