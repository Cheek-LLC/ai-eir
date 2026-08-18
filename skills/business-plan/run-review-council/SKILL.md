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
   gap, and it sends you to step 1a.
1a. **If `gtm.funding_strategy` is `undecided` (or absent), check `business_basics.funding_intent`
   next, before doing any prose-inference.** This field is the founder's own earliest stated
   signal, captured directly during onboarding (`skills/interview/onboarding-interview`) — it's
   auditable and stable across re-reviews in a way that re-scanning plan prose every cycle is not.
   If it is `bootstrap` or `raising_outside_capital`, use it directly (as a provisional signal for
   weighting only, same non-write-back rule as step 2 below) and skip to step 3. If it is
   `undecided` or the field doesn't exist on this business's record (older businesses created
   before this field existed), fall through to step 2.
2. **If neither field above gave a clear signal,** infer it yourself, provisionally and
   *only for the purpose of weighting this review* — never write your inference back into
   `gtm.funding_strategy` or `business_basics.funding_intent`; those fields stay owned by
   `launch-director` and `onboarding-interview` respectively. Scan, in order: `founder.notes`, the
   executive summary and Step 15 (business model) section of `plan/business-plan.md`, and
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

1. **`regulated-industry-compliance-reviewer`** triggers on a **content signal, not a
   `business_type` match** — none of the 6 `business_basics.business_type` enum values name a
   regulated vertical, so this trigger is evaluated against `business_basics.business_type_notes`
   and the plan's own text at Steps 1, 7, and 15 (`plan/01-market-segmentation.md`,
   `plan/07-high-level-product-specification.md`, `plan/15-design-a-business-model.md`) for
   mentions of health/medical/patient data, financial services/payments/lending, or another
   explicitly regulated activity (insurance, cannabis, alcohol, firearms, gambling, education
   records, transportation-safety-regulated services, and the like) — keywords such as "patient,"
   "PHI," "HIPAA," "clinical," "diagnosis," "medical record," "payments," "lending," "custody of
   funds," "money transmission," "KYC," "AML," "insurance underwriting," "FERPA," "controlled
   substance," "licensed provider." **A keyword match only counts if it describes the business's
   own actual or pursued activity** — the selected beachhead, the chosen business-model archetype,
   the actual product/service being delivered — never (a) a candidate/customer characteristic
   inside a surveyed-and-rejected Step 1 segment (Step 1 necessarily lists these by design, and a
   segment's description can legitimately contain a regulated-sounding term without the business
   itself touching that activity), or (b) a sentence that explicitly negates the regulated
   attribute rather than asserting it (e.g. "not a licensed profession," "no HIPAA scope" — read
   the actual claim, don't fire on substring presence alone). Confirmed via round 4's live dry run
   that a literal/mechanical keyword-presence check would misfire on exactly these two real
   patterns; an executing agent must read the surrounding sentence for what it actually claims
   about the pursued business, not pattern-match the word list. **Added this round as the new
   highest-priority trigger, evaluated ahead of `technical-feasibility-reviewer` (now #2) and every
   other tier** — see "Why the compliance reviewer is checked first" immediately below the numbered
   list for the full reasoning; in short, this seat can fire for business types (`saas`,
   `consumer_app`, `services`, `marketplace`) that no other tier below reaches on a
   licensing/regulatory-awareness basis at all, and even where it overlaps with a lower tier's
   trigger, the "can this business legally operate as scoped" question it asks is prior-in-kind to
   that tier's question.
2. **`technical-feasibility-reviewer`** triggers if `business_basics.business_type` is
   `physical_product` **and** `business_type_notes` (or `founder.notes`) signals hardware,
   deep-tech, or regulated-engineering content — keywords like "hardware," "device," "firmware,"
   "IoT," "robotics," "battery," "manufacturing tooling," "biotech," "medical device," "clinical,"
   "FDA," "novel algorithm," "proprietary model," "deep tech," "R&D," "patent-pending
   technology," "regulatory approval," "certification (UL/FCC/CE/FDA)" — **or**
   `business_basics.business_type` is `other` with `business_type_notes` describing exactly that
   shape (the fixed enum in `docs/DATA-CONTRACT.md` has no dedicated hardware/deep-tech/regulated
   value yet — this is a candidate future schema addition, flagged for the Data Contract owner
   rather than invented here), **or** Step 7's product spec itself
   (`disciplined_entrepreneurship.07_high_level_product_specification.summary` and/or
   `plan/07-high-level-product-specification.md`) describes a novel/unproven core technology (a
   proprietary algorithm, novel hardware mechanism, or a safety-/accuracy-critical or regulated
   product) regardless of the `business_type` label — trigger on the plan's own content, not just
   the category field, since a `saas`-labeled plan can still describe a technically ambitious or
   regulated build (an AI-diagnostics or fraud-detection product, for instance). Among tiers #2-#6,
   this is the highest priority, unconditionally, regardless of what else would trigger below: a
   business built on a technically infeasible premise is a more consequential blind spot than an
   unresolved market, liquidity, capacity, or channel question, because no amount of good GTM
   execution, take-rate design, or delivery-capacity planning rescues a product that can't be
   built as scoped. This holds even for a `marketplace` or `services` business that would
   otherwise take seat #3 below — a marketplace with real hardware-feasibility risk (e.g., a
   physical fulfillment/IoT component embedded in an otherwise two-sided platform) or a services
   business betting on an unproven core technology still needs its buildability question answered
   before its business-model question, so #2 wins the seat and the business-type-specific
   specialist becomes the logged runner-up per the tie-break rule below. It in turn yields to #1
   when `regulated-industry-compliance-reviewer`'s content signal independently fires (e.g. a
   novel medical device is simultaneously a hardware-feasibility question and a licensing-
   awareness question) — see the reasoning below the list.
3. **`marketplace-liquidity-specialist`** triggers if `business_basics.business_type` is
   `marketplace`. **`services-unit-economics-reviewer`** triggers if `business_basics.business_type`
   is `services`. **`hardware-physical-product-operator`** triggers if
   `business_basics.business_type` is `physical_product` — added this round, closing the gap the
   Data Contract's persona-coverage table flagged: `physical_product` previously had no
   unconditional dedicated persona, only `technical-feasibility-reviewer`'s narrow hardware/deep-
   tech carve-out (#2 above) or `sales-motion-reviewer`'s channel carve-out (#4 below). These three
   triggers are mutually exclusive by construction — `business_type` is a single enum value, so a
   given business can match at most one of them — and, like the original two, none needs an extra
   content signal beyond the type itself: being a marketplace, a services business, or a
   physical-product business at all is enough to make two-sided liquidity, delivery-capacity
   economics, or manufacturing/supply-chain operations close to always a central question worth a
   dedicated seat. This tier sits above `sales-motion-reviewer` and `product-market-fit-panel`
   deliberately: `business_type` is a more fundamental, holistic signal about what kind of
   business this is than a single-step content pattern, and — more importantly — the concerns
   these three specialists own (GMV×take-rate arithmetic and two-sided cold start; billable-hours
   capacity ceilings and founder-dependency; manufacturing lead times, tooling/certification cost,
   supply-chain single-points-of-failure, and the prototype-to-production gap) were entirely
   uncovered by any existing persona before this round and last round, whereas
   `sales-motion-reviewer`'s and `product-market-fit-panel`'s concerns, while real, already have a
   seat that can pick them up on a later review cycle.
4. **`sales-motion-reviewer`** triggers if `business_basics.business_type` is `services` or
   `physical_product` with a stated retail/wholesale/channel component, **or** Step 12's DMU
   description (check `disciplined_entrepreneurship.12_determine_the_dmu.summary` and/or
   `plan/12-determine-the-dmu.md`) names multiple stakeholder roles, procurement, or an explicitly
   long/multi-stage sales cycle — i.e., anything beyond a single self-serve buyer-user-payer.
   **Note the direct consequence of the tie-break rule below:** because `business_type: services`
   satisfies both this trigger and #3's `services-unit-economics-reviewer` trigger, and
   `business_type: physical_product` satisfies both this trigger's channel clause and #3's
   `hardware-physical-product-operator` trigger, and #3 is evaluated first in both cases,
   `sales-motion-reviewer` will not win the seat for a services business or a physical-product
   business purely on the type match — it can still win, in principle, for a non-services,
   non-physical-product business whose DMU content independently trips this trigger.
5. **`product-market-fit-panel`** triggers if `business_basics.business_type` is `saas`,
   `consumer_app`, or `marketplace`, **and** `key_assumptions` entries with `step_ref` in the
   06/07/08/20/21/22/23 range and `confidence: low` outnumber similarly-low-confidence entries
   elsewhere in the plan — i.e., the PMF-critical steps are the plan's least mature section right
   now. **(Round 3 fix: this used to also OR in "any of those steps has `status` other than
   `approved`" — since no `disciplined_entrepreneurship.NN_slug.status` value is ever promoted
   past `drafted` by anything in this plugin, per `agents/orchestrator.md`'s explicit design, that
   clause was unconditionally true for every business ever reviewed and made the maturity check
   vacuous — it always fired whenever the business-type matched, regardless of actual step
   maturity. Removed; the `key_assumptions`-confidence-concentration test is the only real signal
   and was already doing the actual work.)** In practice this trigger's `marketplace` branch will
   rarely fire, for the same reason noted at #4: `business_type: marketplace` is already claimed
   by #3 before evaluation reaches #5. It remains live for `saas` and `consumer_app`.
6. **`competitive-strategy-reviewer`** — the default, used only when nothing above triggered.
   **Also use this instead of #4/#5 whenever Steps 10 or 11 have `key_assumptions` entries with
   `step_ref` in that range at `confidence: low`, or either step's `summary` explicitly states no
   differentiated Core/position was found yet (e.g. a pre-liquidity marketplace with no Core yet,
   or a generic/undifferentiated competitive chart)** — i.e. the same kind of real content-based
   maturity signal #5 uses, not a status value. **(Round 3 fix: this condition used to read
   "whenever Steps 10/11 are not yet `approved`" — the identical vacuous-status bug found and
   fixed in #5 above, independently present here too and confirmed, by a live second dry run, to
   have survived a full rewrite of this section untouched. Since no step status ever reaches
   `approved`, that clause was unconditionally true for every business, silently overriding #4 and
   #5's legitimately-firing triggers every single time for any business type other than
   `marketplace`/`services` — which now have their own higher-priority trigger at #3 and so were
   accidentally shielded from ever hitting this bug. Replaced with a real, variable signal.)** Its
   own file's description still names `marketplace` as a load-bearing case from before round 3 —
   that is now superseded by #3 for seat-selection purposes; `business_type: marketplace` will
   always be intercepted by #3 unless #1 or #2 fires first, so this persona's marketplace-specific
   rigor, while still real and worth reading in its own right, will only be selected onto the
   panel via the Steps-10/11 content signal above or the true default case, not via the
   business-type match alone. This is a known, intentional consequence of adding #3, not an
   oversight — flagged here so a future
   editor of `competitive-strategy-reviewer.md` understands why its own description now overstates
   how often it's actually selected for a marketplace.)

`technical-feasibility-reviewer` and `regulated-industry-compliance-reviewer` are deliberately
**not** fallback defaults — most plans describe conventional, well-understood, unregulated builds
where these seats have little to add, so each only takes the seat when its own trigger actually
fires, exactly like #4/#5 below them.

### Why the compliance reviewer is checked first

Placing `regulated-industry-compliance-reviewer` at #1 — ahead of `technical-feasibility-reviewer`,
which held that position through round 3 — is a real priority change this round is making
deliberately, not a default earned by being newest, and it deserves the same rigor as the
tie-break rule below rather than being asserted in a bullet. Two independent reasons, either one
sufficient on its own:

1. **It reaches business types nothing else does on this question.** `technical-feasibility-
   reviewer` and the #3 tier are gated by `business_type` (or a hardware/deep-tech content signal
   layered on top of it). A regulated `saas` business (a HIPAA-scope patient-scheduling tool), a
   regulated `services` business (a bookkeeping firm that starts handling client payroll funds), or
   a regulated `marketplace` (a peer-to-peer lending platform) can each be a technically ordinary,
   conventional build — zero `technical-feasibility-reviewer` trigger — while still carrying a
   licensing/data-handling blind spot severe enough to block the business from operating at all.
   Before this round, nothing on the panel could reach that concern except the generic default.
2. **When it does overlap with a lower tier, its question is prior-in-kind.** For the one case
   where `regulated-industry-compliance-reviewer` and `technical-feasibility-reviewer` can both
   fire on the same business (a regulated hardware/deep-tech build — a medical device is the
   clearest case), "can this business legally operate this activity at all, at this scope" is a
   more fundamental gate than "is this specific engineering approach buildable" — a perfectly
   buildable device that can't obtain the clearance to sell is exactly as dead as an unbuildable
   one, and unlike `technical-feasibility-reviewer` (which explicitly punts the legal/compliance
   *substance* of a certification requirement to `agents/risk/privacy-compliance-officer.md` and,
   ultimately, real counsel — see that persona's own Step 7 rubric #4) and
   `agents/risk/privacy-compliance-officer.md` itself (which is not a review-council seat and
   doesn't produce a panel verdict), no seat on the panel evaluated the compliance-*awareness*
   substance before this round. That gap, not novelty, is why it outranks #2 rather than merely
   sitting alongside it.

This is a genuinely new kind of priority decision, not a mechanical extension of the existing
"business-type is more fundamental than a content pattern" reasoning used for tiers #3 vs. #4/#5 —
those tiers rank a holistic type signal above a narrower content signal; this ranks a narrower
content signal (regulated-industry) above both a wider content signal (#2) and a holistic type
signal (#3), specifically because #1's content signal identifies a *legal-operability* gate that
nothing else on the panel checks, not because content signals generally outrank type signals.

### Tie-break rule — precise, not vague

If more than one of #1-#5 triggers for the same review, **take the lowest-numbered one that
triggered**, full stop — this single rule resolves every case, including the ones the roadmap and
this round's own persona-coverage gap specifically called out:

- **A regulated `marketplace`, `services`, or `saas` business** (e.g., a peer-to-peer lending
  marketplace, a bookkeeping services firm handling client funds, a HIPAA-scope patient-scheduling
  SaaS tool) whose `business_type` would otherwise route it straight to #3 (or, for `saas`, to #5
  or the #6 default): #1 outranks every lower tier. Seat goes to
  `regulated-industry-compliance-reviewer`; whichever lower-tier persona would otherwise have been
  selected (`marketplace-liquidity-specialist`, `services-unit-economics-reviewer`, or nothing more
  specific than the default) is the logged runner-up. This is precisely the case the roadmap's
  round-4 brief called out by name — a regulated marketplace or regulated SaaS business still gets
  the compliance reviewer even though its `business_type` already triggers a different persona.
- **A regulated `physical_product` business with an independently-triggering hardware/deep-tech
  signal** (a medical device, the clearest case): #1 outranks #2. Seat goes to
  `regulated-industry-compliance-reviewer`; `technical-feasibility-reviewer` is the logged
  runner-up — see "Why the compliance reviewer is checked first" above for why the legal-
  operability question goes first here specifically.
- **A `marketplace` (or `services`) business with an independently-triggering technical-feasibility
  signal** (e.g., a marketplace with a real hardware/IoT/regulated-engineering component, or a
  services business betting on an unproven core technology, with no regulated-industry content
  signal present): #2 outranks #3. Seat goes to `technical-feasibility-reviewer`;
  `marketplace-liquidity-specialist` or `services-unit-economics-reviewer` (whichever matched) is
  the logged runner-up.
- **A `physical_product` business with an independently-triggering hardware/deep-tech signal but no
  regulated-industry content signal** (ordinary consumer electronics with a genuinely novel sensor,
  say): #2 outranks #3. Seat goes to `technical-feasibility-reviewer`;
  `hardware-physical-product-operator` is the logged runner-up — the two personas' lenses are
  distinct (engineering buildability vs. manufacturing/supply-chain operations) but only one seat
  exists, so the more consequential "can this be built at all" question wins per the reasoning at
  #2 above.
- **A `services` business whose Step 12 DMU also independently signals multi-stakeholder
  complexity** (e.g., an agency selling to enterprise clients with real procurement): #3 outranks
  #4. Seat goes to `services-unit-economics-reviewer`; `sales-motion-reviewer` is the logged
  runner-up. As noted at #4 above, this is in fact the outcome for *every* `services` business,
  not just an edge case, since `sales-motion-reviewer`'s own trigger includes the bare
  `business_type: services` match — the tie-break rule makes that resolution automatic and
  consistent rather than something each review has to re-decide.
- **A `marketplace` business whose Step 12 DMU independently signals complexity on one or both
  sides** (a B2B marketplace with real procurement on the demand side, say): #3 outranks #4 here
  too, for the same reason. This is a smaller loss than it looks — `marketplace-liquidity-
  specialist`'s own rubric already requires a per-side DMU check at Step 12 (see its file), so the
  DMU-complexity concern is not dropped entirely, just read through a liquidity lens rather than
  `sales-motion-reviewer`'s process-realism lens.
- **Every `physical_product` business whose Step 12 DMU or channel component would otherwise
  independently signal `sales-motion-reviewer`'s trigger** (added this round, parallel to the
  services case above): #3 outranks #4. Seat goes to `hardware-physical-product-operator`;
  `sales-motion-reviewer` is the logged runner-up — this is the outcome for *every*
  `physical_product` business, not an edge case, for the identical structural reason the services
  case is unconditional: `sales-motion-reviewer`'s own trigger includes the bare
  `business_type: physical_product`-with-channel match, and #3 is evaluated first.

In every case above, **note in the review file's rationale that the runner-up trigger(s) are
recommended for the *next* review cycle** rather than silently dropping the concern — this was
already this skill's convention before this round and applies unchanged to the personas added this
round. A single review can in principle have three or more triggers fire simultaneously (a
regulated hardware physical product can trip #1, #2, and #3 all at once) — the rule still resolves
mechanically to the single lowest-numbered winner, and every other triggering persona is logged as
a runner-up, plural, not just the immediate next-lowest one. Never exceed 5 seats total.

### Why 5 seats stays fixed rather than flexing to 6

Two contextual triggers firing independently and both being clearly warranted (the
technical-feasibility-vs-marketplace-liquidity case above, most concretely) is exactly the
scenario that might argue for a 6th seat. This skill does **not** add one, and holds the panel at
a fixed 5 (4 core + 1 contextual) deliberately: `CONVENTIONS.md` §6 defines a review council panel
as "3-5 distinct reviewer personas," and 5 is already the top of that explicitly stated range —
flexing to 6 would mean this skill silently exceeding a cap `CONVENTIONS.md` states as a hard
range, not a soft default, and `CONVENTIONS.md` is the one document every skill and agent in this
plugin writes against precisely so no single skill unilaterally reinterprets a shared constraint
in its own favor. Changing that range is a `CONVENTIONS.md` edit with plugin-wide consequences
(every other council-adjacent skill and doc that assumes "5 seats" would need re-checking) and is
explicitly out of this task's authorized scope, which permits editing `docs/DATA-CONTRACT.md` in
one narrow way and nothing else outside `agents/council/*` and this file. The tie-break rule above
is the mechanism that keeps the fixed-5 design honest under the new pressure: it never drops a
real concern silently, it demotes it to a named, logged runner-up that the founder and the next
review cycle can see and act on. A future round is free to revisit the 3-5 range itself in
`CONVENTIONS.md` directly, with the cross-file audit that deserves — this task deliberately does
not make that call by side effect.

**This round puts the fixed-5 design under a sharper version of the same pressure, and the answer
is unchanged.** `regulated-industry-compliance-reviewer`'s trigger is content-based rather than
`business_type`-based specifically *because* the roadmap's brief for this round raised the
question directly: should a regulated marketplace or regulated SaaS business get a 6th seat so the
compliance reviewer can run *alongside* the type-triggered persona, rather than competing with it
for the single contextual slot? The answer, decided here with the same rigor as the tie-break rule
above, is **no — it competes for the single contextual seat like every other trigger, it does not
flex the panel to 6.** Three reasons:

1. **Consistency with the round-3 precedent this task was explicitly pointed at.** Round 3 already
   confronted the identical shape of pressure (two independently-warranted contextual triggers on
   one review) and declined to flex, for the `CONVENTIONS.md`-range reasons above. Nothing about
   this round's specific pressure case is structurally different enough to justify a different
   answer — a regulated marketplace with two warranted contextual seats is the same category of
   problem as a hardware-feasibility marketplace with two warranted contextual seats, just with a
   different pair of personas. Treating one case as flex-worthy and the other as not would be an
   unprincipled, undocumented exception, not a reasoned distinction.
2. **The tie-break rule already has a clean answer, and it's not a silent loss.** Per the new
   tie-break entries above, `regulated-industry-compliance-reviewer` wins the seat and the
   type-triggered persona becomes a *named, logged runner-up* — visible to the founder in the
   review file's rationale and explicitly recommended for the next review cycle, per the
   standing convention every other tie-break case already follows. This is a real cost (the
   founder's very next review cycle, not this one, gets `marketplace-liquidity-specialist`'s or
   `services-unit-economics-reviewer`'s full rigor) but it is a bounded, visible one — not a
   concern that disappears.
3. **Flexing for content-triggered personas specifically would set a worse precedent than not
   flexing.** `regulated-industry-compliance-reviewer` is the first council persona whose trigger
   is explicitly content-based rather than tied to the `business_type` enum, and it will not be
   the last — future rounds are likely to add more (geography-specific, stage-specific personas
   are named directly in `docs/ROADMAP.md`'s v0.3 long tail). If a content-triggered persona gets
   to flex the panel to 6 by rule, every future content-triggered persona has the same claim, and
   the fixed-5 range stops being fixed in practice even though `CONVENTIONS.md` still states it on
   paper — exactly the "silently exceeding a cap" failure mode the original round-3 decision was
   written to prevent. Holding the line here, on the first content-triggered persona, is what
   keeps the precedent meaningful for the next one.

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
`[FINANCIAL-ARITHMETIC]` `[TECHNICAL-FEASIBILITY]` `[FALSE-PRECISION]` `[LIQUIDITY]`
`[DELIVERY-CAPACITY]` `[REGULATORY-RISK]` `[MANUFACTURING-RISK]`

`[FALSE-PRECISION]` is distinct from `[FINANCIAL-ARITHMETIC]` — use it for "this number claims
more precision than its method supports" (e.g. a TAM stated to the dollar from a rough bottom-up
estimate), and reserve `[FINANCIAL-ARITHMETIC]` for actual computation/formula errors. Conflating
the two under one tag would make the §6 overlap check treat an unrelated arithmetic mistake and a
precision complaint as corroborating each other, which could wrongly save a verdict from being
discarded as an outlier.

`[LIQUIDITY]` (added round 3, owned primarily by `marketplace-liquidity-specialist`) is for
two-sided cold-start sequencing and supply/demand-balance concerns specific to marketplaces —
one side under-courted relative to the other, a take-rate that charges the price-sensitive side
and threatens liquidity, a next-10 list that's real on one side but a wishlist on the other. It is
distinct from `[BUSINESS-MODEL]` (general archetype-fit issues not specific to two-sidedness) and
from `[MARKET-SIZE]`/`[FINANCIAL-ARITHMETIC]` (a marketplace TAM priced per-seat instead of
GMV × take-rate is a `[FINANCIAL-ARITHMETIC]` formula error, not a `[LIQUIDITY]` finding, even
though both can appear in the same review of the same plan).

`[DELIVERY-CAPACITY]` (added round 3, owned primarily by `services-unit-economics-reviewer`)
is for billable-hours/utilization ceilings and key-person/founder-dependency risk that caps how
fast a services (or any labor-delivered) business can actually grow — a growth curve that requires
more delivery hours than the stated team can provide, an uncapped retainer that quietly commits
unbounded hours, an MVBP that only pencils out because the founder's time is valued at zero. It is
distinct from `[UNIT-ECONOMICS]` (the LTV/COCA figures and ratio themselves) and from
`[SCALABILITY]` (broader product/market scalability questions not specific to labor-hours
capacity) — a services business can have a mathematically healthy LTV:COCA ratio and still be
`[DELIVERY-CAPACITY]`-flagged if delivering on that LTV requires hours nobody on the team actually
has.

`[REGULATORY-RISK]` (added this round, owned primarily by
`regulated-industry-compliance-reviewer`) is for the plan's own steps failing to show awareness of
a licensing, certification, or data-handling regime that its stated business model or product spec
implies — a health/fintech/regulated-vertical activity described with no named regime (HIPAA,
money-transmission/KYC/AML, an industry-specific license), or a revenue mechanism that itself
requires a license the plan doesn't mention. It is distinct from `[TECHNICAL-FEASIBILITY]` (which
flags *that* a certification/regulatory-engineering step exists and whether a build timeline
accounts for it, an engineering-sequencing question) and from `[MANUFACTURING-RISK]` below (a
physical product's certification *cost and lead time* being unbudgeted is `[MANUFACTURING-RISK]`;
the underlying licensing/regulatory-awareness gap for a regulated activity or regulated data type
is `[REGULATORY-RISK]`, even when both show up on the same certification requirement) — and it is
never itself a legal-clearance signal: an `APPROVE` tagged `[REGULATORY-RISK]`-free means the plan
shows awareness, not that a lawyer has confirmed compliance (see the persona's own file for the
full boundary with `agents/risk/privacy-compliance-officer.md`).

`[MANUFACTURING-RISK]` (added this round, owned primarily by
`hardware-physical-product-operator`) is for manufacturing lead times, tooling/certification cost
and timeline, supply-chain single points of failure, and the gap between a validated prototype and
a validated-at-production-volume product — a COGS or per-unit-cost figure that's really a
prototype/small-batch number presented as production-ready, a certification named with no
cost/timeline attached, an unaddressed single-supplier dependency, or an MVBP production quantity/
lead time that doesn't match a real minimum order quantity. It is distinct from
`[TECHNICAL-FEASIBILITY]` (whether the underlying hardware mechanism or engineering approach is a
solved problem at all — a technically simple, conventional physical product can still be
`[MANUFACTURING-RISK]`-flagged on operational grounds) and from `[UNIT-ECONOMICS]`/
`[FINANCIAL-ARITHMETIC]` (a production-scale COGS figure being the *wrong kind* of number for what
it's proving is `[MANUFACTURING-RISK]`; an actual multiplication/formula error in the same figure
is `[FINANCIAL-ARITHMETIC]`, and both tags can legitimately appear together when they coincide).

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

Fix the **comparison set** before you test anything: it is the blocking set exactly as it stood
after Step A (all 5 seats for Track B/C, or the 4 non-downgraded seats for Track A) — call this
the **original blocking set**. Every tag-overlap check below, on every discard round including
the first, is run against the original blocking set minus the verdict being tested — never
against whatever subset happens to remain after earlier discards. This matters from round two
onward: a verdict already discarded is still "in the room" for the purpose of checking whether a
*later* candidate's tags overlap with it.

A verdict at the current-harshest severity (among whatever verdicts still remain under
consideration) is a **discardable outlier** if and only if:

1. **It is alone at that severity** — no other verdict still under consideration shares the same
   severity level. (Two or more reviewers independently landing on the same harsh verdict — e.g.
   two REJECTs — is never an outlier situation for either of them, regardless of tag overlap; real
   convergence from independent reviewers is corroboration, not noise.)
2. **None of its Risks/gaps or Required-revisions tags appear in any *other* original-blocking-set
   reviewer's Risks/gaps or Required-revisions** (check every other reviewer's tags — including
   already-discarded reviewers, per the fixed comparison set above — not just reviewers who share
   its verdict level; a reviewer who APPROVE_WITH_NOTES'd but flagged the same tag as a lone
   REJECT is corroboration that concern is real, even though their overall verdict was softer). If
   there is *any* tag overlap with *any* other reviewer in the original blocking set, the verdict
   is **not** discardable — a credible concern shared across personas blocks, full stop, per
   CONVENTIONS.md §6's "one credible blocking objection should block, not get diluted."
   **This tag check is mechanical but not sufficient on its own — also read the actual prose of
   every other reviewer's Risks/gaps for substantive overlap even under a *different* tag.** Two
   personas can converge on the same real underlying concern through legitimately distinct rubric
   lenses and tag it differently (e.g. `expert-entrepreneur-panel` tagging a hiring plan's missing
   sourcing channel `[EXECUTION-RISK]` while `services-unit-economics-reviewer` tags the same
   underlying "can this scaling plan actually work" concern `[DELIVERY-CAPACITY]` from its own
   angle) — confirmed as a real, demonstrated case in round 4's live dry run, where the literal tag
   check alone let a substantively-corroborated REVISE get discarded. If you judge two reviewers'
   prose describes the same underlying finding despite different tags, treat it as corroboration
   (not discardable) the same as a literal tag match — and if you're genuinely unsure whether the
   overlap is substantive or coincidental, resolve in favor of not discarding (a false "kept"
   costs a slightly less concentrated aggregate; a false "discarded" can silently drop a real,
   corroborated concern from the gate). Either way, name the specific cross-reference explicitly in
   the review file's aggregation accounting — don't just note "tag overlap: none" when a semantic
   read says otherwise.
3. **Discarding it would leave at least one verdict still under consideration.** Never discard the
   last verdict standing. This floor case is rare but real: it can only arise in Track A, where
   the blocking set has 4 seats (not 5) and 4 severity levels exist, so it is mathematically
   possible for every seat to land alone at a distinct severity with zero tag overlap between any
   pair — a cascade that would otherwise empty the blocking set and leave no defined aggregate. If
   the verdict under test is the sole remaining verdict, it is not discardable regardless of tests
   1-2, and it stands as the aggregate — state in the review file that the floor rule was invoked,
   since it means a lone, uncorroborated verdict became the aggregate and the founder should know
   that context.

If a verdict passes all three tests, discard it from consideration and recompute the harshest
severity among what remains (repeat Step B/C — a second, third, or later lone dissenter can also
be tested and discarded independently, always against the fixed original blocking set per above).
If it fails any test, it is **not** discarded — the current harshest severity stands as the
aggregate.

**Step D — the aggregate verdict is the harshest severity remaining after all applicable
discards.** The **aggregate score** is the lowest (harshest) score among the blocking-set
reviewers whose verdict is at that final aggregate severity — never an average.

**Worked example.** Five blocking-set verdicts: REJECT (`vc-panel`, tags `[VENTURE-FIT]` only —
but this is Track B, so it's in the blocking set), REVISE (`customer-discovery-skeptic`, tags
`[EVIDENCE-GAP]`), APPROVE_WITH_NOTES (`expert-entrepreneur-panel`, tags `[EXECUTION-RISK]`),
APPROVE_WITH_NOTES (`financial-modeling-reviewer`, tags `[UNIT-ECONOMICS]`), APPROVE
(`competitive-strategy-reviewer`, no risk tags). Harshest is REJECT, held alone by `vc-panel`.
Check tag overlap: `[VENTURE-FIT]` does not appear in any other reviewer's tags, and discarding it
leaves four verdicts standing → passes all three outlier tests → discard. Recompute: harshest
remaining is REVISE, held alone by `customer-discovery-skeptic`. Check tag overlap:
`[EVIDENCE-GAP]` does not appear elsewhere either, and discarding it leaves three verdicts
standing → discard. Recompute: harshest remaining is APPROVE_WITH_NOTES, held by two reviewers (not alone)
→ stops here. **Aggregate verdict: APPROVE_WITH_NOTES**, score = the lower of the two
APPROVE_WITH_NOTES scores. Contrast: if `financial-modeling-reviewer` had *also* tagged a bullet
`[EVIDENCE-GAP]` (e.g., flagging that a TAM input traces to the same unvalidated customer claim
`customer-discovery-skeptic` flagged), the REVISE would **not** be discardable — it would stand as
the aggregate, because two independent reviewers converged on the same underlying concern.

**Floor-rule example (Track A only).** Four blocking-set verdicts (Track A, `vc-panel` already
set aside per §4), each alone at a distinct severity with zero tag overlap between any pair:
REJECT (`customer-discovery-skeptic`, `[EVIDENCE-GAP]`), REVISE
(`financial-modeling-reviewer`, `[FINANCIAL-ARITHMETIC]`), APPROVE_WITH_NOTES
(`expert-entrepreneur-panel`, `[EXECUTION-RISK]`), APPROVE (contextual seat, no tags). REJECT is
alone, has no tag overlap, and discarding it leaves three verdicts → discard. REVISE is alone, no
overlap, discarding it leaves two → discard. APPROVE_WITH_NOTES is alone, no overlap, but
discarding it would leave only APPROVE standing — still one verdict, not zero, so it still passes
test 3 → discard. Recompute: only APPROVE remains. It is trivially alone, and by test 3 discarding
it would leave the blocking set empty — so the floor rule stops the cascade here regardless of
tag overlap. **Aggregate verdict: APPROVE**, and the review file must state plainly that this is a
lone, uncorroborated verdict reached only because the floor rule blocked further discarding, so
the founder reads it with that context rather than as unanimous agreement.

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
   and a synthesized checklist — the union of every required-revision item from every reviewer
   whose verdict counted toward the aggregate severity, deduplicated by tag+substance, not just the
   single harshest reviewer's list, so the founder gets one actionable checklist).
   **When the aggregate verdict is `REVISE` or `REJECT`**, that checklist is headed
   `### Required revisions`, per CONVENTIONS.md §6's schema (which only defines a Required
   revisions section for those two verdicts).
   **When the aggregate verdict is `APPROVE` or `APPROVE_WITH_NOTES`, there is no Required
   revisions content to union — per §6's own schema, an APPROVE/APPROVE_WITH_NOTES verdict has no
   Required-revisions section at all, so every reviewer at that severity contributes zero items by
   construction.** In that case, head the checklist `### Notes to consider` instead, and build it
   from the union of the surviving reviewers' Risks/gaps bullets (deduplicated the same way) —
   this is real, actionable information the founder should still see, just not phrased as a
   blocking requirement. Do not reuse the `Required revisions` heading over this content, and do
   not leave the section blank or improvise a different resolution per review — this exact branch
   is the specified behavior, confirmed necessary by a real APPROVE_WITH_NOTES aggregate in round
   4's live dry run (the case neither round 2's REVISE aggregate nor round 3's REJECT aggregate
   exercised).
   **Immediately under that checklist, add a `### Discarded-but-real concerns` subsection** if
   §6 discarded any verdict as an outlier — one line per discarded reviewer: persona name,
   severity, and a one-sentence summary of their sharpest point (not their full required-revisions
   list — that would defeat the point of the outlier rule, which exists precisely so one
   uncorroborated verdict doesn't dictate the aggregate). Nothing in this skill's design hides a
   verdict (every individual verdict is written in full per item 2 above), but a busy founder is
   realistically going to treat the synthesized checklist in this section as *the* action list —
   don't let a discarded reviewer's sharpest finding, which may be the single most consequential
   point on the whole panel, be findable only by reading past the checklist into the full verdict
   blocks above. Omit this subsection entirely if nothing was discarded — don't write "none" for
   every review, that's noise.
   **A related, distinct case (round 3 fix): a verdict can *survive* the outlier test — it wasn't
   discarded, it's sitting right there in the panel — while still landing at a severity softer
   than the aggregate, purely because its corroboration came from a lower-severity reviewer's tag
   overlap. In that case its required-revisions items still don't make the synthesized checklist
   (the literal rule above only unions items from reviewers *at* the final aggregate severity),
   even though the finding itself might be the single most consequential one on the whole panel —
   this was confirmed to happen for real, not just hypothetically, in round 3's second live dry
   run (a marketplace disintermediation-risk finding at APPROVE_WITH_NOTES, aggregate REJECT).
   After the Required Revisions checklist and any Discarded-but-real-concerns subsection, add one
   more, severity-independent check: does any surviving verdict contain a finding you'd judge as
   the single most consequential one on the panel, regardless of its own severity level? If so,
   add a one-line `### Also flagging, regardless of severity` note: "<finding>, raised by
   <persona> — not part of the aggregate-severity checklist above, but worth the founder's
   attention on its own merits." This is a judgment call, not a mechanical trigger like the
   discarded-outlier case — use it sparingly, for a genuinely load-bearing finding, not every
   review. Omit entirely when nothing meets that bar.**
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
  it becomes `true` once the founder has seen an APPROVE/APPROVE_WITH_NOTES verdict's notes, once
  `skills/business-plan/revise-business-plan` closes the loop for REVISE/REJECT via a clean
  re-review, **or once the orchestrator itself executes a founder override on this review per
  Non-negotiable #3** — confirmed live in round 7 as a real, distinct third path: an override is a
  fully equivalent way of satisfying the gate (Non-negotiable #3 frames revision-to-clean-verdict
  and founder-override as parallel options, not a primary path with the override as an unresolved
  exception), so `resolved` becomes `true` at the moment of override, not left `false` forever —
  nothing further is coming on that specific review. Setting it is the orchestrator's job on the
  read side, not this skill's — don't set it `true` yourself even for a clean APPROVE, so the
  founder-facing acknowledgment step never gets silently skipped.
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
