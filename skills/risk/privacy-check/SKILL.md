---
name: privacy-check
description: >
  The callable privacy/legal-scope gate for the AI EIR plugin, backed by
  agents/risk/privacy-compliance-officer.md. Use it in exactly two situations: (a) once, during
  onboarding, right after the founder's basic business info is captured, to set expectations
  about what's stored locally and why and to state the legal-advice scope boundary once; and
  (b) as a mandatory pre-send gate, invoked by any GTM/ops skill (skills/gtm/*, skills/ops/*) or
  the connectors flow (agents/connectors-liaison.md) immediately before founder or prospect data
  is pushed to a real external connector — an email tool, a CRM, a payments processor, an ad
  platform. Triggers: "onboarding privacy notice," "check before we send this to the CRM,"
  "connector gate," "is this okay to sync," "privacy check," "before we load this contact list."
  Never skip the pre-send gate because a send seems routine — every real external transmission of
  founder or prospect data goes through it first.
---

# Privacy Check

You are the callable entry point for privacy/data-handling/legal-scope review. You are thin by
design: you determine which mode you're in, gather what `agents/risk/privacy-compliance-officer`
needs, delegate the actual judgment to that subagent, and make sure its output lands in the right
place. You do not make privacy/legal-basis judgment calls yourself — that's the subagent's job;
read `agents/risk/privacy-compliance-officer.md` before running this skill.

> ## 🛑 MANDATORY GATE — DO NOT SKIP
>
> **Mode A (onboarding notice):** any skill running the founder's first business-basics capture
> must call this skill, in Mode A, once, immediately after those basics are captured and before
> any Disciplined Entrepreneurship step begins. Pass: nothing beyond the `business-slug` — Mode A
> reads no external input, it delivers a fixed notice. Non-blocking by design (it cannot "fail");
> **skipping it entirely** is the violation — a founder who starts DE step 1 without having heard
> the local-storage/legal-scope notice has been let past a gate this plugin promises every founder
> crosses exactly once.
>
> **Mode B (pre-send gate):** any skill or agent about to move real founder/prospect data into an
> external connector must call this skill, in Mode B, **immediately before that send, every single
> time**, with no exceptions for "it's just an email" or "the connector's already wired up."
>
> **What to pass in, every Mode B call:**
> 1. What data is about to move (fields/records, not necessarily every raw value) and where it
>    came from.
> 2. Which connector it's going to (must match `business-state.json.connectors`).
> 3. What the founder has said, if anything, about consent/legal basis for this specific data.
>
> **What "clear" looks like:** the calling skill/agent may proceed with the send; any `risk_log`
> entry filed for the record is reported back for reference, not as a blocker.
>
> **What "blocked" looks like:** the calling skill/agent may **not** proceed. The specific finding
> and specific fix are relayed in plain terms. The only way past a block is the founder explicitly
> and knowingly overriding it (named risk, explicit "yes, override," `risk_log` entry updated to
> `accepted` with a note) — never a silent pass-through, never the calling skill's own judgment
> standing in for this gate's.
>
> **If a caller skips this entirely:** that send has not been cleared, regardless of how routine it
> seemed — this is precisely the scenario Mode B exists to prevent, and a caller that sends first
> and rationalizes after has violated this file's contract, not found a shortcut around it.
> `docs/QA-FINDINGS-GATES-ROUND2.md` is the current audit of which expected callers actually make
> this call — check it before assuming a given caller already complies.

This skill runs in one of two modes. Determine which one you're in from how you were invoked.

## Mode A — Onboarding notice (run once per business)

**When:** Called by the orchestrator (or `skills/interview/onboarding-interview`) once, right
after the founder's business name and basic info are captured, before Disciplined Entrepreneurship
steps begin. This should happen exactly once per business — check
`business-state.json.risk_log` for an existing entry with `id` starting `privacy-onboarding-` for
this slug before running it again; if one exists, skip straight to confirming nothing has
changed rather than re-running the full notice.

**What to do:**

1. Tell the founder, in plain language, before any further data is collected:
   - Everything captured in this session — their answers, business details, any prospect
     information they mention — is written to `.startup/<slug>/` on their own machine/environment.
     Nothing leaves that local directory automatically.
   - The only thing that ever transmits data externally is an explicit connector action they
     approve later (loading a list into an email tool, syncing to a CRM, etc.) — and that always
     goes through this same gate (Mode B) first.
   - This plugin produces business-planning content, not legal advice. Entity formation, IP
     protection, employment law, securities/fundraising compliance, and data-protection-regime
     compliance (GDPR/CCPA and similar) are all real legal questions this plugin will flag when
     they come up, but a real professional — not this plugin — is who resolves them. State this
     once here; it does not need restating on every later output (CONVENTIONS §7).
   - Ask the founder plainly: don't paste real customers' or prospects' sensitive personal data
     (health, financial, or similarly sensitive information about identifiable individuals) into
     answers meant for business planning. Ordinary planning content — market segments, personas,
     a handful of real prospect names/emails as part of an active outreach list — is fine and
     expected; bulk contact exports or sensitive personal data are not what plan files are for.
2. Delegate to `agents/risk/privacy-compliance-officer.md` to confirm the notice content is
   current against `docs/PRIVACY-AND-DATA-HANDLING.md` (that doc is the source of truth if the
   two ever drift) and to log the onboarding notice.
3. Write to `business-state.json.risk_log`:
   ```json
   {
     "id": "privacy-onboarding-<slug>",
     "type": "privacy",
     "raised_by": "privacy-check (onboarding)",
     "description": "Onboarding privacy/data-handling and legal-scope notice given to founder on <date>.",
     "status": "accepted"
   }
   ```
   (`status: "accepted"` here just means "delivered and acknowledged," not that a risk was
   found — it's the durable record the notice happened, consistent with never leaving a
   meaningful event unlogged.)
4. Report back to the orchestrator/onboarding skill: notice delivered, logged, continue
   onboarding.

## Mode B — Pre-send connector gate (mandatory, every real external send)

**When:** Called immediately before any of the following, with zero exceptions:
- Any `skills/gtm/*` skill about to push contact/prospect data into an external tool (loading a
  list into an email platform, syncing leads to a CRM, pushing an audience to an ad platform)
- Any `skills/ops/*` skill about to send business or customer data to an external analytics,
  finance, or payments tool
- `agents/connectors-liaison.md`, at the point it's about to actually wire a connector and move
  real data through it (not at the point of merely registering that a connector is needed —
  that's a `connectors.needed_not_installed[]` entry and doesn't require this gate; the gate
  applies once real founder/prospect data is about to flow)

**Calling contract:** the calling skill/agent must supply, before this gate can clear anything:
1. What data is about to move (a description of the fields/records, not necessarily every raw
   value) and where it came from.
2. Which connector it's going to (must match an entry in `business-state.json.connectors`).
3. What the founder has said (if anything) about consent/legal basis for this specific data.

**What to do:**

1. Read `business-state.json` in full (including its `connectors` key) and the specific
   plan/gtm/ops file the data is drawn from.
2. Delegate to `agents/risk/privacy-compliance-officer.md`, handing it exactly what the calling
   skill supplied. It runs the four-part connector gate check (data minimization, legal basis,
   undisclosed-collection check, destination-ownership check — full detail in that agent's file)
   and returns **clear** or **blocked**, with a `risk_log` entry either way if warranted (see that
   agent's §2 and §4 for when a clean clear still gets logged).
3. **If clear:** tell the calling skill/agent it may proceed, and note any `risk_log` entry the
   officer filed for the record.
4. **If blocked:** the calling skill/agent must not proceed with the send. Relay the officer's
   specific finding and the specific fix needed (e.g., "founder needs to confirm this list is
   opt-in outreach before it goes to the email tool," or "this field set includes sensitive
   personal data — strip it before syncing, or get explicit founder sign-off to proceed with the
   risk accepted and logged"). If the founder chooses to proceed anyway despite a block, that is
   a founder override exactly like the orchestrator's review-gate override
   (`agents/orchestrator.md` non-negotiable #3): get an explicit "yes, override" from the founder,
   naming the specific risk, then update the `risk_log` entry to `status: "accepted"` with a note
   of the override — never silently wave a block through.
5. Report the outcome back to whichever skill/agent called this gate. Do not let a connector send
   proceed without an explicit clear-or-override recorded.

## Who is expected to call this gate

This skill is useless if the skills that actually move data don't call it. The following are
expected integration points, even though this builder does not own those files:

| Caller (owned elsewhere) | Calls this skill | Mode |
|---|---|---|
| `skills/interview/onboarding-interview` | once, right after business basics are captured | A |
| Any `skills/gtm/*` skill before an external send (list import, CRM sync, ad audience push) | every time, before the send | B |
| Any `skills/ops/*` skill before an external send (analytics/finance/payments sync) | every time, before the send | B |
| `agents/connectors-liaison.md` | before actually moving real data through a newly-wired connector | B |

If you are implementing one of the caller files above and this gate doesn't exist yet or hasn't
been wired in, that's a bug in the integration, not a reason to skip it — add the call.

## What this skill reads

- `business-state.json` (whole file, including its `connectors` key — there is no separate
  `connectors.json` file)
- `docs/PRIVACY-AND-DATA-HANDLING.md`
- The specific plan/gtm/ops file(s) relevant to the current check

## What this skill writes

- `business-state.json.risk_log` (via the privacy-compliance-officer subagent) — append/update
  only, never blind-overwrite

## Done looks like

- **Mode A:** founder has heard the local-storage explanation, the legal-scope boundary, and the
  "don't paste in sensitive real customer data" guidance, exactly once, and it's logged.
- **Mode B:** every real external send has an explicit clear or blocked-then-resolved decision
  recorded in `risk_log`, and the calling skill only proceeds after that decision, never before or
  around it.
