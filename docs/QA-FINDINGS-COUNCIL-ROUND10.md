# QA Findings — Round 10: `operational-execution-reviewer` live dry run

**Method.** This round runs the plugin's newest (round 9) council persona,
`agents/council/operational-execution-reviewer.md`, and its seat-selection trigger at
`skills/business-plan/run-review-council/SKILL.md` §3 priority tier #3, for the first time —
neither had ever been convened or tested against a real plan before this round. Two distinct
tests were performed, and they are reported separately below because they answer different
questions:

- **Test #1 (real fixture)** works entirely against a genuine, already-drafted business:
  `.startup/skyclaim/` was copied to an isolated working copy at `.startup/skyclaim-t10-council/`
  (the original fixture was never touched), that copy's `business-state.json.slug` was updated to
  `skyclaim-t10-council`, and the full, real content of `business-state.json` and the five files
  `operational-execution-reviewer` is specified to read — `plan/06-full-life-cycle-use-case.md`,
  `plan/13-map-the-process-to-acquire-a-paying-customer.md`,
  `plan/18-map-the-sales-process-to-acquire-a-customer.md`, `plan/22-define-the-mvbp.md`, and
  `plan/24-develop-a-product-plan.md` — was read in full. The three-signal trigger test from
  SKILL.md §3 was then applied by hand against that real text (not summarized or assumed), the
  correct seat-selection outcome was worked out, and `operational-execution-reviewer`'s own rubric
  was then applied by hand to that same real content to produce a genuine, complete CONVENTIONS.md
  §6 verdict — done regardless of whether the trigger would have selected this persona in a real
  panel run, per the task's explicit instruction, precisely so the persona itself gets exercised
  even though (as found below) it would not actually be selected for this specific real business.
- **Test #2 (synthetic scenario)** is clearly-labeled hypothetical only. A short note,
  `.startup/skyclaim-t10-council/SYNTHETIC-SCENARIO-NOTE.md`, describes — and is marked throughout
  as a test artifact, not a real plan — a modified version of SkyClaim's plan with a second
  fulfillment channel added on top of the real, already-drafted multi-stage sales process, so that
  two of the trigger's three signals are present. No plan file was altered to match this
  hypothetical; it exists only as a written note used for a by-hand trigger walkthrough, reported
  below. Test #2 exists solely to confirm the trigger mechanics *can* select this persona and
  produce the documented tie-break outcome — it is not evidence about SkyClaim's real plan and
  must not be read as such.

No file outside `.startup/skyclaim-t10-council/**` and this findings file was created or modified.
`agents/council/operational-execution-reviewer.md` and `skills/business-plan/run-review-council/
SKILL.md` were read in full but not edited, per the task's file scope.

---

## Test #1 — real fixture: does the trigger correctly fire or not fire?

### Signal-by-signal walkthrough against SkyClaim's real Steps 6/13/18/22/24

**Signal 1 — multi-channel/multi-mode fulfillment or delivery. Does NOT fire.**

Step 22's MVBP delivery process is explicitly single-mode: "Automated today: nothing.
Manual/concierge today: Derek personally matches each incoming demand-side job request to one of
the 4-6 committed pilots by text/phone, tracks who's available, and manually reconciles payment."
Step 6's full-life-cycle map draws two *tracks* (supply and demand), but that is the ordinary
two-sidedness of any marketplace, not a second fulfillment channel/mode in the sense the trigger
means (its own examples are "DTC shipping *plus* a wholesale/retail channel" or "self-serve *plus*
high-touch onboarding" — two operationally distinct delivery mechanics running at once). SkyClaim
has exactly one delivery mechanic (concierge-matched aerial inspection, one report format,
delivered one way) applied across both sides of the same transaction. Signal 1 does not fire.

**Signal 2 — multi-stage/high-touch sales process required at launch. Fires.**

Both of Step 13/18's acquisition maps clearly exceed the "three or more distinct
founder-time-consuming stages" bar. Demand-side, quoting Step 13/18 directly: "1. Awareness ... 2.
Evaluation ... 3. Carrier-acceptance check ... 4. First booking" — four stages, and Step 18 costs
Derek's personal time at every one ("Derek's time: ~1 hr," "~2 hrs," "~2 hrs (supporting the
contractor's internal validation)," "~1 hr (coordination)"), with Stage 3 explicitly flagged as
"the flagged riskiest, longest stage per Step 13," taking "1-4 weeks." Supply-side is a parallel
four-stage founder-time-consuming process (Awareness → Evaluation → Sign-up & vetting → First job),
also entirely Derek's personal time per Step 18's table. This is squarely the pattern the signal
describes ("outbound prospecting, demo/consultation, negotiation, custom onboarding") on *both*
sides at once. Signal 2 fires.

**Signal 3 — aggressive MVBP timeline relative to concurrent build+deliver+support load. Does NOT
fire.**

The MVBP's own success bar is a short window — "3 real, paid transactions completed end-to-end
... within 6 weeks" (Step 22) — which is inside the trigger's own 8-week anchor. But the signal
requires the product to *still need finishing* concurrently with acquisition and
fulfillment/support, "with no described way to stage or sequence those three concurrent demands."
SkyClaim's plan explicitly does the opposite: Step 22 states the MVBP deliberately excludes any
new build ("no live in-app availability map yet ... no automated payment split ... first
transactions are invoiced and paid via direct transfer, split manually") and Step 24 confirms
automation work is deliberately deferred to "Priority 3 (after MVBP proves the mechanic works
manually first)," with named, real automation triggers ("job-matching automates once there are
more concurrent open jobs than Derek can track by hand"). This is a plan that *has* a described way
to stage the build-vs-launch tension — the exact opposite of what Signal 3 is looking for. Signal 3
does not fire.

### Team-size gate

`founder.notes` names only Derek Osei as founder ("8 years running Osei Aerial ... Pivoting from
solo operator to a two-sided marketplace"); no co-founder or hire is named anywhere in
`business-state.json`. The gate ("nothing in `founder.notes` or `business_type_notes` names a team
beyond one or two founders") is satisfied — but this is moot here since only one of three signals
fired regardless.

### Trigger outcome and correct seat-selection winner

**One signal fires (Signal 2), not two.** Per SKILL.md §3's own rule — "Exactly one signal firing
is not enough to win this seat... Log a single firing signal as a runner-up note for whichever
lower tier owns that axis" — `operational-execution-reviewer` does **not** win the contextual seat
for this real business. Walking the remaining priority order: #1 `regulated-industry-compliance-
reviewer` does not fire (SkyClaim's own activity is aerial inspection/reporting, not insurance
underwriting, claims adjudication, or funds custody — the plan never asserts SkyClaim itself
performs a regulated financial/health activity, only that its customers' *end use* of the report is
an insurance claim, which the SKILL.md trigger explicitly distinguishes from the business's own
pursued activity). #2 `technical-feasibility-reviewer` does not fire (Part 107 drone photography
and inspection reporting is conventional, not novel/deep-tech content). #3, as shown, does not
fire. #4 fires on the plain type match: `business_basics.business_type` is `marketplace`, so
**`marketplace-liquidity-specialist` correctly wins the contextual seat** for SkyClaim's real plan.

Step 12's DMU content (an external carrier veto-holder, multiple demand-side roles) would
independently trip #5 `sales-motion-reviewer`'s DMU-complexity clause, but per the SKILL.md
tie-break rule ("A `marketplace` business whose Step 12 DMU independently signals complexity ...
#4 outranks #5 here too"), `marketplace-liquidity-specialist` still wins and `sales-motion-reviewer`
is the logged runner-up — along with `operational-execution-reviewer`'s single fired signal
(Signal 2, the multi-stage sales process), which per SKILL.md's own instruction is logged as a
runner-up note under the same axis `sales-motion-reviewer` owns, not treated as a near-miss for
`operational-execution-reviewer` itself.

**This is a correct, unambiguous non-fire.** The trigger did not over-fire, and its two-of-three
bar behaved exactly as designed: a real, genuinely multi-stage sales process on its own was not
enough to displace the type-matched seat.

### `operational-execution-reviewer` invoked standalone — full verdict against SkyClaim's real plan

Per the task's instruction, the persona was invoked as a full standalone review regardless of the
trigger outcome above, reading its own rubric against the same five real files.

**Check 1 (aggregate load arithmetic).** Actual MVBP-phase volume is small — "3 real, paid
transactions ... within 6 weeks," 4-6 committed pilots, 2 named first demand-side customers (Ray
Delgado, Denise Ruiz) — so summed against a realistic solo-founder ceiling (~50-60 hrs/week), the
MVBP's own transaction load does not by itself oversubscribe Derek. This is a genuinely lean,
appropriately-scoped MVBP and is credited as a strength below, per the persona's own explicit
instruction to correct for its bias against brevity. However, Step 24's roadmap stacks three
"Priority 1" tracks onto Derek in the *same* 6-week window: "Execute the MVBP ... Priority 1,"
"Validate carrier acceptance ... Priority 1 (parallel with MVBP)," and "Cold-outreach campaign to
5+ pilots outside Derek's existing network ... Priority 1 (parallel with MVBP)" — three
concurrent, founder-time-consuming obligations with no stated hour allocation or order between
them. Separately, Step 18 states the demand-side carrier-acceptance stage's time cost is not
merely low-confidence but genuinely unmeasured: "Total time-in-funnel to first booking: unknown —
dominated by an untimed, unmeasured Stage 3," which means the true weekly-hours tally for Derek's
demand-side obligations cannot actually be confirmed to fit his bandwidth, even though the
transaction count itself is small. Tag `[EXECUTION-RISK]` on both findings.

**Check 2 (Steps 13/18 vs. 22 checked together).** At MVBP's actual small scale, the sales process
and delivery process do not individually read as two full-time jobs stacked on one person. The real
tension is the one found in Check 1: three "Priority 1, parallel" roadmap items (run the MVBP,
recruit 5+ new pilots, chase carrier validation) compete for the same solo founder's time in the
same window with no stated split. `[EXECUTION-RISK]`.

**Check 3 (credible first-90-days sequence).** Step 24 provides a priority-ranked list with real,
concrete automation-deferral triggers (a genuine strength, credited below), and an honest
"Resourcing reality check" naming the unresolved engineering gap (`ka-024-eng-resourcing`) rather
than hiding it — also credited. But it is not a dated, owner-by-owner operating sequence: three
items share "Priority 1" with only the word "parallel" describing their relationship, and no
function beyond "Derek" is ever named as an owner anywhere in Steps 22/24, including the
support/dispute-handling function Step 6 itself flags as "High" drop-off risk on both tracks
("Support/service ... dispute over a rejected report") — no step in the MVBP scope explicitly
assigns this function to anyone. This lands as category 2 ("a sequence exists but isn't fully
credible") rather than category 1 (no sequence at all) — real structure exists, but it doesn't
resolve the same-window competition for Derek's time that Check 1 found. `[EXECUTION-RISK]`.

```markdown
## Verdict: APPROVE_WITH_NOTES
**Score:** 7
**Reviewer persona:** Ex-COO / VP Operations, scaled three early-stage operating teams (one
rebuilt from scratch after a launch outran its ops capacity) — calibrated to distrust a plan's
silence on operational mechanics, disclosed below.

### Strengths
- The MVBP itself is deliberately, credibly lean: Step 22 explicitly excludes building any new
  automation ("no live in-app availability map yet ... no automated payment split") and defers
  that work to named, observable triggers in Step 24 ("job-matching automates once there are more
  concurrent open jobs than Derek can track by hand") rather than requiring Derek to build and run
  the business simultaneously — exactly the staged-launch mechanism this rubric looks for and
  rarely finds.
- Step 24's "Resourcing reality check" names the unresolved engineering-hire gap
  (`ka-024-eng-resourcing`) plainly rather than glossing over it, and ties it to a real intended
  resolution path (the funding raise) instead of leaving it silent.
- The MVBP's actual transaction volume (3 transactions, 4-6 pilots, 2 initial contractors, 6
  weeks) is genuinely small enough that, on its own, it does not oversubscribe a solo founder's
  realistic weekly bandwidth — this is a real, credit-worthy scoping discipline, not an
  under-specified plan that merely looks lean because it's brief.

### Risks / gaps
- [EXECUTION-RISK] Step 24 stacks three "Priority 1" tracks onto Derek in the identical 6-week
  MVBP window — executing the MVBP itself, a cold-outreach campaign to 5+ new pilots, and carrier-
  acceptance validation — each marked "(parallel with MVBP)" with no stated hour allocation or
  ordering among the three, so the plan does not actually show these fit together in the same
  weeks even though each looks individually reasonable.
- [EXECUTION-RISK] The demand-side carrier-acceptance-check stage's time cost is stated as
  genuinely unmeasured, not merely low-confidence ("Total time-in-funnel to first booking: unknown
  — dominated by an untimed, unmeasured Stage 3," Step 18) — this means the demand-side load on
  Derek cannot actually be confirmed to fit his bandwidth, only assumed to, since the single
  largest unknown cost in the whole funnel has no hours estimate at all.
- [EXECUTION-RISK] No step in the MVBP scope (Step 22 or Step 24) names an owner for
  support/dispute handling, despite Step 6 flagging exactly this ("Support/service ... dispute
  over a rejected report") as a "High" drop-off risk on both the supply and demand tracks —
  implicitly Derek by elimination, but never stated.
- [EXECUTION-RISK] Step 24's roadmap is a priority-ranked list, not a dated, owner-by-owner
  first-90-days operating sequence — "parallel" describes the relationship between the three
  Priority-1 items but does not resolve which gets Derek's time first in a given week, so the plan
  stops short of the credible sequence this rubric is looking for even though real staging
  discipline exists elsewhere in it (the automation deferral, credited above).
```

---

## Test #2 — synthetic scenario: does the trigger correctly fire and place operational-execution-reviewer above the type-match tier?

**Hypothetical construction** (full text in `.startup/skyclaim-t10-council/SYNTHETIC-SCENARIO-
NOTE.md`, clearly marked as a test artifact): add one invented fact on top of SkyClaim's real,
unmodified plan — a second, structurally distinct demand-side fulfillment channel (a wholesale-
style volume contract for large regional roofing chains, with its own batch-scheduling and
batch-invoicing mechanics) running concurrently with the real per-property spot-booking flow, on
the same solo/two-founder team. Nothing else changes: the real multi-stage sales process (already
firing, see Test #1) and the real 6-week MVBP timeline (already not firing, see Test #1) stay
exactly as drafted.

**Signal-by-signal walkthrough against the hypothetical:**
- **Signal 1 (multi-channel/multi-mode fulfillment) — now fires.** Two operationally distinct
  delivery mechanics (per-property spot booking vs. wholesale volume-contract batch fulfillment)
  running concurrently, each with its own scheduling/invoicing mechanics — squarely the "DTC ...
  plus a wholesale/retail channel" example the trigger names directly.
- **Signal 2 (multi-stage/high-touch sales process) — still fires,** unchanged from Test #1's real
  finding (Steps 13/18's four-stage demand-side and supply-side processes).
- **Signal 3 (aggressive concurrent-build timeline) — still does not fire,** unchanged from Test
  #1 — irrelevant here since two of three is already met.
- **Team-size gate — still satisfied.** The hypothetical deliberately keeps the team at
  solo-or-two-founder size; no larger headcount is added.

**Two of three signals fire → the trigger correctly fires.** Walking the priority order again: #1
(`regulated-industry-compliance-reviewer`) and #2 (`technical-feasibility-reviewer`) still do not
fire — the hypothetical adds no regulated-content or hardware/deep-tech signal. #3
(`operational-execution-reviewer`) fires. Per the tie-break rule's dedicated entry — "Any business
(regardless of type) whose Steps 13/18/22 independently trip `operational-execution-reviewer`'s
compound two-of-three execution-complexity signal, with no regulated-industry or
technical-feasibility signal also present: #3 outranks #4/#5/#6/#7" — **`operational-execution-
reviewer` correctly wins the contextual seat** in this hypothetical, ahead of #4.

**Logged runner-up:** `marketplace-liquidity-specialist` — the persona that would otherwise have
won the seat via the plain `business_basics.business_type: marketplace` match at #4 — becomes the
logged runner-up, recommended for the next review cycle, exactly as the tie-break rule specifies.

This confirms the placement mechanics described in `docs/DATA-CONTRACT.md`'s persona-coverage
table and SKILL.md's "Why `operational-execution-reviewer` sits between #2 and #4" section work as
documented: the seat is narrow (SkyClaim's real plan does not trip it) but real (a plan carrying a
second, genuinely independent execution-complexity axis does trip it, and correctly outranks the
otherwise-unconditional type-match tier when it does).

---

## Overall assessment

**Was the trigger logic mechanically followable by hand?** Yes, with one soft judgment call worth
flagging. Signals 1 and 2 were unambiguous — Signal 1's absence and Signal 2's presence both rest
on direct, unambiguous quotes from Steps 6/13/18/22. Signal 3 required a genuine interpretive
judgment: the MVBP's 6-week window is inside the trigger's own 8-week anchor (a surface read might
call this "aggressive"), but the signal's full text requires the *product itself* to still need
finishing concurrently with acquisition and delivery, and Step 22/24 explicitly stage that away.
An executing agent reading only the timeline number without the trigger's full qualifying clause
could plausibly misfire Signal 3 here. This is not a bug in the trigger text — the qualifying
clause is present and correctly resolves the case once read in full — but it is a real spot where
a careless or partial read could produce a different (incorrect) answer. Worth noting for anyone
tightening the persona's or trigger's wording in a future round: an explicit worked example
distinguishing "short MVBP window" from "short window with a still-unbuilt product" (the way this
finding just did) would remove the ambiguity outright.

**Did the tie-break placement work correctly in both tests?** Yes, in both directions. In Test #1
(real fixture), the two-of-three bar correctly held the type-matched seat (`marketplace-liquidity-
specialist`) in place against a plan that only tripped one axis — confirming the persona's
"narrow override, not a routine one" design intent actually holds for a real business, not just in
the abstract reasoning written into SKILL.md. In Test #2 (synthetic), adding one further,
independent axis correctly flipped the outcome and `operational-execution-reviewer` won the seat
per the documented tie-break entry, with `marketplace-liquidity-specialist` correctly demoted to a
logged runner-up. Both directions of the "yields to #1/#2, outranks #4 only on the compound
signal" design worked exactly as documented — this is a real, positive finding: the persona has
never been convened before this round, and its placement logic held up under both a real stress
test and a constructed one.

**Gaps found.**
1. **Signal 3's qualifying clause is easy to skim past** (see above) — not a functional bug, but a
   documentation/robustness gap worth flagging for whoever next edits this trigger or the persona's
   own file, since a partial read produces a materially different (wrong) answer for a plan that
   looks aggressive on the surface but is actually staged.
2. **The persona's own standalone review (run regardless of trigger, per this round's task)
   surfaced four real, concrete `[EXECUTION-RISK]` findings against SkyClaim's real plan** — most
   notably the three "Priority 1, parallel" roadmap items competing for the same solo founder's
   time in the same 6-week window, and the genuinely unmeasured (not just low-confidence)
   carrier-acceptance-check time cost. These are real findings about SkyClaim's plan, not about the
   persona or trigger machinery, and are worth the founder's attention independent of whether this
   persona would ever actually be seated for this business under the real trigger rules.
3. **No mechanical or schema-level defect was found** in either the persona file or the SKILL.md
   §3 trigger logic itself — both files' own worked reasoning ("Why `operational-execution-
   reviewer` sits between #2 and #4") held up exactly as written when tested against a real
   business's real content and against a deliberately constructed compound-signal case.
