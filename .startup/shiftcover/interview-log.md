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
