# QA Findings — Round 10: Legal Structure & IP Basics, Exercised for the First Time

**Method.** `skills/risk/legal-structure-and-ip-basics/SKILL.md` has never been run against a real
fixture before this round. I made an isolated copy, `.startup/shiftcover-t10-legal/` (via
`cp -r .startup/shiftcover .startup/shiftcover-t10-legal`), set its `business-state.json.slug` to
`"shiftcover-t10-legal"`, and worked exclusively inside that copy — the original `.startup/shiftcover/`
was not touched. Before touching the skill I read `CONVENTIONS.md` and `docs/DATA-CONTRACT.md` in
full, then the fixture's real current state: `business-state.json` in full (came in at
`funding_intent: "bootstrap"`, `stage: "approved"`, solo founder Maria Chen, no co-founders anywhere
in the plan or `founder.notes`), `plan/15-design-a-business-model.md` (per-location subscription
selected; marketplace/take-rate rejected partly on an unevaluated wage-and-hour concern), and
`founder.notes` (10 years restaurant ops background, "No stated funding strategy yet" — i.e. the
skill's own read of "check whether founder.notes already records a settled decision" correctly finds
none). I then read `skills/risk/legal-structure-and-ip-basics/SKILL.md` in full and executed it as
literal instructions against this fixture, in two passes:

- **Pass A — bootstrap branch**, run exactly as the fixture arrived (`funding_intent: "bootstrap"`).
  I walked §1 (entity choice), §2 (founder equity/vesting — correctly N/A for this solo founder,
  confirmed explicitly rather than silently skipped), and §3 (contract hygiene) against the real plan
  content, then actually wrote to disk: 3 new `risk_log` entries (`type: "legal"`) and one appended
  `founder.notes` block, dated 2026-08-28 to stay consistent with the fixture's own internal
  chronology (its last event was 2026-08-27; today's real-world date per session context is
  2026-08-18, well before this fixture's story has already progressed to).
- **Pass B — venture branch**, in the same disposable copy only: edited
  `business_basics.funding_intent` to `"raising_outside_capital"` (simulating Maria reconsidering
  after the plan's own logged findings that her sales motion has no scalable paid channel —
  `ka-018-channel-scalability`, `qc-019-ltv-coca-ratio`) and re-ran §1 against that changed input. I
  appended a second `founder.notes` block recording what fired, plus one more `risk_log` entry for the
  concrete conflict this created (LLC-in-progress vs. now-stated fundraising intent).

Every `risk_log` entry and `founder.notes` addition below is a real, on-disk write to
`.startup/shiftcover-t10-legal/business-state.json`, validated with `python3 -m json.tool` after each
edit. Nothing was written to the original `.startup/shiftcover/` fixture or to any skill/agent file.

---

## 1. Bootstrap branch: coherent, and it found three real, concrete gaps

Run against `funding_intent: "bootstrap"`, §1 behaved exactly as written: it did **not** force the
C-corp conversation, presented "LLC is the sensible default," mentioned S-corp election as a later
option once profitable, and moved on — no over-hedging, no forced Delaware/QSBS content the founder
didn't ask for. §2 (equity/vesting) correctly identified this as a true solo-founder business (no
co-founders anywhere in `business-state.json`, `founder.notes`, or the plan) and I logged that as
N/A explicitly in `founder.notes`, per the skill's own carve-out ("a true solo founder has no
vesting-cliff exposure to log") rather than silently skipping the section.

§3 (contract hygiene), read against the actual plan content, surfaced three concrete, non-generic
findings — this is the valuable part of the run, because none of these were already logged anywhere
in the fixture before this skill looked for them:

1. **`legal-entity-formation-shiftcover-t10-legal`** — no entity has been formed anywhere in the
   fixture's history (there's no formation-status field in the schema at all, and nothing in
   `founder.notes` up to this point mentions one), yet Step 22's MVBP pilot is a real, full-price,
   paid engagement with a named prospect (Alex Torres/Copperline). This is a genuinely useful catch:
   nothing in Steps 1-24 or the two prior council reviews ever asked "does an entity exist to sign
   this contract."
2. **`legal-ip-assignment-contractor-shiftcover-t10-legal`** — Step 24's engineering-resourcing
   decision (`qc-024-contractor-quotes`) includes a real, quoted, funded fallback to an outside
   contractor (~$18k-$24k) if Maria's own no-code attempt misses its 2-week checkpoint, but no IP
   assignment agreement is mentioned anywhere for that path. This is exactly the "work-for-hire does
   not cover contractors" trap §2 names, applied correctly to a real, specific fact already sitting
   in the plan rather than restated as generic advice.
3. **`legal-tos-contract-hygiene-shiftcover-t10-legal`** — the MVBP pilot is customer-facing at full
   price with no ToS anywhere in the fixture. The entry correctly deferred the privacy/data-handling
   *substance* to `skills/risk/privacy-check` by name rather than duplicating it, exactly as §3
   instructs — the skill's territorial boundary with `privacy-check` held up under a real run, not
   just on paper.

All three are genuinely new information the fixture didn't have — not restatements of something
already in `risk_log`, and not generic hedging ("consider consulting a lawyer about contracts").

## 2. Venture branch: the C-corp/Delaware/QSBS content fires correctly and reads sensibly for this business

With `funding_intent` flipped to `raising_outside_capital` in the disposable copy, §1's other branch
fired as written: it pushed the C-corp conversation directly and concretely — Delaware, 10,000,000
authorized shares at formation, founder stock subject to the standard vesting schedule, and the
83(b)-election-within-30-days deadline named explicitly by name, exactly as the skill instructs
("flag it explicitly, once, by name"). QSBS (IRC §1202) also fired, correctly framed as a reason to
prefer C-corp stock specifically because ShiftCover's shape (SaaS, real if bootstrap-scale TAM per
Steps 4/14, a plausible eventual sale) is exactly the kind of case QSBS is meant for — the content
isn't just generically true, it's substantively responsive to this specific plan.

The interesting result of running both branches against the same underlying fixture in sequence: the
venture branch's re-run correctly detected the exact conflict the skill's own "concrete entries this
skill actually writes" list predicts — `funding_intent: raising_outside_capital` but the entity path
from the bootstrap-branch conversation was an (unformed) LLC, with no conversion decision made. I
logged `legal-entity-mismatch-raising-shiftcover-t10-legal` for this. That the same skill, run twice
against the same business with one field changed, produces genuinely different, correctly
cross-referencing output rather than two disconnected canned scripts is the strongest positive
finding of this round.

One honest observation, not a bug: the skill does not (and per its own scope, should not) second-guess
whether *this business* should actually raise — `reviews/2026-08-18-balanced-panel-v1.md`'s vc-panel
seat already called ShiftCover a "strong non-venture ($10-30M/yr), not a fund-returner" outcome. §1
stays correctly in its lane (entity mechanics, given a stated intent) rather than re-litigating
venture-fit, which is `agents/gtm/fundraising-advisor.md`'s and the council's territory, not this
skill's. Noted in `founder.notes` explicitly so a future reader doesn't mistake the C-corp content
firing as this skill endorsing the raise itself.

## 3. `risk_log` schema conformance

All 4 new entries were checked programmatically against `docs/DATA-CONTRACT.md`'s schema after
writing:

```
legal-entity-formation-shiftcover-t10-legal        open   {type, id, raised_by, status, description}
legal-ip-assignment-contractor-shiftcover-t10-legal open  {type, id, raised_by, status, description}
legal-tos-contract-hygiene-shiftcover-t10-legal     open  {type, id, raised_by, status, description}
legal-entity-mismatch-raising-shiftcover-t10-legal  open  {type, id, raised_by, status, description}
```

Exactly the 5 fields the contract specifies, `type: "legal"` (a valid enum value), `status: "open"`
(valid), `raised_by: "legal-structure-and-ip-basics"` matching the skill's own name per its "What
this skill writes" section. `python3 -m json.tool` confirms the file stays valid JSON after every
edit. One naming note, not a blocker: the SKILL.md's own documented id format is
`"legal-<short-slug>-<slug>"`, which I followed literally (e.g.
`legal-entity-formation-shiftcover-t10-legal`) — this diverges from the `ar-<slug>-NNN` /
`ov-<slug>-NNN` short-prefix convention every other agent in this fixture actually uses
(`ar-shiftcover-001`, `ov-shiftcover-004`). Neither `CONVENTIONS.md` nor `docs/DATA-CONTRACT.md`
mandates a specific id *format* beyond uniqueness, so this isn't a contract violation, but it is a
real, visible inconsistency in `risk_log[].id` style across agents that a maintainer may want to
reconcile — flagged, not fixed, per this round's scope.

## 4. The "needs a real lawyer" boundary (§4): reads as a real boundary, not hedging

Read against this specific fixture, §4's five moments are concrete and none of them fired
spuriously for ShiftCover at its current stage (idea-stage, pre-entity, solo founder, no term sheet,
no dispute, no infringement claim, no multi-jurisdiction hiring yet) — which is itself a useful
negative check: the skill didn't reflexively tell Maria to "talk to a lawyer" about ordinary entity
and IP-assignment questions it is equipped to answer directly, only named the boundary for the
things it explicitly can't do (term sheet negotiation, an actual dispute, securities compliance
mechanics). That restraint is the difference between a real boundary and stacked disclaimers
`CONVENTIONS.md` §7 warns against. The scope-boundary paragraph at the top of the file (stated once,
not repeated per-section) also held up in practice — I never felt the skill hedging mid-section the
way over-cautious output does.

One gap worth naming: §4 doesn't explicitly address the venture-branch scenario this round actually
exercised — a founder switching funding intent *mid-plan*, after a council has already scored the
business as sub-venture-scale. That's arguably a sixth "get real advice" moment (a founder about to
have an actual fundraising conversation with the C-corp mechanics in hand but no realistic sense
of whether investors will bite) that isn't named. Minor, not blocking — `fundraising-advisor.md`
likely covers the investability question elsewhere, but §4 doesn't say so or point there.

## 5. Gaps and ambiguities found

- **No entity-formation-status field in the schema.** `docs/DATA-CONTRACT.md` has nowhere canonical
  to record "entity formed: yes/no, type, state, date" — this skill has to overload `founder.notes`
  free text for it, same as it already does for equity splits. Not a blocker (the skill's own "What
  this skill writes" section already anticipates and accepts this), but worth flagging since it means
  a future skill/agent wanting "is there an entity yet" has to text-search `founder.notes` rather than
  read a field.
- **`risk_log[].id` format inconsistency** — see §3 above.
- **§4's boundary list doesn't name the mid-plan funding-intent-pivot scenario** — see §4 above.
- No other gaps found. Both branches produced coherent, genuinely differentiated, fixture-specific
  output (not templated filler), the risk_log writes conform to schema, and the lawyer-boundary
  section reads as calibrated rather than reflexively hedged.

## What's still untested

This round deliberately stayed inside `legal-structure-and-ip-basics` itself. Not exercised:
multi-founder equity-split math (this fixture is solo-founder, so §2's split-sequence and
`founder.notes` "Equity split (date): A 60% / B 40%" example format have still never fired against a
real multi-founder fixture), the "Recommended trigger points" section's actual wiring into
`agents/orchestrator.md`/DE step 15 (confirmed in the SKILL.md itself as "not yet wired"), and this
skill's behavior on a business with an *already-formed* entity or an *already-existing* IP-assignment
gap involving a real named contractor already under contract (this fixture's contractor engagement is
still hypothetical/quoted, not signed).
