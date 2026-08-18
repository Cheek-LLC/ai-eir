# Step 21: Test Key Assumptions

## Test design for the top 3 (per Step 20's ranking)

### 1. ka-020-associate-replication

**Test:** hire one associate recruiter and run their **first search as a real, paid engagement at
full published fee** — not a simulation, not a shadow project, not a free trial run. Jordan
provides oversight/QA (reviewing the slate before it goes to the client) but does not personally
source or screen candidates for this search. Per this step's services guidance directly: a paid
pilot engagement at a real price is the standard test here; a free/unpaid trial project would test
willingness to try, not whether the associate can actually deliver at the bar the business's whole
economics depend on.

**Success bar:** slate delivered within the standard ~30-day window, client's own hire outcome
matches Jordan's historical fill-rate/quality bar (no early client complaint about candidate
quality that Jordan's own searches don't also occasionally get).

**Status:** not yet run — this is the single highest-priority test in the entire plan.
`test_result: null`.

### 2. ka-016-delivery-hours-estimate

**Test:** time-track the next 3 engagements explicitly (calendar-logged hours by activity:
sourcing, screening calls, coordination, negotiation) instead of relying on Jordan's memory-based
90-hour estimate.

**Status:** not yet started. `test_result: null`.

### 3. ka-009-referral-concentration

**Test:** over the next 2 quarters, track whether new signed engagements continue to concentrate
in the same 2 referral sources or genuinely diversify. Per services guidance, a reference-call/
referral-rate test against the existing client base is the right method — Jordan will explicitly
ask each new prospect how they heard about Vantage Point Search and log the source.

**Status:** in progress (tracking started this session, no result yet). `test_result: null`.

## Not selected for active testing this pass (still open, lower near-term consequence)

`ka-001`, `ka-004`, `ka-008`, `ka-010`, `ka-011`, `ka-013`, `ka-014`, `ka-015`,
`ka-017-repeat-rate-optimism`, `ka-017-founder-delivery-rate`, `ka-018`, `ka-019` remain open,
untested this session — carried forward, not silently dropped.

## Update business-state.json

```json
"21_test_key_assumptions": {
  "status": "drafted",
  "summary": "Test designs written for the top 3 ranked assumptions; ka-020 (associate replication) is the highest-priority test and the one Step 22's MVBP is explicitly built around; none of the 3 have a result yet this session",
  "file": "plan/21-test-key-assumptions.md"
}
```
