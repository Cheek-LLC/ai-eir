# Privacy & Data Handling

This document is the plain-language policy behind `agents/risk/privacy-compliance-officer.md`
and `skills/risk/privacy-check`. If those files and this one ever disagree, this doc is the
source of truth for policy; the agent/skill files are the source of truth for how the policy is
mechanically enforced.

## 1. What's stored, and where

Every business run through this plugin gets a local working directory,
`.startup/<business-slug>/`, created wherever the founder invokes the orchestrator (their own
machine, their own environment). Per `docs/DATA-CONTRACT.md`, this directory holds:

- `business-state.json` — the canonical structured record: business details, the founder's own
  optionally-supplied name/email, the 24 Disciplined Entrepreneurship step statuses, assumptions,
  claims, plan/review metadata, GTM/ops state, connector wiring, cadence, and the risk log.
- `interview-log.md` — a running transcript of interview and check-in sessions.
- `plan/` — the 24 step files and the assembled business plan.
- `reviews/`, `gtm/`, `ops/` — council review output, launch/marketing artifacts, operations
  snapshots.
- `connectors.json` — which external tools are wired up, and which are still needed.

**This directory is local to the founder's own environment. Nothing in it is transmitted
anywhere by this plugin automatically, by default, ever, as a background process, or as a
side effect of any Disciplined Entrepreneurship step, plan assembly, or review council run.**
Running the interview, drafting a plan, and going through review councils are all purely local,
file-based operations.

## 2. What actually triggers external transmission

Exactly one category of action sends data outside `.startup/<slug>/`: an **explicit connector
action the founder has approved**, wired through `agents/connectors-liaison.md` and gated by
`skills/risk/privacy-check`. Examples: loading a contact list into an email tool, syncing records
to a CRM, pushing an audience to an ad platform, connecting a payments processor, pulling in
analytics from a connected tool.

Concretely, before any such send:

1. The connector must already be wired and recorded in `business-state.json.connectors.wired_up`
   / `connectors.json` — the plugin does not silently discover or auto-connect a tool.
2. `skills/risk/privacy-check` (Mode B) must clear the send — checking what data is moving, where
   it came from, whether the founder has a real legal basis to hold and use it, and whether the
   plugin itself is the point of undisclosed collection (it should never be — the plugin routes
   data the founder already has through tools the founder already owns; it does not independently
   source or scrape data about real people).
3. If the gate blocks the send, it stays blocked unless the founder explicitly and knowingly
   overrides it — the same override discipline the orchestrator applies to a blocked review-gate
   verdict: name the specific risk, get explicit consent to proceed, log it.

Merely *registering* that a connector will eventually be needed (an entry in
`connectors.needed_not_installed[]`) is not a send and does not require the gate — the gate
applies at the moment real founder or prospect data is actually about to move.

## 3. Legal/regulatory disclaimer — stated once, here

This plugin produces business planning content. It is not a substitute for advice from a
licensed professional, and it does not produce legal, financial, tax, or regulatory-compliance
advice, in any of these areas in particular:

- **Entity formation** — business structure, jurisdiction, cap table, founder equity
- **IP protection** — trademark/patent/copyright, freedom-to-operate, assignment terms
- **Employment law** — worker classification, offer letters, equity grants, termination
- **Securities / fundraising compliance** — what constitutes a securities offering, exemptions,
  investor-eligibility rules, SAFE/note terms
- **Data-protection-regime compliance** — GDPR, CCPA/CPRA, and equivalent regimes: lawful basis
  for processing, processor agreements, breach notification, data-subject rights

Where the plugin's output touches one of these areas, it will name a concrete open question or
assumption and say plainly that a real professional should resolve it — that is a specific,
substantive flag tied to the actual content in front of the founder, not a generic disclaimer.
This paragraph is the one place the general boundary is stated. It is not repeated as
boilerplate on every plan section, GTM artifact, or connector prompt — per CONVENTIONS §7, stating
real uncertainty once, plainly, is the standard; stacking the same disclaimer on every output
would bury the specific flags that actually matter under noise the founder learns to skip past.

## 4. A practical guide for founders: keeping real customer data out of your plan files

Your plan files exist to describe your business, your market, and your customers *in the
aggregate and archetypal sense* — not to serve as a database of real people. A few concrete
rules of thumb:

**Fine to write down:**
- "Our beachhead persona is a 30-45 year old ops manager at a 50-200 person logistics company"
- "We're targeting companies structurally similar to Acme Logistics" (a company named as an
  example of a market segment, not a live contact record)
- A short, current list of real prospects you're personally in contact with as part of active
  outreach (e.g., your "next 10 customers" list) — this is normal early-stage GTM work, not a
  privacy problem, as long as it stays a working list you maintain yourself rather than growing
  into an unmanaged bulk contact store sitting in a markdown file
- Aggregated research, cited industry benchmarks, anonymized interview takeaways ("3 of 5
  prospects said pricing was their top objection")

**Don't put in a plan file:**
- Bulk contact exports, CRM dumps, or scraped/purchased lead lists — those belong in a connector
  (a CRM or email tool) that you actually control and that has its own access controls, not in a
  markdown file that gets read by every skill and agent that touches the plan
- Sensitive personal data about a real, identifiable individual — health information, financial
  account details, government ID numbers, or similar — regardless of whether that person is a
  prospect, a customer, or anyone else. There is essentially no business-planning purpose that
  requires this level of detail about a specific real person; describe the pattern or the
  aggregate instead
- A real customer's personal data attributed by full name where an anonymized or role-based
  description ("our first paying customer, a 40-person agency") would tell the planning story
  just as well

**Why this matters, concretely:** anything in `.startup/<slug>/` is a plain local file. It has no
access controls beyond whatever your own environment provides, it gets read by many different
skills and agents as they do their work, and — unlike a CRM or email platform — it was never
built with consent tracking, retention policies, or data-subject-request handling in mind. If you
're holding real people's personal data at all, a purpose-built connector with those controls is
the right home for it, not a plan file. `skills/risk/privacy-check` will flag it if it notices
otherwise, but the fastest fix is simply not putting it there in the first place.

## 5. Where enforcement actually happens

This document describes the policy. The mechanics live in:

- `agents/risk/privacy-compliance-officer.md` — the subagent that evaluates data-minimization
  findings, runs the four-part connector gate check, enforces the scope-of-advice boundary, and
  writes findings to `business-state.json.risk_log` (`type: "privacy"` or `type: "legal"`).
- `skills/risk/privacy-check/SKILL.md` — the callable entry point: run once during onboarding to
  deliver this policy to the founder, and run as a mandatory gate before any `skills/gtm/*` or
  `skills/ops/*` skill, or `agents/connectors-liaison.md`, sends founder or prospect data to a
  real external connector.

If you are building a GTM, ops, or connector-facing skill elsewhere in this plugin: your skill is
expected to call `skills/risk/privacy-check` before any real external send. That expectation is
load-bearing for this whole policy — a gate no one calls protects no one. See that skill's
"MANDATORY GATE — DO NOT SKIP" callout for the exact invocation contract (what to pass in, what
clear/blocked look like), and `docs/QA-FINDINGS-GATES-ROUND2.md` for the current, file-by-file
audit of which expected callers actually make this call today versus which still need to be
wired in — do not assume compliance without checking it.
