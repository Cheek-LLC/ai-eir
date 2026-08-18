# UX Interview Design — 30-Minute Startup

This document is the design rationale behind `skills/interview/onboarding-interview` and
`skills/interview/recurring-check-in`, and the standard every other interview-shaped skill in
this plugin should hold itself to — most directly the 24
`skills/disciplined-entrepreneurship/NN-slug/SKILL.md` step skills, which are themselves
interviews even though they don't live under `skills/interview/`. If you're building one of
those, read this document, not just the two skill files, before you write your question set.

The premise: the entire quality of the eventual business plan is downstream of how well this
interview draws out real, specific, non-generic answers instead of founder platitudes. A business
plan is only as good as the least-specific answer that went into it. This document exists so that
discipline is designed once and applied consistently, not reinvented (or diluted) 26 times across
the onboarding skill, the check-in skill, and 24 step skills.

## 1. Question style

### Concrete over abstract

Every question should be answerable with a fact, a number, a name, or a specific scenario — never
with a sentiment. Compare:

- Abstract (avoid): "Tell me about your target market."
- Concrete (use): "Picture the one person or company most likely to buy this in the next 30 days.
  What's their job, or what does their business do?"

Abstract questions invite abstract answers — a founder answering "tell me about your target
market" will reach for "small businesses" or "professionals" because the question itself doesn't
demand more. A concrete question makes a vague answer *feel* wrong to give, which does most of
the work before any push-back is even needed.

This applies recursively to every DE step skill's own question set, not just onboarding: a step
skill asking "what's your value proposition?" will get marketing copy back; a step skill asking
"what specific, measurable outcome does the beachhead customer get that they don't get today, and
how would they notice it in their week?" gets something usable in a plan.

### One question at a time, never a question-dump

Never send a founder five questions in one message. This is a UX failure mode specific to
chat-shaped interviews: a wall of numbered questions invites the founder to answer the easy ones
fully and the hard ones with a fragment, and the interviewer (you) loses the ability to push back
on any single weak answer before the founder has already moved on mentally.

Ask one question. Get a real answer — pushing back per §3 if needed. Only then ask the next one.
This is slower per message but faster to a usable answer, and it's the difference between an
interview and a survey. The founder should feel like they're in a conversation with someone who
is actually listening to what they just said, not filling out a form that happens to be phrased
as sentences.

Exception: a single follow-up that's clearly in service of the question just asked (e.g. "and
roughly how many of those exist?" immediately after naming a customer segment) is still one
conversational beat, not a dump — the test is whether the founder could reasonably answer it in
the same breath as the first question, not whether it's grammatically a second question mark.

### Why each DE step asks what it asks

A founder (and the AI asking questions) engages more rigorously with a question when the *reason*
for it is visible, not just the prompt. Every interview-shaped skill should be able to state, in
one sentence, what wishful thinking the step exists to prevent. Reference table for the 24 steps
(step skills should open with a one-line version of this, not read it verbatim, but should never
lose the underlying reason the question is being asked):

| Step | What it's really forcing |
|---|---|
| 01 Market Segmentation | Kills "everyone is my customer" by making the founder enumerate distinct segments with different needs, not one blurry mass. |
| 02 Select a Beachhead Market | Forces a *choice* — you cannot attack every segment first; picking one and saying no to the rest is the actual discipline, not the segmentation list itself. |
| 03 Build an End User Profile | Prevents the persona from being a demographic cliché ("millennials," "busy professionals") by demanding specific, observable behaviors and context. |
| 04 TAM for the Beachhead | Kills "huge market" as an unsupported adjective — forces an actual number with a visible method (top-down or bottom-up) attached. |
| 05 Persona for the Beachhead | Makes the beachhead customer a specific person with a name, a day, and a psychology — not a segment label restated. |
| 06 Full Life Cycle Use Case | Forces the founder past "they buy it" into every real step — discovery, purchase, onboarding, ongoing use, renewal/churn — surfacing friction points a pitch usually skips. |
| 07 High-Level Product Specification | Forces "what we're building" to be specific enough to estimate cost and time, not a feature-list wishlist. |
| 08 Quantify the Value Proposition | Kills "it saves time / it's better" as an unquantified claim — demands a number the customer would actually recognize (hours saved, dollars saved, risk reduced — with a magnitude). |
| 09 Identify Your Next 10 Customers | Forces the abstract beachhead down to 10 nameable, contactable real prospects — the single fastest test of whether the beachhead is real or aspirational. |
| 10 Define Your Core | Forces the founder to name their actual durable advantage, not a list of features a competitor could copy in a quarter. |
| 11 Chart Your Competitive Position | Kills "no competitors" by forcing at least the do-nothing/status-quo alternative onto the map, positioned honestly, not favorably. |
| 12 Determine the DMU | Forces the founder to name every human involved in a purchase decision (economic buyer, user, influencer, blocker) — most B2B deals die because one of these was never identified. |
| 13 Map the Process to Acquire a Paying Customer | Forces the sales/acquisition motion into concrete stages instead of "and then they buy," surfacing where deals actually stall. |
| 14 TAM for Follow-on Markets | Prevents the beachhead from being mistaken for the whole opportunity, and equally prevents follow-on markets from being used to inflate the beachhead's credibility. |
| 15 Design a Business Model | Forces a specific mechanism for capturing value (not just creating it) — who pays, for what unit, on what trigger. |
| 16 Set Your Pricing Framework | Kills "we'll figure out pricing later" — forces a real number or tier structure tied to the value quantified in step 8. |
| 17 Calculate LTV | Forces the revenue side of unit economics into a real number with visible assumptions (price, retention, expansion), not a hand-wave "should be profitable." |
| 18 Map the Sales Process (costing pass on step 13) | Forces the acquisition process from step 13 to carry real time and cost per stage — this is where COCA gets its inputs. |
| 19 Calculate COCA | Forces the cost side of unit economics into a real number — and, paired with step 17, forces the LTV:COCA ratio into the open where a weak business model can't hide. |
| 20 Identify Key Assumptions | Forces every unproven belief accumulated across steps 1–19 into one visible list instead of staying buried inside confident-sounding prose. |
| 21 Test Key Assumptions | Forces a *plan* for resolving each assumption (not just naming it) — this is where "I don't know" graduates into "here's how I'll find out." |
| 22 Define the MVBP | Forces the smallest real thing that tests the core assumptions, resisting the urge to over-build before validation. |
| 23 Show the Dogs Will Eat the Dog Food | Forces real evidence of adoption/usage, not intent to adopt — the gap between "people said they'd use it" and "people are using it." |
| 24 Develop a Product Plan | Forces the founder to sequence what comes after the MVBP, so the plan doesn't end at "and then we validate" with no next step. |

A step skill that doesn't know why its own step exists will ask surface-level questions and accept
surface-level answers. Put the "why" in the skill's own framing to the founder when it helps
motivate a hard question — founders push back less on a hard question when they understand what
it's protecting them from.

## 2. Tone guardrails

The target voice is a good cofounder or a sharp YC partner in office hours — someone who has seen
enough startups to know which answers are real and which are comfortable, who respects the
founder enough to say so, and who is on their side precisely by refusing to let weak answers
through. It is explicitly **not** a customer-service bot.

**Do:**
- State disagreement or skepticism plainly: "That number seems high for a beachhead this narrow —
  walk me through how you got there." Not: "That's a great start! Just to double-check..."
- Ask the hard follow-up even when the founder seems tired or eager to move on — a good cofounder
  doesn't let a weak answer slide because the room's energy is dipping.
- Acknowledge a genuinely strong, specific answer briefly and move on — one clause, not a
  paragraph of praise. "Good — that's a real number with a source. Next:" is enough.
- Treat a resolved-false assumption or a bad number as useful information, stated matter-of-factly
  — "so the LTV:COCA ratio is under 2:1 right now — that's a real problem, let's look at why"
  — not as bad news to soften.
- Match effort to what the founder gives: a founder who's clearly thought hard about something
  gets a harder follow-up, testing the edges; a founder who's clearly new to a topic gets it
  explained briefly before being asked to reason about it.

**Don't:**
- No stacked hedges or disclaimers ("just to clarify," "no wrong answers here," "I'm not an
  expert but..."). Say the thing once, plainly, per CONVENTIONS.md §7.
- No sycophantic praise-first framing ("Great question! Love this idea!") before a substantive
  question or push-back — it reads as placating, and founders who've talked to real investors
  will notice the difference immediately.
- No apologizing for pushing back ("Sorry to keep asking, but..."). The pushing back is the job;
  don't frame it as an imposition.
- Never accept a platitude "to keep things moving" and quietly plan to revisit it later — if it's
  wrong now, it's wrong in the plan later too, and it's cheaper to fix at the point it was said.
- Never fabricate confidence — if you (the interviewing agent) don't know whether a founder's
  claim is realistic, say that plainly rather than either rubber-stamping it or inventing a
  counter-number of your own that isn't sourced either.

## 3. Handling vague and unknown answers — the shared discipline

Two distinct failure modes require two distinct responses. Conflating them is the most common way
an interview skill goes wrong — either browbeating a founder who genuinely doesn't know yet, or
letting a deflection slide because it's phrased like an admission of uncertainty.

**Vague / wishful (the founder could be specific but isn't yet)** — examples: "everyone is my
customer," "we have no competitors," "it's a huge market," "it'll basically sell itself," "we're
disrupting the industry with AI." The response is a *specific* probing follow-up, not a generic
"can you elaborate" — see the full playbook table in
`skills/interview/onboarding-interview/SKILL.md` for the canonical set, extend it per-step with
the same pattern (name the platitude, ask the question that only a real answer can satisfy). One
follow-up is proportionate; if a real answer doesn't emerge after that, the honest move is often
to convert it into a `key_assumptions` entry rather than a third increasingly pointed rephrasing
of the same question.

**Genuine unknown (the founder has not yet learned this)** — the response is never a forced
number. Confirm it's real (not a dodge) with one direct question, then log it: a
`key_assumptions[]` entry per `docs/DATA-CONTRACT.md` (`statement`, `step_ref`, `confidence:
"low"`, a `test_plan` if one exists), and **say so to the founder in the same turn** — "I'm
logging that as an open assumption, not guessing a number" — so it's never a silent gap. This
reframes not-knowing as the interview working correctly (surfacing what still needs testing)
rather than a failure the founder needs to paper over with a made-up figure. `quantitative_claims`
entries always need a real `source`; an entry with no source is exactly the failure mode this
distinction exists to prevent — it's an AI-risk finding per the Data Contract and blocks council
approval, so the discipline here isn't stylistic, it has a downstream enforcement mechanism.

## 4. Business-type branching: how it propagates into the 24 step skills

`business_basics.business_type` (`saas | physical_product | marketplace | services |
consumer_app | other`, plus free-text `business_type_notes`) is captured once, during onboarding,
and every DE step skill must read it before asking its questions. The classification exists
because the *shape* of a rigorous question at a given step is genuinely different across business
types — asking a physical-product founder about API integrations, or a SaaS founder about unit
manufacturing cost, wastes the conversation and signals the interviewer doesn't understand the
business. Concrete worked examples, same step, different business type:

**Structural convention:** a step skill that branches by business type puts the branching in its
own `## Business-type branching` section, positioned right after `## Interview the founder` (see
`skills/disciplined-entrepreneurship/01-market-segmentation/SKILL.md` through `04-...` for the
pattern) — not folded as asides into the numbered question list itself. Follow that placement when
adding a branching section to a step skill that doesn't have one yet, so a founder-facing reader
(and a reviewer diffing step skills against each other) always finds it in the same place.

**Step 01 — Market Segmentation.** The axis that actually produces heterogeneous segments differs
by type — steer the brainstorm at that axis, not a generic "list some segments" prompt:
- *SaaS:* segment along company size/vertical/technical sophistication and workflow — "seed-stage
  startups with no dedicated ops hire" is a real segment; "companies that need software" is not.
- *Physical product:* segment along purchase channel and occasion (DTC vs. retail/wholesale, gift
  vs. self-use, replacement vs. first purchase) as much as demographics — two demographically
  identical buyers in different channels often behave like different segments.
- *Marketplace:* brainstorm supply-side and demand-side segments **separately** before pairing
  them — a segmentation done on only one side misses that the real constraint is usually finding a
  supply segment and a demand segment that fit each other.
- *Services:* segment by client sophistication, project complexity, or budget tier at least as
  much as by industry vertical — engagement size/complexity is often the real driver of differing
  needs, not the vertical label.

**Step 02 — Select a Beachhead Market.** "Reach" and "competitive intensity" in the scoring matrix
mean something different by type — probe for the right kind of access/threat, not a generic one:
- *SaaS:* reach = access via existing communities, content/SEO, product-led signups, or a network
  of prospects already using adjacent tools; competitive intensity = how many funded competitors
  already target this exact workflow.
- *Physical product:* reach = access to a retail buyer relationship, an existing DTC audience, or
  a distribution/wholesale contact; competitive intensity should account for shelf-space or
  channel gatekeeping, not just other brands.
- *Marketplace:* reach must be assessed on **both sides** — a segment is only a real beachhead
  candidate if the founder can plausibly access initial supply *and* initial demand at the same
  time; reachable on one side only isn't a candidate yet.
- *Services:* reach = access via referral relationships, past clients, or a professional network
  where reputation travels; competitive intensity should weigh how commoditized the service
  category already is.

**Step 04 — Calculate the TAM for the Beachhead Market.** The counting unit and the multiplier
both change shape by type — "count × price" without adapting to the type is how this step produces
a misleading number:
- *SaaS:* count = companies (or seats within them) matching the Step 3 profile; multiplier =
  realistic annual contract value or seat price × seats — grounded in what the founder said
  they'd charge, not an aspirational ACV.
- *Physical product:* count = end consumers/households in the target segment; multiplier =
  average annual spend at realistic purchase frequency (units/year × price/unit) — and note
  whether the realizable price is DTC or nets down through a wholesale/retail channel, since that
  changes the revenue that actually reaches the business.
- *Marketplace:* size by **GMV × take rate**, not a per-user subscription price — count the
  transacting population on the binding-constraint side, multiply by expected transaction value
  and frequency to get GMV, then apply the take rate. Pricing a marketplace like a SaaS seat is the
  most common sizing mistake at this step.
- *Services:* count = target clients in the beachhead; multiplier = average annual contract/
  engagement value — and flag delivery-capacity constraints explicitly, since a services TAM
  otherwise silently assumes unlimited delivery capacity.

**Step 03 — Build an End User Profile.**
- *SaaS:* Ask about the end user's role and tools: what's their job title, what software stack are
  they already living in, do they have budget authority or do they need to convince someone else,
  what's a typical day look like at the moment they'd feel this problem.
- *Physical product:* Ask about the end user's purchase context instead: where do they typically
  shop for products like this, what triggers the purchase occasion (a life event, a season, a
  replacement need), who else in the household or team influences the purchase, what's their
  price sensitivity at the category level.
- *Marketplace:* Ask about **both** sides separately and explicitly — a supply-side profile
  (what does a seller/provider look like, what's their motivation to list) and a demand-side
  profile (what does a buyer look like, what's their motivation to transact) — treating either
  side alone as "the end user" is the step-3 mistake specific to marketplaces.

**Step 07 — High-Level Product Specification.**
- *SaaS:* Ask about must-have integrations, deployment model (cloud multi-tenant vs. on-prem vs.
  hybrid), uptime/SLA expectations at this customer tier, and data residency/security
  requirements the beachhead segment will actually ask about.
- *Physical product:* Ask about materials and manufacturing tolerances, unit cost at target
  volume, packaging and shipping constraints, and any required regulatory certification (FDA,
  CPSC, UL, etc.) that gates going to market at all — a spec that ignores this isn't a real spec.
- *Services:* Ask about what's standardized versus custom per engagement, what a delivery
  "unit" actually is (a project, a retainer month, an hour), and what tooling or process makes
  the service repeatable rather than fully bespoke every time.

**Step 16 — Set Your Pricing Framework.**
- *SaaS:* Ask whether pricing is seat-based, usage-based, flat-tier, or hybrid; whether there's a
  free tier or trial and what it's meant to prove; and how price scales as the customer grows
  (the expansion-revenue question that feeds step 17's LTV).
- *Physical product:* Ask about the full markup chain — unit COGS, wholesale price if selling
  through retail, retail markup, and what margin survives at each stage — plus how DTC pricing
  compares to any wholesale channel.
- *Marketplace:* Ask about take rate (percentage of transaction value) versus flat listing/
  subscription fees on one or both sides, and whether the take rate is even viable given what
  each side would tolerate — a marketplace's "price" is really a fee structure, not a unit price.

These six (01, 02, 03, 04, 07, 16) are worked examples, not the full set — round 2 is actively
extending `## Business-type branching` sections to more of the 24 step skills; check a given step
skill's own file before assuming it's still generic, and update this doc with a new worked example
whenever a step's branching becomes genuinely developed and this list is still missing it.

The pattern to replicate when writing or reviewing any step skill: don't ask a business-type-
blind version of the question and hope it lands; look up what actually determines a good answer
for *this* business type at *this* step, and ask for that directly. When a step skill is unsure
which business-type variant applies (a genuine hybrid, or `business_type: "other"`), it should
ask the founder which framing fits better rather than guessing — the same one-question-at-a-time,
concrete-over-abstract discipline applies to resolving ambiguity about the business itself.

## 5. Session structure and pacing

- **Set expectations before asking anything substantive.** The onboarding skill's opening framing
  exists because "30-Minute Startup" is a memorable product hook, not an honest estimate of how
  long a rigorous 24-step interview takes — overpromising speed here produces a founder who
  disengages the moment step 4 takes real thought, or who resents the process for taking longer
  than advertised. Say the honest version once, up front, and don't repeat it as a disclaimer
  every subsequent session.
- **Checkpoint, don't silently chain.** After each DE step (per the orchestrator's own guidance),
  give the founder a short "here's what we decided, here's what's next" before continuing —
  unless the founder has explicitly signaled they want to move briskly through several steps
  before reconvening, in which case say so explicitly rather than assuming.
- **A recurring check-in opens with state, not a blank "how's it going."** Founders forget what
  was open since last time; restating it (per `recurring-check-in`'s Phase 1) is what makes the
  conversation feel like continuity rather than starting over each time.
- **Close every session with a concrete next step**, never an implicit "we'll pick this up
  eventually" — state what's next and, for recurring check-ins, what the cadence is and how (or
  whether) re-activation actually happens in this environment. Never imply a scheduled check-in
  will happen automatically when no scheduling mechanism is actually in place.

## 6. Anti-patterns to actively avoid

- **Question-dumping** — covered above; the single most common way a chat-based interview
  degrades into a form.
- **Leading questions** — "This is a huge market, right?" invites agreement instead of testing the
  claim. Ask "what's the market size and how did you get there?" instead of a question shaped to
  be confirmed.
- **False precision worship** — pushing a founder to produce a specific number is right; pushing
  them to produce a *false* one by refusing to accept "I don't know, here's my best rough range"
  is wrong. A rough range with stated low confidence is a better answer than a confident-sounding
  number with no basis — don't optimize for the appearance of rigor over the substance of it.
  See §3's genuine-unknown protocol.
- **Sycophancy** — praising a weak answer to keep the founder's energy up costs the plan's
  integrity later; a founder who hears "good" for a platitude has no signal to try harder next
  time.
- **Interrogation without narrative context** — a rapid-fire sequence of hard questions with no
  acknowledgment of what's being learned reads as hostile, not rigorous. Brief context ("this
  matters because it's what step 17's LTV depends on") keeps the hard questions feeling like part
  of building something, not a test the founder is failing.
- **Business-type-blind questions** — asking the generic version of a step's question when a
  business-type-specific version (§4) is available and would surface something real. If a step
  skill finds itself asking the same question regardless of `business_basics.business_type`, that
  is a sign the step skill needs its own type-specific branches, not that the classification
  doesn't matter for that step.

## 7. Relationship to the two interview skills

- `skills/interview/onboarding-interview/SKILL.md` implements §1 (concrete/one-at-a-time),
  §2 (tone), §3 (vague/unknown handling) in full, and §4's classification capture, plus §5's
  expectations-setting.
- `skills/interview/recurring-check-in/SKILL.md` implements §2 (tone) and §3 (vague/unknown
  handling, applied to check-in answers) and §5's state-first, cadence-close structure.
- Every `skills/disciplined-entrepreneurship/NN-slug/SKILL.md` step skill should implement all
  seven sections of this document for its own question set — this document is written to be their
  shared reference, not just the two interview skills'.
