<!-- DOC | Bootstrap module snapshot for the images area of the course -->
<!-- DOC DISCIPLINE | Soft ceiling: 500 lines. One topic per file; structure under ## headings.
     The DOC line above feeds `phaneslight doc-index`, keep it accurate; it is this file's line in _index.md.
     If this file exceeds the ceiling: split it into a same-named folder of focused topic files;
     carry both header lines into every part; update every inbound reference in the same change set;
     finish by running `phaneslight doc-index`.
     Consumers: NEVER bulk-read documentation folders, read _index.md first, load only what you need.
     Audit: `phaneslight doc-check`. -->

# Module: `images`

**Path:** `images/`
**Apparent purpose:** screenshots of GitHub's own interface, referenced by name from the step
prose so a beginner can match what they read against what they see.

## Key files

14 PNG files, named for what they depict rather than for the step that uses them:
`create-branch-button.png`, `create-new-file.png`, `commit-full-screen.png`,
`compare-and-pull-request.png`, `pull-request-branches.png`, `pull-request-description.png`,
`Green-merge-pull-request.png`, `delete-branch.png`, `main-branch-dropdown.png`,
`code-tab.png`, `create-new-repository.png`, `my-profile-file.png`,
`profile-readme-example.png`, `Actions-to-step-4.png`.

## Internal structure

Flat directory, no subfolders, no manifest. The binding between a screenshot and the step that
uses it exists only as a relative link inside the step Markdown.

## Gotchas for future work

- **This is the course's most silently-decaying asset.** GitHub's interface changes; a screenshot
  that no longer matches what the learner sees is actively confusing, and nothing dates, versions
  or checks these files.
- Naming is inconsistent (`Green-merge-pull-request.png` and `Actions-to-step-4.png` are
  capitalised, the rest are not). Renaming to normalise would break inbound step links, so it is
  a coordinated change across two modules, never a tidy-up.
- TODO for `introduction-to-github-orchestrator`: build the screenshot → step cross-reference that
  does not currently exist anywhere, and record it in `documentation/registry/images.md`.
