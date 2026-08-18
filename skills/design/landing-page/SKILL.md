---
name: landing-page
description: >
  Use once a business's plan is council-approved and the founder needs an actual landing page
  draft — not copy in a doc, a real published page. Triggers: "build our landing page," "make a
  website for the launch," "landing page draft," "design our homepage," "page for the beta
  signup." Derives hero, problem/solution, and CTA copy directly from the plan's value proposition
  (step 08) and persona (step 05), ties the call-to-action to the specific next-10-customers
  motion from step 09 rather than a generic "sign up" button, and includes an explicitly-labeled
  social-proof placeholder since a pre-launch business has no real testimonials yet. Uses the
  built-in `design` skill to produce and publish the page as a real Artifact — this skill supplies
  the business-specific content and structure, `design` supplies the visual layout mechanics.
---

# Landing Page

You turn an approved business plan into an actual landing page draft, published as a real
Artifact a founder can look at, click through, and share for feedback — not a copy doc describing
what a landing page should say. Content and structure decisions (what the hero says, what proof
goes where, what the CTA actually asks the visitor to do) are this skill's job; visual layout,
responsive design, and the artboard/publishing mechanics are the built-in `design` skill's job.
Invoke `design` (via the Skill tool) to actually build and publish the page once the content
below is worked out — do not hand-roll HTML/CSS layout decisions this skill isn't specialized for.

## 1. Reads

- `.startup/<slug>/business-state.json` (whole file, to preserve unrelated keys on write-back,
  and to read `business_name`).
- `.startup/<slug>/plan/08-quantify-the-value-proposition.md` — **required.** The hero headline
  and subhead come directly from this step's quantified promise, not a paraphrase of the business
  category.
- `.startup/<slug>/plan/05-profile-the-persona-for-the-beachhead-market.md` — **required.** Page
  copy should read as written *to* this specific persona (their vocabulary, what convinces them,
  what objection they'll silently have) — see the brand-identity voice guide if one exists and
  use it directly.
- `.startup/<slug>/plan/09-identify-your-next-10-customers.md` — **required for the CTA.** The
  call-to-action must be the specific motion this business is actually using to land its first 10
  customers (e.g. "book a 15-minute setup call," "join the beta waitlist," "start a free trial,"
  "request access") — not a generic "Sign Up" or "Learn More" button disconnected from how this
  business actually acquires customers.
- `.startup/<slug>/plan/06-full-life-cycle-use-case.md` and
  `.startup/<slug>/plan/07-high-level-product-specification.md` — for the problem/solution section
  and any "how it works" content.
- `.startup/<slug>/plan/10-define-your-core.md` — if present, use to make sure the differentiation
  claim on the page is the real, defensible one, not a generic category claim.
- `.startup/<slug>/design/brand-identity.md` — if present, **required input**: carry its tagline
  selection, voice/tone guide, and color/type direction directly into the page rather than making
  independent brand choices. If it doesn't exist yet, proceed with plan-grounded copy but tell the
  founder that running `skills/design/brand-identity` first would tighten consistency.

If step 08, 05, or 09 is missing, stop and tell the founder which is missing — a landing page
built without the value prop, persona, or actual acquisition motion collapses into generic SaaS
landing-page filler, which is exactly what this skill exists to avoid.

## 2. Page structure and content

Work out the following before invoking `design`:

1. **Hero** — headline built directly from the step 08 value proposition (the quantified promise,
   not a vague benefit statement), a one-sentence subhead naming who it's for (the step 05
   persona, in their own likely words), and the primary CTA button (from step 09, see above).
2. **Problem** — the specific pain from steps 03/05/06, stated the way the persona would describe
   it, not an abstracted industry problem.
3. **Solution / how it works** — 3-4 concrete points from step 07's product spec and step 06's
   use case, each tied back to a piece of the problem section — not a generic feature list.
4. **Social proof placeholder** — this business is pre-launch or early; do not fabricate
   testimonials, logos, or user counts. Build an explicitly-labeled placeholder section (e.g. a
   visually distinct "What early users will say" block, or a "Join N founders already testing
   this" counter wired to a real number if one exists, or omitted if it doesn't) and label it in
   an HTML comment or visible small caption as a placeholder to replace with real proof once it
   exists. Never ship a fake quote attributed to a fake person — that crosses into fabricated
   social proof, which this plugin does not produce.
5. **Secondary CTA / objection handling** — one section addressing the persona's most likely
   silent objection (pull this from step 05 if it names one, or step 08's proof points) before
   repeating the CTA.
6. **Footer CTA** — repeat the same step-09-grounded action as the hero CTA, worded identically
   or near-identically — don't introduce a second, different ask at the bottom of the page.

Every headline/subhead/CTA choice should be traceable in your own working notes to a specific
line in steps 05/08/09 — if you can't point to the source, it's drifting toward generic copy and
should be rewritten.

## 3. Build and publish

Invoke the built-in `design` skill (via the Skill tool) to lay out and publish the page as a
single-artboard landing-page Artifact, per that skill's own guidance for landing pages. Supply it:
the structure and copy from §2, the color/type direction and voice from
`design/brand-identity.md` if available, and `business_name`. Load `artifact-design` first if the
`design` skill's own instructions call for it. Confirm the Artifact actually publishes (get the
resulting URL) before writing the output files below — a landing-page deliverable that only
exists as a description of a page is not done.

## 4. Output file: `design/landing-page-brief.md`

Write the full content spec and the published URL to a file, since the live Artifact is hosted
externally to the business's working directory and needs a durable pointer inside it:

```markdown
# Landing Page — <business_name>

**Published:** <Artifact URL>
**Built:** <ISO-8601 timestamp>

## Grounding
- Value proposition (step 08): <one-line pull>
- Persona (step 05): <one-line pull>
- Next-10-customers CTA motion (step 09): <one-line pull>

## Section-by-section content
### Hero
- Headline: ...
- Subhead: ...
- CTA: ...

### Problem
...

### Solution / how it works
...

### Social proof
<note explicitly that this is a placeholder, and what real proof should replace it once
available>

### Objection handling
...

### Footer CTA
...

## What this is / isn't
This is a draft to gather feedback and iterate on — not production infrastructure. It has no
real form backend, no analytics, and no custom domain. Before using it as the real launch page,
wire the CTA to an actual signup mechanism (a connector-liaison task, see `agents/connectors-liaison.md`)
and replace the social-proof placeholder with real evidence.
```

## 5. Update business-state.json

Read the whole file, write back only:
- `gtm.artifacts`: append `{ "type": "landing-page", "file": "design/landing-page-brief.md" }`
  (replace in place if a landing-page entry already exists — this is a refresh).
- `updated_at`: current ISO-8601 timestamp.

Preserve every other key untouched.

## 6. Done means

- The page is actually published as an Artifact (you have a real URL, not a plan to make one).
- `design/landing-page-brief.md` exists with the URL and full content spec, including the
  explicitly-labeled social-proof placeholder.
- The CTA on the page is the specific step-09 acquisition motion, not a generic button.
- `business-state.json.gtm.artifacts` has a `landing-page` entry.
- Report back: the Artifact URL, the CTA chosen and why it matches the next-10-customers motion,
  and the one explicit reminder that this is a draft needing a real form backend and real social
  proof before it's a production launch page.
