# Review — Vantage Point Search — Plan v1 — 2026-08-18

## Header

- **Business:** Vantage Point Search (retained VP/Director Engineering search, services,
  bootstrap-funded, already operating 14 months)
- **Plan version reviewed:** v1 (`plan/business-plan.md`)
- **Review date:** 2026-08-18
- **Track assigned:** **Track A — bootstrap-track.** `gtm.funding_strategy` is `undecided` (GTM
  work hasn't started), so per §2's priority order this fell to `business_basics.funding_intent`,
  which is explicitly `bootstrap` (Jordan's own unprompted statement during onboarding: "This
  stays bootstrapped — I'm not raising money to run a search firm, I'm reinvesting placement fees
  into hiring associate recruiters"). Used directly per §2 step 1a, no prose-inference needed.
- **Panel (5 seats):** `customer-discovery-skeptic`, `financial-modeling-reviewer`, `vc-panel`,
  `expert-entrepreneur-panel` (4 fixed seats) + `services-unit-economics-reviewer` (contextual
  5th seat).
- **5th-seat trigger reasoning (stated per this skill's auditability requirement):** Ran the
  current §3 priority procedure in full, including the two new tiers added to this file
  mid-session (`regulated-industry-compliance-reviewer` at #1, `hardware-physical-product-
  operator` at #3 for `physical_product`):
  1. `regulated-industry-compliance-reviewer` (#1): **checked and correctly not triggered.**
     `business_basics.business_type_notes` and Steps 7/15 contain no regulated-industry content.
     Step 1's full segmentation table (which, by design, surveys all 7 candidate segments,
     several explicitly rejected) does contain one incidental keyword hit — Segment 7's
     description mentions candidates needing "HIPAA-adjacent experience" for a non-tech-industry
     variant of the role. This is content about a *candidate's résumé qualification for a
     segment that was never selected as the beachhead and is not pursued anywhere else in the
     plan* — not a signal that Vantage Point Search itself handles PHI, patient data, or any
     regulated activity. Read in context rather than as a bare string match, this does not
     describe the business's own actual activity, so the trigger correctly does not fire. Flagged
     explicitly in this rationale, and separately in this session's QA findings, since a less
     careful reading of this trigger's own "keywords such as..." list against Step 1's necessarily-
     broad segmentation table could plausibly false-positive here.
  2. `technical-feasibility-reviewer` (#2): not triggered — `business_type` is `services`, not
     `physical_product`; no novel/unproven technology anywhere in Step 7's product spec (the
     "product" is a defined service delivery process, not a technology).
  3. `services-unit-economics-reviewer` (#3): **triggers** — `business_basics.business_type` is
     `services`, unconditional type match, no additional content signal required.
- **Tie-break note:** Step 12's DMU is genuinely multi-stakeholder (champion, economic buyer, and
  a real comp-committee veto at larger clients — confirmed on 2 of 6 closed engagements), which
  independently satisfies `sales-motion-reviewer`'s trigger too. Per the tie-break rule, #3
  outranks #4 for every `services` business, so `services-unit-economics-reviewer` takes the seat
  and **`sales-motion-reviewer` is logged as the runner-up**, recommended for the next review
  cycle specifically to give the comp-committee veto point a dedicated process-realism read.
- **Regulated-industry near-miss:** also logged explicitly above as considered-and-correctly-not-
  triggered, not as a runner-up (it never fired), because a mechanical read of the trigger's
  keyword list against Step 1's table alone could plausibly have misfired — see the QA findings
  doc for the full write-up of this edge case.
- **First review for this plan** — no prior review file to reconcile against.

---

## `customer-discovery-skeptic`

## Verdict: APPROVE_WITH_NOTES
**Score:** 8
**Reviewer persona:** Applied customer-discovery coach, Steve Blank tradition — deliberately the
harshest reviewer on the panel, hunting for pattern-matching to founder's desired story over real
evidence in Steps 1-9. Disclosed default-skeptical posture below.

### Strengths
- This is real, not constructed evidence, and it shows: the beachhead (Step 2) is validated by 6
  of 8 actual signed engagements, not a hypothesis about where a business *should* focus.
- Step 9's next-10 list includes two honest disconfirming signals (a quiet prospect, a
  non-responsive one) rather than a curated wishlist — exactly the discipline this rubric exists
  to demand, and rare to see unprompted.
- Step 3/5's personas are built from named, traceable client relationships with specific,
  idiosyncratic detail (Dana's exhausted-network frustration, the specific quote about "knowing
  what good looks like but not having time to find it") rather than a generic archetype.

### Risks / gaps
- [EVIDENCE-GAP] The evidence base is real but thin: 35 tracked conversations, 8 signed
  engagements, over 14 months. This is legitimate early-operator evidence, not a fabrication — but
  it should not be read as more statistically robust than it is when this plan is shown to anyone
  outside internal planning.
- [MARKET-SIZE] Step 4's beachhead TAM is bottom-up in *methodology* but every input (company
  count, turnover rate) is an unverified founder estimate — no external search was attempted this
  session (honestly disclosed). Recommend at minimum a free-source spot-check (e.g., sampling
  actual funding-announcement data for the stage/headcount band) before this figure is shown
  outside internal planning.
- [SEGMENTATION] The "next 10" real-signal evidence, while genuinely real, is concentrated in just
  2 referral relationships (`ka-009-referral-concentration`) — this is validation of two strong
  relationships more than it is broad validation of the beachhead market itself. Worth naming
  explicitly rather than reading the 23% conversion rate as representative of a diversified
  channel.

---

## `financial-modeling-reviewer`

## Verdict: APPROVE_WITH_NOTES
**Score:** 8
**Reviewer persona:** Former startup CFO / financial-modeling consultant — independently
re-derives every material figure and checks its sourcing; conservative, spreadsheet-shaped bias
disclosed below.

### Strengths
- Every material figure recomputes cleanly from its stated inputs: TAM (360 × $70,500 =
  $25.38M, rounds to the stated ~$25M), Pin-2 TAM (288 × $65,000 = $18.72M, rounds to ~$19M), LTV
  ($70,500 − $9,000 = $61,500; × 1.33 = $81,795, rounds to $81,800), COCA ($1,600 + $2,900 + $670 =
  $5,170, within the stated $4,900-$5,400 range), and both LTV:COCA ratios (11.83:1 and 15.73:1,
  correctly rounded to 11.8:1 and 15.7:1). No arithmetic errors found anywhere in the money-making
  section.
- The pricing figure ($70,500 average fee, `qc-016-price`) is the standout figure on this whole
  panel from a sourcing standpoint — real, repeated market data across 8 actual signed
  engagements, correctly marked `confidence: high`, not an estimate dressed up as one.
- Precision now correctly matches method throughout Section 4, including the COCA figure — this
  session's own AI-risk gate log (`risk_log` `ar-vps-001`) shows an earlier draft stated COCA to
  the exact dollar and was correctly caught and fixed; the fixed version holds up under
  independent recomputation.

### Risks / gaps
- [SOURCING] The $100/hr founder-time placeholder rate is used consistently across LTV and COCA
  (a real internal-consistency strength), but has never been checked against an actual market
  comparable (`ka-019-founder-rate`) — still open.
- [FINANCIAL-ARITHMETIC] Step 14's Pin-2 TAM uses a distinct opening-rate assumption (12%/year vs.
  the beachhead's 15%/year) with no stated basis for why Product-leadership roles would turn over
  less often — a reasonable-sounding but currently unsupported adjustment, worth a one-line
  justification or removal in favor of using the same rate.
- [UNIT-ECONOMICS] The guarantee-invocation cost surfaced honestly in Step 23
  (`ka-023-guarantee-cost-uncounted`, 17% observed rate, ~85 uncompensated hours) has not actually
  been computed as an expected-value adjustment anywhere. Rough math: 17% × 85 hrs × $100/hr ≈
  $1,445 of expected additional delivery cost per engagement — not currently reflected in Step
  17's $9,000 delivery-cost figure. This modestly overstates true margin; recommend folding it in
  explicitly next revision rather than leaving it as a footnote.

---

## `vc-panel`

## Verdict: REJECT
**Score:** 3
**Reviewer persona:** Seed/Series A generalist VC, ~10-12 years, evaluates for venture-scale
return potential — calibrated bias toward large TAM disclosed below.

### Strengths
- This is a genuinely well-run small business with real revenue, real margins, and an honest
  founder — if anything, the founder's own stated bootstrap intent means this reviewer's lens is
  somewhat moot for what Jordan is actually trying to build, and that's worth saying plainly
  rather than pretending this REJECT is a verdict on the business's soundness.
- The unit economics, on their own narrow terms, are strong (LTV:COCA 11.8:1-15.7:1) — this is not
  a REJECT on execution or arithmetic grounds.

### Risks / gaps
- [VENTURE-FIT] Both the beachhead (~$25M) and Pin-2 (~$19M) TAMs are modest, and neither shows a
  path to a venture-scale (hundreds of millions+) outcome — this is capped by the business's
  structure (single-operator, project-based fee-for-service), not just by current stage.
- [VENTURE-FIT] Step 10's core is honestly self-assessed in the plan itself as founder-relationship-
  and-method-based, not a compounding technical/network-effect/data moat — this reviewer credits
  the honesty, but the underlying fact remains a real cap on venture-scale defensibility.
- [VENTURE-FIT] Step 15's business model requires linearly-scaling headcount to grow revenue — the
  single clearest signal this is not a venture-shaped bet, independent of how healthy today's
  LTV:COCA ratio looks.

### Required revisions (if REVISE or REJECT)
Not applicable in the sense this reviewer would apply to a venture-track business — this REJECT
rests entirely on `[VENTURE-FIT]` grounds and is expected, consistent with the founder's own
stated bootstrap intent (see this persona's own file: "a services business is the case most likely
to earn a `[VENTURE-FIT]`-only REJECT even when everything else about it is sound — say so
plainly rather than inventing a defensibility problem that isn't really there").

**This REJECT rests entirely on `[VENTURE-FIT]` concerns — every Risks/gaps bullet above is tagged
`[VENTURE-FIT]` and nothing else; there is no independent soundness concern in this verdict.**

---

## `expert-entrepreneur-panel`

## Verdict: REVISE
**Score:** 5
**Reviewer persona:** Operator, 3x founder (2 bootstrapped to profitability, 1 modest VC exit) —
calibrated toward operational realism and founder-market fit, skeptical of hypergrowth claims
untested by real constraints, disclosed below.

### Strengths
- Real founder-market fit, not assembled from market logic — 11 years in-house recruiting at
  exactly this company profile, evident throughout Steps 3/5/6.
- The core offer's MVBP has already been validated 6 times, not hypothetically designed — this
  plan is describing a running business, and it shows.
- The roadmap explicitly sequences capacity-building work ahead of market expansion, and — genuinely
  rare on this reviewer's desk — names a real fallback if the associate-recruiter hire doesn't
  work out, rather than treating headcount growth as the only acceptable outcome. Credit this
  plainly: this is exactly the kind of intellectual honesty this reviewer wishes more plans had.

### Risks / gaps
- [EXECUTION-RISK] Step 24's associate-recruiter hiring plan costs the comp, override commission,
  and training-time opportunity cost in real detail — genuinely well done — but never names who
  the candidate actually is or where Jordan would source one. This is structurally identical to
  the "we'll run ads with no stated budget" pattern this reviewer specifically watches for in
  Steps 13/18, just applied to hiring instead of paid acquisition: a real, currently-unaddressed
  channel-access question for the hire itself.
- [MVBP-SCOPE] MVBP #2's success bar is well-specified (comparable fill rate/timeframe, QA time
  under 15 hours), but there's no stated fallback if the *first* associate-led search fails that
  bar — try a second candidate immediately, redesign the playbook first, or pause the hiring
  thread entirely? Not addressed.

### Required revisions (if REVISE or REJECT)
1. [EXECUTION-RISK] Name a real, current channel for sourcing the associate-recruiter candidate
   (an existing relationship, a specific job board/network, or an explicit statement that this
   channel doesn't exist yet and needs its own discovery process) before this roadmap item is
   treated as ready to execute — right now the hire is costed but not actually sourceable as
   described.

---

## `services-unit-economics-reviewer`

## Verdict: APPROVE_WITH_NOTES
**Score:** 7
**Reviewer persona:** Former professional-services/agency operator — calibrated to distrust
SaaS-shaped financial-model language applied to a business that's actually capacity-constrained
by real delivery hours, disclosed below.

### Strengths
- This plan does exactly what my own disclosed bias asks me to watch for and credit when I see
  it: it names a real, specific delivery-scaling mechanism (hiring and training an associate
  recruiter) with a stated timeline and cost already folded into the analysis — comp, override
  commission, *and* the founder's own training-time opportunity cost, not just headcount salary.
  This is the single most consistently well-executed thread in the whole plan from my chair, and I
  am correcting for my own default skepticism explicitly rather than re-raising a capacity concern
  that has, in fact, already been addressed with real numbers.
- Step 17's LTV correctly nets a real delivery-cost figure rather than borrowing an unadjusted
  SaaS-typical gross-margin assumption — exactly the check my rubric exists to force, done
  correctly without my having to ask for it.
- Step 19's framing — "acquiring a customer was never the bottleneck — delivering the work is" —
  is stated explicitly and correctly. A healthy LTV:COCA ratio is presented honestly as orthogonal
  to the real growth constraint, not as evidence the business can simply scale by acquiring more
  customers. This is precisely the SaaS-shaped-language trap my rubric exists to catch, and this
  plan avoids it on its own.

### Risks / gaps
- [DELIVERY-CAPACITY] A real internal inconsistency between two of this plan's own figures: Steps
  4/19's theoretical solo capacity ceiling (~14.2 placements/year, from 4 concurrent search slots
  × 52/11-week cycle time × a 75% fill rate) implies roughly 36-37 combined BD-plus-delivery hours
  per week at full utilization — above my own rubric's stated 20-30 hr/week realistic solo
  ceiling, and Jordan is doing *both* BD and delivery personally, which if anything argues for the
  lower end of that range, not the higher. The plan never reconciles its own cited theoretical
  ceiling against this heuristic; the *realized* rate (5.1 placements/year, ~13 hrs/week) is
  comfortably within it, but the aspirational figure quoted upstream in Steps 4 and 19 is not, and
  nothing currently flags that gap.
- [DELIVERY-CAPACITY] The guarantee-invocation cost (`ka-023-guarantee-cost-uncounted`, a real,
  17%-observed-rate, ~85-uncompensated-hour cost) is honestly surfaced in Step 23 but never folded
  into Steps 17/19's margin, LTV, or COCA figures even as a footnote — this independently
  corroborates `financial-modeling-reviewer`'s separate note on the same underlying gap, from a
  delivery-capacity angle rather than a pure-sourcing one.

### Required revisions (if REVISE or REJECT)
Not formally applicable at this verdict level (`APPROVE_WITH_NOTES`) — see Risks/gaps above for
the two nameable, non-blocking gaps. If I were to name one priority for the next revision cycle
regardless: reconcile the theoretical-capacity figure against the realistic-hours heuristic
explicitly, since it's the one place this plan currently cites a number that would concern me if a
founder started planning around it uncritically.

**One-seat-boundary note, per my own rubric:** `sales-motion-reviewer` was the tie-break runner-up
for this review's contextual 5th seat (Step 12's DMU independently signals multi-stakeholder
complexity — a comp-committee veto at larger clients). I don't duplicate that rubric here; a
dedicated process-realism read on that veto point is still recommended for the next review cycle.

---

## Aggregation accounting

**Step A — track weighting (§4).** Track A (bootstrap). `vc-panel`'s verdict is REJECT with every
Risks/gaps bullet tagged `[VENTURE-FIT]` and nothing else — 100% `[VENTURE-FIT]`-tagged, per its
own explicit closing statement. Per §4, this verdict is downgraded to **informational** and set
aside from the blocking set. **Blocking set (4 seats):** `customer-discovery-skeptic`
(APPROVE_WITH_NOTES), `financial-modeling-reviewer` (APPROVE_WITH_NOTES), `expert-entrepreneur-
panel` (REVISE), `services-unit-economics-reviewer` (APPROVE_WITH_NOTES).

**Step B — harshest severity in the blocking set.** REVISE (severity 3), held alone by
`expert-entrepreneur-panel`.

**Step C — outlier test on `expert-entrepreneur-panel`'s REVISE.**
1. Alone at the harshest severity in the blocking set? **Yes** — the other three are all
   APPROVE_WITH_NOTES.
2. Tag overlap check against every other original-blocking-set reviewer's tags: `expert-
   entrepreneur-panel` tagged `[EXECUTION-RISK]` and `[MVBP-SCOPE]`. Checking all three other
   blocking-set reviewers' tags: `customer-discovery-skeptic` used `[EVIDENCE-GAP]`,
   `[MARKET-SIZE]`, `[SEGMENTATION]`; `financial-modeling-reviewer` used `[SOURCING]`,
   `[FINANCIAL-ARITHMETIC]`, `[UNIT-ECONOMICS]`; `services-unit-economics-reviewer` used
   `[DELIVERY-CAPACITY]` (twice). **`[EXECUTION-RISK]` and `[MVBP-SCOPE]` appear in no other
   blocking-set reviewer's tags — no overlap, by the letter of the mechanical check.**
3. Discarding it would leave 3 verdicts standing (not zero) — passes.

**This verdict passes all three outlier tests and is discarded**, per the mechanical rule — flagged
explicitly, and separately in this session's QA findings, as a case worth a second look: in
substance, `expert-entrepreneur-panel`'s `[EXECUTION-RISK]` finding (no named channel to source the
associate-recruiter candidate) and `services-unit-economics-reviewer`'s `[DELIVERY-CAPACITY]`
findings (the capacity-ceiling reconciliation gap) are two independent panelists converging on the
same underlying theme — *can the associate-hire plan for scaling delivery actually be executed as
described* — from two different, correctly-distinct rubric angles, but they used different tags
(`[EXECUTION-RISK]` vs. `[DELIVERY-CAPACITY]`) for their specific, non-identical findings within
that theme. The mechanical tag-overlap check, which operates on exact tag identity, cannot detect
this kind of substantive-but-differently-tagged convergence, and correctly discards
`expert-entrepreneur-panel`'s verdict as an outlier per its own literal rule.

**Recompute.** Harshest remaining severity: APPROVE_WITH_NOTES (severity 2), held by 3 reviewers
(`customer-discovery-skeptic`, `financial-modeling-reviewer`, `services-unit-economics-reviewer`)
— not alone, stops here.

**Aggregate verdict: APPROVE_WITH_NOTES. Aggregate score: 7** (the lowest of the three
APPROVE_WITH_NOTES scores — `services-unit-economics-reviewer`'s 7).

---

## Aggregate Verdict

## Verdict: APPROVE_WITH_NOTES
**Score:** 7

### Notes to consider

**A schema note, stated plainly rather than silently resolved:** per CONVENTIONS.md §6, a
`Required revisions` section is only part of the schema `if REVISE or REJECT`; none of the three
surviving APPROVE_WITH_NOTES-level verdicts above formally carry one. §8.4's instruction to
synthesize "the union of every required-revision item from every reviewer whose verdict counted
toward the aggregate severity" has no literal content to union when the aggregate itself lands at
APPROVE_WITH_NOTES, since the per-persona schema doesn't produce Required-revisions items at that
severity. This is flagged as a real spec gap in this session's QA findings rather than silently
worked around. The pragmatic resolution used here: union the three surviving reviewers' Risks/gaps
bullets into a "Notes to consider" list instead, since that's the substantive content the founder
actually needs to see at this severity level.

1. [MARKET-SIZE] Beachhead and Pin-2 TAM company counts/turnover rates are founder estimates with
   no external verification attempted this session — spot-check against a free public source
   before sharing outside internal planning (`customer-discovery-skeptic`).
2. [SOURCING] The $100/hr founder-time placeholder used throughout LTV/COCA has never been checked
   against a real market comparable (`financial-modeling-reviewer`, `services-unit-economics-
   reviewer` both independently flag this via different steps).
3. [UNIT-ECONOMICS] / [DELIVERY-CAPACITY] The guarantee-invocation cost (~$1,445/engagement
   expected value) is honestly surfaced but not yet folded into the LTV/COCA figures — fold it in
   explicitly next revision (`financial-modeling-reviewer` and `services-unit-economics-reviewer`
   independently, genuinely overlapping tags this time).
4. [DELIVERY-CAPACITY] Reconcile the theoretical ~14.2-placement/year solo capacity ceiling cited
   in Steps 4/19 against the realistic 20-30 hr/week heuristic — the cited ceiling currently implies
   more weekly hours than a solo operator doing both BD and delivery could realistically sustain
   (`services-unit-economics-reviewer`).

### Discarded-but-real concerns

- **`expert-entrepreneur-panel` — REVISE, score 5.** Sharpest point: the associate-recruiter
  hiring plan is costed in real detail but names no actual channel for sourcing the candidate —
  the hire is budgeted but not yet sourceable as described. Discarded as a mechanical outlier (see
  Aggregation accounting above) despite substantively echoing `services-unit-economics-reviewer`'s
  `[DELIVERY-CAPACITY]` concerns under a different tag — see the QA findings doc for the full
  write-up of why this is worth a second look before treating the discard as final.

### Also flagging, regardless of severity

The single most consequential open question in this entire plan, independent of any persona's
verdict severity, is `ka-020-associate-replication` — whether an associate recruiter can actually
replicate Jordan's fill rate and quality bar. No panelist's tags or severity fully capture this,
because the plan itself already treats it as the top-priority open test (Steps 20-22) rather than
an unnoticed gap — the panel's job here was to confirm the plan is honest about this dependency
(it is) rather than to discover it fresh. Flagging it here anyway, per this section's purpose, so a
founder skimming only the checklist above still sees it named plainly: **this entire plan's growth
story is currently unproven past one person, and everyone on this panel, including this aggregate
verdict, is approving a plan whose central bet has not yet been tested.**

---

## Council-integrity note

Ran the post-verdict AI-risk council-integrity check (`skills/risk/ai-risk-review`, second required
call). **No rubber-stamping signal this pass** — the five verdicts are visibly non-interchangeable:
each panelist grounds its findings in different step numbers, uses distinct tag combinations, and
reaches a different severity for different, named reasons (from `vc-panel`'s pure venture-fit
REJECT to `expert-entrepreneur-panel`'s execution-risk REVISE to three genuinely distinct
APPROVE_WITH_NOTES rationales). Stated as a clean result, not omitted because it's good news.

## Disclaimer

This review is a planning aid produced by simulated reviewer personas grounded in the Disciplined
Entrepreneurship framework and this business's own stated facts — it is not licensed financial,
legal, or investment advice, and passing it is not validation from a real investor, customer, or
advisor. See `docs/AI-RISK-FRAMEWORK.md` for what this system's review layers do and do not verify.
