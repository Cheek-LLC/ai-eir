---
name: 01-market-segmentation
description: >
  Use to run Disciplined Entrepreneurship Step 1 with a founder: a structured brainstorm that
  generates and clusters at least 10 distinct candidate market segments before any single
  target market is chosen. Trigger phrases: "market segmentation," "what markets could this
  serve," "brainstorm segments," starting the 24-step process fresh, or any request to widen
  a founder's target-market thinking beyond their first idea. Not for picking a single beachhead
  (that is Step 2) and not for describing one customer in depth (that is Steps 3 and 5).
---

# Step 1: Market Segmentation

## Role in the 24 steps

First step of Theme 1 ("Who is your customer?"). The entire purpose is breadth before
narrowing: force at least 10-15 genuinely distinct candidate segments onto the table so Step 2
has real options to score, instead of the founder anchoring on the first market they thought of.
Do not narrow to one market in this skill — that happens in `02-select-a-beachhead-market`.

## Read before starting

- `.startup/<slug>/business-state.json` — founder info, `business_name`, any onboarding notes,
  and **`business_basics.business_type`/`business_type_notes`**. Read the business type before
  asking anything below and tailor per "Business-type branching" here and
  `docs/UX-INTERVIEW-DESIGN.md` §4.
- `.startup/<slug>/interview-log.md` (skim, if present) for anything already said about the
  product/technology or target customers, so you don't re-ask what's already on record.

This is normally the first DE step run, so there are usually no prior `plan/` files to read.

## Interview the founder

Ask these directly — don't accept vague answers, push for specifics:

1. Are you starting from a technology/capability looking for a market ("tech push"), or from a
   problem/need you already believe needs solving ("market pull")? This changes how segments get
   generated but not the requirement to generate many.
2. List every type of customer or user you can imagine touching this — no filtering yet, quantity
   over quality at this stage.
3. (B2B) What industries, company sizes, job functions/departments could plausibly buy this?
4. (B2C) What demographics, life stages, occasions, or use contexts could plausibly buy this?
5. Name 3-5 different "jobs to be done" or problems this could solve, even ones that seem to be
   for entirely different kinds of people.
6. Have you seen anything like this used in adjacent verticals or by unexpected user types?

If the founder's first answer is close to "everyone" or "anyone could use this," push back
immediately, don't let it stand as segment #1 — ask them to name the first 5 specific people or
companies they'd actually call this week if they had to sell something today. That list is real
data; "everyone" is not.

## Business-type branching

The axes that actually produce heterogeneous segments differ by business type — read
`business_basics.business_type` and steer the brainstorm accordingly:

- **SaaS:** segment along company size/vertical/technical sophistication and workflow — e.g.
  "seed-stage startups with no dedicated ops hire" is a real segment; "companies that need
  software" is not.
- **Physical product:** segment along purchase channel and occasion (DTC vs. retail/wholesale,
  gift vs. self-use, replacement vs. first purchase) as much as demographics — two demographically
  identical buyers in different channels often behave like different segments.
- **Marketplace:** brainstorm supply-side and demand-side segments **separately** before pairing
  them — a marketplace segmentation done on only one side (e.g., only buyer types) misses that the
  real constraint is usually finding a supply segment and demand segment that fit each other.
- **Services:** segment by client sophistication, project complexity, or budget tier at least as
  much as by industry vertical — a services business segmented only by vertical often misses that
  engagement size/complexity is the real driver of differing needs.

## Method: generate and cluster, don't describe one customer

1. **Brainstorm raw ideas** across two lenses simultaneously — this is what makes a segmentation
   exercise rather than a demographic list:
   - *End-user characteristics*: who they are, what job/role, behavioral and psychographic
     traits, and the specific need or problem they share.
   - *Product/application characteristics*: what version or use case of the underlying
     technology/capability would actually serve them.
2. **Force at least 10-15 candidate segments.** If the founder stalls below 5-6, keep pushing
   with the interview questions above — don't pad the list with near-duplicates just to hit a
   number, and don't stop early either.
3. **Cluster into valid segments.** A valid segment is one where, *within* it, customers share
   the same need, buy similarly, reference each other, and would respond to the same product and
   positioning — and *across* segments, those things differ. Merge raw ideas that are really the
   same segment; split ideas that only look similar but have different underlying needs or buying
   behavior.
4. **Avoid the three common failure modes**: (a) one mega-segment ("everyone who could use
   software"), (b) segments defined only by demographics with no distinct need attached, (c)
   collapsing to a single vertical this early — that collapse is Step 2's job, done with evidence.

## When the founder doesn't know

Never invent segments or their sizes to hit the 10+ target. If the founder can only substantiate
2-3 segments from direct knowledge:
- Still produce a best-effort list of 10+ by combining the founder's raw ideas with reasonable
  adjacent-market extrapolations — but label every entry `founder-identified` or
  `candidate — needs validation`, never blend the two silently.
- Add a `key_assumptions` entry: `statement`: "Only N segments are grounded in the founder's
  direct knowledge; the rest are unvalidated candidates," `step_ref`: `01_market_segmentation`,
  `confidence`: `low`, `test_plan`: e.g. "run 5 exploratory conversations across the top
  unvalidated candidates," `test_result`: `null`.
- If any segment description implies a market-size figure, do not state it as fact — either omit
  it or flag it as unverified; a number stated as fact needs a `quantitative_claims` entry per
  the Data Contract, and this step should not be manufacturing those.

## Write `plan/01-market-segmentation.md`

```markdown
# Step 1: Market Segmentation

## Starting point
(tech push vs. market pull, one paragraph)

## Candidate segments
| # | Segment name | End user | Distinct need | Why it's heterogeneous from other segments | Source | Side (marketplace only: supply/demand) |
|---|---|---|---|---|---|---|
(source = founder-identified | candidate — needs validation)

## Segments carried forward to Step 2
(shortlist of the strongest 4-6, one line each on why they made the cut)

## Assumptions flagged
(list, or "none")
```

## Update `business-state.json`

Read the whole file first; write back only these keys, preserving everything else:

```json
"disciplined_entrepreneurship": {
  "01_market_segmentation": {
    "status": "drafted",
    "summary": "<N> candidate segments identified; shortlisted for Step 2: <seg A, seg B, seg C>",
    "file": "plan/01-market-segmentation.md"
  }
}
```

Append any `key_assumptions` entries created above to the top-level `key_assumptions` array.

## Definition of done

- 10+ candidate segments documented in `plan/01-market-segmentation.md`, each with a clear,
  distinct end-user + need pairing.
- `business-state.json` key `01_market_segmentation` set to `status: "drafted"`.
- Any unvalidated claims logged in `key_assumptions`, not stated as fact.
- Stop here — do not select a beachhead or run scoring; that's `02-select-a-beachhead-market`.
  Review/approval of this step happens later via the council skill; this skill does not do that.
