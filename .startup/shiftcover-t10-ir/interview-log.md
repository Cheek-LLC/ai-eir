# Interview Log — ShiftCover

## 2026-08-18 — Onboarding Interview

**Opening framing given:** explained "30-Minute Startup" is the product's hook, not a time
estimate; a rigorous 24-step plan is real back-and-forth across one or more sessions. Founder
acknowledged.

**Business name:** ShiftCover (confirmed, not a working title).

**Founder:** Maria Chen. Declined to give an email for now ("don't need it yet"). Ten years in
multi-unit restaurant operations, most recently Director of Operations for a 42-unit QSR
franchise group (chicken-sandwich concept, unnamed by request) in the Texas Triangle.

**One-liner — first pass (vague):** "We help restaurants manage their staff better."
- Pushback applied (platitude playbook — closest match: "everyone is my customer" pattern,
  since "restaurants" and "manage staff better" are both too broad to be a real answer):
  "If you could only sell to one specific type of restaurant operator for the next six months,
  who would it be — and what specifically about staffing is broken for them, not staffing in
  general?"
- **Second pass (accepted):** "Software that lets a multi-location restaurant's shift manager
  automatically text the right qualified backup workers the moment someone calls out sick, so
  the shift gets covered in minutes instead of the manager working down a phone list for 45
  minutes while the line backs up." Names a real customer type (multi-location restaurant shift
  manager) and a real problem (manual call-out coverage). Recorded as `business_basics.one_liner`.

**Venture stage:** `idea_only`. No product built. Maria has had 14 informal conversations with
peers (ops directors, GMs) at other franchise groups since leaving her operating role three
months ago, but no pilot, no code, no paying customer.

**Business type:** SaaS — confirmed directly. Differentiator follow-ups:
- Self-serve or sales-led? Hybrid: a single-location GM could self-serve a trial, but real
  revenue is sales-assisted contracts signed at the multi-unit franchise-group level (the
  Director of Ops signs, not the individual GM).
- Buyer vs. day-to-day user: different people. Director of Operations (or Owner/Operator for
  smaller groups) is the economic buyer; the shift manager/GM at each location is the day-to-day
  user.
- Hard constraints known already: must integrate with whatever scheduling system the group
  already uses (named 7shifts and HotSchedules as the two most common in her network) — text
  message delivery (SMS) is a hard requirement, not push notification, because the backup-worker
  pool skews toward workers without the employer's scheduling app installed on a personal phone.

Recorded `business_basics.business_type: "saas"`, with the hybrid buyer/user and integration
detail written into `business_basics.business_type_notes`.

**Vague-answer moments during the rest of onboarding:**
- Asked about competitors: first answer was "there's nothing really like this out there."
  Pushback applied ("no competitors" pattern): "What does a shift manager do today, right now,
  without your product, when someone calls out?" Real answer: "They open the group text thread
  or call down a paper list, in order of seniority, until someone says yes — that's the actual
  status quo alternative, not a named competitor product." Logged as the real Step 8/11 baseline,
  not treated as "no competitors."

**Genuine unknown flagged (not a dodge):** Maria does not yet know whether backup workers would
tolerate being on more than one location's on-call list simultaneously (a cross-location backup
pool is central to the product concept). Confirmed with her directly this is a real unknown, not
something she has a rough sense of. Logged as a `key_assumptions` entry rather than guessed:

```json
{
  "id": "ka-onboarding-cross-location-pool",
  "statement": "Assumes hourly backup workers are willing to be on a shared on-call list across multiple nearby locations (even different franchise owners) rather than just their home location.",
  "step_ref": "onboarding",
  "confidence": "low",
  "test_plan": "Ask this directly in the next 10 backup-worker conversations (feeds Step 9); if resistance is high, the beachhead may need to narrow to single-owner multi-location groups only, not cross-owner pools.",
  "test_result": null
}
```

Told Maria plainly: "I'm logging that as an open assumption, not guessing an answer — it's a
real fork in how big this product's addressable pool of backup labor actually is."

**Closing summary read back and confirmed:** ShiftCover — B2B SaaS, multi-location restaurant
staffing/shift-coverage automation, idea stage, hybrid self-serve/sales-led with a
buyer/user split. Maria confirmed accurate.

**What's next:** Told Maria the 24 DE steps start with market segmentation. She elected to keep
going in the same session rather than stopping here (moving briskly — checkpoints at the end of
each step, not full interactive dwell time on every question, per her explicit signal).

**Handoff:** control passes to the orchestrator to begin Step 1 (01-market-segmentation).

## 2026-08-25 — Revision Follow-up (round-trip on council's REVISE verdict)

**Context:** `reviews/2026-08-18-balanced-panel-v1.md` returned aggregate **REVISE** with 5
required revisions ([VENTURE-FIT], [SCALABILITY], [EXECUTION-RISK], [DMU-COMPLEXITY],
[SALES-CYCLE]). Read the full list back to Maria and asked what she could realistically do about
each one before the plan goes back to the council. Her answer, plainly: "some of this I can do
this week, some of it just takes real weeks I don't have yet — I'm not going to pretend I ran a
funnel that hasn't run."

**1. [VENTURE-FIT] — funding-intent statement (first explicit signal logged).** Read her the
`vc-panel` framing verbatim (sized for a $10-30M/year outcome, not a fund-returner). Her response,
quoted directly: *"I'm not trying to raise a venture round on this — if it works I want to run it
as a real, profitable business, and I'd rather it be a $15-20M/year business I own 100% of than
chase something bigger I don't."* This is the first time funding intent has come up explicitly in
any logged conversation — `business_basics.funding_intent` was `undecided` through onboarding and
the v1 review. **Noting for the orchestrator/next `recurring-check-in`:** this statement should be
captured into `business_basics.funding_intent` (bootstrap) by its proper owner
(`skills/interview/onboarding-interview` / `skills/interview/recurring-check-in` per the Data
Contract) — `revise-business-plan` does not own that field and is not writing to it directly, even
though it's using the statement to reframe the plan's venture-fit narrative this cycle.

**2. [SCALABILITY] — cold-outbound test.** Maria sourced a public regional franchise-association
member directory and sent 20 cold LinkedIn/email messages to Directors of Operations and
Owner-Operators **outside** her existing network, over 2026-08-19 through 2026-08-24. Result: 3
replies (15%), 1 scheduled intro call for next week, 0 further progress, 0 declines. Logged as a
real, small, honestly-labeled data point (see Step 19 update) — not used to recompute COCA.

**3. [EXECUTION-RISK] — engineering resourcing decision.** Got quotes from 2 contractors
(~$18k-$24k, 6-8 weeks). Decided to attempt a no-code build herself (Twilio Studio + Retool) with
a hard 2-week checkpoint, falling back to a contractor if no working demo by then. See Step 24
update.

**4. [DMU-COMPLEXITY] — franchisor confirmation calls.** Called 3 of the 7 Step 9 prospects (Alex
Torres/Copperline, Priya Nair/Nair Hospitality, Derek Osei/RiverBend) directly. 2 of 3: no
franchisor veto. 1 of 3 (RiverBend): a real but non-fatal franchisor security-attestation review
(2-3 weeks). See Step 12/13 updates. Explicitly a partial result — 4 of 7 prospects still
unconfirmed.

**5. [SALES-CYCLE] — NOT resolved this cycle, and said so plainly.** Only 2 of 7 prospects have
reached Stage 2 (Alex Torres — first conversation held; Priya Nair — scheduled). The council asked
for 5+ prospects through the first two stages before Step 18's funnel is recomputed. Maria: "I'm
not going to make up a funnel from two calls to make the review look done." Carried forward as
open — see Step 18 update and `plan.history`/the triggering review's `resolved` field.

**Handoff:** control passes back to `skills/business-plan/revise-business-plan` to re-synthesize
`plan/business-plan-v2.md` from the above, run the AI-risk gate, and hand off to
`skills/business-plan/run-review-council` for re-review.

## 2026-08-27 — Founder Override Session (rev-shiftcover-002, aggregate REJECT)

**Session bootstrap.** Resumed with `stage: "revising"`. Per `agents/orchestrator.md`'s bootstrap
step 2, since `stage` is past `"interview"` and this isn't a command that already owns the
reconciliation conversation, ran a short `skills/interview/recurring-check-in`-style check before
substantive work: nothing new in the real world since 2026-08-25 to reconcile except one item
already flagged and pending capture — `reviews/2026-08-25-bootstrap-track-panel-v1.md` §1 noted
Maria's 2026-08-25 funding statement ("I'd rather it be a $15-20M/year business I own 100% of than
chase something bigger I don't") had never been written into the canonical
`business_basics.funding_intent` field, only inferred provisionally by the review itself. Confirmed
with Maria this is still her position — yes. Captured: `business_basics.funding_intent: "bootstrap"`.
This is a real, on-record founder statement being formally captured by its rightful owner
(recurring-check-in → orchestrator), not a step-skill inference — see `business-state.json`.

**The REJECT verdict, read back plainly.** Told Maria the aggregate verdict on
`plan/business-plan-v2.md` is **REJECT** (score 4), the same aggregate severity as v1's REVISE
round — but this time from `customer-discovery-skeptic` alone, held up specifically because
`sales-motion-reviewer`'s independent `[SALES-CYCLE]` finding corroborated it (per the review's own
aggregation accounting: without that corroboration, 3 of 5 seats landed at `APPROVE_WITH_NOTES` and
this would likely have cleared). Read her the three required revisions verbatim:

1. [PERSONA-VALIDITY] 7+ more real GM/shift-manager conversations before Step 3's profile is more
   than a hypothesis — carried forward unchanged from v1, not addressed this cycle.
2. [EVIDENCE-GAP] Get Step 9's prospects to an actual stated signal of interest (scheduled pricing
   conversation, stated "yes, interested," or declined-with-reason) before the list is used to
   justify anything downstream — carried forward; 2 of 7 have real motion, which the reviewer is
   explicit does not yet meet the bar.
3. [SOURCING] An independently checkable source for the 3,000-group beachhead count — carried
   forward unchanged, not addressed.

Also surfaced, by name and separately from the required-revisions list per the review file's own
"Also flagging, regardless of severity" section: `sales-motion-reviewer`'s `[SALES-CYCLE]` finding
(only 2 of 7 prospects have reached Stage 2 vs. the council's 5+ bar) — told Maria plainly this is
the single piece of evidence keeping the REJECT from being discarded as an outlier, not a secondary
note, and that three other seats (`vc-panel`, `financial-modeling-reviewer`,
`expert-entrepreneur-panel`) independently confirmed her prior revision work on their own required
items.

**Maria's response, real, not a shrug.** Quoted directly:

> "I've now been through this twice. The first time I did real work between rounds — cold outreach,
> franchisor calls, a build decision — and I'd do that again if I thought two more weeks would
> actually move these three items. But I don't think it would, not honestly. Item 2 is the one I
> actually disagree with, not just find inconvenient: the panel wants a *stated* signal of interest
> before I build anything, but every one of these prospects is telling me, politely, 'call me back
> when there's something to look at.' I don't think I can get a real yes/no out of a Director of
> Ops on a product that doesn't exist yet — that's not evidence I'm avoiding, it's a chicken-and-egg
> problem the review doesn't weight. Items 1 and 3 I actually agree are real gaps — I haven't talked
> to enough GMs, and I don't have a real source for the group count — I'm just not going to let them
> block this. And the sales-cycle one you just told me about separately — that one I take dead
> seriously, more than the others honestly, because it's not a disagreement, it's just true: 2 of 7
> isn't 5 of 7, and I don't have a funnel yet. I'm not going to pretend otherwise.
>
> I left a paying job three months ago for this. I have runway for a few more months, not for an
> indefinite string of review cycles before I'm allowed to talk to a real customer with a real demo.
> I want to move into building the MVBP and running it as a real pilot with Alex at Copperline —
> the one relationship in Step 9 I trust the most — rather than spend another two or three weeks
> proving things in the abstract that a pilot would prove for real, faster. I understand this means
> the plan does not have a real customer signal yet, does not have a validated end-user sample beyond
> 3 GMs, does not have a sourced TAM, and does not have a real sales funnel — those are all still
> genuinely open, I'm not fixing them, I'm choosing to carry them forward as accepted risk instead."

**Explicit override, on record.** Asked Maria directly, per `agents/orchestrator.md` Non-negotiable
#3: "I need you to say the actual words — do you want to override this REJECT and proceed, knowing
and naming these four specific risks: the end-user evidence gap, the missing Step-9 interest signal,
the unsourced beachhead count, and the sales-cycle-funnel finding sales-motion-reviewer raised?" Her
answer: **"Yes. Override it. I'm naming all four and I'm accepting all four."**

**What got logged, per Non-negotiable #3 exactly.** Four `risk_log` entries appended to
`business-state.json`, each `raised_by: "startup-operator (founder override)"`,
`status: "accepted"`, naming the specific risk and Maria's stated reason (see `ov-shiftcover-001`
through `ov-shiftcover-004`). `reviews/2026-08-25-bootstrap-track-panel-v1.md` marked
noted-but-overridden inline against each affected item (not deleted — the full verdict, every
persona's reasoning, and the original required-revisions list are all still there verbatim) plus a
new "Founder Override" section at the top of the file. See `docs/QA-FINDINGS-OVERRIDE-ROUND7.md`
finding #2 for a real ambiguity I hit and had to resolve by judgment call: neither
`agents/orchestrator.md`'s state-machine diagram nor `run-review-council/SKILL.md` §9 says
precisely what happens to `stage` or `reviews[].resolved` on this specific path (override, as
opposed to "revisions addressed and re-reviewed") — I resolved both, stated my reasoning, and moved
on rather than leaving Maria waiting on an internal documentation gap.

**Resulting state.** `stage: "approved"` (not another `"revising"` cycle — the whole point of an
override is that it substitutes for a clean re-pass, not that it triggers one). Told Maria plainly
this is *not* the same thing as a clean `APPROVE` — the plan is proceeding with four named, accepted
risks on the record, and every future session touching ShiftCover will say so up front, not just
this one.

**Go/no-go on GTM.** Per Phase 4's closing instruction, asked whether she wants to proceed to
go-to-market now or pause at `approved`. She said now — consistent with the time-pressure reasoning
above. Ran `agents/gtm/launch-director.md`'s Gate check (its own precondition logic) against the
current state as the first real step of that handoff, **not** the full sequencing pass (drafting
`gtm/launch-plan.md` requires `marketing-strategist`/`sales-lead` to actually run, which is real
specialist work out of scope for this session — flagged to Maria explicitly rather than faked).
Confirmed `stage: "approved"` passes the gate, and — because I patched `launch-director.md`'s Gate
section this session (see QA findings #3) to check the most recent `reviews[]` verdict, not just the
`stage` value — it correctly identified that the most recent review (`rev-shiftcover-002`) was
`REJECT`, not a clean pass, and it produced the required flag: *"This business reached `approved` via
a logged founder override on a REJECT verdict (`reviews/2026-08-25-bootstrap-track-panel-v1.md`,
overridden 2026-08-27) — four named risks are carried as `accepted`, not resolved. State this
plainly in `gtm/launch-plan.md`'s risk section and to the founder before any further GTM work."*
Confirmed, out loud, to Maria: this flag will repeat, unprompted, in every subsequent interaction on
this business until the underlying risks are actually retired, not just accepted. `gtm.status`
remains `"not_started"` — genuine launch-director sequencing (marketing-strategist, sales-lead,
`gtm/launch-plan.md`) is next session's real work, not simulated here.

Also captured this session, since it's the funding-strategy determination step launch-director's
gate work performs before delegating (three concordant signals: plan prose, `founder.notes`, and now
`business_basics.funding_intent`): `gtm.funding_strategy: "bootstrap"`.

**Cadence.** Asked again per the standing rule at the end of every session. Maria: still `manual` —
"I'll run `/business-status shiftcover` myself when I'm ready for the next round, I don't want a
timer pushing me." Reminded her explicitly (last thing said this session, not buried) that means no
automatic check-in will happen — she has to trigger it herself. `cadence.scheduling_mechanism`
remains `"manual-reminder"`.

**Handoff:** control passes back to the orchestrator's ordinary resume flow. Next real action:
`agents/gtm/launch-director.md`'s full sequencing pass (funding strategy already determined above;
still needs `marketing-strategist` → `sales-lead` delegation and `skills/gtm/launch-plan` to produce
a real `gtm/launch-plan.md` that states the override context in its risk section, per the patched
gate check above) — not run this session.
