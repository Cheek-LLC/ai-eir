# QA Findings — Round 3: Connectors Layer Caller Audit

**Scope of this pass.** Round 2 (`docs/QA-FINDINGS-GATES-ROUND2.md`) found that
`agents/connectors-liaison.md`'s five named expected callers (`launch-director`, `sales-lead`,
`fundraising-advisor`, `growth-analyst`, `finance-controller`) all skipped the gate entirely, and
fixed those five files in that round. This pass re-audits all of `agents/gtm/*.md` and
`agents/ops/*.md` (9 files) plus every `skills/gtm/*/SKILL.md` and `skills/ops/*/SKILL.md` (10
files) against `docs/CONNECTORS-CATALOG.md`'s categories, to check whether round 2's fix actually
holds up under a fresh read, and whether any file — agent or skill — asserts a connector check in
passing prose without the instructions actually making that check happen.

**Method.** Full read of all 19 files (not a grep-only pass), cross-referenced against
`docs/CONNECTORS-CATALOG.md`'s category-to-agent mapping, then a repo-wide grep for "connector" in
every file with no full-text hit on the term, to confirm an N/A verdict isn't hiding a vague/buried
reference. Verdicts:

- **REAL CHECK** — the file names `agents/connectors-liaison.md` explicitly, states the delegation
  happens at a concrete point (via `Task`/`subagent_type: connectors-liaison`, with real
  task/category/purpose fields), and makes proceeding — or claiming the action happened — expressly
  conditional on connectors-liaison's reported status. An agent executing the file literally would
  actually stop and delegate, and would not report a live action as done without a clear signal.
- **ASSERTED-BUT-NOT-REAL** — the file claims or implies a connector check happens (e.g. "I check
  for the connector first," a reference to `wired_up`/`needed_not_installed` as if read directly,
  or a vague nod to "connectors" or "integrations") without a concrete, blocking instruction that
  would actually make that happen.
- **N/A — DOESN'T TOUCH CONNECTORS** — the file produces markdown/document artifacts only, never
  claims or implies a live external-tool action, and a repo grep for "connector" against it returns
  nothing. Confirmed clean, not silently missing something it should have.

**Result count.** 19 files audited: 5 REAL CHECK, 0 ASSERTED-BUT-NOT-REAL, 14 N/A.

| Verdict | Count |
|---|---|
| REAL CHECK | 5 |
| ASSERTED-BUT-NOT-REAL | 0 |
| N/A — doesn't touch connectors | 14 |

**Headline finding:** round 2's fix holds. All five of `agents/connectors-liaison.md`'s named
callers still carry a real, concrete, fail-closed delegation on this fresh read — none has
regressed into an assertion-only mention. No file in this scope claims a connector check it doesn't
actually perform. The 14 N/A files are correctly silent: none of them touches a real external tool
or implies one is available, and none references "connector" at all (confirmed by grep, not just
absence-of-mention-so-far). The architecture holds up: `skills/gtm/*` and `skills/ops/*` are
uniformly document-producers (a playbook, a calendar, a metrics file, a dashboard) that never touch
a connector themselves — the five agents above are the sole checkpoint, by design, and they're
the only files that need to (and do) delegate to `agents/connectors-liaison.md`.

---

## agents/gtm/*.md (4 files)

| File | Verdict | Notes |
|---|---|---|
| `agents/gtm/launch-director.md` | **REAL CHECK** | "Real external tools (checkout, landing page, launch email, ads)" section (lines ~97–111) names `stripe`/`webflow`/`gmail`/`google-ads` moments per the catalog, delegates via `Task`, `subagent_type: connectors-liaison`, and states explicitly: "Never report a launch-week action ('sent the announcement,' 'checkout is live') as done unless connectors-liaison actually confirmed it's clear and live; if it's blocked or pending founder action, say so plainly in the launch plan's readiness snapshot rather than marking the item complete." Fail-closed on the action; gracefully degrades to a documented readiness-snapshot item rather than blocking the whole launch plan. |
| `agents/gtm/sales-lead.md` | **REAL CHECK** | "Real external tools (CRM, scheduling)" section (lines ~74–89) covers `hubspot`/`calendly`, explicitly rules out workarounds ("must not improvise a workaround (asking the founder to paste API keys, fabricating a 'connected' status, etc.)"), delegates via `Task`/`subagent_type: connectors-liaison`, and states: "wait for its 'safe to proceed' answer before treating the CRM/scheduling tool as usable... never claim the CRM is wired up because the founder said so once." |
| `agents/gtm/fundraising-advisor.md` | **REAL CHECK** | "Real external tools (investor CRM, scheduling, e-signature)" section (lines ~72–85) covers `hubspot`/`calendly`/`docusign`, delegates via `Task`/`subagent_type: connectors-liaison`, and states: "Do not treat a connector as usable, and do not describe investor data as 'synced' or 'sent,' until connectors-liaison reports back that it's clear." |
| `agents/gtm/marketing-strategist.md` | **N/A** | Produces `gtm/positioning.md` and `gtm/content-calendar.md` only — no publishing, sending, or syncing action anywhere in the file. Grep for "connector" returns nothing. Correctly out of scope: per the catalog, the `webflow`/ad-platform/email moments belong to `launch-director`, not this agent. |
| `agents/ops/growth-analyst.md`* | *(listed under ops below — cross-referenced here since it's one of the 5 named callers)* | | |

\* `growth-analyst` and `finance-controller` are `agents/ops/*`, listed in the ops table below;
noted here only because they're two of connectors-liaison's five named callers.

## agents/ops/*.md (5 files)

| File | Verdict | Notes |
|---|---|---|
| `agents/ops/growth-analyst.md` | **REAL CHECK** | "Real external tools (analytics)" section (lines ~76–89) covers `google-analytics`, explicitly rules out fabricating a "connected" status or a plausible number, delegates via `Task`/`subagent_type: connectors-liaison` with task+category, and states: "Only treat the tool as usable once connectors-liaison reports clear; otherwise keep asking the founder directly per the skill's default path." Degrades gracefully to the founder-reported default rather than blocking. |
| `agents/ops/finance-controller.md` | **REAL CHECK** | "Real external tools (accounting, payments)" section (lines ~99–114) covers `quickbooks`/`stripe`, explicitly flags this as the catalog's highest-sensitivity category (bank-linked data, SSN/EIN), delegates via `Task`/`subagent_type: connectors-liaison`, and states: "Only treat the tool as a source of truth once connectors-liaison reports clear; otherwise keep asking the founder directly, every time, per the discipline above." |
| `agents/ops/operations-manager.md` | **N/A** | Pure coordinator — reads specialist outputs and writes the retro; never itself claims or performs a live external-tool action, and correctly delegates that responsibility down to `growth-analyst`/`finance-controller` (who do it correctly, per above) rather than duplicating or shortcutting it. Grep for "connector" returns nothing. |
| `agents/ops/customer-success-lead.md` | **N/A** | Works entirely from founder-reported churn/retention counts; no `intercom`/`zendesk`-style support-tool action anywhere in the file (that catalog row is post-launch support-ticket handling, a function this agent doesn't perform — it does retention *analysis*, not support). Grep for "connector" returns nothing. |
| `agents/ops/scaling-strategist.md` | **N/A** | Reads only plan files and prior ops snapshot files; asks the founder direct capacity/process questions. No external-tool action anywhere. Grep for "connector" returns nothing. |

## skills/gtm/*/SKILL.md (5 files) — all N/A

| File | Verdict | Notes |
|---|---|---|
| `skills/gtm/launch-plan/SKILL.md` | **N/A** | Assembles a sequencing document from already-produced GTM artifacts; explicitly "This skill's own output is the `gtm/launch-plan.md` file. It does not update `business-state.json`." No connector action. |
| `skills/gtm/positioning-and-messaging/SKILL.md` | **N/A** | Writes `gtm/positioning.md` only. |
| `skills/gtm/content-calendar/SKILL.md` | **N/A** | Writes `gtm/content-calendar.md` only — a *plan* for what to post where, never posts anything itself. |
| `skills/gtm/fundraising-deck-prep/SKILL.md` | **N/A** | Writes the deck brief and hands the `.pptx` build to the `pptx` skill (a local file-generation skill, not a connector) — no CRM/e-signature/scheduling action performed here; that's correctly `fundraising-advisor`'s job one layer up, per the catalog. |
| `skills/gtm/outbound-sales-playbook/SKILL.md` | **N/A** | Writes the playbook/target-tracker document; explicitly does not send or sync anything — that's `sales-lead`'s job one layer up. |

## skills/ops/*/SKILL.md (5 files) — all N/A

| File | Verdict | Notes |
|---|---|---|
| `skills/ops/weekly-metrics-review/SKILL.md` | **N/A** | Founder-reported numbers only, by explicit design ("Never fills in a metric the founder hasn't reported"); the live-analytics-pull path is `growth-analyst`'s job one layer up (REAL CHECK, above). |
| `skills/ops/runway-and-burn-tracking/SKILL.md` | **N/A** | Founder-reported cash/spend/revenue only, by explicit design; the accounting/payments-reconciliation path is `finance-controller`'s job one layer up (REAL CHECK, above). |
| `skills/ops/retention-and-churn-analysis/SKILL.md` | **N/A** | Founder-reported counts and segment-fit judgments only; no connector anywhere in scope for this skill (support/helpdesk tooling, if ever added, would be a separate function). |
| `skills/ops/scaling-readiness-check/SKILL.md` | **N/A** | Reads plan files, prior ops snapshots, and direct founder answers; no external-tool action. |
| `skills/ops/kpi-dashboard-setup/SKILL.md` | **N/A** | Writes the standing `ops/kpi-dashboard.md` reference from plan data; explicitly marks any KPI needing unwired instrumentation as "recommended, not yet trackable" rather than assuming a data source exists — this is the correct fail-closed behavior for *this* skill's scope (it never touches a connector, it just refuses to claim data it can't get). |

---

## No fixes owed to `agents/gtm/*` or `agents/ops/*` from this pass

Because every REAL CHECK file above is genuinely real (not asserted), and every N/A file is
genuinely clean (confirmed by grep, not just by not being read), **this pass has no exact-fix rows
to hand to the round's ops-skill-deepening reviewer.** The round 2 fix to the five agent files
held. If a future round extends any `skills/gtm/*` or `skills/ops/*` skill (or a new
`agents/ops/*` agent, e.g. a support/helpdesk specialist for the catalog's `intercom` row) to
perform a live external-tool action directly rather than staying a founder-reported/document-only
skill, that extension must add the same "Real external tools" pattern used in the five REAL CHECK
files above — delegate to `agents/connectors-liaison.md` via `Task`, name the concrete
task/category, and make any "done"/"sent"/"synced" claim conditional on connectors-liaison's
reported `available`-and-privacy-cleared status. That is not a gap today; it is the trap the next
extension could fall into if it copies a document-writing skill's shape instead of an
agent-layer connector delegation's shape.

---

## What I tightened in the two files I own (Part B of this pass)

I own exactly `agents/connectors-liaison.md` and
`skills/connectors/discover-and-suggest-connector/SKILL.md` for this round. I did not edit any
`agents/gtm/*`, `agents/ops/*`, `skills/gtm/*`, or `skills/ops/*` file — the table above is what a
future round acts on if a real gap ever appears there.

While confirming the five REAL CHECK callers' fail-closed language was unambiguous, I found one
real ambiguity **in `agents/connectors-liaison.md` itself**, not in any caller file: the "Report
back to the calling agent" section (old §6) told a caller *that* a connector is not safe to use,
and gave it the single outstanding blocker, but then said only that the caller "can decide whether
to pause its task or continue with a different, unblocked part of it" — without saying what
"continue" is actually supposed to look like. Read literally, a caller could take that as license
to silently skip the connector-dependent portion of its deliverable, or, at the other extreme, to
block its entire task rather than deliver what it safely can. Neither reading is what
`docs/ARCHITECTURE.md`'s "connectors layer" section actually specifies (produce the artifact that
*would have been sent*, as a file the founder can act on manually, and log the gap — never pretend
the action happened, and never let the rest of a deliverable go undelivered just because one piece
of it needed a missing connector) — but that specification lived only in `ARCHITECTURE.md`, not in
the gate file itself, so a caller reading only `connectors-liaison.md`'s own contract (the
document every caller is actually pointed at) didn't have an unambiguous instruction to follow.
This is exactly the class of gap this round's audit was commissioned to catch, just located one
level up from the caller files rather than inside any of them.

**Fixed:** `agents/connectors-liaison.md`'s "Report back to the calling agent" section (renumbered
§6) now states the required caller behavior explicitly and by name — not-safe-to-proceed means the
live connector action is blocked and must not be claimed as done, but the caller's *task* is not
blocked wholesale: it must still produce whatever artifact/deliverable it can complete without the
connector (a drafted document, a target tracker, a metrics file — whatever the task would have
produced short of the live send/sync/pull), explicitly mark the connector-dependent piece as
pending with the exact outstanding blocker connectors-liaison reported, and never omit that pending
item silently. I also added one sentence to the "🛑 MANDATORY GATE" callout at the top of the file
cross-referencing this so it's visible on first read, not only in §6.

I did not find a comparable ambiguity in `skills/connectors/discover-and-suggest-connector/SKILL.md`
— that file never makes the "safe to proceed" call itself (it only detects and prompts, and its own
"How to invoke me" contract and "What I never do" section are already unambiguous about that
boundary), so I made no changes there. I considered whether its `status` enum needed a matching
note, but the ambiguity was entirely on the caller-facing consequence of a non-`available` status,
which is `connectors-liaison.md`'s responsibility to specify, not this skill's.
