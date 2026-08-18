---
name: run-review-council
description: >
  Use when a business plan (stage plan_assembled, or revising after a prior REVISE/REJECT) is
  ready to face expert/VC review, or when the orchestrator re-invokes review after a pivot or
  major decision. Triggers: "submit the plan for review," "run the council," "the council said
  REVISE — re-review," "is this plan ready to approve." Reads business-state.json and
  plan/business-plan.md, determines which agents/council/* personas to convene and how to
  weight each one's verdict based on the plan's actual strategy (funding intent, business type,
  which steps are still immature), runs the mandatory pre-council AI-risk gate, convenes the
  selected personas as a genuine parallel panel (never one agent standing in for "the
  council"), computes the aggregate verdict as the harshest non-outlier verdict per
  CONVENTIONS.md §6, runs the post-verdict AI-risk council-integrity gate, writes every
  individual verdict plus the aggregate into reviews/<timestamp>-<council-set>.md, and updates
  business-state.json's reviews[] array and stage.
---

# Run Review Council

You convene, weight, and aggregate the expert/VC review panel that decides whether a business
plan is allowed to proceed toward go-to-market. This is a gate, and it is a *designed* gate — the
panel composition and weighting are chosen deliberately from the actual content of this specific
business's plan, not a fixed roster run identically on every business. Read
`docs/ARCHITECTURE.md`'s "Why the review council varies by business strategy" section before your
first run if you haven't already; this skill is the mechanical implementation of that design
intent.

## 0. Preconditions

1. Load `.startup/<slug>/business-state.json` in full.
2. Confirm `stage` is `plan_assembled` or `revising` (a fresh review or a re-review after
   revisions). If `stage` is anything else, stop and report — don't run a council against a plan
   that isn't ready, and don't run one twice concurrently against the same plan version.
3. Determine the plan version under review: `plan.version`, and confirm `plan.file` (normally
   `plan/business-plan.md`, which always mirrors the latest version per
   `skills/business-plan/revise-business-plan`) exists on disk. Read it in full.
4. If this is a re-review (`stage: revising` → back to `council_review`), also read the specific
   `reviews/*.md` file(s) whose required revisions triggered the revision cycle, and the
   `plan.history` entry describing what changed — you'll want this for the panel's context and
   for your own "what changed since last review" framing in the new review file.

## 1. Mandatory pre-council AI-risk gate — call this before anyone reviews the plan

Per `skills/risk/ai-risk-review`'s binding calling-point contract, **you must call that gate on
the current plan before convening any council persona.** Invoke
`skills/risk/ai-risk-review` (which delegates to `agents/risk/ai-risk-analyst.md`) against
`plan/business-plan.md` (the version under review).

- **BLOCKED:** Do not convene the panel. Do not change `stage`. Report back to the caller
  (normally the orchestrator) exactly what the gate reported — the specific blocking finding(s),
  what would resolve each, and the `risk_log` entry ids. This is not this skill's call to
  override; route it back per `agents/orchestrator.md` Non-negotiable #3 (fix it, or the founder
  explicitly and knowingly overrides, logged). Stop here.
- **PASS:** Proceed to panel selection. Note any advisory findings in your own final report but
  don't let them slow the panel down.

The point of this ordering (stated in `docs/AI-RISK-FRAMEWORK.md`) is that the council should
spend its scrutiny on business judgment, not rediscover an unsourced TAM a mechanical check
already caught — never skip this call because "the plan looks fine" or because time is tight.

## 2. Determine the funding track — this drives panel weighting

Read, in this priority order, until you get a clear signal:

1. **`business-state.json`'s `gtm.funding_strategy`.** If it is `bootstrap` or
   `raising_outside_capital`, that is authoritative — use it directly, skip to step 3 below. Note
   that at a *first* council review (before `stage: gtm` has ever been reached),
   `gtm.funding_strategy` is very often still `undecided`, because `agents/gtm/launch-director.md`
   doesn't set it until GTM work actually starts — that is the expected common case, not a data
   gap, and it sends you to step 2.
2. **If `gtm.funding_strategy` is `undecided` (or absent),** infer it yourself, provisionally and
   *only for the purpose of weighting this review* — never write your inference back into
   `gtm.funding_strategy`; that field stays owned by `launch-director` and stays `undecided` in
   the state file until it sets it for real. Scan, in order: `founder.notes`, the executive
   summary and Step 15 (business model) section of `plan/business-plan.md`, and
   `plan/15-design-a-business-model.md` directly, for explicit statements of funding intent:
   - **Bootstrap signal** — phrases like "bootstrapped," "self-funded," "no outside investment,"
     "profitable from day one," "not raising," "keep full ownership," "cash-flow funded,"
     "lifestyle business" (used by the founder themselves, not as a pejorative you're applying).
   - **Venture signal** — phrases like "raising a seed round," "raising venture capital,"
     "VC-backed," "pre-seed/seed/Series A round," "venture-scale," "the ask is $X for Y% equity,"
     or any explicit funding ask in the executive summary.
   - **No clear signal either way** — the common case for an early plan that hasn't addressed
     funding strategy explicitly. Do not force a read where none exists.
   - **On a re-review specifically** (`stage: revising` → back to `council_review`), before
     re-deriving this from scratch, read the track stated in the header of the most recent prior
     `reviews/*.md` file for this plan (you already loaded it per §0.4). If `gtm.funding_strategy`
     is still `undecided`/absent *and* your fresh scan above doesn't turn up an explicit signal
     that is new or different from whatever drove the prior review's track assignment, **keep the
     prior track** rather than re-inferring independently — track assignment must not flap between
     review cycles on wording variance alone when the founder's actual funding intent hasn't
     changed. If a genuinely new explicit signal has appeared (the founder added a funding
     statement, Step 15 was revised to state a funding approach), the new signal wins; state
     plainly that the track changed and quote what changed.
3. Assign the **track**:
   - **Track A — bootstrap-track**: explicit bootstrap signal (from `gtm.funding_strategy` or
     inference).
   - **Track B — venture-track**: explicit venture signal (from `gtm.funding_strategy` or
     inference).
   - **Track C — balanced/undecided**: `gtm.funding_strategy: undecided` with no clear inferred
     signal either way. This is expected to be the most common track for a first-time review.

State which track you assigned and why (quote the specific signal, or say plainly "no explicit
funding-intent signal found — Track C") in the review file's rationale section (step 6 below).
This decision is never silent.

## 3. Select the panel — always exactly 5 seats

Run the full top of the CONVENTIONS.md §6 range (5, not the minimum 3) on every review, every
track. A thin panel is exactly the rubber-stamping risk `docs/AI-RISK-FRAMEWORK.md` failure mode
4 warns about — this plugin does not economize on panel size to save time.

**Four fixed seats, every track:**

1. `customer-discovery-skeptic` — evidence quality in Steps 1-9 underlies every other panelist's
   judgment; always run.
2. `financial-modeling-reviewer` — arithmetic correctness and sourcing integrity are not
   funding-strategy-dependent; always run.
3. `vc-panel` — always run (see §4 for how its weight, not its attendance, varies by track).
4. `expert-entrepreneur-panel` — always run alongside `vc-panel`, deliberately, so the two
   genuinely different generalist lenses (venture fundability vs. operational buildability) are
   both on record and get reconciled by the aggregation rule in §5, not pre-decided by which one
   you bothered to invite.

**One contextual 5th seat**, chosen by this priority procedure — evaluate in order, take the
first that triggers; if none trigger, use the default:

1. **`technical-feasibility-reviewer`** triggers if `business_basics.business_type` is
   `physical_product` **and** `business_type_notes` (or `founder.notes`) signals hardware,
   deep-tech, or regulated-engineering content — keywords like "hardware," "device," "firmware,"
   "IoT," "robotics," "battery," "manufacturing tooling," "biotech," "medical device," "clinical,"
   "FDA," "novel algorithm," "proprietary model," "deep tech," "R&D," "patent-pending
   technology," "regulatory approval," "certification (UL/FCC/CE/FDA)" — **or**
   `business_basics.business_type` is `other` with `business_type_notes` describing exactly that
   shape (the fixed enum has no dedicated hardware/deep-tech/regulated value yet — see this
   skill's cross-team note), **or** Step 7's product spec itself
   (`disciplined_entrepreneurship.07_high_level_product_specification.summary` and/or
   `plan/07-high-level-product-specification.md`) describes a novel/unproven core technology (a
   proprietary algorithm, novel hardware mechanism, or a safety-/accuracy-critical or regulated
   product) regardless of the `business_type` label — trigger on the plan's own content, not just
   the category field, since a `saas`-labeled plan can still describe a technically ambitious or
   regulated build (an AI-diagnostics or fraud-detection product, for instance). This is the
   highest-priority trigger: a business built on a technically infeasible premise is a more
   consequential blind spot than an unresolved market or channel question, because no amount of
   good GTM execution rescues a product that can't be built as scoped.
2. **`sales-motion-reviewer`** triggers if `business_basics.business_type` is `services` or
   `physical_product` with a stated retail/wholesale/channel component, **or** Step 12's DMU
   description (check `disciplined_entrepreneurship.12_determine_the_dmu.summary` and/or
   `plan/12-determine-the-dmu.md`) names multiple stakeholder roles, procurement, or an explicitly
   long/multi-stage sales cycle — i.e., anything beyond a single self-serve buyer-user-payer.
3. **`product-market-fit-panel`** triggers if `business_basics.business_type` is `saas`,
   `consumer_app`, or `marketplace`, **and** any of Steps 06, 07, 08, 20, 21, 22, 23 has `status`
   other than `approved`, **or** `key_assumptions` entries with `step_ref` in that range and
   `confidence: low` outnumber similarly-low-confidence entries elsewhere in the plan — i.e., the
   PMF-critical steps are the plan's least mature section right now.
4. **`competitive-strategy-reviewer`** — the default. Also use this instead of #1/#2/#3 whenever
   `business_basics.business_type` is `marketplace` (two-sided defensibility is close to always
   the central strategic question for a marketplace) or Steps 10/11 are not yet `approved`.

`technical-feasibility-reviewer` is deliberately **not** a fallback default — most plans describe
conventional, well-understood builds where this seat has little to add, so it only takes the seat
when its trigger actually fires, exactly like #2/#3 below it.

If more than one of #1-#3 triggers for the same review, take the lowest-numbered one that
triggered — #1 (`technical-feasibility-reviewer`) outranks #2 (`sales-motion-reviewer`), which
outranks #3 (`product-market-fit-panel`), per the priority order above (rarest, most consequential
signal wins) — and note in the review file's rationale that the runner-up trigger(s) are
recommended for the *next* review cycle rather than silently dropping the concern. Never exceed 5
seats total.

State your full seat list and the one-line trigger reason for the contextual 5th seat in the
review file's rationale section — this is what makes the "extremely thoughtfully designed" part
auditable rather than asserted.

## 4. Track-based weighting — this is what actually changes by track

Every one of the 5 seats runs and produces a full verdict, written into the review file in full,
**always** — no verdict is ever hidden or truncated regardless of weighting. What weighting
changes is whether a given seat's verdict counts toward the *aggregate* computation in §5.

- **Track B (venture-track):** All 5 seats are fully blocking, `vc-panel` included at full
  weight — including any `[VENTURE-FIT]`-tagged concerns. Venture-fit *is* the fundamental
  question for a plan explicitly pursuing outside capital, so there is no downgrade here.
- **Track A (bootstrap-track):** `customer-discovery-skeptic`, `financial-modeling-reviewer`,
  `expert-entrepreneur-panel`, and the contextual 5th seat are fully blocking. `vc-panel`'s
  verdict is downgraded to **informational** for the aggregate computation *only if 100% of its
  Risks/gaps and Required-revisions bullets are tagged `[VENTURE-FIT]` and no other tag* — in
  that case its verdict level is excluded from §5's aggregation entirely (though it still
  appears in full in the file, and its Strengths still inform the founder). If `vc-panel` raises
  even one bullet under a different tag (a real soundness concern independent of venture-scale
  fit — an unsourced TAM, a broken competitive analysis), its **full verdict level counts as
  blocking like every other seat's** — you do not get to cherry-pick the bad tags out of an
  otherwise-blocking verdict. State explicitly in the review file which case applied.
- **Track C (balanced/undecided):** All 5 seats are fully blocking, no downgrades. Let
  `vc-panel` and `expert-entrepreneur-panel` disagree at full strength — the general outlier rule
  in §5 (not a track-specific override) is what reconciles them. This is deliberate: when funding
  intent is genuinely unknown, this skill does not pre-judge which generalist lens should win.

## 5. Run the panel — a genuine parallel panel, not a simulated one

Invoke all 5 selected `agents/council/*.md` personas as **separate, simultaneous subagent
invocations in a single batch** (e.g., multiple Task-tool calls issued together in one turn) so
each one reasons independently, with no visibility into any other panelist's output. Never:

- Run them sequentially and let a later persona's prompt include an earlier one's verdict.
- Have a single agent invocation role-play multiple personas and report back several verdict
  blocks — that is exactly the "one agent standing in for the council" pattern CONVENTIONS.md §6
  forbids, and it is also exactly the rubber-stamping failure mode `docs/AI-RISK-FRAMEWORK.md`
  warns about (interchangeable bullets between personas is the tell).

Give each persona the same inputs: the plan version under review, and (if this is a re-review)
the prior review file and what changed. Collect all 5 full verdict blocks, each already in the
CONVENTIONS.md §6 schema, tagged per the shared vocabulary below.

### Shared tag vocabulary (authoritative — every `agents/council/*` persona uses these)

Every bullet in every persona's Risks/gaps and Required revisions sections must start with
exactly one of these bracketed tags, so this skill can mechanically check cross-persona overlap
in §6:

`[MARKET-SIZE]` `[SEGMENTATION]` `[EVIDENCE-GAP]` `[PERSONA-VALIDITY]` `[VALUE-PROP]`
`[MVBP-SCOPE]` `[ASSUMPTION-UNTESTED]` `[UNIT-ECONOMICS]` `[PRICING]` `[SOURCING]`
`[DEFENSIBILITY]` `[COMPETITIVE-BLIND-SPOT]` `[BUSINESS-MODEL]` `[SALES-CYCLE]`
`[DMU-COMPLEXITY]` `[EXECUTION-RISK]` `[FOUNDER-MARKET-FIT]` `[VENTURE-FIT]` `[SCALABILITY]`
`[FINANCIAL-ARITHMETIC]`

If a returned verdict has an untagged bullet, tag it yourself from context before running §6
rather than discarding the aggregation step — but note in the review file that you had to backfill
a tag, since a persona omitting tags repeatedly across reviews is itself a signal worth mentioning
in your final report (it makes cross-persona overlap harder to check mechanically, which is a
real, if minor, integrity concern).

## 6. Compute the aggregate verdict — harshest non-outlier, precisely defined

Severity order, harshest to softest: `REJECT` (4) > `REVISE` (3) > `APPROVE_WITH_NOTES` (2) >
`APPROVE` (1).

**Step A — Apply track weighting from §4.** Set aside any seat's verdict that's fully
informational per §4 (Track A's `vc-panel`, only when 100% `[VENTURE-FIT]`-tagged). Call the
remaining verdicts the **blocking set**. (Track B and C: the blocking set is all 5.)

**Step B — Find the current harshest severity among the blocking set.**

**Step C — Test whether the verdict(s) at that harshest severity are outliers, and discard only
if they pass every part of this test:**

A verdict at the current-harshest severity is a **discardable outlier** if and only if:

1. **It is alone at that severity** — no other blocking-set verdict shares the same severity
   level. (Two or more reviewers independently landing on the same harsh verdict — e.g. two
   REJECTs — is never an outlier situation for either of them, regardless of tag overlap; real
   convergence from independent reviewers is corroboration, not noise.)
2. **None of its Risks/gaps or Required-revisions tags appear in any *other* blocking-set
   reviewer's Risks/gaps or Required-revisions** (check every other reviewer's tags, not just
   reviewers who share its verdict level — a reviewer who APPROVE_WITH_NOTES'd but flagged the
   same tag as a lone REJECT is corroboration that concern is real, even though their overall
   verdict was softer). If there is *any* tag overlap with *any* other reviewer, the verdict is
   **not** discardable — a credible concern shared across personas blocks, full stop, per
   CONVENTIONS.md §6's "one credible blocking objection should block, not get diluted."

If a verdict passes both tests, discard it from consideration and recompute the harshest severity
among what remains (repeat Step B/C — a second lone dissenter can also be tested and discarded
independently, using tag-overlap against the *original* full blocking set, not just the
already-reduced one). If it fails either test, it is **not** discarded — the current harshest
severity stands as the aggregate.

**Step D — the aggregate verdict is the harshest severity remaining after all applicable
discards.** The **aggregate score** is the lowest (harshest) score among the blocking-set
reviewers whose verdict is at that final aggregate severity — never an average.

**Worked example.** Five blocking-set verdicts: REJECT (`vc-panel`, tags `[VENTURE-FIT]` only —
but this is Track B, so it's in the blocking set), REVISE (`customer-discovery-skeptic`, tags
`[EVIDENCE-GAP]`), APPROVE_WITH_NOTES (`expert-entrepreneur-panel`, tags `[EXECUTION-RISK]`),
APPROVE_WITH_NOTES (`financial-modeling-reviewer`, tags `[UNIT-ECONOMICS]`), APPROVE
(`competitive-strategy-reviewer`, no risk tags). Harshest is REJECT, held alone by `vc-panel`.
Check tag overlap: `[VENTURE-FIT]` does not appear in any other reviewer's tags → passes both
outlier tests → discard. Recompute: harshest remaining is REVISE, held alone by
`customer-discovery-skeptic`. Check tag overlap: `[EVIDENCE-GAP]` does not appear elsewhere either
→ discard. Recompute: harshest remaining is APPROVE_WITH_NOTES, held by two reviewers (not alone)
→ stops here. **Aggregate verdict: APPROVE_WITH_NOTES**, score = the lower of the two
APPROVE_WITH_NOTES scores. Contrast: if `financial-modeling-reviewer` had *also* tagged a bullet
`[EVIDENCE-GAP]` (e.g., flagging that a TAM input traces to the same unvalidated customer claim
`customer-discovery-skeptic` flagged), the REVISE would **not** be discardable — it would stand as
the aggregate, because two independent reviewers converged on the same underlying concern.

## 7. Post-verdict AI-risk council-integrity gate

Call `skills/risk/ai-risk-review` a second time, this time targeting the set of `reviews/*.md`
files just produced (this review plus, if available, recent prior reviews for this business using
overlapping personas), per that skill's binding calling-point contract. This call does **not**
gate the verdict you just computed in §6 — the verdict stands on its own merits regardless of
this check's outcome. What it can produce is a **structural** finding against the council/
persona-set itself (score clustering, verdict uniformity, interchangeable bullets across
personas) — if it finds one, include it plainly in the review file (§8) and in your final report,
and say explicitly that future verdicts from this persona set should be treated as
reduced-confidence until addressed, per `docs/AI-RISK-FRAMEWORK.md`. This is a standing note, not
a one-off — don't bury it.

## 8. Write the review file

Determine the filename: `reviews/<YYYY-MM-DD>-<track-slug>-panel-v<N>.md`, where `track-slug` is
`bootstrap-track` / `venture-track` / `balanced` per §2, and `N` starts at 1 and increments only
if a file for the same date and track-slug already exists in `reviews/` (a same-day re-review
after fast revisions gets `-v2`, etc.).

Write, in this order:

1. **Header** — business name, plan version reviewed, review date, track assigned and why (quote
   the signal or state "no explicit signal — Track C"), the 5 seats selected and the one-line
   trigger reason for the contextual 5th seat, and (on a re-review) a one-paragraph summary of
   what changed since the prior review.
2. **Every individual verdict, in full, verbatim**, each under its own `### <persona name>`
   heading, in the exact CONVENTIONS.md §6 schema each agent returned — never summarized, never
   trimmed, including any seat downgraded to informational per §4 (label it plainly: "**Weight:
   informational — Track A bootstrap plan, verdict is 100% `[VENTURE-FIT]`-tagged per §4**" right
   under that persona's heading).
3. **Aggregation accounting** — show the work from §6: the severity of each blocking-set verdict,
   which (if any) were tested as outlier candidates and why they were or weren't discarded (name
   the tag-overlap check explicitly, the way the worked example does), and the final aggregate
   verdict and score.
4. **`## Aggregate Verdict`** section in the same CONVENTIONS.md §6 schema shape (Verdict, Score,
   and a synthesized Required revisions list — the union of every required-revision item from
   every reviewer whose verdict counted toward the aggregate severity, deduplicated by tag+substance,
   not just the single harshest reviewer's list, so the founder gets one actionable checklist).
5. **Council-integrity note** from §7, even if it's reassuring ("no rubber-stamping signal this
   pass") — state it, don't omit it because it's good news.
6. **Footer disclaimer, once:** "This review is a planning aid produced by simulated reviewer
   personas grounded in the Disciplined Entrepreneurship framework and this business's own stated
   facts — it is not licensed financial, legal, or investment advice, and passing it is not
   validation from a real investor, customer, or advisor. See `docs/AI-RISK-FRAMEWORK.md` for what
   this system's review layers do and do not verify."

## 9. Update `business-state.json`

Read the whole file, write back only these keys, preserve everything else:

- Append to `reviews[]`:
  ```json
  {
    "id": "rev-<slug-short>-<sequential, incrementing from the highest existing rev-<slug>-* id>",
    "council": "<track-slug>-panel (5 seats: <comma-separated persona names>)",
    "target": "plan-v<N>",
    "verdict": "<aggregate verdict from §6>",
    "score": "<aggregate score from §6>",
    "file": "reviews/<the file you just wrote>",
    "resolved": false
  }
  ```
  `resolved` starts `false` regardless of verdict — per the orchestrator's own Phase 4 handling,
  it becomes `true` once the founder has seen an APPROVE/APPROVE_WITH_NOTES verdict's notes (or,
  for REVISE/REJECT, once `skills/business-plan/revise-business-plan` closes the loop). Setting it
  is the orchestrator's job on the read side, not this skill's — don't set it `true` yourself even
  for a clean APPROVE, so the founder-facing acknowledgment step never gets silently skipped.
- Set `stage`:
  - Aggregate `APPROVE` or `APPROVE_WITH_NOTES` → `stage: "approved"`.
  - Aggregate `REVISE` or `REJECT` → `stage: "revising"`.
- `updated_at`: current ISO-8601 timestamp.

Do not touch `disciplined_entrepreneurship`, `plan`, `gtm`, `ops`, `connectors`, `cadence`,
`key_assumptions`, or `quantitative_claims` — those belong to other skills/agents. You may not
set `gtm.funding_strategy` even if you inferred a track in §2 — that field is owned exclusively by
`agents/gtm/launch-director.md`; your inference is scoped to this review's weighting only and must
never leak into the canonical field.

**Boundary with the orchestrator:** this skill's job ends at a correctly written review file and
a correctly updated `reviews[]`/`stage`. The founder conversation (announcing the verdict,
walking through required revisions, routing each one to the owning specialist per
`agents/orchestrator.md` Phase 4) is the orchestrator's job, not this skill's — report back to it
plainly rather than trying to have that conversation yourself.

## 10. Done looks like

- The pre-council AI-risk gate passed (or was overridden per the orchestrator's logged-override
  path) before any persona saw the plan.
- All 5 selected personas ran as genuinely independent, simultaneous invocations, each returning
  a full CONVENTIONS.md §6 verdict with every Risks/gaps and Required-revisions bullet tagged.
- The aggregate verdict was computed by the precise outlier rule in §6, with the accounting shown
  in the review file, not asserted.
- The post-verdict AI-risk council-integrity check ran and its read is stated in the review file.
- `reviews/<timestamp>-<council-set>.md` exists with every individual verdict in full, the
  aggregation accounting, the aggregate verdict, the integrity note, and the disclaimer.
- `business-state.json` has a new `reviews[]` entry and `stage` set to `approved` or `revising`
  per the aggregate verdict.
- Report back to the caller: the track assigned and why, the 5 seats and the aggregate verdict,
  the file path, and — if `revising` — the synthesized Required revisions list so the caller can
  route it immediately.
