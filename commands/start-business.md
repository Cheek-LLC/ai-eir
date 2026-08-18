---
description: Start a brand-new business — launches the Startup Operator to onboard and begin the 24-step Disciplined Entrepreneurship process.
---

The user wants to start a new business through the 30-Minute Startup process.

Arguments given (may be empty): `$ARGUMENTS`

Do the following:

1. Determine the starting business name and one-liner:
   - If `$ARGUMENTS` is non-empty, treat it as the founder's own words for the business — it may
     be just a name, just a one-liner idea, or both. Don't force it into a rigid format.
   - If `$ARGUMENTS` is empty, ask the founder directly for two things before proceeding: a
     working name for the business (it can change later) and a one-sentence description of the
     idea. Don't invent placeholders — get real answers.
2. Derive a kebab-case slug from the working name. Check whether
   `.startup/<slug>/business-state.json` already exists.
   - If it already exists, stop and tell the founder plainly: a business with this slug already
     exists, and ask whether they mean to resume it (point them at `/business-status <slug>`)
     or are starting a genuinely different business that needs a different name/slug.
   - Otherwise, this is a fresh start.
3. Delegate to the `startup-operator` agent to run its session bootstrap for this new business
   (create the `.startup/<slug>/` directory skeleton and initial `business-state.json` per the
   Data Contract, `stage: "interview"`) and begin Phase 1, the onboarding interview
   (`skills/interview/onboarding-interview`). Pass along the working name and one-liner captured
   above so the interview doesn't re-ask for what the founder already gave you.
4. Stay in this conversation as the onboarding interview runs — it's interactive by design. The
   `startup-operator` agent owns pushing back on vague answers; let it do that rather than
   smoothing answers over on its behalf.

This command only ever starts something new. To resume, check status, or continue an existing
business, use `/business-status` instead.
