---
name: 02-select-a-beachhead-market
description: >
  Use to run Disciplined Entrepreneurship Step 2 with a founder: score the candidate market
  segments from Step 1 against a weighted criteria matrix (reach, resources, urgency, right to
  win, follow-on path, values fit, competitive intensity) and select ONE beachhead market with
  documented rationale and runner-ups. Trigger phrases: "pick a beachhead," "which market should
  we focus on," "select a target market," "narrow down the segments." Requires Step 1's segment
  list to already exist.
---

# Step 2: Select a Beachhead Market

## Role in the 24 steps

Second step of Theme 1. Takes the broad candidate list from Step 1 and narrows it to exactly one
beachhead market — a market small enough to dominate but big enough to matter, chosen with an
explicit, auditable rationale rather than gut feel. Every subsequent DE step (3 through 24)
is anchored to this one market; get this wrong and everything downstream is built on sand.

## Read before starting

- `.startup/<slug>/business-state.json`, including `business_basics.business_type` — read before
  scoring; tailor "reach" and "competitive intensity" per "Business-type branching" below.
- `.startup/<slug>/plan/01-market-segmentation.md` — **required**. If it doesn't exist or
  `disciplined_entrepreneurship.01_market_segmentation.status` is `not_started`, stop and tell
  the founder Step 1 needs to run first; do not invent a segment list here.

## Interview the founder

For each of the top candidate segments carried forward from Step 1:

1. Can you (or someone on the team) actually reach this segment today — via an existing network,
   warm intros, a channel you already have access to?
2. Do you have any unfair advantage here — domain expertise, existing relationships, IP, an
   existing customer base, credibility others don't have?
3. Is the need urgent and painful enough that they'd pay now, not "someday"?
4. If you completely won this segment, what adjacent segment does it let you expand into next
   (the "bowling pin" — which pin does this one knock over)?
5. Which segment most aligns with your own passion or mission? Beachhead work takes years —
   low personal conviction is a real risk, not a minor preference.
6. Gut check: is this big enough to build a venture-scale business on, but small enough that you
   could plausibly become the clear #1 player within ~2-3 years?
7. What does the competitive landscape look like here — fragmented and displaceable, or
   dominated by an entrenched incumbent?

## Business-type branching

What "reach" and "competitive intensity" actually mean differs by business type — probe for the
right kind of access/threat, not a generic version:

- **SaaS:** reach = access via existing communities, content/SEO, product-led signups, or a
  network of prospects already using adjacent tools; competitive intensity = how many funded
  competitors already target this exact workflow.
- **Physical product:** reach = access to a retail buyer relationship, an existing DTC audience,
  or a distribution/wholesale contact; competitive intensity should account for shelf-space or
  channel gatekeeping, not just other brands.
- **Marketplace:** reach must be assessed on **both sides** — a segment is only truly reachable if
  the founder can plausibly access initial supply *and* initial demand at the same time; a segment
  reachable on one side only is not yet a real beachhead candidate.
- **Services:** reach = access via referral relationships, past clients, or a professional network
  where reputation travels; competitive intensity should weigh how commoditized/undifferentiated
  the service category already is.
- **Consumer app:** reach = access to real individuals via personal network, beta-tester/early-
  adopter communities (Discord, Reddit, Product Hunt, relevant subreddits/forums), or an existing
  content/creator audience — not an ad-audience size estimate, which measures who you could pay to
  reach, not who you can actually reach and learn from now. Competitive intensity = how many other
  apps are already competing for the same slice of this segment's attention/habit, not just
  feature-identical competitors (see Step 11's consumer-app competitive-position guidance for the
  same distinction).
- **Other:** ask the founder which of the above reach/competitive-intensity framings fits best, or
  whether it's a genuine hybrid, rather than defaulting to a generic version (per
  `docs/UX-INTERVIEW-DESIGN.md` §4).

## Method: weighted scoring matrix, not a gut call

Score the top 3-5 candidates from Step 1 against these criteria (a 1-5 scale is fine; the goal is
a documented, comparable rationale, not false precision):

1. **Reach** — within the founders' current resources/network to access.
2. **Sizing fit** — big enough to matter, small enough to dominate quickly (a real bottom-up TAM
   comes later in Step 4; this is a directional judgment, not a calculation).
3. **Compelling reason to buy** — is there a clear, urgent customer need, or is this a "nice to
   have"?
4. **Word-of-mouth potential** — is this a tight-knit community where customers reference each
   other (conferences, associations, tight social/professional networks)?
5. **Right to win** — team's domain expertise, credibility, passion, existing relationships.
6. **Follow-on pathway** — does winning this market open a credible "bowling pin" path to
   adjacent segments (this feeds Step 14, Follow-on Market TAM)?
7. **Values/aspirations fit** — consistent with what the founders (and any investors) actually
   want to spend years building.
8. **Competitive intensity** — fragmented/beatable incumbents vs. an entrenched giant.

Sum the scores per segment, but apply judgment on top of the math — a segment that wins on total
score but scores a 1 on "right to win" or "reach" is a red flag worth naming explicitly, not
silently overridden by the total.

## When the founder doesn't know

If the founder can't confidently score a criterion (most often sizing or competitive intensity),
don't silently guess a number to fill the cell. Mark that cell "estimated — low confidence" in
the matrix and add a `key_assumptions` entry: `step_ref`: `02_select_a_beachhead_market`,
`confidence`: `low`, `test_plan`: e.g. "validate market sizing directionally via Step 4's
bottom-up TAM" or "confirm competitive intensity via 3-5 customer conversations."

## Write `plan/02-select-a-beachhead-market.md`

```markdown
# Step 2: Select a Beachhead Market

## Candidates carried from Step 1
(list, 3-5 segments)

## Scoring matrix
| Segment | Reach | Sizing fit | Reason to buy | Word of mouth | Right to win | Follow-on path | Values fit | Competitive intensity | Total |
|---|---|---|---|---|---|---|---|---|---|

## Selected beachhead market
(name + one-paragraph rationale, naming which criteria drove the decision)

## Runner-ups and why they were not selected
(1-2 segments, specific reasons)

## Bowling-pin path
(what follow-on market(s) this beachhead is expected to open up next)

## Assumptions flagged
```

## Update `business-state.json`

```json
"disciplined_entrepreneurship": {
  "02_select_a_beachhead_market": {
    "status": "drafted",
    "summary": "Beachhead selected: <segment name> — <one-line rationale>",
    "file": "plan/02-select-a-beachhead-market.md"
  }
}
```

Append any new `key_assumptions` entries; preserve every other key in the file untouched.

## Definition of done

- Scoring matrix completed for 3-5 candidates from Step 1.
- Exactly one beachhead market selected with a documented rationale and named runner-ups.
- `business-state.json` key `02_select_a_beachhead_market` set to `status: "drafted"`.
- Low-confidence scoring inputs logged in `key_assumptions`, not asserted as fact.
- Stop here — review/approval happens later via the council skill, not this one.
