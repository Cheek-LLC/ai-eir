# Operations & Fulfillment Review — SkyClaim — 2026-08-18

## Business type: marketplace
Only the `marketplace` section below applies (`business_basics.business_type: "marketplace"`);
`physical_product` and `services` sections are not applicable and are omitted per the skill's own
gate. **This is the first-ever run of this skill for SkyClaim** — no prior
`ops/operations-review-*.md` file exists, so there is no trend to compare against yet, only a
baseline.

**Context this review must state plainly, because it changes what "real data" can mean here:**
`business-state.json.stage` is `"revising"` — `plan/business-plan.md` v1 was **REJECTed** by the
venture-track council (`reviews/2026-08-18-venture-track-panel-v1.md`, score 2/10), not
`"operating"` or `"gtm"`. Per this skill's own frontmatter, its normal trigger is stage `operating`
(or `gtm` post-soft-launch); this run instead uses the frontmatter's explicit direct-invocation
allowance ("run directly when a founder asks about... marketplace supply-side vetting and liquidity
health") — Derek asked directly, mid-revision, before any formal re-review. Separately and more
consequentially: `plan/23-show-that-dogs-will-eat-the-dog-food.md` states explicitly **zero MVBP
transactions have occurred** — the Step 22 MVBP (manual concierge matching, 4-6 committed pilots,
$175/property, 18% take rate) has been defined but not yet run live. This review does not invent a
transaction history that doesn't exist. Where the founder genuinely has no data because nothing has
happened yet, this review says so plainly rather than estimating.

## marketplace: Supply-side operations

### 1. Supply-side onboarding and vetting
Founder-reported, cumulative to date (no formal "period" exists yet — this is a first baseline, not
a period-over-period figure):

- **Candidates identified:** 5 named supply-side prospects (Step 9): Marcus Webb, Priya
  Chandrasekaran, Jake Fennimore, Carlos Districh, Tom Whitfield. Of these, 4 are described in
  Step 22 as "committed" (ready to accept a dispatched job on short notice) and 1 (Tom) is not yet
  contacted.
- **Verification steps that actually exist today:** none formal. For pilots Derek already knows
  personally (Marcus, Jake), verification is "I already know he's Part 107 certified and insured
  because I've worked with him." For pilots outside his personal network (Priya, Carlos), the only
  check performed is asking to see a screenshot of the Part 107 certificate over text — no
  cross-check against the FAA's public certificate registry, no insurance-proof document collected,
  no sample-work or portfolio review, no identity verification beyond the certificate photo itself.
- **Applicants vs. approved vs. rejected:** 5 candidates identified, 0 formally rejected, 0
  formally approved through any defined step — "approval" so far means Derek personally deciding
  someone is good enough, not a process with a pass/fail gate. **Time-to-approve is not tracked**
  because there is no discrete approval event to time.

**Material finding — `[SUPPLY-QUALITY]`.** This clears the skill's own materiality bar on **two
independent grounds**, not one: (a) **no vetting process exists at all**, and this is a category
where supply-side quality is load-bearing to trust — FAA-regulated aerial operation over private
property, feeding a document a licensed insurance carrier will rely on to pay a claim; and (b) the
**informal approval rate is effectively 100%** (every candidate approached has been accepted, zero
rejections ever recorded), which the skill's own guidance names directly as "a vetting step that
never actually filters anyone isn't a filter." Both conditions hold simultaneously here, not just
one. Logged as `risk_log` entry `ops-skyclaim-t10-ops-1` (see below).

**Consistency check against `marketplace-liquidity-specialist`'s plan-stage review:** this finding
does not contradict that review — it sharpens it. The reviewer never assessed supply-side vetting
mechanics (out of that persona's stated rubric: Steps 1/3/9/12/15/4/14, not an operational
QC/verification process), but its central framing — supply is "the binding constraint," the side
"harder to get" — is corroborated here from a different angle: not only is supply thin in *count*
(the review's concern), the little supply that exists has never been through any real quality gate
either. Both findings point the same direction and reinforce rather than conflict.

### 2. Quality and trust mechanisms
Founder-reported: **not applicable this period — no completed transactions exist.**
`plan/23-show-that-dogs-will-eat-the-dog-food.md` confirms zero MVBP transactions to date, so there
is no rated transaction, no dispute, and no deactivation event to report on. This is not a data gap
the founder failed to provide — it is the literal, honest state of a business that hasn't
transacted yet. No materiality judgment applies to data that cannot yet exist; nothing is logged
here as a finding, and nothing should be estimated to fill the gap.

## marketplace: Liquidity operations

**Fill/Match Rate = Matched Transactions ÷ Total Search-or-Listing Attempts.** Founder-reported:
0 ÷ 0 — undefined. No demand-side job has yet been routed through any matching mechanism (formal
or manual); the 4-6 "committed" pilots are a recruiting-stage list, not evidence of a single
completed match.

**Founder-manual-intervention share:** by Step 22's own design, matching today is **100% manual**
(Derek personally matches every incoming job to a pilot by text/phone — this is a stated design
fact of the MVBP itself, not a measured period trend). Because zero jobs have actually been routed
yet, there is no trend to report on whether that manual share is starting to decrease as volume
grows — it cannot decrease from a base of zero real transactions. This is worth naming as its own
structural observation: **the manual-intervention metric this section is built to track will read
as literally undefined for as long as the MVBP stays unlaunched**, which is exactly this business's
current, honestly-disclosed state (Step 21 deferred all leap-of-faith assumption testing to
post-MVBP; Step 23 confirms no transaction has closed).

**Consistency / integration check against `marketplace-liquidity-specialist`'s review — the
material gap this run surfaced.** That review's own aggregation section names the panel's
disintermediation-risk finding — "once a matched pilot and contractor have each other's contact
info and a completed transaction's worth of trust, what stops them from going direct next time and
cutting the take rate?" — as **"arguably the single most consequential finding on the entire
panel."** This skill's Liquidity Operations section (fill/match rate, manual-intervention share) is
the only place in this ops layer that could operationalize that finding into a tracked, real metric
once transactions start closing — something like "% of a repeat pair's transactions that route
through SkyClaim vs. off-platform" or "known off-platform-contact incidents this period." **No such
check exists anywhere in this skill's marketplace section.** This is not a contradiction of the
plan-stage review (the ops skill never asserts disintermediation isn't a risk), but it is a real
gap: this skill explicitly bills its marketplace section as "the ongoing-operations execution of
what `marketplace-liquidity-specialist` assessed at the plan stage," and the plan-stage review's own
highest-weighted finding has no operational counterpart here to eventually measure it against. Not
logged as a `risk_log` entry against SkyClaim (this is a plugin content gap, not a fact about
SkyClaim's operations) — see the QA findings doc for the full writeup.

## Process documentation
Team is solo-founder (Derek alone) — per this skill's own team-size gate, this is noted in the
Watch List, not `risk_log`, at this team size. No process has been run "twice or more" in the
skill's sense yet, since no MVBP transaction has occurred at all — there is nothing yet to have run
even once.

## Risks logged this period
- `ops-skyclaim-t10-ops-1` — `[SUPPLY-QUALITY]` No formal supply-side vetting process exists (only
  informal personal-relationship recognition or a certificate screenshot with no registry
  cross-check), and the informal approval rate to date is 100% (0 of 5 candidates ever rejected),
  for a category (FAA-regulated aerial operation, insurance-claim documentation, property access)
  where supply-side quality is load-bearing to trust on both sides of the marketplace.

## Watch list
- Team is solo-founder; process-documentation debt is real but not yet material at this team size
  — revisit once a second person (technical co-founder/contractor per `ka-024-eng-resourcing`, or a
  second pilot-facing operations hire) is doing operational work.
- Liquidity-operations metrics (fill rate, manual-intervention share) are structurally undefined
  until the Step 22 MVBP actually launches — re-run this section as the first real check once any
  transaction closes, not on a calendar cadence alone.
- The plan-stage disintermediation-risk finding (`marketplace-liquidity-specialist`, Required
  revision #1) currently has no operational metric anywhere in this ops layer to eventually track it
  against — worth raising to plugin maintainers, not something SkyClaim itself can resolve
  operationally before the skill gains a check for it.

## Data gaps
- Time-to-approve for supply-side vetting: not tracked (no discrete approval event exists to time).
- All quality/trust metrics (rating %, dispute rate, deactivations): not applicable — zero
  completed transactions.
- Fill/match rate and its trend: not applicable — zero transactions attempted through any matching
  mechanism yet.
