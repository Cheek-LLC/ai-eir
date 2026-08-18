# Interview Log — SkyClaim

## 2026-08-18 — Onboarding Interview

**Opening framing given:** explained "30-Minute Startup" is the product's hook, not a time
estimate; a rigorous 24-step plan is real back-and-forth across one or more sessions, and some
steps (market sizing, unit economics) take real thought or research between sessions. Founder
acknowledged and said he'd rather do it right than fast.

**Business name:** SkyClaim (confirmed, not a working title — Derek had been using it informally
for the pivot already).

**Founder:** Derek Osei. Declined to give an email for now ("let's get further before you have a
way to spam me"). Eight years running Osei Aerial, a single-operator regional drone-services
company doing FAA Part 107 aerial inspection work, most recently concentrated on post-hailstorm
roof inspections for insurance claims across the Texas/Oklahoma "Hail Alley" corridor.

**One-liner — first pass (vague):** "We help people get drone inspections done."
- Pushback applied (platitude playbook — closest match: "everyone is my customer," since
  "people" and "drone inspections" name neither a real customer nor a specific problem):
  "If you could only sell to one specific type of customer for the next six months, who would it
  be — and what specifically breaks for them today, not drone inspections in general?"
- **Second pass (accepted):** "A booking marketplace that lets roofing contractors doing
  storm-damage insurance claims summon a vetted, FAA Part 107-certified drone pilot within a
  30-mile radius to fly and deliver an insurance-ready roof inspection report within 24 hours of
  a hailstorm, instead of scrambling their own crew or waiting days for a scheduling gap." Names
  a real customer (storm-damage roofing contractors) and a real, time-boxed problem (surge demand
  for inspection capacity right after a hailstorm). Recorded as `business_basics.one_liner`.

**Venture stage:** `pivoting`. Follow-up asked per the skill ("what's changing and why"): Derek's
existing business, Osei Aerial, is a single-operator drone-services shop — he personally flies
every job. He's pivoting that into a two-sided marketplace because he keeps turning away
inspection requests during storm surges (he's one person, storms create 10-50x demand spikes
across a metro overnight) while he personally knows a dozen other certified pilots sitting idle
between jobs. The pivot is: stop being the pilot, start being the marketplace that connects
roofing contractors to a pool of vetted pilots.

**Funding intent:** Asked directly, light touch. Derek: "I want to raise a seed round — I've
already run this as a real (if small) business for years and I think the pivot needs capital to
build the booking/dispatch software and to get liquidity in a second metro before a well-funded
competitor beats me to it." Mapped to `business_basics.funding_intent: "raising_outside_capital"`
— a clear, founder-stated signal, not a guess.

## Mandatory privacy notice (Mode A)

Checked `business-state.json.risk_log` first — no existing `privacy-onboarding-skyclaim` entry
(first time this business has been onboarded). Invoked `skills/risk/privacy-check` in Mode A,
passing only the business slug, immediately after the funding-intent question and before the
business-type framing questions began. Delivered the fixed notice: everything captured this
session is written to `.startup/skyclaim/` only; nothing leaves that directory without an
explicit connector action, which itself goes through the same gate (Mode B) first; this plugin
produces business-planning content, not legal advice — entity formation, insurance-industry
compliance, and contractor-classification questions (relevant here, since SkyClaim's pilots are
independent contractors) are real legal questions a real professional resolves, not this plugin;
and asked Derek plainly not to paste real customers'/prospects' sensitive personal data into
planning answers. Delegated to `agents/risk/privacy-compliance-officer.md` to confirm notice
content against `docs/PRIVACY-AND-DATA-HANDLING.md` and log it. Logged to `risk_log`:

```json
{
  "id": "privacy-onboarding-skyclaim",
  "type": "privacy",
  "raised_by": "privacy-check (onboarding)",
  "description": "Onboarding privacy/data-handling and legal-scope notice given to founder on 2026-08-18.",
  "status": "accepted"
}
```

Confirmed to Derek this is a one-time notice, logged so it never re-runs for this business.

**Business type:** Marketplace — confirmed directly, no ambiguity (Derek used the word himself
before being offered the taxonomy). Differentiator follow-ups:
- Which side is he seeding first, and why? Supply (pilots) — he already personally knows ~12
  Part 107-certified pilots in the Dallas–Fort Worth metro from industry meetups and a
  drone-operator Facebook group; he has zero named roofing-contractor demand relationships beyond
  his own existing 6 direct clients (who currently hire *him*, not the marketplace).
- What does a transaction actually look like? A booking: a roofing contractor posts a job (address
  radius, property count, deadline — usually "within 24-48 hours of a specific storm date"), the
  system (manually, today) matches it to an available nearby pilot, the pilot flies and uploads
  the imagery/report, the contractor pays a flat per-property fee, SkyClaim takes a cut.
- Take rate or fee structure? Derek's initial instinct is a commission on the pilot's payout
  (not a subscription from either side) because contractors already think in per-job costs and
  pilots are used to being paid per flight, not paying a listing fee — flagged as not yet decided
  with confidence, carried into Step 15.

**Vague-answer moments during the rest of onboarding:**
- Asked about competitors: first answer was "nobody's really doing this for storm claims
  specifically." Pushback applied ("no competitors" pattern): "What does a roofing contractor do
  today, right now, without your product, when a hailstorm hits and they need 40 roofs inspected
  in a week?" Real answer: "Either they send their own crew up on ladders one at a time — slow,
  and dangerous on steep/wet roofs — or, if they're big enough, they keep one drone pilot on
  staff who becomes the bottleneck the moment two storms hit different parts of the state in the
  same week. A few contractors use general-purpose drone marketplaces (DroneBase-style gig
  platforms) but Derek says those are built for real-estate/media shoots, not storm-claim
  documentation speed or insurance-report formatting, and pilots on those platforms aren't
  vetted for roof-specific flying (steep pitch, close-proximity obstacle avoidance)." Logged as
  the real Step 8/11 baseline, not treated as "no competitors."

**Genuine unknown flagged (not a dodge):** Derek does not yet know whether the pilots in his
network would tolerate being dispatched to jobs for *multiple* different roofing contractors
through a shared marketplace pool (versus each pilot having their own direct client
relationships, which is how the industry mostly works today) — and specifically whether they'd
accept surge-based job assignment (i.e., getting bumped to a farther-away or lower-priority job
during a storm surge) rather than first-come-first-served. Confirmed with him directly this is a
real unknown, not something he has a rough sense of. Logged as a `key_assumptions` entry rather
than guessed:

```json
{
  "id": "ka-onboarding-pilot-pool-tolerance",
  "statement": "Assumes Part 107 drone pilots are willing to accept marketplace-dispatched jobs from multiple different roofing-contractor clients (rather than maintaining their own direct client relationships) and will accept surge-based job routing/prioritization rather than first-come-first-served.",
  "step_ref": "onboarding",
  "confidence": "low",
  "test_plan": "Ask this directly in conversations with the 12 pilots in Derek's existing network (feeds Step 9's supply-side prospect list); if resistance is high, the marketplace may need a different dispatch model (pilot-choice bidding instead of platform-assigned routing).",
  "test_result": null
}
```

Told Derek plainly: "I'm logging that as an open assumption, not guessing an answer — it's a
real fork in whether the dispatch/matching mechanic you're picturing actually works the way
pilots will tolerate."

**Closing summary read back and confirmed:** SkyClaim — two-sided marketplace connecting FAA
Part 107-certified drone pilots (supply) with storm-damage insurance-claim roofing contractors
(demand) for fast aerial roof inspections after hailstorms, pivoting from Derek's existing
single-operator drone-services business, raising outside capital. Derek confirmed accurate.

**What's next:** Told Derek the 24 DE steps start with market segmentation, and — because this is
a marketplace — segmentation needs to happen on both the supply and demand sides separately. He
elected to keep going in the same session (moving briskly — checkpoints at the end of each step,
not full interactive dwell time on every question, matching his explicit "let's move" signal).

**Handoff:** control passes to the orchestrator to begin Step 1 (01-market-segmentation).
