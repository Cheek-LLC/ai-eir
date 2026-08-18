---
name: 04-calculate-the-tam-for-the-beachhead-market
description: >
  Use to run Disciplined Entrepreneurship Step 4 with a founder: a bottom-up Total Addressable
  Market calculation for the beachhead market only — count real end users matching Step 3's
  profile, multiply by realistic annual revenue per end user, and cross-check against any
  top-down figure. Trigger phrases: "calculate TAM," "how big is this market," "market sizing,"
  "size the beachhead." Explicitly rejects top-down "1% of a huge market" reasoning. Every number
  produced here is a fact-claim and must get a sourced `quantitative_claims` entry — never
  invent a market-size figure.
---

# Step 4: Calculate the TAM for the Beachhead Market

## Role in the 24 steps

Fourth step of Theme 1. Converts the beachhead market (Step 2) and its End User Profile (Step 3)
into a single defensible dollar figure: annual revenue if you captured 100% of the beachhead.
This is a bottom-up unit-economics calculation, not a market-research-report lookup — it depends
directly on Steps 2 and 3 and feeds every downstream financial claim in the plan.

## Read before starting

- `.startup/<slug>/business-state.json`, including `business_basics.business_type` — read before
  choosing the counting unit and multiplier; the bottom-up method itself differs by type (see
  "Business-type branching").
- `.startup/<slug>/plan/02-select-a-beachhead-market.md` — **required**, defines the market
  boundary being sized.
- `.startup/<slug>/plan/03-build-an-end-user-profile.md` — **required**, defines the exact
  counting unit (who counts as one end user). If either file is missing or `not_started`, stop
  and tell the founder to complete that step first — do not size an undefined market.

## Interview the founder

1. Within the beachhead, roughly how many organizations/people match the End User Profile from
   Step 3? Do you have a source — an industry association, government statistics (e.g. Census/
   NAICS/BLS), LinkedIn Sales Navigator counts, a trade publication, a paid market report?
2. What would you realistically charge this end user per year (or per unit), once you have a real
   product? On what basis — per seat, per transaction, flat annual fee?
3. Do you have any direct evidence to sanity-check the count — a waitlist, pilot conversations,
   sales data from a comparable product?
4. Is there a reliable top-down figure (a research report's stated TAM/SAM for the broader
   market) available to cross-check the bottom-up number against?

## Method: bottom-up, always — never top-down "1% of a huge market"

1. **Fix the counting unit.** It is exactly the end user defined in Step 3 (a specific role at a
   specific kind of company, or a specific consumer profile). Count units first (companies,
   seats, households) — not dollars.
2. **Estimate the total number of such end users** in the beachhead, using one or both of:
   - Direct enumeration where feasible (e.g., "there are N hospitals with >200 beds in the US,"
     from a named data source).
   - Bottom-up "end-user density" extrapolation: take a well-defined, countable reference
     population (e.g., a NAICS-code company count, a professional-association membership count),
     then apply a density/fit fraction (share of that population matching the Step 3 profile) —
     this avoids needing to enumerate every single end user.
   - **Do not** back into a number by taking a headline market-research TAM and assuming "we'll
     get 1%." That is exactly the reasoning this step exists to replace.
3. **Multiply**: `# end users × realistic annual revenue per end user = beachhead TAM ($/year)`.
   Annual revenue per user = price × purchase frequency, grounded in what the founder said they'd
   realistically charge, not an aspirational number.
4. **Sanity-check the result.** This is annual revenue at 100% share of the beachhead. As a
   rough heuristic, a workable beachhead TAM is typically in the tens to low hundreds of millions
   of dollars per year — big enough to build a real venture-scale business on, small enough to
   plausibly dominate. If the number lands far outside that range, say so explicitly as a note
   for the founder to consider revisiting Step 2's beachhead choice — do not silently redo Step 2
   yourself.
5. **Cross-check against any top-down figure** (a market report's stated TAM for the broader
   category) as directional support only. Always show the bottom-up math as the number of
   record; label any top-down figure as "directional cross-check," never as the primary source.

## Business-type branching

The counting unit and the multiplier both change shape by business type — using a generic
"count × price" without adapting to the type is a common way this step produces a misleading
number:

- **SaaS:** count = number of companies (or seats within them) matching the Step 3 profile;
  multiplier = realistic annual contract value or seat price × seats, grounded in what the founder
  said they'd charge, not an aspirational ACV.
- **Physical product:** count = number of end consumers/households in the target segment;
  multiplier = average annual spend at realistic purchase frequency (units/year × price/unit) —
  and note whether the realizable price is DTC or nets down through a wholesale/retail channel,
  since that changes the revenue that actually reaches the business.
- **Marketplace:** size by **GMV × take rate**, not a per-user subscription price — count the
  transacting population on the demand side (or supply side, whichever is the binding constraint),
  multiply by expected transaction value and frequency to get GMV, then apply the take rate the
  founder actually expects to charge. Pricing a marketplace like a SaaS seat is the most common
  sizing mistake at this step for this business type.
- **Services:** count = number of target clients in the beachhead; multiplier = average annual
  contract/engagement value — and flag delivery-capacity constraints explicitly as a note (a
  services TAM assumes unlimited delivery capacity, which is rarely true; this doesn't change the
  TAM figure itself but should be named so it isn't mistaken for revenue the business can actually
  capture without scaling delivery).

If Step 3 produced two profiles for a marketplace (supply-side and demand-side), size from
whichever side is the actual constraint on transaction volume and say explicitly which side that
is and why.

## Every number here is a fact-claim — source it, never invent it

This step produces a number presented as fact. It **must** get an entry in `quantitative_claims`:

```json
{
  "id": "qc-04-tam",
  "claim": "Beachhead TAM (annual revenue at 100% share)",
  "value": "$<X>/year = <end-user count> × $<revenue per user>/year",
  "step_ref": "04_calculate_the_tam_for_the_beachhead_market",
  "source": "<exact source for the end-user count, e.g. 'US Census NAICS 621 establishment count (2024)' or 'founder estimate, unvalidated' — plus the source for the price assumption>",
  "confidence": "low|medium|high",
  "ai_risk_flag": true
}
```

Set `ai_risk_flag: true` whenever any input to the calculation came from AI-assisted web
research rather than the founder directly or a document the founder supplied — the risk council
needs to see that flag to evaluate it.

## When the founder doesn't know the count or the price

Never silently fill either gap with an invented number.
- **No count source**: use WebSearch for a credible published count (government stats, trade
  association, market report) and cite the exact source/URL in `quantitative_claims.source`. If
  nothing credible turns up, use a clearly labeled range (low/base/high) and add a
  `key_assumptions` entry: `step_ref`: `04_calculate_the_tam_for_the_beachhead_market`,
  `confidence`: `low`, `test_plan`: "validate end-user count via direct market-sizing research or
  early pilot signups," `test_result`: `null`.
- **No price hypothesis**: ask for a rough anchor relative to what alternatives cost today
  (from Step 8's eventual value-prop work). If still unknown, log a `key_assumptions` entry with
  `test_plan`: "run pricing/willingness-to-pay research (see Step 16)."

This output is a planning aid, not financial, legal, or tax advice — state that once here.

## Write `plan/04-calculate-the-tam-for-the-beachhead-market.md`

```markdown
# Step 4: TAM for the Beachhead Market

## Counting unit
(from Step 3's profile)

## Bottom-up calculation
- Reference population & source:
- Density/fit fraction & rationale:
- Estimated end-user count:
- Annual revenue per end user (price × frequency) & source:
- **Beachhead TAM = count × revenue per user = $X/year**

## Top-down cross-check
(figure, source, and how it compares — or "none available")

## Sanity check
(does the number fall in a workable beachhead range? if not, flag for founder to reconsider Step 2)

## Quantitative claims logged
(list the `quantitative_claims` ids added)

## Assumptions flagged

*This is a planning aid, not financial, legal, or tax advice.*
```

## Mandatory AI-risk gate — before this step is reported done

This step is one of the five DE steps `skills/risk/ai-risk-review`'s own "Who must call this, and
when" table names explicitly (it produces the beachhead TAM figure, a headline number a founder
can act on before ever seeing the assembled plan). Per that gate's MANDATORY GATE banner: after
writing `plan/04-calculate-the-tam-for-the-beachhead-market.md` and before setting `status:
"drafted"`, invoke `skills/risk/ai-risk-review` against this step's plan file (whole file, not a
summary) plus the business-slug.

- **PASS** → proceed to write `business-state.json` below.
- **BLOCKED** → do not set `status: "drafted"`. Fix the specific finding and re-run the gate, or
  route to the orchestrator for an explicit founder override (per `agents/orchestrator.md`
  Non-negotiable #3) — this step does not accept an override itself.

Do not skip this because plan-assembly time will "catch it later" — a founder who stops after
this step (a common real pattern: "let's just see the market size first") would otherwise get an
unreviewed figure with zero mechanical check on it.

## Update `business-state.json`

```json
"disciplined_entrepreneurship": {
  "04_calculate_the_tam_for_the_beachhead_market": {
    "status": "drafted",
    "summary": "Bottom-up beachhead TAM = $X/year (<count> end users × $<price>/year); source: <short source note>",
    "file": "plan/04-calculate-the-tam-for-the-beachhead-market.md"
  }
}
```

Append the `quantitative_claims` entry (mandatory) and any `key_assumptions` entries. Preserve
every other key untouched.

## Definition of done

- Bottom-up math shown in full (population, density/fit logic, count, price, result).
- Sourced `quantitative_claims` entry added for the TAM figure — no unsourced number stands as
  fact.
- Before reporting `drafted`: re-read this file's own "Quantitative claims logged" section and
  confirm every dollar figure/percentage/ratio stated as fact above it has a matching entry — a
  heading with no JSON block under it is not done.
- Sanity check against the beachhead-size heuristic stated explicitly.
- If you fell back to a founder-estimate/range instead of using WebSearch for a credible
  published count, say so explicitly in the Assumptions section ("no external search attempted
  this session") — this distinguishes an honest fallback from a skipped search, which otherwise
  look identical in the output.
- The mandatory AI-risk gate above returned PASS, or a BLOCKED finding was resolved/overridden —
  see above. A step that skipped this call is not done per this plugin's contract.
- `business-state.json` key `04_calculate_the_tam_for_the_beachhead_market` set to
  `status: "drafted"`.
- Stop here — review/approval happens later via the council skill, not this one.
