IMPORTANT: Critical Insights and Instructions related to the contents of this module MUST be documented below.
Ensure your information or instruction is accurate, you must never poison context here or elsewhere. No Hallucinations or Invention.
If you discover and confirm poisoned context you must remove it from here so it does not mislead other agents.
Language must be module-specific, unambiguous, and kept current by agents.
The instructions and knowledge below are not mandates, treat them as guidance only.
---

# Module: `images` — course screenshots

14 PNG screenshots of GitHub's own interface, named for what they depict rather than for the step
that uses them. Flat directory, no manifest. The binding between a screenshot and the step that
uses it exists **only** as a relative link inside the step Markdown.

Things worth knowing before you touch anything here:

- **This is the course's most silently-decaying asset.** GitHub's interface changes; a screenshot
  that no longer matches what the learner sees is worse than no screenshot, because it makes them
  doubt they followed the instructions. Nothing here is dated, versioned or checked.
- **Never claim a screenshot is current.** This project renders no UI, so no capture tooling can
  verify these. They are checked by a human against live GitHub, or not at all. Report unverified.
- **Renaming breaks steps.** Inbound links live in `.github/steps/*.md` and are checked by nothing.
  Any rename is a coordinated two-module change, never a tidy-up.
- Naming is inconsistent (`Green-merge-pull-request.png`, `Actions-to-step-4.png` are capitalised;
  the rest are not). Normalising it is a real change with real inbound-link risk, not a cleanup.
- The screenshot → step cross-reference does not exist anywhere yet. Building it is a standing
  TODO recorded in `documentation/registry/images.md`.
