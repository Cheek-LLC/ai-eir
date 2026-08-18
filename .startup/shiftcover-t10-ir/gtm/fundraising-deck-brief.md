# ShiftCover — Fundraising Deck Brief (test-fixture stand-in)

_Planning aid drafted from this business's own plan and sourced quantitative claims — not
financial, legal, tax, or securities-compliance advice. Does not run any part of an actual raise
(cap-table structuring, SAFE/equity terms, accredited-investor verification, Reg D filings)._

> **QA NOTE (round 10, not part of the real fixture):** this file was authored directly by the
> round-10 QA agent as a minimal stand-in for what `agents/gtm/fundraising-advisor.md` +
> `skills/gtm/fundraising-deck-prep` would have produced, solely to satisfy
> `skills/gtm/investor-updates-and-cap-table-basics`' own applicability precondition ("a prior
> round closed, or `gtm/fundraising-deck-brief.md` exists and a raise is underway") so that skill
> could actually be exercised live. `agents/gtm/fundraising-advisor.md`'s deck-prep mandate itself
> was **not** executed this round — this is not a real test of that skill, only scaffolding to
> reach a state where the investor-updates skill has an audience to write to. See
> `docs/QA-FINDINGS-INVESTORRELATIONS-ROUND10.md` for why this was necessary.

## Narrative (reconciled from the real plan, v2)

ShiftCover is a B2B SaaS tool letting shift managers at 10-50 unit QSR franchise groups text a
qualified backup-worker pool the moment an hourly employee calls out, replacing a 30-75 minute
manual phone/paper call list. Beachhead: Directors of Operations at 10-50 unit QSR groups
(economic buyer); end user: GM/shift manager (no budget authority).

- Beachhead TAM: $118M/year (founder estimate, unvalidated — `qc-04-tam`).
- Follow-on Pin 2 (casual dining) TAM: $70.8M/year (founder estimate — `qc-014-pin2-tam`).
- Combined near-term addressable figure, as already reconciled in `plan/business-plan.md`'s
  Executive Summary: ~$189M, stated there as sized for a strong non-venture outcome per the
  `vc-panel` council seat's own read (~$10-30M/yr), not asserted as fund-returner scale.
- Pricing: $129-149/location/month (`qc-016-price`).
- Blended LTV: $52,503/signed group contract (`qc-017-ltv`) against COCA $3,213
  (`qc-019-coca`) — 16.3:1 ratio (`qc-019-ltv-coca-ratio`), explicitly caveated in the plan as
  built entirely from a non-scalable warm-network channel, not yet representative at scale.

## Change of course since v2

The plan's own v2 executive summary and `interview-log.md` (2026-08-27) record the founder's
explicit bootstrap preference and `funding_intent: "bootstrap"`. Per this round's test setup, the
founder is simulated to have since reconsidered and decided to raise outside capital to fund the
MVBP build and beachhead expansion faster than the no-code-solo/contractor-fallback path alone
would allow. `gtm.funding_strategy` was updated to `raising_outside_capital` accordingly. This
reversal is noted here plainly, not smoothed over — a real re-run of this business would need
`business_basics.funding_intent` re-captured by `recurring-check-in`, not silently left as
`bootstrap` while `gtm.funding_strategy` says otherwise.

## Honest risks (carried from the VC-panel / council record, not re-litigated here)

- LTV:COCA ratio is not representative outside the warm network (one 20-contact cold-outbound
  test only, 15% reply rate — too small a sample).
- Sales-cycle evidence gap open: only 2 of 7 Step 9 prospects have reached Stage 2, short of the
  council's 5+ bar (`ov-shiftcover-004`).
- Engineering-resourcing risk: MVBP build approach decided (no-code solo, 2-week checkpoint,
  ~$18k-$24k contractor fallback) but the checkpoint had not yet been reached as of the last
  recorded state (`ka-024-no-eng-resourcing`).

## Status

Raise: actively underway (soft conversations with prospective angel/pre-seed investors); no
round has closed as of this brief.
