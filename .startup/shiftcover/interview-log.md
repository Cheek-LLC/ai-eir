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
