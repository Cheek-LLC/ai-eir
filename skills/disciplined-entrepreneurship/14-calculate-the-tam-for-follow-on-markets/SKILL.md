---
name: 14-calculate-the-tam-for-follow-on-markets
description: >
  Use once the beachhead TAM (Step 4) and beachhead market (Step 2) are drafted and the founder
  needs to size the "bowling pin" markets they'll expand into after dominating the beachhead.
  Triggers: "follow-on market," "next market after beachhead," "bowling pin strategy," "adjacent
  market size," "TAM beyond the beachhead," "step 14," "what's the market after this one."
  Produces a ranked list of 2-4 follow-on markets with TAM estimates and an explicit rationale
  for why each is a natural next "pin" — market segmentation logic reused from Step 1, not a
  fresh brainstorm.
---

# Step 14: Calculate the TAM for Follow-on Markets

## What this step is

Aulet's "bowling pin" strategy: dominate the beachhead (Steps 2-13), then knock over adjacent
market segments using the beachhead as a base — reusable product core, references, distribution
relationships, or brand credibility. This step sizes the *next* pins, not the beachhead itself
(already sized in Step 4), and is explicitly qualitative-plus-numeric: it must connect back to
the market segmentation map from Step 1, not invent new segments from scratch.

## Reads

- `.startup/<slug>/business-state.json` (whole file)
- `.startup/<slug>/plan/01-market-segmentation.md` — required. Follow-on candidates should come
  from the full segmentation list produced there, not be invented fresh.
- `.startup/<slug>/plan/02-select-a-beachhead-market.md` — required, to understand why the
  beachhead was chosen and what adjacency criteria matter (shared distribution channel, shared
  buyer persona, shared regulatory environment, product reusability).
- `.startup/<slug>/plan/04-calculate-the-tam-for-the-beachhead-market.md` — required, both for
  the TAM methodology to reuse (top-down/bottom-up approach) and so follow-on TAM isn't double
  counting the beachhead.
- `.startup/<slug>/plan/10-define-your-core.md` if present — the durable "core" (technology,
  network effects, brand, etc.) argues for which follow-on markets are actually reachable with
  the same core vs. requiring a new one.

## Founder-facing deliverables

1. From the Step 1 segmentation list, identify 2-4 candidate follow-on segments and, for each,
   state the **adjacency logic** explicitly: what does the beachhead give you a head start on
   here (same buyer, same channel, same core product, same regulatory approval, referenceable
   case study)?
2. For each candidate, calculate TAM using the same methodology rigor as Step 4 — prefer
   bottom-up (target customer count × achievable revenue per customer) over top-down industry
   report multiplication; if only top-down is available, say so and flag confidence accordingly.
3. Rank the candidates by a combination of TAM size and ease of the "bowling pin" transition
   (lower switching effort ranks higher even at smaller size).
4. State the qualitative bowling-pin sequence: beachhead → pin 2 → pin 3, and roughly when each
   becomes viable (e.g., "after beachhead reaches X% penetration" or "after core capability Y is
   built").

Ask the founder directly:
- "If you fully won the beachhead tomorrow, what's the next most natural market to sell into
  using what you've already built?"
- "Is there a segment where your beachhead customers themselves are the buyers of the next
  product (expansion revenue) versus a genuinely new customer base?"
- "What would have to be true — technically or commercially — before pin 2 becomes sellable?"

## When the founder doesn't know

Follow-on market sizing is inherently more speculative than the beachhead. Never fabricate
customer counts, pricing, or penetration assumptions to fill a gap. When founder input is
missing or guessed, add a `key_assumptions` entry, e.g.:

```json
{ "id": "ka-014-pin2-penetration", "statement": "Assumes 15% of beachhead customers convert to pin-2 product within 12 months", "step_ref": "14_calculate_the_tam_for_follow_on_markets", "confidence": "low", "test_plan": "Validate with 5 beachhead customer interviews once beachhead has 20+ paying customers", "test_result": null }
```

## Quantitative claims (required)

Every TAM number for every follow-on market is a number presented as fact and **must** get a
`quantitative_claims` entry with a real source per the Data Contract's AI-risk rule:

```json
{ "id": "qc-014-pin2-tam", "claim": "TAM for follow-on market: mid-market logistics ops teams", "value": "$340M", "step_ref": "14_calculate_the_tam_for_follow_on_markets", "source": "founder estimate — bottom-up from 8,500 target orgs × $40k ACV; needs independent verification", "confidence": "low", "ai_risk_flag": true }
```

Set `ai_risk_flag: true` whenever the source is an AI-generated estimate rather than founder
data or a cited external benchmark — this is exactly the case the Data Contract's AI-risk rule
exists for.

## Output file: `plan/14-calculate-the-tam-for-follow-on-markets.md`

```markdown
# Step 14: TAM for Follow-on Markets

## Bowling pin sequence
Beachhead ([Step 2 name]) → Pin 2: [...] → Pin 3: [...]

## Follow-on market candidates
### Pin 2: <segment name>
- Adjacency logic: ...
- TAM calculation (bottom-up preferred): ...
- TAM: $X (see quantitative_claims qc-014-...)
- Trigger condition to pursue: ...

### Pin 3: <segment name>
(same structure)

## Open assumptions
- ka-014-...: ...
```

## Mandatory AI-risk gate — before this step is reported done

This step is one of the five DE steps `skills/risk/ai-risk-review`'s own "Who must call this, and
when" table names explicitly. After writing `plan/14-calculate-the-tam-for-follow-on-markets.md`
and before setting `status: "drafted"`, invoke `skills/risk/ai-risk-review` against this step's
plan file (whole file, not a summary) plus the business-slug.

- **PASS** → proceed to write `business-state.json` below.
- **BLOCKED** → do not set `status: "drafted"`. Fix the finding and re-run the gate, or route to
  the orchestrator for an explicit founder override (per `agents/orchestrator.md` Non-negotiable
  #3) — this step does not accept an override itself.

## Update business-state.json

```json
"14_calculate_the_tam_for_follow_on_markets": {
  "status": "drafted",
  "summary": "<ranked follow-on markets and combined TAM>",
  "file": "plan/14-calculate-the-tam-for-follow-on-markets.md"
}
```

Append the `quantitative_claims` and `key_assumptions` entries created above; preserve all other
keys untouched.

## Done means

- `plan/14-calculate-the-tam-for-follow-on-markets.md` written with sourced TAM figures.
- Every TAM figure has a matching `quantitative_claims` entry — before reporting `drafted`,
  re-read this file's own "Quantitative claims" section and confirm every figure stated as fact
  above it has a matching entry; a heading with no JSON block under it is not done.
- If you fell back to a founder-estimate/range instead of using WebSearch for a credible
  published count, say so explicitly ("no external search attempted this session") — an honest
  fallback and a skipped search otherwise look identical in the output.
- The mandatory AI-risk gate above returned PASS, or a BLOCKED finding was resolved/overridden.
- `business-state.json` key `14_calculate_the_tam_for_follow_on_markets` set to `status:
  "drafted"`. Review/approval happens later via a council skill — do not set it yourself.
