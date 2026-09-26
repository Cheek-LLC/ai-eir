---
name: 04-assets
description: >
  Use once a business is ready to market or sell to real prospects and needs to decide which
  visual assets (website, brand mark, deck, ad creative, video/animation) actually matter for
  this specific GTM motion, and in what order to build them — runs Tactic 4, Developing Startup
  Visual Assets. Triggers: "what assets do we actually need," "asset plan for launch," "what
  should we build first, the site or the deck," "sequence our marketing assets." Decides WHICH
  assets and WHEN; delegates actual production to `skills/design/brand-identity`,
  `skills/design/landing-page`, and the built-in `pptx`/`design` skills rather than
  re-specifying how to build any of them.
---

# Tactic 4: Assets — Developing Startup Visual Assets

## Role in the 15 tactics

Third of four Market Testing tactics. By the time a founder needs this tactic, Tactic 3 has
(or is) sharpening the plan's assumptions, and Tactic 5 (advertising) and Tactic 6 (sales) are
about to need real things to point prospects at — a page to send them to, a mark that makes the
business look like a real company, collateral a rep can leave behind. This tactic's job is not
to build any of those things itself. Its job is to decide, for *this* business's actual GTM
motion, which assets are genuinely needed, which aren't, and in what order to build them — then
hand each one to the skill that actually produces it. Treat this as a triage and sequencing
exercise, not a design exercise.

## What you read

- `.startup/<slug>/business-state.json` — whole file. Read `gtm.artifacts` first, to see what's
  already been produced (don't recommend rebuilding a `brand-identity` or `landing-page` entry
  that already exists — recommend a refresh only if the plan or positioning has materially
  changed since). Read `gtm.status` and `gtm.funding_strategy`.
- `.startup/<slug>/plan/09-identify-your-next-10-customers.md` — **required**. The actual
  acquisition motion (outbound to named targets, inbound content, a marketplace/platform listing,
  warm referral) is what determines which assets matter first. An outbound-only motion doesn't
  need a polished explainer video before it needs a credible page to send a prospect to; a
  content/inbound motion needs the reverse priority.
- `.startup/<slug>/plan/08-quantify-the-value-proposition.md` — the claim every asset should
  ultimately carry.
- `.startup/<slug>/gtm/positioning.md`, if it exists — the messaging pillars every asset's content
  should draw from, so this tactic isn't guessing at message before positioning work exists.
- `.startup/<slug>/design/brand-identity.md`, if it exists — read it to check whether the naming/
  tagline/voice/color-and-type direction is already settled (a precondition for most other
  assets looking coherent, not an independent decision this tactic makes).

If `gtm/positioning.md` doesn't exist yet, note it as a dependency for asset *content* (copy,
messaging) even though it doesn't block this tactic's triage/sequencing work itself.

## 1. Determine what this business's GTM motion actually needs

Read Step 9 and, if present, `gtm.funding_strategy`/`gtm/outbound-sales-playbook.md`, to classify
the primary motion:

- **Outbound-led** (named prospects, a rep or founder reaching out directly): needs a credible
  landing page and short sales collateral (one-pager, a lean deck) before it needs polished video
  or paid ad creative — the asset exists to close a warm conversation someone else already
  started, not to stop a stranger's scroll.
- **Paid-digital-led** (this business's Tactic 5 will run ad spend): needs ad creative variants
  and a conversion-focused landing page early, and can defer a full brand system or explainer
  video until the ad test itself (Tactic 5) has told you which angle works.
- **Content/inbound-led**: needs a landing page and a content-ready visual system (templates,
  a recognizable look across posts) earlier than sales collateral — coordinate with
  `skills/gtm/content-calendar` on what visual formats its calendar actually calls for, rather
  than guessing.
- **Fundraising-adjacent** (plan/`funding_intent` signals raising capital soon): a pitch deck
  moves up the priority order even if customer-facing assets aren't otherwise urgent yet.

State the classification and reasoning explicitly in the output file — this is the single
decision that drives everything else in this tactic.

## 2. Build the asset inventory — needed now / later / not needed

For each candidate asset type, decide a status and give one line of GTM-motion-grounded
reasoning. Do not default every asset to "needed now" — a real triage says no to some of these:

| Asset | Typical trigger to build it now |
|---|---|
| Brand identity (name check, tagline, voice, color/type direction) | Almost always first — nearly every other asset depends on it. |
| Landing page | As soon as any outbound, ad, or content motion needs somewhere to send a prospect. |
| Sales one-pager / lean deck | Outbound-led motion, or any motion with a real sales conversation happening. |
| Pitch deck (investor) | `funding_intent`/`gtm.funding_strategy` is `raising_outside_capital` and fundraising is imminent (Tactic 14), not merely "someday." |
| Product screenshots / mockups | Any asset (page, deck, ad) that needs to show the product and a working build or prototype exists to screenshot. |
| Ad creative (static/carousel) | This business will run Tactic 5's digital-advertising test. |
| Explainer video / animation | Genuinely warranted only once the core message is validated (post Tactic 5, or a motion where video is the primary channel, e.g. TikTok/short-form-led consumer) — building a polished video around a message that hasn't been tested yet risks investing production effort in the wrong story. |
| Email templates | An outbound or lifecycle-email-dependent motion. |

## 3. Sequence the "needed now" set

Order matters because these assets depend on each other:

1. **Brand identity first**, if `design/brand-identity.md` doesn't exist — every other asset's
   voice, tagline, and color/type direction traces back to it. Say explicitly: "run
   `skills/design/brand-identity` before anything else on this list."
2. **Landing page next** — it's the hub every other asset (ad, email, sales collateral) links
   back to, and it needs the brand direction settled to look coherent. Say explicitly: "run
   `skills/design/landing-page`, supplying it the brand-identity brief."
3. **Motion-specific collateral** after that — sales one-pager/deck for outbound, ad creative for
   paid-digital, content-ready templates for inbound — each pulling copy from
   `gtm/positioning.md` and visual direction from `design/brand-identity.md`, never freelancing
   new brand choices at this stage.
4. **Video/animation and anything requiring true production tooling** last, and only once
   flagged genuinely needed in §2 — be honest that this plugin's built-in `design`/`pptx` skills
   produce static artboards, decks, and pages, not rendered video or animation; a real video/
   animation need is a hand-off to a human editor or an external video tool, not a task this
   tactic or its delegate skills can execute end-to-end. Say this plainly rather than implying a
   capability that doesn't exist.

## 4. Delegate production — never re-specify it here

For every asset in the "needed now" sequence, name the exact skill that produces it and do not
duplicate its instructions:

- Brand name/tagline/voice/color-type direction → `skills/design/brand-identity` (produces
  `design/brand-identity.md`).
- Landing page → `skills/design/landing-page`, which itself invokes the built-in `design` skill
  to lay out and publish the actual page (produces `design/landing-page-brief.md` + a live URL).
- Investor deck → the built-in `pptx` skill (or `skills/design/pitch-deck` if this plugin has a
  dedicated skill for it) for the actual slide file; this tactic's job is only flagging that it's
  now time, not laying out slides.
- Sales one-pager → the built-in `design` skill for layout, fed by `gtm/positioning.md` copy.
- Ad creative → the built-in `design` skill for static/carousel formats, fed by the specific
  angles Tactic 5 defines — coordinate directly with that tactic rather than inventing creative
  independent of the hypotheses it's meant to test.

If a needed asset has no existing skill to delegate to in this plugin (most likely: rendered
video/animation), say so explicitly rather than attempting to hand-roll it here.

## What you write

Write `.startup/<slug>/tactics/04-assets.md`:

```markdown
# Tactic 4: Assets — Visual Asset Plan

## GTM motion driving asset priority
(classification + reasoning, from §1)

## Asset inventory
| Asset | Needed now / later / not needed | Why | Produced by |

## Sequencing plan
1. ...
2. ...

## Status tracker
| Asset | Status (not started / in progress / delegated to <skill> / complete) | File or URL |

## What this tactic does not do
(no logo files, no rendered video/animation, no layout decisions — those belong to the named
delegate skills)

## Done means
```

This skill does not write to `business-state.json` itself — not the `tactics.04_assets` entry,
and not `gtm.artifacts` (that stays owned by the delegate skills that actually produce each
asset, e.g. `brand-identity` and `landing-page` already write their own `gtm.artifacts` entries).
State plainly in your report to whoever invoked you: the recommended `tactics.04_assets`
status/summary. The orchestrator applies it to `business-state.json` after confirming
`tactics/04-assets.md` exists and is complete — the same handoff pattern the Disciplined
Entrepreneurship step skills use for their own plan files.

## Done means

- The GTM motion classification is stated and grounded in Step 9, not assumed.
- Every candidate asset has an explicit needed-now/later/not-needed call with reasoning tied to
  that motion — no asset defaulted to "needed" just because it's common to build.
- The sequencing plan names, in order, the exact delegate skill for each needed-now asset.
- The file states plainly which needed assets (if any) this plugin genuinely cannot produce
  (e.g. rendered video/animation) rather than implying a capability that doesn't exist.
- Report back: the motion classification, the needed-now list in build order, and which asset(s)
  (if any) require a capability outside this plugin.
