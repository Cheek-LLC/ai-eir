# Interview Log — Vantage Point Search

## 2026-08-18 — Onboarding interview (skills/interview/onboarding-interview)

Opened with the standard "30-Minute Startup" expectation-setting (this is a multi-session
process, not a literal 30 minutes; a genuinely rigorous plan runs all 24 DE steps).

**Business name:** Vantage Point Search (founder already had this name; no rename needed).

**Founder:** Jordan Reyes. No email offered/needed this session.

**One-liner — first pass (vague, pushed back on):** "I help startups hire senior engineering
leaders." Applied the vague-answer playbook's "narrower-than-everyone-but-still-not-a-real-
beachhead" test — "startups" and "senior engineering leaders" are both still categories with
thousands of members. Asked: "If you had to pick the single most likely first client — one type
of company, one kind of role — who is it?"

**One-liner — second pass (accepted):** "Retained executive search for VP/Director of
Engineering hires at Series B–D venture-backed startups (roughly 50–500 employees) who've tried
to fill the role through their own network or a generalist recruiter for 2–3+ months and struck
out." Names a real customer type (a specific funding-stage/headcount band of startup, specifically
the person doing the hiring — usually the CEO or Head of Talent) and a real problem (a senior
technical-leadership role that's stalled past the point their own pipeline can fill it). Recorded
as `business_basics.one_liner`.

**Venture stage:** `already_operating`. Follow-up on traction: Jordan has run this as a solo
independent search consultant for 14 months — 8 retained engagements signed, 6 completed
placements, 2 did not close (1 client paused hiring after a rough fundraise, 1 filled internally
after Jordan's slate was presented). This is real, if thin, operating history — not a from-scratch
idea.

**Funding intent:** Asked directly. Jordan was clear and unprompted: "This stays bootstrapped —
I'm not raising money to run a search firm, I'm reinvesting placement fees into hiring associate
recruiters." Recorded `funding_intent: bootstrap`.

## Mandatory privacy notice (skills/risk/privacy-check, Mode A)

Delivered immediately after business basics were captured, before business-type framing began.
Jordan confirmed understanding: everything stored locally under `.startup/vantage-point-search/`;
nothing leaves without an explicit connector action; this plugin is planning content, not legal/
tax/employment-law advice; don't paste real candidates' sensitive personal data (comp history,
health info) into planning files — first-name/company-level detail for planning purposes is fine.
Logged to `risk_log` as `privacy-onboarding-vantage-point-search`.

## Phase 2 — Business-type framing

Offered the five categories. Jordan picked **services** ("people doing billable work" — his own
words: "I sell my time and my network, that's the whole business") without hesitation — no hybrid
ambiguity here.

Differentiator follow-ups (services track):
1. **Project-based, retainer, or hourly?** Project-based, industry-standard retained-search
   structure: fee = 30% of the placed candidate's first-year base salary, billed in three equal
   installments — 1/3 at engagement signing (non-refundable), 1/3 at candidate-slate delivery
   (~day 30), 1/3 at the placed candidate's start date — with a 90-day replacement guarantee (a
   free re-run of the search if the hire leaves inside 90 days, not a refund).
2. **What's the actual bottleneck on scaling?** Immediate, unprompted, correct answer: "Me. I run
   every search myself — sourcing, screening, client management, offer negotiation. I physically
   cannot run more than about 4 searches at once and stay good at any of them." This became the
   thread carried through Steps 14/15/17/19/22/24 below.
3. **Licensing/certification requirement?** None — executive search is not a licensed profession
   in the US (unlike, say, staffing agencies placing W-2 temp workers in some states, which can
   require a license; retained permanent-placement search does not). Jordan confirmed no state
   licensing applies to his current states of operation (CA, NY, remote-first clients).

`business_basics.business_type_notes`: "Retained executive search, project-based per engagement
(not retainer, not hourly). Currently solo — founder personally executes 100% of delivery
(sourcing, screening, client management) in addition to 100% of business development. No
licensing requirement. The founder's own professional network (11 years as an in-house technical
recruiter before going independent) is both the primary demand-generation channel and, candidly,
the delivery bottleneck — this shows up repeatedly through the DE steps below."

## Vague-answer / "I don't know" protocol usage during onboarding

- Applied the vague-answer playbook once (one-liner, first pass — see above); Jordan produced a
  specific second-pass answer on the first push, no further probing needed.
- No genuine "I don't know" moments during onboarding itself — Jordan had real, if limited,
  operating data for every basics question (venture stage, funding intent). The genuine unknowns
  (churn/repeat-engagement rate, true realized vs. theoretical delivery capacity, associate-
  recruiter ramp economics) surface starting at Step 14 and are logged as `key_assumptions` there,
  not invented here.

## Closing

Read back the summary: Vantage Point Search, retained VP/Director-of-Engineering search for
Series B–D venture-backed startups, already operating solo for 14 months (6 placements),
bootstrap-funded, services business type with founder-capacity-constrained delivery flagged
explicitly as the central economic question. Jordan confirmed accuracy. Told him plainly what's
next: 24 DE steps starting with market segmentation, expect real back-and-forth on the unit-
economics steps given how much rides on the capacity question. Jordan opted to keep going in the
same session rather than pause.

`business-state.json` written: `slug: vantage-point-search`, `stage: "interview"` at handoff to
orchestrator (per skill contract — this skill does not advance stage itself).
