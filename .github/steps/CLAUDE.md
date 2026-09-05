IMPORTANT: Critical Insights and Instructions related to the contents of this module MUST be documented below.
Ensure your information or instruction is accurate, you must never poison context here or elsewhere. No Hallucinations or Invention.
If you discover and confirm poisoned context you must remove it from here so it does not mislead other agents.
Language must be module-specific, unambiguous, and kept current by agents.
The instructions and knowledge below are not mandates, treat them as guidance only.
---

# Module: `steps` — the course prose and the state cursor

Each `<N>-*.md` is the `README.md` body a learner sees while on step N.
`skills/action-update-step@v2` swaps them in as the cursor advances. `X-finish.md` is terminal.

**`-step.txt` is the state cursor, and it is content, not config.** It is committed, and the
update action rewrites it in the learner's fork. Editing it by hand in this template
desynchronises the course from its own workflows.

Things worth knowing before you edit anything here:

- **These files are learner-facing product.** They are the first thing a complete beginner reads
  on their first GitHub course. Weigh every edit against that reader.
- **They are deliberately excluded from `stampedTrees`** in `.phaneslight/config.json`. A
  `phaneslight new-file` module stamp writes `# <module> | <description>` as the first line, which
  in Markdown renders as an H1 heading and corrupts the page. Create files here directly and name
  the edit in your report.
- **Screenshots are referenced by filename** from `images/`. Nothing checks those links. Renaming
  a screenshot without fixing every inbound reference silently breaks the step.
- **Prose, workflow and cursor must agree.** Adding or removing a step is a T3 task touching all
  three modules — never edit prose alone and assume the automation follows.
- Keep one action per step. The course's whole design is that a beginner does exactly one thing,
  sees it work, and moves on.
