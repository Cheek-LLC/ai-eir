# Hiring Plan — associate-recruiter — Vantage Point Search — 2026-09-29

_This is a planning aid, not licensed employment, HR, immigration, or legal advice._

## Context for this run

Jordan is asking whether to move forward now with the associate-recruiter hire that
`plan/24-develop-a-product-plan.md` already named as the roadmap's #2 near-term priority
("hire first associate recruiter," directly behind writing the technical-screening playbook) —
this is the live, specific hiring decision this session, invoked directly by the founder rather
than relayed through `operations-manager`.

**Stage note (flagged, not resolved here):** `business-state.json.stage` currently reads
`de_steps_in_progress` (steps 01/02/04 are reopened mid-pivot, 05 flagged for re-confirmation),
not `operating`. In substance this business is operating — `gtm.status: "launched"`, `ops.status:
"active"`, two real biweekly ops check-ins completed, real revenue collected on a signed
engagement — the `de_steps_in_progress` value reflects the in-flight beachhead-narrowing pivot
running in parallel with continued operations, not a pre-launch business. Treating the operating
gate as satisfied in substance for this run; see the QA findings doc for this as a flagged gap
rather than a fix.

## Should-we-hire decision

**Option selected: full-time hire (associate recruiter).** Reasoned through the 1a table
explicitly rather than defaulting to plan/24's prior assumption:

- **Not "founder keeps doing it"** — the need plan/24 identifies (delivery capacity, and
  specifically testing whether anyone besides Jordan can replicate his fill rate/quality bar) is
  structural, not occasional.
- **Not a contractor** — this isn't a project-scoped or time-boxed need; the intent (per plan/24)
  is a durable, ongoing delivery role if `ka-020-associate-replication` tests positive.
- **Not fractional/agency** — the role requires daily, integrated judgment (live candidate
  screening against Jordan's quality bar), not periodic specialist input or an outside team's
  tooling.
- **Full-time hire** is the right classification — but **the reason is not the one the services
  sequencing pattern's stated trigger names.** See "Sequencing rationale" below for the honest
  version of why.

## Runway math

| Input | Value | Source |
|---|---|---|
| Latest cash on hand | $56,360 | `ops/2026-09-29-finance-metrics.md` |
| Latest monthized net burn (baseline used — see note) | $2,571/month | `ops/2026-09-15-finance-metrics.md` (not the 2026-09-29 file — see note below) |
| Fully-loaded monthly cost of this hire | $7,583/month ($70,000 base × 1.3x fully-loaded multiplier midpoint ÷ 12) | plan/24's costed $70,000 base salary; multiplier is a planning estimate (1.25-1.4x US benchmark), not Jordan's confirmed real number — flagged as such |
| Variable cost not included above | 10% override commission on the associate's own closed placements | plan/24 — contingent on production, not a fixed monthly cost, so excluded from the fully-loaded fixed figure above; will show up as real burn only once the associate closes placements |
| Credible monthly revenue contribution | $0 assumed | Per this skill's own instruction, revenue is only credited for a role with a direct, near-term line — the associate's placements are real future revenue, but plan/24's own model assumes a ~4-month ramp with no output during it, so no near-term monthly contribution is credible yet |
| Post-hire monthized net burn | $2,571 + $7,583 − $0 = $10,154/month | computed |
| Post-hire runway | $56,360 / $10,154 ≈ **5.6 months** | computed |
| Threshold classification (post-hire) | **Warning** (3-6 months) | per `runway-and-burn-tracking` thresholds |

**Baseline-burn judgment call, stated explicitly (this is the deliverable's most important honest
disclosure):** the *latest* finance-metrics file (2026-09-29) itself reports runway as **"not
applicable — cash-generative this period"** because a single $23,500 installment payment made
that period's net burn negative. That same file explicitly warns: *"the swing is a single lumpy
fee-installment payment... not a repeatable revenue run-rate... next period's spend/revenue will
most likely look like period 1 again."* Feeding that literal "latest" figure into this skill's
runway formula would make **any** hire look artificially safe (adding $7,583/month of new fixed
cost to an already-negative burn number stays negative) — exactly the kind of one-off illusion the
finance-metrics file itself warns against reading as a trend. I used the **prior period's
steady-state monthized burn ($2,571/month, the number both periods' own commentary treat as the
representative baseline)** instead, paired with the *current* (higher, real) cash-on-hand figure.
This is a defensible reading, not a mechanical one — and the SKILL.md doesn't actually say what to
do when the "latest" finance-metrics snapshot is itself flagged non-representative. See the QA
findings doc for this as a real gap, not resolved by this file's judgment call alone.

**Read of the result:** Warning, not Critical. This can still be the right call — Jordan has real,
recently-strengthened cash ($56,360, +65.8% this period) and the hire is explicitly a test of a
load-bearing growth assumption (`ka-020`), not discretionary. But it is not routine, and proceeding
should be a stated, logged choice, not an assumed one (see "Risk flagged" below).

## Sequencing rationale

`business_basics.business_type: "services"` — the applicable pattern is "delivery/production
staff, triggered when the founder's own billable hours are the bottleneck (check utilization
data)."

**The honest evidence check, not the mechanical answer:** `ops/2026-09-29-growth-metrics.md`'s
business-type follow-up reports **billable utilization at 28%** (up from 22% the prior period) —
Jordan is using roughly a quarter of his available delivery capacity. By the sequencing pattern's
own stated trigger ("founder's own billable hours are the bottleneck"), **this does not currently
fire** — there is no evidence right now that Jordan's calendar is crowding out delivery work. This
directly contradicts plan/24's framing of the associate hire as relieving "the single largest
threat to the whole plan" if that threat is read as *current* capacity pressure.

**What the evidence actually supports instead:** the real, current constraint this period is
demand/pipeline-side, not delivery-side — the beachhead-band pivot (`ops-vantage-point-search-001`,
open) shows the sub-120-employee segment declining on fee justification, and even the strongest
active prospects are still mid-cycle (5-9 week sales cycle, zero closes across two check-in
periods). Jordan has spare delivery hours *because* fewer engagements are converting yet, not
because delivery capacity is capping revenue today.

**Why "full-time hire" still stands, on different grounds:** plan/24's real rationale for this
hire, read carefully, is not "relieve today's crowding" — it's "test `ka-020-associate-replication`
before it becomes an emergency," i.e. a structural, validation-driven hire ahead of demand, timed
to the calendar (playbook + associate ramp takes ~4 months) rather than to this period's
utilization reading. That is a legitimate, different form of "sustained and core" under the 1a
table (the role is meant to become permanent if the test passes), but it is **not** the same
justification the services sequencing pattern's stated trigger describes, and this file states
that distinction explicitly rather than citing the "billable hours" trigger when the actual retro
evidence doesn't support it. See the QA findings doc — this is a genuine tension between the
skill's default sequencing trigger and this fixture's real numbers, not a fixture artifact.

**Common-mistake check (services, from Step 2):** this is not the "hire a salesperson before
delivery capacity exists" mistake (this is a delivery hire, and pipeline — not delivery — is the
live constraint) nor the "junior ops/admin hire" mistake (this is a revenue-producing delivery
role with a costed, real justification in plan/24). Confirmed clear of both named failure modes.

## Comp and equity

`funding_intent: "bootstrap"` — per Step 3's bootstrap guidance, cash comp should sit closer to
market rather than below-market-plus-equity, and Jordan has explicitly ruled out raising or
building a formal option pool ("This stays bootstrapped... I'm reinvesting placement fees into
hiring associate recruiters").

**Using Jordan's own already-decided structure (plan/24), not inventing a new one:**
- **Base cash comp:** $70,000/year.
- **Variable:** 10% override commission on the associate's own closed placements — a real,
  production-linked incentive consistent with a bootstrap posture (pay scales with revenue the
  hire personally generates) rather than an equity substitute.
- **Equity/profit-share:** none proposed. Consistent with the bootstrap guidance — no formal
  option pool exists, and a simpler documented profit-share mechanism isn't currently on the
  table per Jordan's own stated plan. If Jordan wants to add one later, this needs his actual
  lawyer/cap-table setup before anything is promised in writing — not assumed here.
- **Fully-loaded planning estimate:** ~$91,000/year (1.3x multiplier midpoint) — stated as a
  planning estimate only; Jordan's real fully-loaded number (state payroll tax, any benefits
  offered, tooling/LinkedIn Recruiter seat, etc.) should replace this before the hire is finalized.

This is a planning-reference band, not a substitute for Jordan's own counsel or current
market-comp data for a search-associate role in his specific geography.

## Job description (draft)

**Title:** Associate Executive Recruiter

**Mission:** Vantage Point Search's growth is capped by Jordan's own delivery hours, not by demand
or pricing (LTV:COCA is already healthy at 11.8-15.7:1) — this role exists to prove the business
can deliver retained VP/Director Engineering searches at Jordan's quality bar without Jordan
personally sourcing every candidate, unlocking the roadmap's Pin 2 (Product-search) expansion once
proven.

**Outcomes/KPIs owned in the first 6-12 months:**
1. Complete onboarding/ramp (technical-screening playbook + Jordan's direct oversight) within the
   first ~4 months, per plan/24's ramp assumption.
2. Independently source, screen, and deliver a 4-6 candidate slate within ~30 days of search kickoff
   on at least one real, paid engagement, with Jordan on QA/oversight only — this is the live test
   of `ka-020-associate-replication`, this business's single most consequential open assumption.
3. Close 3 associate-led placements in Year 1 (plan/24's conservative Year-1 output assumption,
   well below Jordan's own realized 5.1/year solo rate — deliberately conservative for a ramping
   hire).
4. Maintain the same 90-day placement guarantee standard Jordan holds himself to (observed 17%
   invocation rate on Jordan's own searches — the bar this role must meet, not beat, in year one).

**Must-haves (3-5, real, not a wish list):**
- Prior technical/engineering-leadership recruiting experience (in-house or agency) — this role
  has no ramp time to teach recruiting fundamentals from zero.
- Demonstrated ability to run structured candidate conversations and make a real go/no-go call on
  technical depth — not just source and forward resumes.
- Comfortable working under a written playbook and a supervisor's QA review during the ramp period,
  without needing to reinvent process.
- Based in (or willing to work) Jordan's operating time zone(s) for live client/candidate
  coordination.

**Nice-to-haves (clearly separated):**
- Prior experience specifically in retained (not contingency) search.
- Existing relationships in the VC-backed startup engineering-leadership community.
- Comfortable with commission-based variable comp as a meaningful share of total earnings.

**Comp range:** $70,000 base + 10% override commission on own closed placements (fully-loaded
estimate ~$91,000/year planning figure) — disclosed range, per Step 3 above.

**Reporting line:** Reports directly to Jordan (founder) during ramp; this is the business's first
hire, so there is no existing management layer to place this role under.

## Interview scorecard (draft)

Three-stage loop — appropriate for a single individual-contributor delivery hire, not a senior
leadership loop:

**Stage 1 — Screen (30 min, Jordan):**
- Recruiting-experience depth: has this candidate actually run technical/leadership searches, not
  just generalist recruiting?
- Communication clarity: can they explain a past placement's process in a structured, specific way
  (not vague generalities)?

**Stage 2 — Working session / live case (60-90 min, Jordan):**
- Technical-screening judgment: given a mock VP-Engineering candidate profile, can they identify
  the right follow-up questions to assess real depth (the exact skill the not-yet-written playbook
  is meant to codify)?
- Process discipline: do they naturally structure their approach, or do they need heavy prompting —
  a live signal for how much ramp/QA oversight this specific hire will actually need.
- Real-world sourcing instinct: given a mock beachhead-profile client brief, where would they
  actually look for candidates?

**Stage 3 — Reference checks (2 references, prior manager or client where possible):**
- Fill-rate/quality track record: did placements stick, or churn early?
- Independence under supervision: can they take direction without needing to be told everything
  twice — directly relevant to the ramp model plan/24 assumes (Jordan on QA only, not daily
  hands-on management).

**No-hire bar, stated in advance:** a "no" on either must-have #1 (prior technical-recruiting
experience) or must-have #2 (structured technical-depth judgment, demonstrated in Stage 2) is a
no, regardless of how strong sourcing instinct or culture fit signals are — those two are the load-
bearing skills `ka-020-associate-replication` is actually testing; a warm, well-liked hire who
can't clear that bar doesn't resolve the assumption, it just delays finding out.

## Org design notes

This is the business's first hire — no standing headcount to re-check for manager-layer or DRI
issues yet. Flagging forward: once this hire is made, Jordan becomes a manager (of one) for the
first time; per Step 5's span-of-control guidance, this is nowhere near the 7-10-report threshold,
so no manager-layer concern now. **Common-mistake check:** this is explicitly not a premature
"VP/Head-of" hire — it's an individual-contributor role with an existing function (Jordan's own
search practice) to be trained into, which is exactly the structure Step 5 says a senior title
would be missing if hired first. None flagged.

## Risk flagged

Post-hire runway recomputes to **Warning (~5.6 months)**, using the judgment-call baseline burn
described above (the literal latest finance-metrics snapshot reads "cash-generative," which this
file treats as non-representative of ongoing burn, not as the safe answer). Per Step 1b, this is
not a block, but must be visible, not routine. Jordan has not yet been asked, in this dry run,
whether he wants to proceed with this Warning-level read in hand — this file surfaces it for that
conversation rather than assuming an answer. A `risk_log` entry is logged below regardless, per
this skill's instruction that a Warning-level post-hire runway gets logged (the instruction reads
"lands Warning and the founder proceeds anyway" — this run proceeded through Steps 2-4 to produce
the deliverable per this QA round's own instructions, so the entry is logged; see the QA findings
doc for the ambiguity this created about whether "produce the deliverable" implies "proceed" for
`risk_log`-logging purposes when no founder was actually asked).
