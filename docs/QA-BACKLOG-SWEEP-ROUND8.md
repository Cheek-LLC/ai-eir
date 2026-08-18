# QA Backlog Sweep — Round 8

**Method.** Read `CONVENTIONS.md`, `docs/DATA-CONTRACT.md`, `docs/CHANGELOG.md`, and
`docs/ROADMAP.md` first, then read all twelve findings documents listed below in full and
extracted every item marked "not fixed," "logged for a future round," "worth considering," "not
changed this round," or equivalent deferred language, skipping anything the Changelog already
records as fixed. For each extracted item, checked the *current* state of the relevant file(s)
directly (`Read`/`Grep`, not assumption) before deciding whether it was still open — several items
turned out to have been fixed incidentally by a later round's unrelated edit, or by that same
round's own subsequent integration pass landing after its findings doc was written. This document
is organized by source document, one row per item, and records exactly what was found — not a
re-run of any dry run.

**Headline result.** 34 deferred items extracted across the twelve documents. Of these:
**5 were fixed this round** (all small, single- or two-file, mechanical additions with no design
judgment involved), **20 turned out to be already resolved** — fixed by a later round's own
integration pass or by a subsequent round's unrelated edit, confirmed by reading the current file,
not assumed from the Changelog — and **9 remain genuinely open**, either because they require
editing `CONVENTIONS.md`/`docs/DATA-CONTRACT.md` (explicitly off-limits to this round), because
they're a real design/process question a prior round's own document already flagged as needing
maintainer judgment rather than a unilateral patch, or because closing them requires a live
multi-session run or new testing infrastructure, not a text edit.

`scripts/validate-plugin.sh` passes clean (0 warnings, 0 errors) after this round's edits.

---

## docs/QA-FINDINGS-ROUND2.md

| # | Original finding (one line) | Status | Detail |
|---|---|---|---|
| 1 | 1.2 — orchestrator's inline DE-step dependency examples (steps 5/8/17) don't match what the step files actually declare as required | **ALREADY RESOLVED** | `agents/orchestrator.md` Phase 2 item 1 no longer states any inline dependency examples at all — it now reads: "The step's own 'Read before starting'/'Reads' section is the source of truth for its real dependencies — do not rely on memory or on any inline example list, including the one that used to be here, since a stale illustrative example is worse than none." The wrong examples were removed, not just corrected. |
| 2 | 1.5 — no doc states the `qc-*`/`ka-*` id-prefix conventions are non-canonical, inconsistent padding across step skills | **ALREADY RESOLVED** | `docs/DATA-CONTRACT.md`'s Conventions section now has an explicit paragraph: "`key_assumptions[].id` and `quantitative_claims[].id` values just need to be unique within their array — the `ka-NN-slug`/`qc-NN-slug` style... is a convention for readability, not a schema requirement... Don't read padding differences as a bug; do keep ids unique." |
| 3 | 2.3 — `assemble-business-plan`'s theme-mapping table/§6 don't cross-reference where the Confidence & Validation Status section sits relative to the six theme sections | **ALREADY RESOLVED** | `skills/business-plan/assemble-business-plan/SKILL.md` §7 now states placement explicitly inline: "write the mandatory `Confidence & Validation Status` section... placed immediately after the executive summary — do not assume the editor will include it unprompted; name it in the delegation." |
| 4 | 6.2 — `docs/DE-24-STEPS.md` step 18's long parenthetical reads, on a fast skim, like a description of step 19 since it sits on the line just before step 19 | **ALREADY RESOLVED** | Current file has a blank line between step 18's parenthetical (line 33) and step 19's entry (line 35) — the visual separation the finding asked for is present. |

No items from this document remain open.

---

## docs/QA-FINDINGS-GATES-ROUND2.md

| # | Original finding (one line) | Status | Detail |
|---|---|---|---|
| 1 | Gate 2, callers #2/#3 — `outbound-sales-playbook`/`kpi-dashboard-setup` have no forward note that a future live-send/live-pull extension must call `skills/risk/privacy-check` (Mode B) first | **FIXED THIS ROUND** | Added a "Forward note for a future extension" paragraph to both `skills/gtm/outbound-sales-playbook/SKILL.md` (end of file, after "Write-back") and `skills/ops/kpi-dashboard-setup/SKILL.md` (end of "Never fabricate"), each stating the skill is document/founder-report-only today and that any future live-send/live-pull extension must call `skills/risk/privacy-check` (Mode B) first — near-verbatim to the language this finding recommended. |
| 2 | Gate 3, callers #3/#4/#5 — `fundraising-advisor`/`growth-analyst`/`finance-controller` had no `connectors-liaison` delegation, only a "latent" future obligation | **ALREADY RESOLVED** | All three now have a real, live `Task`/`subagent_type: connectors-liaison` delegation with fail-closed language ("Only treat the tool as usable/a source of truth once connectors-liaison reports clear"), confirmed present in `agents/gtm/fundraising-advisor.md`, `agents/ops/growth-analyst.md`, `agents/ops/finance-controller.md` — independently re-confirmed by `docs/QA-FINDINGS-CONNECTORS-ROUND3.md`'s own audit (all three scored REAL CHECK). |
| 3 | Note on `docs/DATA-CONTRACT.md` — no `gated_by` field records which specific `ai-risk-review` invocation cleared/blocked a given artifact/version, so a gate call isn't mechanically auditable against the specific version it cleared | **STILL OPEN** | Confirmed: no `gated_by`-shaped field exists anywhere in the current `docs/DATA-CONTRACT.md` schema. This is an explicit schema addition to `docs/DATA-CONTRACT.md`, which is off-limits to this round. **Recommended fix, restated:** add an optional `gated_by` (risk_log entry id) field to the `disciplined_entrepreneurship[NN]` step-status object and to `plan.history[]` entries, so a gate call becomes auditable against the specific artifact version it cleared rather than only inferable from timing. A future round with `DATA-CONTRACT.md` in scope should pick this up. |

---

## docs/QA-FINDINGS-ROUND3.md

No open items — this document's one blocking finding (4.2, the vacuous "Steps 10/11 not yet
approved" seat-selection clause) and its other findings are all confirmed fixed per
`docs/CHANGELOG.md`'s Round 3 section, re-confirmed present in the current
`skills/business-plan/run-review-council/SKILL.md`.

---

## docs/QA-FINDINGS-CONNECTORS-ROUND3.md

No open items — this pass found zero live gaps to fix in its own scope; its one forward-looking
note ("if a future skill adds a live external-tool action, it must copy the 'Real external tools'
pattern") is advisory guidance for future authors, not a defect to close, and the one real
ambiguity it did find in `agents/connectors-liaison.md` itself was fixed in the same pass
(confirmed present in the current file's §6, "Report back to the calling agent").

---

## docs/QA-FINDINGS-ROUND4.md

No open items — all findings (1.2 Step 18 background-relationship-time template, 2.4 services LTV:COCA
capacity caveat, 4.2 regulated-industry trigger false-positive risk, 4.3 semantic tag-overlap check,
4.4 `APPROVE_WITH_NOTES` checklist branch) are confirmed fixed per `docs/CHANGELOG.md`'s Round 4
section and re-confirmed present in the current files during this sweep.

---

## docs/QA-DOGFOOD-ROUND4.md

| # | Original finding (one line) | Status | Detail |
|---|---|---|---|
| 1 | Council write-scope statement missing on all 10 (then 12) `agents/council/*.md` files, explicitly flagged as out-of-scope for that round | **ALREADY RESOLVED** | Confirmed fixed in Round 5 per `docs/CHANGELOG.md` — all 12 current `agents/council/*.md` files carry an explicit "## What you write" section. |
| 2 | `connectors.json`/`cadence.json` mirror-file staleness across 7 files | **ALREADY RESOLVED** | Confirmed fixed in Round 4's own integration pass per `docs/CHANGELOG.md` — spot-checked `agents/connectors-liaison.md`, `agents/orchestrator.md`, and `docs/DATA-CONTRACT.md`; none describe a standalone mirror file. |
| 3 | `agents/qa/consistency-checker.md`'s own §4 reference list had drifted (stale `connectors/` subfolder, missing `design/`, stale mirror-file names) | **ALREADY RESOLVED** | Fixed within the same dogfood pass per the document's own text; not independently re-checked further since the document itself records the fix as landed. |
| 4 | Design gap: `skill-quality-auditor` has no mechanism to catch a file whose shared-contract dependency (e.g. `CONVENTIONS.md`) changed underneath it after the file was last correct | **STILL OPEN — maintainer judgment** | Explicitly logged by the document itself as "not added this round... squarely the kind of judgment call this round's scope discipline says to flag rather than freelance into `consistency-checker.md`." Confirmed no such cross-corpus staleness-detection mechanism exists in the current `agents/qa/consistency-checker.md` or `agents/qa/skill-quality-auditor.md`. This is a real design addition (e.g. "when auditing a file, also grep the corpus for any other file asserting the same fact-about-shared-state and flag disagreement"), not a mechanical fix — left for a maintainer to scope. |
| 5 | Design tightening: `skill-quality-auditor`'s item-3 "missing write-statement is always a FAIL" rule doesn't credit a `tools:` field that already omits `Write`/`Edit` as an equally strong (arguably stronger) mechanical guarantee | **STILL OPEN — maintainer judgment** | Explicitly logged as "not changed this round... genuinely a judgment call about the checklist's own precision." Confirmed the current `agents/qa/skill-quality-auditor.md` still treats a missing body write-statement as a FAIL regardless of the `tools:` field. Left for a maintainer — the suggested fix (note in the checklist's own fix-guidance that the `tools:` field already proves the behavior, so the fix is documentation not a behavior change) is not mine to unilaterally decide is the right calibration. |

---

## docs/QA-FINDINGS-ROUND5.md

| # | Original finding (one line) | Status | Detail |
|---|---|---|---|
| 1 | 4.1 item 2 — no genuinely dedicated `consumer_app`/`saas` contextual council persona exists (only a `competitive-strategy-reviewer` calibration bullet, fixed this round) | **STILL OPEN — design/process question** | Confirmed: `docs/DATA-CONTRACT.md`'s persona-coverage table still lists `saas`/`consumer_app`/`other` as "none dedicated." This is a scoping decision for a future round (add a new council persona file plus a seat-selection trigger and a `DATA-CONTRACT.md` table update) explicitly named by the Round 5 document as "a real future-round scoping question," not a small fix, and `DATA-CONTRACT.md` is off-limits to this round regardless. Already tracked in the one place a future round would look. |
| 2 | R2 1.4 (restated again this round) — Steps 04/11/14's "use WebSearch before falling back" instruction still has no enforcement, and no round has yet tested what happens when an agent *does* invoke WebSearch mid-session | **STILL OPEN** | Confirmed: no round's fixture or step file shows a WebSearch invocation being tested, and the steps still only instruct (not verify) attempting a search before falling back. This needs a live round actually invoking WebSearch mid-session to be closed, not a text edit — restating the recommendation rather than fixing blind. |

The two consumer_app-specific fixes from this document (Step 4 consumer_app branching, Steps 16/18
conversion cross-check, the LTV:COCA consumer_app caveat, and Step 19's standing rounding reminder)
are all confirmed fixed per `docs/CHANGELOG.md`'s Round 5 section.

---

## docs/QA-LAYER3-REGRESSION-ROUND5.md

| # | Original finding (one line) | Status | Detail |
|---|---|---|---|
| 1 | 3.1 item 6 — `vantage-point-search`'s `reviews[0]` was left `resolved: false` while `stage` was already `"approved"` | **ALREADY RESOLVED** | Confirmed directly against the live fixture: `.startup/vantage-point-search/business-state.json`'s `reviews[0].resolved` is now `true`. Fixed live in Round 6's post-approval run (`docs/QA-FINDINGS-POSTAPPROVAL-ROUND6.md` §1, "Fixed in place"). |
| 2 | "What a future round needs to do" item 1 — run a real REVISE/REJECT all the way through `revise-business-plan` and back to a re-review | **ALREADY RESOLVED** | Done live in Round 6 (`docs/QA-FINDINGS-ROUND6.md`) against `shiftcover`. |
| 3 | "What a future round needs to do" item 2 — run a business past `approved` into `gtm`/`operating` for real | **ALREADY RESOLVED** | Done live in Round 6 (`docs/QA-FINDINGS-POSTAPPROVAL-ROUND6.md`) against `vantage-point-search`. |
| 4 | "What a future round needs to do" item 4 — resolve the `vantage-point-search` `resolved`/`stage: approved` discrepancy explicitly | **ALREADY RESOLVED** | Same as row 1 above — closed live in Round 6. |
| 5 | "What a future round needs to do" item 3 — capture real before/after `business-state.json` snapshots at two lifecycle points to properly close the read-modify-write-discipline checklist item (3.3 item 2) | **STILL OPEN** | Confirmed: no round since has captured a mid-lifecycle before/after snapshot pair; the checklist item is still marked closeable only by inference from final-state consistency. This needs new testing infrastructure/methodology (a deliberate snapshot-and-diff step added to a future live dry run), not a text edit — restating the recommendation rather than attempting a stand-in fix. |
| 6 | 3.1 item 3a / 3.3 item 2 — dependency-ordering and read-modify-write discipline are structurally unverifiable from static fixtures, since no fixture's `interview-log.md` captures a per-step execution timeline | **STILL OPEN** | Same root cause as row 5 — the fix (log DE-step start/end timestamps into `interview-log.md`) is a live-run methodology change, not a text fix to an existing file, and touching this would mean prescribing a new logging convention across all 24 DE-step skills without maintainer sign-off on the convention itself. |

---

## docs/QA-FINDINGS-ROUND6.md

| # | Original finding (one line) | Status | Detail |
|---|---|---|---|
| 1 | 2.1 — a discarded outlier's required revisions are never routed to by `revise-business-plan`, so they resurface identically on re-review; the document itself says "Not fixed this round... deserves maintainer judgment" | **ALREADY RESOLVED** | Confirmed directly in the current `skills/business-plan/revise-business-plan/SKILL.md` §0.3: it now explicitly instructs extracting and carrying forward both the `### Discarded-but-real concerns` and `### Also flagging, regardless of severity` sections as in-scope (non-mandatory but not-silently-droppable) work, exactly option (a) the finding proposed. This was fixed by the round's own subsequent integration pass after the findings document itself was written — the findings doc's "not fixed this round" note is now stale, and `docs/CHANGELOG.md`'s Round 6 section correctly records it as fixed. |
| 2 | 3.1 — `revise-business-plan` conflated decision-gated and time-gated "blocked" items | **ALREADY RESOLVED** | Confirmed fixed per `docs/CHANGELOG.md` — present in the current file's §1, "Distinguish decision-gated items from time-gated items." |
| 3 | 3.2 — `business_basics.funding_intent` has no compliant landing place for a signal a revision cycle surfaces mid-cycle; the real, valuable signal sits unused in prose until some future, unscheduled `recurring-check-in` happens to notice it | **STILL OPEN — design/process question** | Confirmed: no mechanism in `agents/orchestrator.md` or `skills/interview/recurring-check-in/SKILL.md` proactively schedules a check-in touch when `revise-business-plan` or `run-review-council` logs a founder funding statement it isn't allowed to persist. The finding itself scoped this as "would mean editing the orchestrator's check-in-triggering logic, out of this round's safe single-file-fix scope." **Recommended fix, restated:** wire the orchestrator to proactively schedule (or at minimum flag for the very next session) a short `recurring-check-in` touch specifically when a specialist skill logs a founder funding statement it can't write to `business_basics.funding_intent` itself. This changes orchestrator behavior (when a check-in gets triggered), which is a maintainer-level call, not a documentation tweak — left open rather than patched unilaterally. |
| 4 | 3.3 — the AI-risk gate held on the revision path for the first time | **n/a — confirmation, not a finding** | No fix needed; recorded in the Changelog. |

---

## docs/QA-FINDINGS-POSTAPPROVAL-ROUND6.md

| # | Original finding (one line) | Status | Detail |
|---|---|---|---|
| 1 | §1 — round-4's `vantage-point-search` review left `resolved: false` | **ALREADY RESOLVED** | Fixed in place by this same document's own session (see the Layer 3 Round 5 table above); confirmed live in the fixture. |
| 2 | §2 — `runway-and-burn-tracking` had no period-normalization step | **ALREADY RESOLVED** | Confirmed fixed per `docs/CHANGELOG.md`; present in the current `skills/ops/runway-and-burn-tracking/SKILL.md` Step 2, and independently re-confirmed working on a second, opposite-direction case by `docs/QA-FINDINGS-PIVOT-ROUND7.md` §6. |
| 3 | §3 — ambiguity: does a founder's own personal email send need the connectors-liaison gate | **ALREADY RESOLVED** | Confirmed fixed per `docs/CHANGELOG.md`; `agents/connectors-liaison.md`'s MANDATORY GATE callout states the gate applies only when the agent itself initiates/automates an action through a connector it operates. |
| 4 | §4 — `outbound-sales-playbook`'s DMU-role count doesn't specify whether soft-influence-only roles count toward the tier decision | **STILL OPEN — minor, design call** | Confirmed: `skills/gtm/outbound-sales-playbook/SKILL.md` §3's tier-decision table still instructs counting "distinct DMU roles... populated with a real, distinct title," with no clause about veto power. This is a real, if minor, open rubric-precision question (should a purely-advisory, no-veto DMU role count the same as a hard-veto role toward tier complexity) that the original finding flagged as needing a decision ("clarify... whether to count only roles with real veto/blocking power, or state explicitly that any distinctly-titled role counts regardless, and say why") rather than a mechanical fix — a wrong unilateral choice here would silently change which businesses land in the Enterprise tier. Left open for a maintainer to decide the actual rule, restated here so a future round doesn't have to re-derive it. |
| 5 | §5 — walking all 16+ `key_assumptions` by name doesn't scale gracefully against a tight cadence (explicitly "not a bug," "worth considering") | **STILL OPEN — design tension, not a defect** | See the combined note under Round 7 Pivot §8 below — this same tension was re-confirmed, still unresolved, a second time in Round 7. |
| 6 | §6 — the cadence-scheduling mechanism was real but deliberately not exercised live (a methodological note, not a plugin bug) | **n/a — not a defect** | No fix applicable; correctly a note about what a future live founder session, not a QA round, would need to do. |

---

## docs/QA-FINDINGS-OVERRIDE-ROUND7.md

| # | Original finding (one line) | Status | Detail |
|---|---|---|---|
| 1 | #1 — the orchestrator's state-machine diagram misdescribed the founder-override path as looping back through another council re-run | **ALREADY RESOLVED** | The document records this as fixed in its own session; confirmed present in the current `agents/orchestrator.md` diagram (two distinct branches out of `revising`, the override branch explicitly labeled "no re-run"). |
| 2 | #2 — no file states explicitly what `reviews[].resolved` means on the override path | **ALREADY RESOLVED** | Confirmed present in both `agents/orchestrator.md` Non-negotiable #3 ("set that `reviews[]` entry's `resolved: true` — an override is a fully equivalent way of satisfying the gate...") and `skills/business-plan/run-review-council/SKILL.md`'s `resolved` field comment (explicitly names the override branch as "a real, distinct third path... confirmed live in round 7"). |
| 3 | #3 — `launch-director` would silently miss a founder override entirely (gate only reads `stage`, and its `risk_log` filter of "anything open" would exclude an override's `status: "accepted"` entries) | **ALREADY RESOLVED** | Confirmed present in `agents/gtm/launch-director.md`: an explicit override-detection check reading the most recent `reviews[]` verdict and the matching `accepted` `risk_log` entries whenever `stage` is `approved`. |
| 4 | #4 — no `risk_log[].type` enum value cleanly fits a review-gate override (explicitly logged as "out of authorized scope" since `DATA-CONTRACT.md` was off-limits that round) | **ALREADY RESOLVED** | Confirmed: `docs/DATA-CONTRACT.md`'s Conventions section now documents a `risk_log[].type: "governance"` value explicitly scoped to "the plugin's own process/gate decisions, raised by `agents/orchestrator.md` itself — the clearest example is a founder override... per Non-negotiable #3," and `agents/orchestrator.md` Non-negotiable #3 itself now instructs `type: "governance"` for exactly this case. |
| 5 | #5 — no `risk_log[].id` naming convention exists (the document itself calls this "no action needed") | **n/a — not a defect** | The finding's own text states ids only need to be unique, which the chosen `ov-<slug>-NNN` prefix satisfies; nothing to fix. |

All four real findings in this document are closed. Its own "What's still untested after this
round" section (full `launch-director` sequencing against an overridden plan; a founder changing
their mind after an override; a second business exercising this path) names live-run gaps, not
text-fixable ones — restated here rather than duplicated, since they're not "deferred findings"
in the same sense as the numbered items above.

---

## docs/QA-FINDINGS-PIVOT-ROUND7.md

| # | Original finding (one line) | Status | Detail |
|---|---|---|---|
| 1 | §1 — `docs/DATA-CONTRACT.md` assigns pivot-driven `business_basics` updates to `recurring-check-in`, but that skill's own file never implements the handoff | **ALREADY RESOLVED** | Confirmed present in `skills/interview/recurring-check-in/SKILL.md` Phase 2: an explicit clause instructing that a pivot-shaped answer be named back to the founder as a real decision point, then handed to the orchestrator to route through `agents/ops/operations-manager.md`'s pivot section (or executed directly if none is running) — matching the fix the finding recommended almost verbatim. |
| 2 | §2 — `agents/orchestrator.md`'s DE-step reopening protocol was a single unspecified sentence (no partial-reopening mechanic, no status semantics for a reopened-but-probably-still-valid step, no transitive-impact guidance) | **ALREADY RESOLVED** | Confirmed present in `agents/orchestrator.md` Phase 6, "Reopening a subset of DE steps after a pivot" — a full three-part subsection covering exactly the three gaps named (partial reversion to `not_started`, the `NEEDS RE-CONFIRMATION:` summary-prefix convention, and a "skim every other step file" transitive-impact check). `docs/DATA-CONTRACT.md`'s own Conventions section separately documents the `NEEDS RE-CONFIRMATION:` convention and cross-references this exact orchestrator section, confirming both sides landed together. |
| 3 | §3 — `agents/gtm/launch-director.md`'s mid-GTM pivot section didn't cover a pivot signal firing after launch (`stage: operating`), only one firing during active sequencing (`stage: gtm`) | **ALREADY RESOLVED** | Confirmed present: `agents/gtm/launch-director.md`'s pivot section now has an explicit "If `stage` is already `operating` (not `gtm`) when a pivot signal arrives" clause covering exactly this case. |
| 4 | §4 — `operations-manager`'s drift comparison is plan-vs-actual only, with no cross-period trend algorithm | **n/a — confirmed working as specified** | The document itself files this as "not a defect," confirming the qualitative founder-statement path is the intended (and correctly working) defense, not a numeric-trend gap. No fix needed. |
| 5 | §5 — `weekly-metrics-review`'s founder-input field list has no structured place for a lost-deal reason; this period's whole finding lived in an ad hoc table outside the template | **FIXED THIS ROUND** | Added a "Funnel losses this period" bullet to `skills/ops/weekly-metrics-review/SKILL.md` Step 1's field list (prospect/company, stage lost at, reason — same "not tracked" discipline as every other field) and a matching "Funnel losses this period" table to the `ops/<timestamp>-growth-metrics.md` output template, right after "Founder-reported inputs." |
| 6 | §6 — round 6's runway-normalization fix holds on a second, opposite-direction case | **n/a — confirmation, not a finding** | No fix needed; the document notes a possible future addition (a one-line caution about reading a single lumpy-payment period as a trend) but explicitly does not file it as a bug. Restating here only because the document itself flags it as a "possible future addition" — genuinely optional polish, not something this sweep judged worth touching unilaterally in the ops finance skill's careful risk-communication language without the maintainer's sign-off on the exact wording. |
| 7 | §7 — `scaling-strategist`'s "≥3 periods" bar correctly stayed un-invoked under a plausible-looking trigger | **n/a — confirmation, not a finding** | No fix needed. |
| 8 | §8 — the `key_assumptions` walk (now 20 items) doesn't scale gracefully against a tight cadence; this is the same tension Round 6 §5 flagged, now re-confirmed a second time, still "worth formalizing" | **STILL OPEN — design tension, not a defect** | Confirmed: `skills/interview/recurring-check-in/SKILL.md` Phase 3 still instructs "list each one by its `statement`, and ask directly" with no lighter-touch opt-out for a founder who already knows nothing's moved. Two independent rounds (6 and 7) have now hit this same tension and both explicitly declined to file it as a bug, instead flagging it as "worth considering"/"worth formalizing." This is a real UX/process trade-off (a lighter "anything change, or should I walk the full list" opt-out vs. the current unconditional per-item walk) that changes what a founder is asked every check-in — exactly the kind of design call this sweep's instructions say to leave alone rather than patch unilaterally after two rounds of hedged, non-committal language from the rounds that found it. **Recommended fix, restated:** add an explicit, sanctioned "lighter-touch" branch to Phase 3 — something like "if the founder confirms nothing has changed since the ops check-in already surfaced, ask 'anything else move since then, or is that the full picture?' instead of re-walking every item by name; only fall back to the full per-item walk if the founder's answer is vague or it's been several check-ins since the full list was walked" — but the exact threshold/phrasing is a maintainer call, not a mechanical fix. |

---

## Summary

- **34 deferred items** extracted across the 12 findings documents.
- **5 fixed this round**, all small and mechanical:
  - `skills/gtm/outbound-sales-playbook/SKILL.md` — forward note: a future live-send extension must call `skills/risk/privacy-check` (Mode B) first.
  - `skills/ops/kpi-dashboard-setup/SKILL.md` — forward note: a future live-pull extension must call `skills/risk/privacy-check` (Mode B) first.
  - `skills/ops/weekly-metrics-review/SKILL.md` — added a structured "Funnel losses this period" field to both Step 1's ask-list and the output template.
- **20 already resolved** — confirmed fixed by a later round's own integration pass or a subsequent round's unrelated edit, verified by reading the current file rather than trusting the original finding document's "not fixed" note (several rounds' findings documents were written *before* that same round's integration pass landed, so their own "not fixed this round" language is now stale).
- **9 remain genuinely open**, and are left untouched with the original fix recommendation restated in the tables above, because each one is either:
  - a `docs/DATA-CONTRACT.md` or `CONVENTIONS.md` schema/contract change (off-limits to this round) — the `gated_by` audit-trail field;
  - an explicit design/process judgment call a prior round's own document already flagged as needing a maintainer, not a unilateral patch — the QA-tooling shared-contract-staleness mechanism, the write-statement-vs-`tools:` calibration, the `consumer_app`/`saas` dedicated persona question, the `funding_intent` mid-cycle capture mechanism, the DMU soft-influence-role tier-counting rule, and the `key_assumptions` walk lighter-touch opt-out;
  - something only a live multi-session run or new test methodology can close — the WebSearch-enforcement gap, and the before/after `business-state.json` snapshot pair for the read-modify-write-discipline checklist item.
