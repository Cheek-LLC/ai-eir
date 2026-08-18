# Launch Plan — Vantage Point Search

Produced by `skills/gtm/launch-plan`, delegated from `agents/gtm/launch-director.md`. Assembles
`gtm/positioning.md`, `gtm/content-calendar.md`, and `gtm/outbound-sales-playbook.md` into one
sequenced plan. `fundraising-deck-brief.md` does not exist — see §7 for why.

## Funding strategy determination

`gtm.funding_strategy` was `undecided` at GTM kickoff (2026-08-18). Determined this session per
`agents/gtm/launch-director.md`'s own procedure:

1. **Plan executive summary, verbatim:** "Funding intent is explicitly bootstrap; this plan does
   not describe a venture-scale opportunity and does not claim to."
2. **`founder.notes`:** "This stays bootstrapped — I'm not raising money to run a search firm, I'm
   reinvesting placement fees into hiring associate recruiters." Unprompted, explicit.
3. **`business_basics.funding_intent`:** `bootstrap`, set directly during onboarding.
4. **`quantitative_claims`:** no entry tagged with a funding ask or raise target.

Signal is unambiguous and triples-confirmed (plan text, founder notes, and the earlier-set
`funding_intent` field all agree). Set `gtm.funding_strategy: "bootstrap"`.

**Consequence: `fundraising-advisor` is correctly skipped for this pass** — not run and discarded,
never invoked, per its own gate ("if `gtm.funding_strategy` is not `raising_outside_capital`,
stop"). No fundraising materials produced. This aligns with the `vc-panel` review seat's own REJECT
verdict (Section — venture-fit only, correctly downgraded to informational by the review's own
Track A weighting) — this plan was never asking to be venture-shaped, and GTM sequencing follows
that consistently rather than defaulting to a fundraising track "just in case."

## 1. Launch readiness snapshot

| Item | Status | What closes the gap |
|---|---|---|
| MVBP (Step 22) built and usable by a real customer today | **Ready** | Already validated 6 times over 14 months — this is not a hypothetical launch, it's a continuation of an operating business with a refreshed GTM motion. |
| Pricing/business model (Steps 15/16) settled | **Ready** | Fee structure validated across 8 real signed engagements, no client pushback on record. |
| Positioning/messaging | **Ready** | `gtm/positioning.md` complete. |
| Content calendar | **Ready**, with one open item | `gtm/content-calendar.md` complete for 6 weeks; channel choice (LinkedIn) is the most defensible available evidence, not fully confirmed — see content-calendar's own flagged gap (possible VC-community channel, unconfirmed). |
| Outbound sales playbook | **Ready**, with one pending item | `gtm/outbound-sales-playbook.md` complete and usable as a markdown tracker today; CRM sync is pending (see below), does not block using it. |
| `ka-020-associate-replication` (untested) | **Not applicable to this launch** | This launch is GTM for the existing solo-delivered offer (MVBP #1), not the associate-delivered offer (MVBP #2) — the associate hire is gated on the playbook being written first (Step 24 roadmap) and is not part of this GTM push. Flagged so nobody reads this launch as implicitly testing `ka-020` — it isn't. |
| `ka-009-referral-concentration` (open) | **Live risk during this launch** | The whole outbound motion in §outbound-sales-playbook is explicitly designed to test this by diversifying beyond the 2 concentrated referral sources — see §5 below. |

**Overall: ready to launch.** Nothing load-bearing (the product/delivery capability itself) is
blocking — every open item above is a marketing/tooling refinement, not a "the thing doesn't exist
yet" gap.

## 2. Objective and success metrics

- **Primary:** 3 of the Step 9 next-10 list convert to signed engagements within 10-12 weeks of
  launch (2026-09-01 to ~2026-11-17) — chosen to match, not exceed, Jordan's historical closing
  pace (see `outbound-sales-playbook.md` §6's arithmetic), not an aggressive growth target.
- **Secondary (value-prop validation):** the next 3 clients who sign each report, post-engagement,
  that the founder-time-saved estimate (`qc-008-time-saved`, $15,000-$21,000, currently
  low-confidence) is directionally accurate — this is the concrete step toward resolving that
  assumption's confidence rating, not just re-asserting the range.
- **Channel-diversification metric (ties to `ka-009-referral-concentration`):** at least 1 of the 3
  target closes should trace to a non-referral channel (Jordan's own outbound or inbound, per Step
  9's existing signal that 2 of 8 historical engagements already came this way) — tracked
  explicitly, not left implicit, since this is the specific test this launch's outbound motion is
  designed to run.

## 3. Pre-launch phase (2026-08-19 to 2026-08-31)

| Week | Task | Owner | Depends on | Source artifact |
|---|---|---|---|---|
| 08-19 | Publish 2 pre-launch LinkedIn posts (technical-depth pillar) | marketing-strategist / founder | positioning.md finished | content-calendar.md |
| 08-19 | Confirm/refresh the Step 9 target tracker's current stage for all 10 prospects | sales-lead / founder | — | outbound-sales-playbook.md §1 |
| 08-21 | Send Day-1 outreach to 2 new prospects (channel-diversification push) | sales-lead / founder | tracker confirmed | outbound-sales-playbook.md §3 |
| 08-26 | Publish founder-voice + track-record posts | marketing-strategist / founder | — | content-calendar.md |
| 08-28 | Draft launch-day personal email to warm network | founder | positioning.md's 10-second pitch | content-calendar.md §3 |
| 08-31 | Founder review/approval of all launch-week copy | founder | all above | — |

## 4. Launch week — day by day (2026-09-01 to 2026-09-05)

| Day | Action | Channel | Owner |
|---|---|---|---|
| Mon 09-01, AM | Personal launch email to warm network (past clients/candidates/VC talent partners) | Email (personal send, not bulk — see connector note below) | founder |
| Mon 09-01, midday | Launch post (30-second pitch) | LinkedIn | founder |
| Mon 09-01, PM | 1:1 follow-ups to next-10 prospects #1, #4, #7 referencing the launch post | LinkedIn / email | founder |
| Wed 09-03 | Anonymized client-story post | LinkedIn | founder |
| Fri 09-05 | "Real cost of a stalled search" post | LinkedIn | founder |

Every launch-week post's CTA drives to a discovery call or a direct reply — no vague "learn more"
CTAs, per content-calendar.md.

## 5. Post-launch cadence (30 / 60 / 90 days)

- **Day 14 (2026-09-15):** first ops check-in (`agents/ops/operations-manager.md`) — realistically
  too early for a new signed engagement given the 5-9 week cycle (Step 18), but the right checkpoint
  for outbound activity (touches sent, discovery calls booked) and to confirm content is landing.
  Explicit checkpoint question: has channel-diversification produced any real signal yet (a
  discovery call from prospect #8's inbound-signal pattern repeating, for instance)?
- **Day 30 (2026-10-01):** does the ongoing content cadence (content-calendar.md §4) need
  adjustment based on what performed in weeks 1-4? Has the referral-concentration risk shown any
  movement?
- **Day 60-90 (2026-10-31 – 2026-11-30):** this is inside the real 5-9 week sales cycle window for
  prospects contacted at launch — first real read on whether the §2 objective (3 of next-10
  converting) is on pace. Ongoing metrics tracking and retros from this point forward are
  `agents/ops/*`'s job, not this plan's — this section hands off, it does not take over ops'
  territory.

## 6. Channel plan summary

| Channel | Purpose | Owning artifact |
|---|---|---|
| LinkedIn | Awareness + consideration (technical-depth, track-record content) | content-calendar.md |
| Direct email/relationship outreach | Conversion (warm network + next-10 list) | outbound-sales-playbook.md |
| Personal launch email | Conversion (highest-intent, warmest audience) | content-calendar.md §3 |

## 7. Fundraising milestone integration

**Not applicable.** `gtm.funding_strategy` is `bootstrap` (see determination above) — this section
is intentionally empty of content per the skill's own instruction not to leave a silent gap.

## 8. Connector status — real external tools, checked this session

Per `agents/gtm/launch-director.md`'s own contract, delegated to `agents/connectors-liaison.md`
(via `Task`) for the one genuinely real-connector moment in this launch: operationalizing the
outbound tracker into a real CRM.

- **Category:** CRM. **Task:** log the Step 9 next-10-customers target tracker (built in
  `gtm/outbound-sales-playbook.md`) into a real CRM so DMU-stage/next-action updates don't require
  hand-editing markdown.
- **`connectors-liaison` → `discover-and-suggest-connector` Step A (live check):** no CRM tool
  (HubSpot/Salesforce/Pipedrive-class) present in this session; `connectors.wired_up` was already
  empty, confirmed still empty by live scan, not just trusted from the state file.
- **Step B (suggestion capability):** no connector-discovery/suggestion capability found in this
  environment.
- **Step C (fallback):** manual-setup explainer returned — what it is (HubSpot/Pipedrive/Close/
  Salesforce), why now (operationalizing the tracker), what data would move (prospect names,
  emails, company, DMU-role/stage notes — no candidate PII), what to do (sign up for one directly,
  or tell Jordan once it's set up).
- **Privacy gate:** not reached — no real data is moving yet, since no connector is available to
  move it through (per `agents/connectors-liaison.md`'s own rule: registering a need doesn't
  require the privacy gate; the gate applies once data is actually about to flow).
- **Result reported back to `sales-lead`:** `status: needs_manual_setup`, **not safe to proceed**
  with any live CRM action. **Everything else in the task was completed regardless** — the full
  target tracker exists and is usable today as a markdown table (`outbound-sales-playbook.md` §1);
  only the CRM-sync convenience is pending. Recorded in `business-state.json.connectors.
  needed_not_installed`.
- **Founder-facing summary:** nothing has been "connected" or synced anywhere. Jordan can keep
  working directly from the markdown tracker with zero loss of function; if/when he sets up a real
  CRM, tell the plugin and this gets picked up and logged as `wired_up` on the next live check —
  never upgraded on a "yes I did it" alone.

No other GTM action in this launch (checkout/payments, a landing page, paid ads) is in scope — this
is a direct-outreach/referral-driven services launch, not a self-serve product launch, so those
connector categories are correctly not invoked here.

## 9. Risks and open assumptions carried into GTM

- **`ka-009-referral-concentration`** (open) — this launch's outbound motion is a direct attempt to
  address it; tracked explicitly in §2's channel-diversification metric.
- **`ka-013-conversion-sample`** (open) — all activity targets in `outbound-sales-playbook.md` §6
  rest on founder-tracked, not CRM-verified, historical conversion rates; the CRM-sync gap above
  (§8) is directly relevant to eventually resolving this.
- **Content channel choice (LinkedIn)** — the most defensible available evidence, not fully
  confirmed against a possible VC-community channel; carried from `content-calendar.md`'s own
  flagged gap.
- **`ka-020-associate-replication`** (open, not in scope for this specific launch) — noted in §1 so
  it isn't mistaken for something this GTM push is testing.

## Done

`gtm/launch-plan.md` complete. Every referenced artifact (`positioning.md`, `content-calendar.md`,
`outbound-sales-playbook.md`) exists and was read in full before this plan was assembled — no
dangling references. `fundraising-advisor` correctly did not run; the reason is stated above, not
silently omitted. The one blocked item (CRM connector) is marked pending with its exact blocker,
not silently dropped, per `agents/connectors-liaison.md`'s contract.
