---
name: discover-and-suggest-connector
description: >
  Use whenever agents/connectors-liaison.md needs to determine, for one specific connector, (a)
  whether it's already available in the current Claude Code environment, and (b) if not, whether
  the environment exposes any capability for suggesting/installing/connecting external tools —
  and if so, invoke it to prompt the founder. Triggers: "check if <tool> is connected," "find a
  way to connect <tool>," "suggest the founder connect <tool>," "is there a connector for X in
  this environment." Not typically invoked directly by founder-facing flows — it's the mechanics
  skill connectors-liaison delegates to; it does the environment inspection and, where possible,
  the actual prompt, then returns a structured result. Never invokes a connector to move real
  data itself — detection and prompting only.
---

# Discover and Suggest Connector

You perform one bounded task: given a connector need, figure out whether it's already usable in
*this session, right now*, and if not, get the founder prompted to connect it — using whatever
mechanism this specific environment actually provides. Environments differ (Claude Code CLI,
Claude Code web, Claude.ai with connectors enabled, a bare API integration with no connector
concept at all), so you inspect rather than assume.

> ## How to invoke me — the contract
>
> My only caller is `agents/connectors-liaison.md`, for Step A (always) and Steps B/C (only when
> Step A doesn't find a live match) of its own "identify → check → surface → gate" sequence. I am
> not a substitute for that agent's privacy gate (step 4) and I never touch it — I only detect and
> prompt.
>
> **What the caller must give me:** `category`, `canonical_id`, a real (non-generic) `purpose`
> sentence, `needed_by_step`, and the founder's `business_name`. A missing or generic `purpose`
> ("we might need it") is not a valid call — I send it back rather than guessing at one.
>
> **What I always return:** the structured shape at the bottom of this file — `connector`,
> `category`, `status`, and whichever of `matched_tool`/`capability_used`/`founder_message`/
> `detail` applies. I never return a bare "yes"/"no" — the caller's next action depends on which
> exact `status` I report, not just whether it was good or bad news.
>
> **What I never do, regardless of how the caller invokes me:** report `available` or `prompted`
> without having actually found/invoked a real tool this turn, invoke a connector's own domain
> tool (send the actual email, create the actual charge), or write to `business-state.json` — see
> "What you never do" below for the full list. If a caller seems to want any of those from me,
> that caller has the contract wrong, not me.

## Input you need from the caller (`agents/connectors-liaison.md`)

- `category` and `canonical_id` — from `docs/CONNECTORS-CATALOG.md` (e.g. category `payments`,
  id `stripe`).
- `purpose` — one plain-language sentence: what this specific connector will be used for, tied to
  the task that needs it (e.g. "to create a checkout link for the launch pricing page").
- `needed_by_step` — the step/task reference driving the need (e.g. `gtm.launch-director:
  publish-landing-page`).
- The founder's `business_name` (for a natural-sounding prompt, if you compose one yourself).

Do not proceed without a `purpose` string — "we might need it" is not a valid input; send it back
to the caller if `purpose` is missing or generic.

## Step A — Detect current availability

1. Enumerate every tool actually available to you in this session, including any deferred/
   searchable tool registry the environment exposes (e.g. a tool-search mechanism that surfaces
   additional callable tools by keyword — check for one before concluding a tool doesn't exist;
   don't judge availability from the visible tool list alone if a search mechanism is present).
2. Match tool names/descriptions against the `canonical_id` and the "Example real tools" row in
   `docs/CONNECTORS-CATALOG.md`. Connectors typically surface as tools namespaced to the service
   (e.g. a tool name or prefix containing the product name — `stripe`, `gmail`, `hubspot`,
   `github`, `slack`). Search on the product name, common abbreviations, and the category itself.
3. Cross-check against `business-state.json.connectors.wired_up`, but treat the **live tool
   scan as ground truth, not the state file** — a connector recorded as wired up in a prior
   session may have been disconnected since (tokens expire, founders revoke access). If the state
   file says wired up but no matching tool is present in this session, report the discrepancy
   back to the caller as `status: "state_stale_not_actually_available"` rather than silently
   trusting the old record or silently overwriting it yourself — the caller owns the state write.
4. If a match is found and it is live in this session: return
   `status: "available", matched_tool: "<tool name found>"`. Stop here — do not proceed to Step B
   or C.

## Step B — If not available, look for a connector-discovery/suggestion capability

1. Search the tools available to you (and any deferred-tool search mechanism, per Step A.1) for
   one whose name or description indicates it can browse, suggest, install, or initiate a
   connection to an external tool/integration/connector for the founder — this is a capability
   about *adding new tools to the environment*, distinct from the domain tools themselves. Look
   for description language like "connector," "integration," "connect an account," "directory,"
   "marketplace," "install," "add a tool" — the exact tool name is not fixed across environments,
   so match on intent, not a specific string.
2. If you find a plausible candidate, try it with query terms in this order until one succeeds:
   the connector's real product name (e.g. "Stripe"), the `canonical_id`, then the `category`
   (e.g. "payments"). Confirm the result is actually about connecting *this* tool before using it
   — a near-miss (wrong product, wrong category) is worse than no match.
3. If invoking it succeeds in surfacing a connect/install prompt to the founder: pass through
   your `purpose` string as the explanation shown to them if the capability accepts one. Do not
   let the prompt imply data has already moved — the accurate framing is "connecting this lets
   [purpose]; nothing is sent until you approve the connection and then approve each action that
   uses it."
4. Return one of:
   - `status: "prompted", capability_used: "<tool name>", founder_message: "<what was shown or
     would be shown to the founder>"` — you successfully surfaced the prompt.
   - `status: "capability_found_but_failed", capability_used: "<tool name>", detail: "<what went
     wrong>"` — a plausible capability existed but didn't complete (bad params, environment
     declined, no matching integration in its directory for this specific product). Fall through
     to Step C in this case — don't leave the caller with nothing.

## Step C — No discovery/suggestion capability exists (or Step B fell through)

This is the honest-fallback path. Do not imply anything got connected.

1. Pull this connector's row from `docs/CONNECTORS-CATALOG.md` (category, example real tools,
   data that would flow, privacy consideration).
2. Compose a short, plain-language explainer for the founder, in this shape:
   - **What it is**: the real product name(s) from the catalog row.
   - **Why now**: the specific task/step driving the need (`needed_by_step` verbatim, in plain
     English — not the internal key).
   - **What data would move through it**: from the catalog row, in plain terms.
   - **What to do**: a concrete manual action — sign up / log in at the real product, generate
     the specific credential type needed (e.g. "a restricted API key," "an OAuth app"), and how
     to hand it back (e.g. "tell me when it's set up and I'll pick up from there," or, if this
     environment supports adding MCP servers/connectors via configuration, name that path
     generically without assuming a specific config file location you haven't verified exists).
   - State plainly: "This environment doesn't currently expose a way for me to connect this
     automatically — you'll need to do this step yourself." Never soften this into ambiguity.
3. Return `status: "needs_manual_setup", founder_message: "<the explainer text>"`.

## What you never do

- Never report `status: "available"` or `"prompted"` without having actually found/invoked a
  real tool this turn — no guessing, no "probably fine."
- Never invoke a connector's own domain tool (e.g. actually create a Stripe charge, send a Gmail
  message) — that's downstream of the privacy-check gate the caller runs, and out of scope here.
- Never write to `business-state.json` yourself — you return a structured result; the caller
  (`agents/connectors-liaison.md`) owns reading and writing state so writes stay centralized and
  race-free.

## Return shape (always report this back to the caller)

```
connector: <canonical_id>
category: <category>
status: available | prompted | capability_found_but_failed | needs_manual_setup | state_stale_not_actually_available
matched_tool / capability_used: <tool name, if applicable>
founder_message: <exact text shown or to be shown to the founder, if applicable>
detail: <free text, if status needed one>
```
