# Connectors Catalog

Authoritative reference for `agents/connectors-liaison.md` and
`skills/connectors/discover-and-suggest-connector/SKILL.md`. Every builder whose agent/skill
needs a real external tool should check this doc first — it's the map from "what step/task needs
a tool" to "which category, which real products, what data moves, what to check before it moves."

If a category or connector you need isn't listed here, add a row in the same change that
introduces the need — don't invent an ad hoc category name inline in an agent/skill file.

## Naming convention

`business-state.json.connectors.wired_up[]` and `connectors.needed_not_installed[].connector`
must use the **Canonical id** from the table below (lowercase, kebab-case) — never a free-text
product name — so every agent/skill that reads `connectors` can match on it reliably. If a
founder connects a product not listed here, add a row rather than inventing an id inline.

## Catalog

| Category | Canonical id | Example real tools | DE step / GTM-ops task that creates the need | What data would flow through it | Privacy consideration to check first |
|---|---|---|---|---|---|
| Payments | `stripe` | Stripe, Paddle, Lemon Squeezy | GTM launch — `agents/gtm/launch-director.md` wiring up checkout/pricing on the launch page (post step 22 MVBP, step 16 pricing framework); ops — `agents/ops/finance-controller.md` reconciling payouts against COCA/LTV assumptions (steps 17/19) | Customer name + email, tokenized card/payment-method reference (never a raw card number — that must never transit this session), transaction amounts, subscription/plan status, refund/dispute records | PCI DSS scope: confirm only tokenized references touch the agent, never raw PANs. Confirm the Stripe account is under the founder's real legal entity/bank account before any live (non-test-mode) charge is initiated. |
| Email / comms | `gmail` (or `google-workspace`) | Gmail / Google Workspace, Outlook / Microsoft 365 | GTM — `agents/gtm/launch-director.md` sending the launch announcement; `agents/gtm/sales-lead.md` running outbound/follow-up sequences to the Step 9 "next 10 customers" list | Prospect/customer email addresses, message subject/body content, thread history if the scope is read+send rather than send-only | Many email connectors grant broad inbox read access by default, not just "send." Confirm the actual granted scope (send-only vs. full inbox read) before use, and confirm each recipient has a lawful basis to be emailed (opt-in, existing relationship, or CAN-SPAM/GDPR-compliant cold outreach) — this is a founder compliance question, not just a technical one. |
| Team comms | `slack` | Slack, Microsoft Teams | Ops — `agents/ops/growth-analyst.md` and `agents/ops/finance-controller.md` posting metrics/retro summaries to a founder or team channel | Message content posted by the agent; if read access is also granted, existing channel history (which may include content unrelated to this business) | Scope to a specific channel/workspace where possible rather than workspace-wide read access; never post financial or customer PII to a channel wider than intended without the founder confirming who's in it. |
| CRM | `hubspot` (or `salesforce`, `pipedrive`) | HubSpot, Salesforce, Pipedrive, Close | GTM — `agents/gtm/sales-lead.md` logging and tracking the Step 9 next-10-customers list and the Step 12/13 DMU/acquisition-process stages per prospect; `agents/gtm/fundraising-advisor.md` tracking the investor pipeline | Prospect/customer/investor names, emails, company, title, deal/pipeline stage, free-text notes (which can include sensitive negotiating detail or personal opinions about the contact) | CRM notes are an easy place for sensitive judgments about a named person to accumulate — treat note content as PII-adjacent. Confirm data retention/export settings and who besides the founder can see the CRM before logging anything sensitive. |
| Accounting | `quickbooks` (or `xero`) | QuickBooks Online, Xero, Wave | Ops — `agents/ops/finance-controller.md` bookkeeping, reconciling Stripe payouts, tracking burn/runway that feeds `quantitative_claims` and ops metrics snapshots | Full transaction ledger (revenue, expenses, vendor names + amounts), linked bank-account data, and — for contractor payments — SSN/EIN used for 1099 reporting | Highest-sensitivity category in this catalog: full bank-linked financial visibility. Prefer read-only/reporting scopes over write access where the task allows. Contractor SSN/EIN is regulated PII — never let it land in `plan/`, `gtm/`, or any founder-facing markdown; it stays inside the accounting tool. |
| Website / landing page | `webflow` (or `framer`, `squarespace`, `vercel`) | Webflow, Framer, Squarespace, WordPress, Vercel/Netlify (custom-code sites) | GTM — `agents/gtm/launch-director.md` publishing the launch/landing page validating Step 22 (MVBP) and driving the Step 4/14 TAM funnel | Page copy and structure via the connector itself; indirectly, whatever the *published site* collects from visitors (signup forms, embedded chat, cookies) once live | The connector transfers only content, but confirm the site has a privacy policy live before launch if it collects any visitor data (email capture, waitlist form, embedded analytics/chat) — that's a launch-gate item, not a nice-to-have. |
| Analytics | `google-analytics` (or `plausible`, `posthog`) | Google Analytics / GA4, Plausible, PostHog, Mixpanel | Ops — `agents/ops/growth-analyst.md` producing `ops.cadence_metrics_files` snapshots; `agents/gtm/fundraising-advisor.md` citing traction numbers, which must be sourced per the Data Contract's `quantitative_claims` rule | Visitor/user behavioral events, page views, conversion funnel data, and — depending on tool/config — IP addresses or device identifiers | Cookie-consent requirements (GDPR/ePrivacy) apply the moment this is live on a public site. Confirm IP anonymization / consent-mode configuration before treating any number it produces as a clean `quantitative_claims` source. |
| Code hosting | `github` (or `gitlab`) | GitHub, GitLab, Bitbucket | Software businesses only — GTM/ops referencing build or release activity (e.g. `agents/ops/growth-analyst.md` citing shipped-feature velocity, `agents/gtm/launch-director.md` linking release notes) | Source code, issue/PR text, commit history, contributor identities | Never let secrets/API keys committed in the repo (even accidentally) flow into `plan/`, `gtm/`, or any founder-facing doc. Confirm repo visibility (public vs. private) before referencing specific code or metrics in investor-facing material. |
| Scheduling | `calendly` (or `cal-com`, `google-calendar`) | Calendly, Cal.com, Google Calendar | GTM — `agents/gtm/sales-lead.md` booking prospect/customer calls from the Step 13/18 acquisition process; `agents/gtm/fundraising-advisor.md` booking investor meetings | Prospect/investor name, email, meeting time, and — if calendar read access is granted rather than a dedicated booking link — the founder's full calendar contents | Calendar connectors frequently expose the founder's *entire* calendar, not just business meetings. Scope to a dedicated business calendar or booking-page-only access where the environment allows it, so personal appointments never enter agent context. |
| Ad platforms | `google-ads` (or `meta-ads`, `linkedin-ads`) | Google Ads, Meta Ads Manager, LinkedIn Campaign Manager | GTM — `agents/gtm/launch-director.md` running paid acquisition per the launch plan | Campaign spend and performance, audience targeting parameters, and — for lookalike/retargeting audiences — uploaded customer contact lists | Uploading a customer list for lookalike/retargeting requires a documented consent basis under most ad platforms' current policies and applicable privacy law — confirm consent basis before any customer list is uploaded, not after. |
| Support / helpdesk | `intercom` (or `zendesk`, `front`) | Intercom, Zendesk, Front | Ops — post-launch customer support handling once `stage: operating` | Customer support conversation content, which routinely includes account details, complaints, and other personal detail volunteered by the customer | Confirm retention policy and who (besides the founder) has read access before connecting; support transcripts are a common place sensitive personal detail ends up without anyone deciding it should. |
| E-signature / legal | `docusign` (or `pandadoc`) | DocuSign, PandaDoc, HelloSign | GTM — `agents/gtm/fundraising-advisor.md` sending SAFEs/term sheets; `agents/gtm/sales-lead.md` sending customer contracts | Legally binding signed documents, counterparty PII, and deal/financial terms | Highest confidentiality tier here: signed terms should never be summarized into an unrelated plan section or shared context without the founder's explicit go-ahead — treat as need-to-know even within the agent's own outputs. |

## How to read "example real tools"

The list under "Example real tools" is illustrative, not exhaustive or exclusive — a founder may
already use something else in the category (e.g. Freshbooks instead of QuickBooks). When that
happens, `skills/connectors/discover-and-suggest-connector` still checks/prompts for the
founder's actual tool; use the row's **category**, **data**, and **privacy consideration**
columns as the template and record the founder's actual product as the `connector` value
(add a canonical id for it here if it'll recur).

## Privacy check is mandatory, not advisory

Every row above has a privacy consideration for a reason: `agents/connectors-liaison.md` must
route through `skills/risk/privacy-check` (Mode B — see that skill's "MANDATORY GATE" callout for
the exact invocation contract) before any data actually flows through a connector, using this
table's "what data would flow" and "privacy consideration" columns as the starting brief for that
check — not as a substitute for it.

## Getting to the connector in the first place is also mandatory

The catalog rows above name, per category, which `agents/gtm/*`/`agents/ops/*` agent is expected
to need that connector — but naming the need in this table doesn't make the agent actually
delegate to `agents/connectors-liaison.md` when the moment comes; see that agent's own "MANDATORY
GATE" callout for its invocation contract, and `docs/QA-FINDINGS-GATES-ROUND2.md` for the current
audit of which of the agents named in this catalog actually make that call today.
