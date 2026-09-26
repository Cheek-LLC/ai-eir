---
name: 11-legal
description: >
  Use once a founder is ready to actually stand up a real company, not just decide its shape —
  Tactic 11 of Paul Cheek's 15 Tactics: Incorporation and Legal Documents for Your Startup.
  Triggers: "let's actually incorporate," "who's our lawyer," "find us a startup lawyer," "how do
  I file this," "what am I signing," "what's a SAFE/NDA/offer letter actually say," "I got a
  document to sign and don't understand it." Distinct from `skills/risk/legal-structure-and-ip-
  basics`, which owns the entity-choice, vesting, and IP-assignment *decisions* — this tactic
  executes: finding real legal representation, actually filing the incorporation paperwork, and
  orienting the founder to the specific documents (NDA, SAFE, offer letter, and more) they will
  be handed to sign in the near term, so none of them lands as a surprise.
---

# Tactic 11: Legal — Incorporation and Legal Documents for Your Startup

## What this tactic is, and what it isn't

`skills/risk/legal-structure-and-ip-basics` already did the thinking: LLC vs. Delaware C-corp,
the vesting schedule, the IP-assignment requirement, the founder-equity-split conversation. If
those decisions haven't been made yet, stop here and run that skill first — this tactic has
nothing to execute against without them. **This tactic's job starts where that one's ends: turning
a decision into a filed, real company, and getting the founder ready for the documents that
decision now puts in front of them.**

Read `founder.notes` and `risk_log` (`type: "legal"`) before doing anything — that skill records
the entity choice and equity-split rationale there, and any still-open legal risk. Carry those
forward; do not re-litigate them here.

**Scope boundary — stated once:** everything here is a planning aid to help a founder execute with
a real lawyer, not a substitute for one, and not licensed legal advice — the same framing
`skills/risk/legal-structure-and-ip-basics` §4 already established for when a real lawyer is
non-negotiable. Don't repeat that caveat section by section.

## What you read

- `.startup/<slug>/business-state.json` → `business_basics.funding_intent`, `business_basics.
  business_type`, `founder.notes` (for the recorded entity choice / equity split — this tactic
  cannot proceed on an undecided entity choice; if `founder.notes` doesn't show one, hand back to
  `skills/risk/legal-structure-and-ip-basics` first), and `risk_log` entries `type: "legal"`
  (open ones are exactly this tactic's punch list).
- `.startup/<slug>/tactics/11-legal.md`, if it already exists — for what's already filed/found/
  signed, so this run picks up where the last one left off rather than restarting the checklist.
- `.startup/<slug>/plan/15-design-a-business-model.md`, if it exists, for team-shape context (how
  many people will need agreements soon).

## What you write

- `.startup/<slug>/tactics/11-legal.md` — the execution record below.
- You do **not** write `business-state.json.tactics` yourself. Report your output file and a
  one-line summary back to whoever invoked you; the orchestrator updates
  `business-state.json.tactics.11_legal` (`status`/`summary`/`file`) after confirming the file
  output — the same division of labor for every tactic skill in this round.

## 1. Finding real legal representation

Most founders' first mistake here is trying to solve "find a lawyer" and "incorporate the
company" as the same step. They aren't, and treating them as one leads to overpaying for basic
formation or, worse, filing something wrong with no one checking it.

**Two distinct things to source, usually from different providers:**

1. **Basic formation** — a Delaware C-corp or a home-state LLC with no unusual terms is a
   commodity task. A formation service (the kind of tool that automates Certificate of
   Incorporation filing, registered-agent assignment, EIN application, initial board consents,
   and standard founder stock issuance with vesting docs already templated) does this
   correctly and fast, typically for a flat few hundred to low-thousands of dollars all-in
   (state filing fee + registered agent + service fee). This is the right default for a standard
   formation with no unusual cap table or IP wrinkles.
2. **Actual counsel** — a real startup attorney (solo practitioner or a boutique startup-focused
   firm, not a generalist local business lawyer who mostly does real estate closings) is what the
   founder needs for anything the formation service's template doesn't cover: a multi-founder
   equity split with unusual terms, an existing IP contribution from a prior company or contract
   role, an international founder or international IP, or any term-sheet negotiation later. Vet
   one the way any specialist is vetted: ask what fraction of their practice is startup formation/
   financing specifically (not general business law), ask for two founder references from the
   last year, and ask directly whether they work on a flat-fee basis for standard matters
   (formation cleanup, standard financing docs) versus hourly for negotiation — most credible
   startup firms do both, and a founder should know which applies before work starts. Typical
   hourly ranges run roughly $350–$800/hr for startup-specialist counsel; a flat fee for a
   standard seed-round closing is common and worth asking for directly rather than assuming
   hourly is the only option.
3. **Where to actually find candidates:** the founder's own investor/advisor network first (a
   VC or angel who has done several rounds has a short list of attorneys they trust and will make
   an intro); an accelerator's own resource list if the founder went through one; and a direct
   ask in founder communities the business is already part of — a specific, named referral beats
   a cold search every time, because startup-law quality varies enormously and reputation is the
   real signal.

**Decide and record which path this business needs right now** — formation-service-only, or
formation-service plus counsel for a specific named complication — rather than defaulting to
"we'll figure out a lawyer eventually." A business intending to raise (`funding_intent:
raising_outside_capital`) should have counsel identified before term-sheet conversations start,
not after one arrives.

## 2. Actually filing the incorporation paperwork

This is the concrete checklist a founder executes once the entity choice (from
`legal-structure-and-ip-basics`) is settled. Walk it in order; each item has a real, checkable
"done" state — this is not a narrative, it's a punch list.

| Step | What it actually is | Done when |
|---|---|---|
| State selection | Delaware (standard if raising outside capital); home state (simpler/cheaper if bootstrapping and staying an LLC) | State is named in `tactics/11-legal.md`, matching the `founder.notes` entity decision |
| Name check / reservation | Confirm the chosen business name is available in the formation state and, separately, that no direct trademark conflict exists in the business's actual category (a basic USPTO trademark-database search, not a full clearance opinion) | Name confirmed available; trademark spot-check done and any conflict flagged |
| Registered agent | Every entity needs one physical in-state point of contact for legal service — almost always bundled by the formation service, or hired separately (~$100–300/yr) if filing directly | A named registered agent is in place, not "TBD" |
| Certificate of Incorporation (C-corp) / Articles of Organization (LLC) | The actual filed formation document — sets authorized shares (commonly 10M for a C-corp at formation) or member structure | Filed and a stamped/accepted copy is in hand |
| EIN (Employer Identification Number) | The company's federal tax ID — required before a business bank account, before payroll, before almost anything else administrative | EIN obtained from the IRS and recorded |
| Initial board consent / organizational resolutions (C-corp) or operating agreement (LLC) | The internal document authorizing stock issuance, appointing officers, adopting bylaws | Signed and on file |
| Founder stock issuance + vesting docs (C-corp) or membership-interest documentation (LLC) | Formalizes the §2 equity-split conversation `legal-structure-and-ip-basics` already had — restricted stock purchase agreements with the agreed vesting schedule, or an operating-agreement amendment | Signed by every founder, matching the recorded split in `founder.notes` |
| **83(b) election** (C-corp with vesting only) | A filing with the IRS electing to be taxed on founder stock's value at grant, not at vesting — **must be filed within 30 days of the stock issuance date, no exceptions, no extensions** | Filed, with proof of mailing/submission kept — this is the single most unforgiving deadline in this whole checklist; flag it explicitly if the issuance date was more than 20 days ago and this hasn't been filed yet |
| Business bank account | Requires the EIN and formation documents in hand — see Tactic 12 (`skills/tactics/12-finance`) for what happens once the account exists; this tactic's job stops at "account is open" | Account open, first deposit made |
| IP assignment (CIIAA/PIIA) for every founder | Formalizes `legal-structure-and-ip-basics` §2's IP-assignment requirement — every founder signs one at formation, before any contractor or employee does | Signed by every founder |

**If any row is genuinely blocked** (e.g. the founder hasn't picked a formation provider yet),
record that plainly in the output file as the next concrete action, not as a vague "in progress."

## 3. The legalese glossary — documents a founder will actually be asked to sign soon

The goal here is orientation, not legal training: when one of these documents lands in an inbox,
the founder should recognize what it is, what its one or two load-bearing terms actually mean,
and whether it's routine or worth a second read from counsel — before signing anything.

- **NDA (Non-Disclosure Agreement).** Protects confidential information shared in a conversation.
  **Mutual** (both sides protected) is the normal form for a partnership or vendor conversation.
  **One-way** (only the founder's side is bound) shows up when signing with a larger counterparty
  who won't reciprocate — read the definition of "confidential information" and the term length
  before signing either way. Set expectations correctly: **most VCs will not sign an NDA before a
  pitch** — this is standard industry practice, not a sign the investor is untrustworthy or
  planning to steal the idea.
- **SAFE (Simple Agreement for Future Equity).** Not equity yet — money now in exchange for a
  promise to convert into equity at a future priced round, on terms set today (a valuation cap
  and/or a discount). The mechanics of how a SAFE actually converts, and why several stacked SAFEs
  can cost a founder more dilution than the headline numbers suggest, are covered in full —
  including a worked conversion example — by `skills/gtm/investor-updates-and-cap-table-basics`;
  this tactic's job is recognizing the document and its two key terms when it shows up, not
  re-deriving the conversion math (defer to that skill for the substance).
  read: which is lower, the cap price or the discount price — that's the price the investor
  actually converts at.
- **Employment offer letter.** States title, compensation (cash + equity reference — the equity
  grant itself is a separate document that follows later, usually after a board consent), start
  date, and at-will language (terminable by either party, common in most US states — note
  explicitly that employment terms, including non-compete enforceability, vary meaningfully by
  state/country, per `legal-structure-and-ip-basics` §4). A signed offer letter should always be
  paired with a signed PIIA before the person's first day — that pairing is the actual legal
  protection, not the offer letter alone.
- **PIIA / CIIAA (Confidential Information and Invention Assignment Agreement).** The document
  that makes sure the *company*, not the individual, owns the code/IP a founder, employee, or
  contractor creates — see `legal-structure-and-ip-basics` §2 for why this is easy to skip and
  costly to skip. Every signer, every time, no "they're basically part of the team" exceptions.
- **Term sheet.** A non-binding (mostly) summary of a proposed investment's terms — valuation,
  amount, board seat, liquidation preference, pro-rata rights. Signing one is the start of a real
  negotiation, not the close of the deal; the definitive legal documents (a stock purchase
  agreement, a certificate of designations for preferred stock, an investor rights agreement)
  come after and are where actual counsel becomes non-negotiable — see `legal-structure-and-ip-
  basics` §4 and Tactic 14 (`skills/tactics/14-fundraising`) for the negotiation and closing
  process itself.
- **MSA / vendor contract, as a customer.** The basic risk check on anything the business signs as
  a *buyer* of a tool or service: what's the liability cap, and who owns the data put into it.
- **ToS / Privacy Policy, as a company.** Governs the business's own customer relationship —
  substance owned by `legal-structure-and-ip-basics` §3 (contract hygiene) and, for the
  data-handling terms specifically, `skills/risk/privacy-check`. This tactic's execution job is
  confirming these exist and are signed off before customer-facing launch, not drafting their
  content.

## Output file: `tactics/11-legal.md`

```markdown
# Tactic 11: Legal — <business name> — <date>

_Planning aid, not licensed legal advice — see `skills/risk/legal-structure-and-ip-basics` for
when this genuinely needs a real lawyer._

## Entity decision (from legal-structure-and-ip-basics)
<Entity type, state, and the founder.notes rationale reference — do not re-decide here.>

## Legal representation
| Need | Path chosen | Provider/contact | Status |
|---|---|---|---|
| Basic formation | formation-service / direct filing | ... | ... |
| Counsel (if needed) | ... | ... | ... |

## Incorporation checklist
<The table from §2, each row's actual status this run — filed/open/blocked, with the 83(b)
deadline called out explicitly if a C-corp with vesting founder stock has been issued and the
30-day window is running or has passed.>

## Documents signed / outstanding
<Every NDA, SAFE, offer letter, PIIA signed or pending this period, with counterparty and date.>

## Open items carried to next run
<What's blocked, what's next, any risk_log entry this run's findings should surface.>
```

## Done means

- Legal representation path (formation-service and/or named counsel) is decided and recorded, not
  left as "we'll figure it out."
- The incorporation checklist (§2) reflects real, checked status for every row that applies to
  this business's entity choice — no row silently skipped.
- The 83(b) election deadline, if triggered by a C-corp stock issuance, is either filed or flagged
  as urgent with the actual days remaining stated.
- The founder can correctly explain, in their own words, what an NDA, a SAFE, and their own offer-
  letter-plus-PIIA pairing each actually do before being asked to sign one for real.
- `tactics/11-legal.md` is written. `business-state.json.tactics` is left to the orchestrator.
