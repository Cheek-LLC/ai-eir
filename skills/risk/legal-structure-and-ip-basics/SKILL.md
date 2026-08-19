---
name: legal-structure-and-ip-basics
description: >
  Advanced walkthrough of entity choice (LLC vs. Delaware C-corp), founder equity/vesting, IP
  assignment, and early-stage contract hygiene. Use once around DE step 15 (design a business
  model), whenever `funding_intent` is set or changes, or before GTM launch when customer
  contracts first become real. Triggers: "LLC vs C-corp," "how do we split equity," "vesting
  schedule," "cap table," "does the company own our code," "co-founder agreement," "contractor
  agreement." Distinct from `skills/risk/privacy-check`, which owns data-handling/privacy-law
  content exclusively — this skill covers structure, ownership, and contracts.
---

# Legal Structure & IP Basics

You are the founder's first substantive conversation about corporate structure, equity, and
contracts — the kind a good startup lawyer has with a new founder before any documents get
drafted. This skill is self-contained: there is no dedicated `agents/risk/*` subagent for legal
structure yet, so the judgment below lives directly in this file rather than being delegated.

**Scope boundary — state this once, here, not on every section below:** everything in this
skill is a planning aid to help a founder walk into a real lawyer's office informed, not a
substitute for one, and not licensed legal advice (CONVENTIONS §7). Section 4 names the specific
moments this skill's output stops being sufficient. Do not repeat this caveat at the top of every
subsection — say it once and move on to substance.

## What this skill reads

- `business-state.json` → `business_basics.funding_intent`, `business_basics.business_type`,
  `business_basics.business_type_notes`, `founder.notes`, and any existing `risk_log` entries
  with `type: "legal"` (check these first — don't re-raise a finding that's already logged
  `open`, and don't re-run the full entity-choice conversation if `founder.notes` already records
  a settled decision; confirm nothing has changed instead).
- `plan/15-design-a-business-model.md` if it exists, for context on revenue model and team shape.
- Any `plan/`, `gtm/` file relevant to the specific question at hand (e.g. a launch plan if this
  runs pre-GTM to check ToS/contract readiness).

## What this skill writes

- `business-state.json.risk_log` — append new entries, `type: "legal"`, for any real open
  structural/legal risk this conversation surfaces (schema below). Never blind-overwrite the
  array; never silently delete a prior entry — mark `mitigated`/`accepted` with a note instead,
  per the Data Contract's standing rule.
- `business-state.json.founder.notes` — append (don't overwrite) a structured record of entity
  decision and equity-split rationale once reached. There is no dedicated multi-founder equity
  field in the schema (`founder` is a single object with `name`/`email`/`notes`), so this is the
  documented place for that record until/unless the schema grows one — write it as a clearly
  labeled block, e.g. `"Equity split (2026-08-18): A 60% / B 40%, rationale: ..."`, appended
  after existing notes rather than replacing them.

`risk_log` entry schema (from `docs/DATA-CONTRACT.md`):
```json
{
  "id": "legal-<short-slug>-<slug>",
  "type": "legal",
  "raised_by": "legal-structure-and-ip-basics",
  "description": "string",
  "status": "open|mitigated|accepted"
}
```

Concrete entries this skill actually writes, when true:
- No entity formed yet and the founder is proceeding toward GTM/customer contracts anyway.
- `funding_intent: raising_outside_capital` but entity is an LLC, not a Delaware C-corp, and the
  founder hasn't yet decided to convert.
- No vesting schedule / no restricted stock purchase agreement in place for founder equity
  (multi-founder businesses only — a true solo founder has no vesting-cliff exposure to log).
- No signed IP assignment (CIIAA/PIIA) on file for one or more founders, contractors, or
  employees who have written code, designs, or other IP for the company.
- Equity split among co-founders discussed only verbally, with nothing written down.
- Customer-facing launch approaching with no ToS/contractor-agreement coverage in place.

## 1. Entity choice — LLC vs. Delaware C-corp

This is a real tradeoff, not a formality. Walk the founder through the actual mechanics, then
branch on `business_basics.funding_intent`.

**Tax treatment.** An LLC (taxed by default as a partnership, or as an S-corp by election once
profitable) is pass-through: profits and losses flow directly to the members' personal returns
and are taxed once, at individual rates. A C-corp is taxed at the entity level (21% federal) and
then shareholders are taxed again on dividends or capital gains at exit — double taxation in the
literal sense. In practice, most venture-backed C-corps never pay dividends, so the double-tax
bite mostly shows up at exit — and there it can be largely offset by **QSBS (IRC §1202)**:
stock in a qualifying C-corp held 5+ years can be sold with federal capital-gains tax excluded
up to the greater of $10M or 10x basis per founder. This is a genuine, large financial reason
founders intending to raise and eventually exit prefer C-corp stock over LLC membership units,
which never qualify for QSBS.

**Why VCs structurally require a Delaware C-corp.** This isn't investor preference, it's
structural: (1) most VC funds have limited partners (pension funds, endowments) that are
tax-exempt and cannot hold interests in pass-through entities without triggering UBTI
(unrelated business taxable income) — an LLC investment can blow up their tax status; (2) the
standard VC financing mechanics — preferred stock with liquidation preferences, an option pool
using ISOs, standard NVCA-template docs — are built for corporate stock, not LLC membership
interests, and don't map cleanly onto an LLC's operating-agreement structure; (3) Delaware's
Chancery Court and a century of settled corporate case law give investors and their counsel
predictable outcomes on fiduciary duty, board mechanics, and dilution — founders and investors
alike default to it because everyone's lawyers already know the playbook. A founder who intends
to raise a priced round should expect to be asked to convert to (or start as) a Delaware C-corp
before the round closes, full stop — this is not negotiable deal-by-deal in the way other terms
are.

**Why an LLC can be the right call.** For a bootstrapped or lifestyle business with no outside-
equity-investor intent — most services businesses, many physical-product businesses sold
DTC/wholesale, solo SaaS products staying self-funded — an LLC is simpler, cheaper to run
(no board formalities, no 83(b) election clock, no option-pool math), and lets losses in early
unprofitable years flow through to the founder's personal return, which can have real value.
Converting an LLC to a C-corp later is possible (an "F reorganization" or straight conversion,
depending on state) but costs real money and time — commonly $10k–$25k in legal/accounting fees
plus weeks of process — so the decision isn't costless to defer indefinitely once outside capital
becomes a real near-term plan, only costless to defer while it stays hypothetical.

**Branch on `business_basics.funding_intent`:**
- **`raising_outside_capital`** — push the C-corp conversation directly and concretely: Delaware,
  standard authorized-share count (commonly 10M shares at formation), founder stock issued
  subject to vesting (see §2) with an **83(b) election filed within 30 days of issuance** — this
  deadline is unforgiving and IRS-enforced with no extensions, flag it explicitly, once, by name.
- **`bootstrap`** — do not force the C-corp conversation. Present the LLC as the sensible default,
  mention S-corp election as a later option once the business is consistently profitable (saves
  self-employment tax on distributions beyond reasonable salary), and move on.
- **`undecided`** — lay out this exact framework, ask the founder to form a view rather than
  guessing on their behalf, and if they proceed into DE step 15 or later without deciding, log a
  `risk_log` entry (`status: "open"`) noting entity choice is unresolved — not because indecision
  itself is a problem, but because downstream steps (equity docs, contractor agreements) need an
  entity to attach to.

## 2. Founder equity & vesting

**Standard structure: 4-year vesting, 1-year cliff, monthly thereafter.** Nothing vests for the
first 12 months; at the 1-year mark, 25% vests at once, then the remainder vests monthly (or
quarterly) over the following 3 years. This is the market standard for a reason: it protects
co-founders and the company from the "dead equity" problem — a co-founder who leaves after two
months keeping 25%+ of the company outright would make the cap table nearly impossible to clean
up for future hires or investors, and would misalign incentives for everyone who stays. The cliff
specifically deters an early bail: someone who leaves in month 11 walks away with nothing vested,
by design, not as a punitive accident.

**Acceleration on acquisition.** Single-trigger acceleration (100% vests immediately on a sale)
is a real investor red flag — it removes the acquirer's ability to retain the team and is
unusual for that reason. Double-trigger acceleration (vesting accelerates only if the founder is
terminated without cause, or resigns for good reason, within some window after the acquisition)
is the market-standard, investor-friendly version. Know the difference before a term sheet shows
up asking about it.

**IP assignment — the part founders most often skip and most regret skipping.** Every founder,
every contractor, and every employee who touches the company's code, design, or content needs a
signed **Confidential Information and Invention Assignment Agreement (CIIAA/PIIA)**. Without
one, default IP law can leave the *individual*, not the company, owning what they built — this
is not a hypothetical: it is a routine, deal-killing finding in real diligence, and a routine
cause of "wait, who actually owns this repo" fights between co-founders. Two specific traps to
name explicitly:
- **Work-for-hire covers employees for copyright automatically, but not contractors.** A
  contractor's code is, by default, the contractor's — the company needs an explicit written
  assignment clause, every time, no exceptions for "they're basically part of the team."
- **Work-for-hire does not cover patents at all**, for employees or contractors. Patent rights
  need an explicit assignment clause regardless of employment status.

**A concrete "who owns what % and why" sequence for multi-founder businesses.** Don't let a
multi-founder team default to an unexamined equal split — equal-without-discussion is one of the
most common sources of later founder blowups, precisely because it papers over differences that
resurface once the business gets hard. Walk each co-founder through, explicitly:
1. **Idea origination** — whose idea was it, and how much should that actually weigh (usually
   less than the originator assumes; ideas are cheap relative to execution).
2. **Time commitment** — full-time from day one, or part-time transitioning in later? This
   affects both the split and each person's vesting **start date** — don't backdate vesting to
   before someone is actually working full-time.
3. **Cash/asset contribution** — real money or assets put into the company, and on what terms
   (equity vs. a loan the company owes back).
4. **Skill/role criticality** — is this person's contribution replaceable, or is their specific
   expertise the thing the company can't function without (e.g. the only technical co-founder on
   a deep-tech product)?
5. **Domain expertise/network** — industry relationships or credibility that measurably reduce
   the company's risk or speed (e.g. regulatory relationships, an existing customer base).
6. **Opportunity cost** — what income/security did each person give up to do this full-time?
7. **Forward-looking commitment** — is everyone still all-in a year from now under the same terms,
   or does the split need a review checkpoint built in?

Then apply an explicit gut check: an equal split is fine **if** every founder can independently
articulate why it's fair after this conversation — not because dividing by headcount was the
path of least friction. Record the agreed split and its rationale in `founder.notes` (see
"What this skill writes" above). If the founders reach a split only verbally with nothing
written down, or can't reach agreement, log a `risk_log` entry — an unresolved or undocumented
equity split is a real open risk, not a detail to leave for later.

## 3. Contract hygiene basics

The concrete set of agreements a real early-stage company needs, and why each one matters:

- **Customer-facing Terms of Service / Terms of Use** — governs the customer relationship
  (liability limits, acceptable use, termination). Needed before real customer-facing launch, not
  after.
- **Privacy Policy and any data-processing/BAA-type agreements** — this is data-specific
  territory owned by `skills/risk/privacy-check`; invoke that skill by name for the substance
  rather than duplicating its analysis here. This skill's job is to flag *that* the agreement
  needs to exist as part of pre-launch contract readiness, not to write its data-handling terms.
- **Founder/co-founder equity documentation** — formalizes the §2 conversation: restricted stock
  purchase agreements with the agreed vesting schedule (C-corp) or an operating agreement
  amendment reflecting membership-interest splits (LLC).
- **Contractor agreements** — always written, always including an explicit IP assignment clause
  and confidentiality terms (per the work-for-hire trap in §2). A handshake-and-a-Venmo
  arrangement with a freelance developer is exactly the scenario that produces an unassignable-IP
  problem later.
- **Employee agreements** — offer letter plus a signed PIIA, and at-will language where
  applicable. Note explicitly: employment terms vary by state/country in ways that matter (e.g.
  California statutorily voids most non-competes; other states enforce them) — this skill flags
  the need, it does not opine jurisdiction-by-jurisdiction (see §4).
- **NDA discipline** — a mutual NDA before substantive technical or financial disclosure to a
  potential partner or acquirer is reasonable practice. Set expectations correctly with founders
  who haven't fundraised before: most VCs will not sign an NDA before a pitch, and that is normal
  industry practice, not a red flag about the investor's intentions.
- **Vendor/SaaS contracts** — the basic risk check on anything the company signs as a customer:
  liability caps, and who owns the data put into the tool.

## 4. When this genuinely needs a real lawyer

Be direct with the founder about where this skill's output stops being sufficient — not as a
blanket disclaimer, but naming the specific moments:

- **Raising a priced round.** Term sheet negotiation, cap table modeling with real liquidation
  preferences, and NVCA-standard financing docs need the company's own deal lawyer. This skill
  gets a founder to that conversation informed, not through it.
- **A co-founder dispute.** The moment agreement breaks down and the conversation becomes
  adversarial, independent counsel for the affected parties is a real need, not a structuring
  question this skill can mediate.
- **An actual IP or infringement claim.** A cease-and-desist letter, a patent/trademark dispute,
  a DMCA notice — these need specific counsel immediately. This skill covers building clean IP
  ownership *before* a dispute exists, not responding to one that already does.
- **Employment law across state or country lines.** Non-compete enforceability, contractor
  misclassification risk, and termination rules all vary by jurisdiction in ways that matter and
  that this skill does not track jurisdiction-by-jurisdiction — the norms above (vesting, IP
  assignment) are directionally right everywhere, but the employment-law specifics are not.
- **Securities compliance itself** (Reg D exemptions, accredited-investor verification, state
  blue-sky filings). This skill flags that a raise triggers securities law; it does not opine on
  compliance mechanics.

## Recommended trigger points (not yet wired — see report to the maintainer)

This skill does not own `agents/orchestrator.md` or any `skills/disciplined-entrepreneurship/*`
file, so it cannot wire itself in. Recommended integration points, for whoever does own those
files:
- **Once, around DE step 15** (`skills/disciplined-entrepreneurship/15-design-a-business-model`)
  — the business-model step is the natural point where entity/equity structure first becomes
  concrete; run this skill after that step drafts, before it's marked `approved`.
- **Again, before GTM launch** (`gtm.status` moving to `in_progress`/`launched`) — specifically to
  check ToS/contractor-agreement readiness from §3 before the business goes customer-facing.
- **Whenever `business_basics.funding_intent` is set or changes** — especially a change *to*
  `raising_outside_capital`, which should immediately reopen the §1 entity-choice conversation if
  the business is still an LLC.

## Done looks like

- The founder has an explicit, reasoned entity choice (or an explicitly logged open decision),
  tied to their actual `funding_intent` rather than a default.
- For multi-founder businesses: a recorded, reasoned equity split and vesting schedule in
  `founder.notes`, or an open `risk_log` entry if unresolved.
- IP assignment coverage has been checked for every founder/contractor/employee who has
  contributed IP, with gaps logged.
- Contract-hygiene gaps relevant to the business's current stage (pre-launch vs. operating) are
  named specifically, not gestured at generally.
- The founder knows, concretely, the handful of moments (§4) where they need to stop treating
  this skill's output as sufficient and go hire a real lawyer.
