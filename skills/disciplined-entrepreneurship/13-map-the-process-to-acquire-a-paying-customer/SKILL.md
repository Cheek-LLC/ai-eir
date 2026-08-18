---
name: 13-map-the-process-to-acquire-a-paying-customer
description: >
  Use once Step 12 (Determine the DMU) is drafted and the founder needs to trace, role by role,
  how a real prospect moves from first contact to signed and paid. Triggers: "map the buying
  process," "how do we actually close a customer," "sales process," "who has to say yes," "DMU
  journey," "acquisition process map," "step 13." Produces a qualitative, stage-by-stage map of
  the acquisition journey per DMU role — trigger, proof needed, objection, and deal-killer at
  each stage. Purely qualitative; costing and conversion rates belong to Step 18, not here.
---

# Step 13: Map the Process to Acquire a Paying Customer

## What this step is (and isn't)

This is the **qualitative** map of the human process a beachhead customer goes through on the way
to a signed, paid deal — who gets involved, in what order, and why. It is keyed directly off the
Decision-Making Unit (DMU) roles established in Step 12 (champion, decision maker, end user,
influencer, saboteur/blocker, procurement).

It is **not** the costed version. Step 18 ("Map the Sales Process to Acquire a Customer") revisits
this exact map and adds time-per-stage, resource cost, and conversion rates so it can be priced
out into COCA (Step 19). If a founder or reviewer asks "didn't we already do this?" — yes, in
spirit, but Step 13 answers "what happens and who has to agree," while Step 18 answers "how long
does it take and what does it cost." Do not duplicate Step 18's costing work here; leave it out.

Read `business_basics.business_type` before assuming the default shape of a multi-stakeholder
enterprise sale. For `consumer_app` or self-serve `saas`/`physical_product` businesses where
Step 12's DMU already collapsed to one person (buyer = user = decision maker), most of these
roles collapse too — don't manufacture a champion/procurement/saboteur cast for a one-person
impulse purchase. The stages are still real (awareness → trial/first use → payment), just with
fewer distinct roles acting at each one; say so plainly in the map rather than padding it out.

## Reads

- `.startup/<slug>/business-state.json` (whole file, to preserve unrelated keys on write-back).
  Check `business_basics.business_type` before drafting — it determines whether this map is a
  multi-role B2B buying process or a collapsed single-person purchase (see above).
- `.startup/<slug>/plan/12-determine-the-dmu.md` — required. The DMU roles are the backbone of
  this map. If Step 12 is missing or `not_started`, stop and tell the founder Step 12 must be
  drafted first.
- `.startup/<slug>/plan/09-identify-your-next-10-customers.md` — if present, use these named
  prospects to sanity-check the map against real people rather than an abstraction.
- `.startup/<slug>/plan/05-profile-the-persona-for-the-beachhead-market.md` — if present, for
  the end-user persona's context (role, day-to-day pressures) that shapes how they'll behave at
  each stage.

## Founder-facing deliverables

Walk the founder through each DMU role from Step 12 and, for each one, extract:

1. **Trigger** — what event or stage causes this role to become involved (e.g., "champion loops
   in procurement once a verbal yes is given").
2. **What they need to see or believe** to move to the next stage (proof point, demo, reference
   customer, security review, budget approval, etc.).
3. **Their real objection or hesitation** at this stage, in their own likely words.
4. **What kills the deal here** — the specific failure mode if this role isn't satisfied.
5. **Who/what unblocks them** — champion advocacy, a specific artifact (ROI calc, case study,
   security doc), a peer reference, a trial period.

Then assemble the full sequence into an ordered stage list (e.g., Awareness → First Conversation
→ Champion Identified → Internal Pitch to Decision Maker → Procurement/Legal Review → Contract
Signed → First Payment), annotating which DMU role acts at each stage.

Ask explicitly:
- "Who first hears about you, and how?"
- "Who has to say yes for money to actually move?"
- "Is there anyone who can single-handedly kill this deal even if everyone else agrees?" (the
  saboteur/blocker role — every DMU has one; if the founder says "no one," push back)
- "What's the single most common reason a deal that got this far still doesn't close?"

## Business-type branching

The shape of "the process" — how many distinct roles act, and whether it's one process or several
running in parallel — changes fundamentally by `business_basics.business_type`. Map the actual
shape, don't force a generic enterprise-sale cast onto a process that doesn't have one:

- **SaaS:** If the DMU from Step 12 is multi-role (sales-assisted or enterprise), map the full
  stage sequence with a distinct stage for security/procurement review where deal size warrants
  it. If self-serve/PLG, collapse to a signup → activation → paid-conversion sequence with one
  role (buyer = user) and no procurement stage — a self-serve product doesn't gain rigor by
  inventing a committee for it.
- **Physical product:** A DTC purchase is usually a single-person process (browse → cart →
  checkout) with at most an informal influencer (a gift recipient, a household co-decider) — don't
  map a DMU cast here. If the business also sells wholesale/retail, that is a **second, separate**
  process with its own DMU-style cast (a retail buyer who reviews assortment fit, negotiates
  terms, and issues a PO) — map both processes if both channels exist; do not merge them into one
  table, since the trigger, proof, and objection at each stage differ completely by channel.
- **Marketplace:** Map **two parallel processes** — one for acquiring supply (sellers/providers)
  and one for acquiring demand (buyers) — never one blended map. What each side needs to see or
  believe is different by nature: supply cares about earning potential, ease of listing, and
  competition from other sellers; demand cares about selection, trust/safety, and price. State
  explicitly which side's process is being mapped in each table.
- **Services:** The process usually centers on trust-building through referral or reputation
  rather than a cold acquisition funnel — typical stages are referral/introduction → discovery
  call → proposal/scope → contract signed. For B2B services with an internal buyer organization,
  the DMU can still be multi-role (as in SaaS); for solo/small clients it often collapses to one
  person. Ask which shape applies rather than assuming.
- **Consumer app:** Almost always a single-person, self-serve funnel with no DMU roles beyond the
  one user — discovery (app store, ad, referral) → install → first-use moment → paid conversion
  (if freemium/subscription). The paid-conversion moment is still worth calling out as its own
  stage even though no new "role" enters — it's where the deal-killer question changes from
  "will they try it" to "will they pay."
- **Other:** Ask the founder which of the above shapes their process actually resembles (or
  whether it's a genuine hybrid) rather than guessing — per `docs/UX-INTERVIEW-DESIGN.md` §4.

## When the founder doesn't know

This step is qualitative and founders often genuinely don't know some of it before they've sold
anything. Do not invent DMU behavior or plausible-sounding process steps. Instead, add an entry
to `key_assumptions` in `business-state.json`:

```json
{ "id": "ka-013-<short-slug>", "statement": "Assumes procurement review is required for deals under $10k", "step_ref": "13_map_the_process_to_acquire_a_paying_customer", "confidence": "low", "test_plan": "Ask next 3 prospects directly whether procurement gets involved below this deal size", "test_result": null }
```

Mark the corresponding stage in the plan file as `[ASSUMPTION — see key_assumptions ka-013-...]`
rather than stating it as settled fact. This step produces no numeric claims, so
`quantitative_claims` does not apply here (that starts in earnest at Step 14).

## Output file: `plan/13-map-the-process-to-acquire-a-paying-customer.md`

Structure:

```markdown
# Step 13: Map the Process to Acquire a Paying Customer

## DMU roles (from Step 12)
- Champion: ...
- Economic buyer / decision maker: ...
- End user: ...
- Influencer(s): ...
- Saboteur/blocker: ...
- Procurement/legal (if applicable): ...

## Acquisition process map
| Stage | DMU role(s) active | Trigger into this stage | What they need to believe | Objection | What kills the deal here | Unblocked by |
|---|---|---|---|---|---|---|
| 1. Awareness | ... | ... | ... | ... | ... | ... |
| ... | | | | | | |
| N. Signed & paid | ... | ... | ... | ... | ... | ... |

## Open assumptions
- ka-013-...: ...

## Notes for Step 18
Flag any stage here you expect to be the longest, most expensive, or riskiest to cost out.
```

## Update business-state.json

Write/merge into `disciplined_entrepreneurship`:

```json
"13_map_the_process_to_acquire_a_paying_customer": {
  "status": "drafted",
  "summary": "<1-3 sentence summary of the acquisition path and its riskiest stage>",
  "file": "plan/13-map-the-process-to-acquire-a-paying-customer.md"
}
```

Append any new `key_assumptions` entries created above. Preserve every other key in the file
untouched.

## Done means

- `plan/13-map-the-process-to-acquire-a-paying-customer.md` exists with the full stage table.
- `business-state.json` key `13_map_the_process_to_acquire_a_paying_customer` set to
  `status: "drafted"` with summary and file path.
- Status stops at `drafted` — review/approval is handled later by a review-council skill; do not
  set `reviewed` or `approved` yourself.
