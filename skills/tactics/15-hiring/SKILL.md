---
name: 15-hiring
description: >
  Use once `skills/ops/hiring-and-org-design` has confirmed a real role should be hired for, and
  the business needs to actually find and onboard the person — Tactic 15 of Paul Cheek's 15
  Tactics: Finding and Onboarding Your First Ten Employees. Triggers: "where do we actually find
  this person," "how do we source candidates for ___," "we made an offer, now what," "how do we
  onboard our first hire," "we have no HR department, how does day one work." Distinct from
  `skills/ops/hiring-and-org-design` (the should-we-hire decision, runway math, comp/equity bands,
  and the JD/scorecard draft) and `agents/ops/people-lead.md` (owns that decision end to end) —
  this tactic starts only after that decision exists, and covers concrete sourcing channels and
  the real onboarding mechanics for a company with no HR function yet.
---

# Tactic 15: Hiring — Finding and Onboarding Your First Ten Employees

## What this tactic is, and what it isn't

`skills/ops/hiring-and-org-design` (owned by `agents/ops/people-lead.md`) already answers whether
to hire at all, which option (contractor/fractional/full-time) fits, whether runway survives the
hire, what business-type-specific role should come first, what comp/equity band applies, and
produces a real draft job description and interview scorecard. **This tactic does not re-run any
of that.** It requires a finished `ops/hiring-plan-<role>-<timestamp>.md` file to already exist —
if one doesn't, hand off to `people-lead` first; there is no role, JD, or comp band to source
against otherwise.

**This tactic's own job, and the reason it exists as a distinct tactic:** the practical,
ground-level mechanics that skill doesn't cover — **where a first-ten-employee candidate actually
comes from** (concrete channels, not "post on LinkedIn"), and **how a real onboarding process runs
at a company with no HR department yet**.

**Scope boundary — stated once:** this is a planning aid, not licensed employment, HR,
immigration, or legal advice — the same framing `hiring-and-org-design` already states. Actual
offer letters and employment agreements are Tactic 11's (`skills/tactics/11-legal`) and the
founder's real lawyer's job; this tactic drafts the sourcing plan and onboarding process, it does
not execute a legally binding hire.

## What you read

- `.startup/<slug>/business-state.json` → `business_basics.business_type`, `funding_intent`
  (comp-posture context, already resolved by the hiring plan), `risk_log` open entries so a
  standing runway-vs-hiring-plan drift finding isn't duplicated.
- `.startup/<slug>/ops/hiring-plan-<role>-<timestamp>.md` — **required**. The specific role, the
  approved comp/equity band, the JD, and the interview scorecard this tactic sources and onboards
  against. If none exists for the role in question, stop and hand off to `people-lead`
  (`skills/ops/hiring-and-org-design`) first.
- `.startup/<slug>/tactics/15-hiring.md`, if it already exists — prior sourcing/onboarding state,
  so this run continues an in-progress search or onboarding rather than restarting it.
- `.startup/<slug>/tactics/11-legal.md`, if it exists — confirms PIIA/offer-letter template
  readiness before an offer actually goes out.

## What you write

- `.startup/<slug>/tactics/15-hiring.md` — the sourcing and onboarding record below.
- You do **not** write `business-state.json.tactics` yourself. Report your output file and a
  one-line summary back to whoever invoked you; the orchestrator updates
  `business-state.json.tactics.15_hiring` after confirming the file output.

## 1. Sourcing — concrete channels, matched to the actual role

"Post the JD on LinkedIn" is the generic non-answer this tactic exists to replace. Match the
channel to the role and the business's actual stage:

- **Warm network, always first, regardless of role.** The founders'/advisors'/current team's own
  professional network, former colleagues, and — if the founder came through one — an accelerator
  alumni network or Slack/community. A warm-network hire is pre-vetted by relationship in a way no
  channel below replicates, and it's free.
- **Engineering.** Name real, specific channels: the monthly Hacker News "Who's Hiring" thread;
  Wellfound (formerly AngelList Talent) filtered to early-stage; YC's Work at a Startup board if the
  founder has any YC affiliation; a Discord/Slack community built around the specific
  language/framework the stack actually uses (these exist for nearly every popular stack and skew
  toward exactly the self-selected, technically engaged candidates an early engineering hire needs);
  a direct, personal ask to a local tech-meetup organizer for an intro to their most technically
  credible regulars.
- **Sales / GTM.** A targeted list of reps currently at comparable-stage companies in an adjacent
  space, built via a real search tool (e.g. a LinkedIn Sales Navigator search filtered on title plus
  company stage/size) rather than a job posting and hoping — the best early sales hires are rarely
  actively job-searching, they're found. Existing investors are also a real, underused channel here:
  a fund's portfolio spans many companies' sales talent, and an investor intro to a rep who's
  outgrown their current seat is a common, high-signal path.
- **Design.** Direct outreach to designers whose actual portfolio (Dribbble, Behance, or a personal
  site) matches the product's real aesthetic need — a specific reference to a specific past project
  in the outreach message beats a generic job-board post by a wide margin for this role in
  particular, since design hiring is unusually portfolio-driven.
- **Generalist / ops / the founder's first non-technical hire.** Often best found through the
  founder's own extended network, or via a **fractional-to-full-time conversion** — someone already
  doing fractional or contractor work for the business (per `hiring-and-org-design`'s own
  fractional/contractor options) who has already proven out the fit before the full-time decision
  is even made. This is frequently the lowest-risk path to a first non-technical hire specifically,
  because the working relationship is already tested.
- **Recruiting agency / contingency search — when it's actually worth it.** Right for a hard-to-fill
  technical or executive role where speed matters more than fee (typical contingency fee runs
  roughly 20-25% of first-year cash comp). Wrong for an early generalist role the founder's own
  network can realistically reach — the fee isn't justified when a warm channel above is genuinely
  available.
- **Referral incentive — a real, specific mechanic, not a vague "ask around."** A cash bonus (a
  commonly-cited range is roughly $1,000-$5,000 depending on role seniority) to a current employee
  whose referral is hired, **paid out at a 90-day mark or later** (not on day one) so the incentive
  rewards a good long-term fit, not just filling the seat fast. This is a genuinely high-signal
  channel once there are 2+ employees to refer from, because a referral is pre-vetted by someone
  with real skin in the outcome.

**State explicitly which channel(s) this run is actually using for the role in question, and why
— not a menu of options left unselected.**

## 2. Onboarding — a real process with no HR department yet

At team-of-one-to-ten, there is no HR function to catch a badly-run first day, and the first hire's
experience sets the pattern every hire after them will implicitly compare against. Run this
concretely, in sequence:

**Pre-start (before day one):**
- Signed offer letter and signed PIIA in hand (per Tactic 11 / `skills/tactics/11-legal`) —
  onboarding does not start without both.
- Equipment ordered and access provisioned *before* day one: email, core tools, repo/codebase
  access, chat/comms — day one should not be spent on IT setup that could have happened the week
  before.
- A concrete 30/60/90-day plan drafted in advance, built directly from the hiring plan's own
  outcomes/KPIs (per `hiring-and-org-design` Step 4) — not vague ("get up to speed"), but the same
  specific, measurable outcomes the JD already committed to.

**Day one:**
- A real welcome, not a checklist handed over silently: who they're meeting this week and why, what
  they're actually doing in the first few days, and an explicit, named answer to "who do I ask when
  I'm stuck" — at this size, that's almost always the founder directly, said out loud, not assumed.
- An honest context-dump on the business: share the real plan/deck, including the parts that are
  still unresolved or risky, not a sanitized version. A first hire is joining a real, unfinished
  company and will do better work informed of that than protected from it.

**First week:**
- Get them doing a real task, paired with the founder or the most relevant existing person, quickly
  — not a long passive orientation period. A first real contribution inside the first week builds
  confidence for the new hire and surfaces any skill/fit gap early, while it's still cheap to
  address.

**30/60/90-day check-ins:**
- A real, scheduled 1:1 cadence — **weekly at minimum** for a first hire specifically, since there
  is no manager layer or HR process to otherwise catch a problem early. Explicit check-ins at the
  30/60/90-day marks against the plan drafted pre-start, so course-correction happens on a real
  schedule rather than waiting for an annual-review ritual this company doesn't have yet.

**Documentation-as-you-go:**
- The first hire is usually also the point where informal "how we do things" knowledge needs to
  start becoming a real, shared, written record — even a simple running doc. Not a full HR policy
  manual; just enough that the *second* hire isn't entirely dependent on asking the first hire
  everything the founder never wrote down.

**Practical legal/compliance items this tactic owns operationally** (substance and documents
themselves are Tactic 11's job — this tactic tracks that each is actually done before it's needed):
- **Payroll provider set up before the first paycheck is due**, not after — pick one (the kind of
  service that handles payroll tax withholding and filing) before an offer is signed, not while a
  first paycheck deadline is already close.
- **State/local registration for payroll tax withholding**, if hiring a W-2 employee — this is a
  real registration in the state where the *employee* works, which can differ from the entity's own
  formation state; confirm it's been checked, don't assume the formation state covers it.
- **Workers' compensation insurance**, where legally required for the hiring jurisdiction.
- **I-9 / work-authorization verification**, completed for every US employee within the legally
  required window — this is a real compliance deadline, not a formality to get to eventually.

## Output file: `tactics/15-hiring.md`

```markdown
# Tactic 15: Hiring — <business name> — <date>

_Planning aid, not licensed employment, HR, immigration, or legal advice._

## Role and hiring-plan reference
Role: ... | Source: ops/hiring-plan-<role>-<date>.md

## Sourcing plan
Channel(s) selected for this role: <named, specific channels from §1, and why>
Candidates in progress: <name/source/stage, if any exist yet>

## Offer and pre-start status
Offer letter + PIIA: signed / pending (per tactics/11-legal.md)
Equipment/access provisioned: yes/no
30/60/90-day plan drafted: yes/no, referencing which JD outcomes

## Onboarding status (once a start date exists)
Day one: <status/notes>
First week real task: <status/notes>
30/60/90 check-in cadence scheduled: yes/no

## Payroll/compliance checklist
Payroll provider: ... | State withholding registration: ... | Workers' comp: ... | I-9: ...

## Open items carried to next run
<Blockers, next concrete action.>
```

## Done means

- A finished `ops/hiring-plan-*.md` was confirmed to exist for this role before this tactic ran —
  never sourcing/onboarding a role that hasn't cleared `hiring-and-org-design`'s should-we-hire test.
- Sourcing channel(s) are named specifically for this role, matched to the pattern in §1 — never a
  generic "post it and see."
- The onboarding plan covers pre-start, day one, first week, and the 30/60/90 cadence concretely,
  with real dates/owners, not a template left unfilled.
- The payroll/compliance checklist is checked explicitly before the first paycheck is due, not
  discovered late.
- `tactics/15-hiring.md` is written. `business-state.json.tactics` is left to the orchestrator.
