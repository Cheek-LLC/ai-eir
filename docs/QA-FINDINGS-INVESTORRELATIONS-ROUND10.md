# QA Findings — Round 10: `investor-updates-and-cap-table-basics` (fundraising-advisor) live dry run

**Method.** Copied the real fixture `.startup/shiftcover` to an isolated working copy at
`.startup/shiftcover-t10-ir/` (slug field updated to match) and worked exclusively inside it. Read
`business-state.json` in full, `plan/business-plan.md`'s executive summary and Response-to-Council
section, `interview-log.md`'s 2026-08-27 session, and `quantitative_claims[]`/`key_assumptions[]`
for real sourced numbers. Then read `skills/gtm/investor-updates-and-cap-table-basics/SKILL.md`
and the appended "After the round closes" section of `agents/gtm/fundraising-advisor.md` in full.
Neither had been executed live before this round. In the isolated copy I set
`gtm.funding_strategy: "raising_outside_capital"` to simulate a founder who has since decided to
raise (the real fixture's `funding_intent` is `bootstrap`, confirmed as recently as
`interview-log.md` 2026-08-27 — this is a deliberate test-fixture override, not a claim about the
real fixture's founder). I then actually drafted a real investor update
(`.startup/shiftcover-t10-ir/gtm/investor-update-2026-08-29.md`) sourcing every number from this
fixture's real `quantitative_claims[]`, and worked two cap-table numeric examples by hand (verified
mechanically, not just by eye) against the skill's own guidance. Full detail is in those files;
this doc summarizes what I did and what it revealed.

## Finding 0 (process note, not a defect): the skill's own audience precondition was not met by the task setup as literally specified, and correctly said so

The skill's "What this skill is" section states an explicit applicability gate: *"Confirm with the
founder that there are investors to update (a prior round closed, or
`gtm/fundraising-deck-brief.md` exists and a raise is underway) before running Step 1; if neither
is true, there's no audience for an investor update yet and this skill isn't applicable."*

Simply flipping `gtm.funding_strategy` to `raising_outside_capital` (this round's Step 1
instruction) satisfies `agents/gtm/fundraising-advisor.md`'s own "should I run at all" gate, but
does **not** satisfy this skill's separate audience gate — `.startup/shiftcover-t10-ir/gtm/` and
`ops/` were both empty before I touched them (`gtm.artifacts: []`, no `fundraising-deck-brief.md`,
no closed round). A literal live run against the fixture as the task set it up would correctly
have stopped here and reported "not applicable yet." I judged this the right, honest behavior of
the gate, not a bug — you shouldn't be able to draft investor updates for a business with no
investors. To actually exercise Parts 1–3 of the skill as the task asked, I added one clearly
labeled scaffolding file, `gtm/fundraising-deck-brief.md`, marked in its own text as QA-round
scaffolding standing in for a real `fundraising-advisor` run (which was **not** itself executed
this round — that agent's own deck-prep mandate is out of this round's scope), sourced entirely
from numbers already reconciled in `plan/business-plan.md`. This let the audience gate pass
legitimately and the rest of the skill be exercised for real. **Net: the gate itself works
correctly; getting past it honestly required more setup than the round's Step 1 alone provides,
which is worth knowing for future rounds testing this skill.**

## Part 1 — the investor update: the "no fabrication" discipline check

`ops.cadence_metrics_files` was `[]` and `ops.status` was `"not_started"` — this business has
never run an MVBP pilot, so **no real operating metrics exist at all**: no MRR, no churn, no
activation rate, nothing. This is exactly the scenario the round asked me to stress: does the
skill fabricate traction to fill the Key Metrics table, or say so honestly?

**Result: the template is followable and correctly forces the honest answer, but only if the
agent applies the skill's *general* "not yet tracked" rule to the Key Metrics table itself — the
template doesn't spell this out at the Key Metrics section specifically.** The skill's opening
"What you read" section states the general rule plainly ("Never invent a metric that isn't in one
of these files... name it as 'not yet tracked'"), and the Key Metrics section's own instructions
say to pull "directly from the most recent `ops/*-metrics.md` file(s)" — since none exists, the
correct inference is an empty/absent table, not a table populated with the plan's *projected* unit
economics (LTV $52,503, COCA $3,213, 16.3:1 ratio — all `confidence: low`) presented as if they
were this period's actuals. I wrote the Key Metrics section as prose explaining no ops-metrics
file exists yet, and included the projected LTV/COCA/ratio only as explicitly labeled
plan-projections-not-actuals, sourced to `qc-017-ltv`/`qc-019-coca`/`qc-019-ltv-coca-ratio`. This
was the correct call under the skill's stated discipline, but a founder or agent moving faster
than I did could plausibly misread "pull directly from the most recent ops/*-metrics.md file(s)"
as silent permission to reach for `quantitative_claims` projections instead when no ops file
exists, since the section doesn't explicitly address the zero-ops-files case the way the intro
paragraph does. **Minor gap, not blocking:** the Key Metrics section's own instructions could
restate the "name it as not yet tracked, don't substitute a plan projection" rule locally, instead
of relying on the reader to carry the general rule forward three subsections.

The same gap recurs for the Runway line: the template shows `Runway | N.N months | ... |` as an
always-present row ("Runway and its classification go here every time, not just when it's bad"),
but this fixture also had no `ops/*-finance-metrics.md` file to source it from. I applied the same
general "not yet tracked" rule (`Runway: not yet tracked — no ops/*-finance-metrics.md file exists
yet.`) — followable, correct, but again resolved by the intro's general rule rather than anything
said at the Runway line itself.

**Everything else in the drafted update traced cleanly to real, sourced fixture content** — Wins
section: the real 20-contact cold-outbound batch (15% reply rate, `qc-018-cold-outbound-pilot`),
the 3-of-7 franchisor-veto calls (`ka-012-franchisor-veto`), and the two real contractor quotes
(`qc-024-contractor-quotes`). Challenge: the real, open sales-cycle gate (2 of 7 prospects at
Stage 2 vs. the council's 5+ bar, `ov-shiftcover-004`). Ask: a specific, named-ICP intro request
(Directors of Operations at 10-50 unit QSR groups) per Part 3's "name the exact profile" rule, not
a vague "let us know if you can help." No `risk_log` entry with `type: "business"` and
`status: "open"` existed in this fixture (the four founder-override entries are all
`status: "accepted"`, not `"open"`), so the skill's "surface open business risk_log entries"
instruction correctly had nothing to surface this period — I did not force one in. The five-part
structure (Headline/Key Metrics/Wins/Challenges & Asks/What's Next) and the "Open items from last
update" footer (correctly "n/a, first update" — no prior `investor-update-*.md` existed) were both
directly followable exactly as specified, no ambiguity.

## Part 2 — cap-table literacy: worked examples, checked mechanically

I built two new worked examples with invented round numbers (clearly distinct from the skill's own
example numbers, so this tests the *mechanic*, not just re-reading the skill's arithmetic), then
verified all four calculations — my two plus the skill's own two — with a short Python script
rather than by eye.

**My option-pool-refresh example** (labeled a walkthrough, not fixture data): founders hold
6,500,000 shares (100%, no pool); a new investor takes 25% post-money and requires a 10%
pre-money-created pool.
```
founders' remaining % = 100% − 25% − 10% = 65%
total post-money shares = 6,500,000 ÷ 0.65 = 10,000,000
investor shares = 25% × 10,000,000 = 2,500,000
pool shares      = 10% × 10,000,000 = 1,000,000
check: 6,500,000 + 2,500,000 + 1,000,000 = 10,000,000 ✓
```
Matches the skill's stated method exactly and checks out.

**My SAFE-conversion example** (labeled a walkthrough, not fixture data): $300,000 SAFE, $6M cap,
15% discount; later priced round at $12M pre-money, $3.00/share, 8,000,000 fully-diluted shares at
signing.
```
cap price      = $6,000,000 ÷ 8,000,000  = $0.75/share
discount price = $3.00 × (1 − 15%)        = $2.55/share
lower price wins → $0.75/share (the cap)
shares issued  = $300,000 ÷ $0.75         = 400,000 shares
check: 400,000 × $0.75 = $300,000 ✓
```
Also matches the skill's stated method exactly and checks out.

**The skill's own two in-line examples were also re-verified mechanically** (not just trusted):
the option-pool example (8,000,000 founder shares, 20% investor / 15% pre-money pool → total
12,307,692.3 shares, investor 2,461,538.5, pool 1,846,153.8 — the skill's stated whole-share
figures are the correct floor/round of these) and the SAFE example ($250,000 at $5M cap / 20%
discount into a $10M pre-money, $2.00/share, 10,000,000-fully-diluted-share round → cap price
$0.50 beats discount price $1.60, 500,000 shares issued) both check out exactly as stated.
**Conclusion: the cap-table math in Part 2 is correct and the worked-example format is genuinely
followable by hand — no arithmetic errors found in either the skill's own examples or two
independently constructed ones.**

The boundary statement ("not a cap-table record... needs a dedicated cap-table tool... and a
qualified startup attorney... not licensed financial, legal, or tax advice") is present once, at
the end of Part 2, exactly per CONVENTIONS.md §7's "state this once, not repeatedly" rule — it
does not recur elsewhere in the skill, which is correct per that same rule.

## Gaps found

1. **(Minor)** Key Metrics and Runway template lines don't locally restate the "name it as not
   yet tracked, never substitute a plan projection" rule for the zero-ops-data case — it's stated
   once in the skill's intro and has to be carried forward by the executing agent. Not a
   correctness bug (I confirmed the rule is followable and produces the honest result when
   applied), but a real founder-facing agent moving quickly through the template section-by-section
   could plausibly reach for `quantitative_claims` projections to fill an empty-looking Key Metrics
   table without rereading the intro. Suggest a one-line reminder at the Key Metrics/Runway
   template lines themselves, not a new rule.
2. **(Process, not a skill defect)** The skill's own audience-applicability gate (Finding 0 above)
   is stricter than what this round's Step 1 setup alone produces — worth flagging for whoever
   designs future rounds targeting this skill, since "flip `gtm.funding_strategy`" alone is not
   sufficient to reach a state where Part 1 can honestly run; a `fundraising-deck-brief.md` or a
   closed round is also required, exactly as the skill itself specifies.

## What worked well, unreservedly

- The "never invent a metric" discipline is real and enforceable in practice, not just stated —
  I was able to draft a complete, honest, five-part update for a business with **zero** operating
  metrics without inventing a single number, and the result still reads as a credible, specific
  update (real wins, a real named challenge, a real specific ask) rather than an empty shell.
- All cap-table arithmetic in Part 2 — both the skill's own two examples and two independently
  constructed ones — is correct.
- The "no risk_log entries met the surfacing filter, so none were forced in" behavior is correct
  and was straightforward to apply directly from the schema (`type: "business"` +
  `status: "open"`, distinct from this fixture's four `status: "accepted"` founder-override
  entries).
- Part 3's "name the exact profile, not the category" guidance for asks was directly actionable
  against this fixture's real Step 2/Step 5 beachhead definition.

## Files touched this round

- `.startup/shiftcover-t10-ir/business-state.json` — `slug`, `gtm.funding_strategy`,
  `gtm.artifacts` (two entries appended).
- `.startup/shiftcover-t10-ir/gtm/fundraising-deck-brief.md` — new, QA-round scaffolding only (see
  Finding 0), clearly labeled as such in its own text.
- `.startup/shiftcover-t10-ir/gtm/investor-update-2026-08-29.md` — new, the actual skill output
  under test.
- `docs/QA-FINDINGS-INVESTORRELATIONS-ROUND10.md` — this file.

No file outside `.startup/shiftcover-t10-ir/` or this findings doc was modified. The original
`.startup/shiftcover/` fixture is untouched.
