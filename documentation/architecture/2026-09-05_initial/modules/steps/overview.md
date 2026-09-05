<!-- DOC | Bootstrap module snapshot for the steps area of the course -->
<!-- DOC DISCIPLINE | Soft ceiling: 500 lines. One topic per file; structure under ## headings.
     The DOC line above feeds `phaneslight doc-index`, keep it accurate; it is this file's line in _index.md.
     If this file exceeds the ceiling: split it into a same-named folder of focused topic files;
     carry both header lines into every part; update every inbound reference in the same change set;
     finish by running `phaneslight doc-index`.
     Consumers: NEVER bulk-read documentation folders, read _index.md first, load only what you need.
     Audit: `phaneslight doc-check`. -->

# Module: `steps`

**Path:** `.github/steps/`
**Apparent purpose:** the course prose. Each file is the `README.md` body the learner sees while
on that step; `skills/action-update-step@v2` swaps them in as the cursor advances.

## Key files

| File | Role |
|---|---|
| `-step.txt` | The state cursor. Currently `0`. Read by every workflow's `get_current_step` job. |
| `0-welcome.md` | Published on step 0. |
| `1-create-a-branch.md` | Published on transition 0 → 1. |
| `2-commit-a-file.md` | Published on transition 1 → 2. |
| `3-open-a-pull-request.md` | Published on transition 2 → 3. |
| `4-merge-your-pull-request.md` | Published on transition 3 → 4. |
| `X-finish.md` | The terminal state, published on transition 4 → X. |

## Internal structure

Prose is authored for a complete beginner: one action per step, screenshots from `images/`
inlined by relative path, and links out to `docs.github.com` for detail.

Note the off-by-one that reads as a bug and is not: a workflow named for step *N* publishes step
*N+1*'s prose, because the workflow fires when the learner **completes** step N.

## Gotchas for future work

- `-step.txt` is content, not config. It is committed, and the update action rewrites it. Editing
  it by hand in this template desynchronises the course.
- Step prose names screenshots by filename. Renaming anything in `images/` breaks the step that
  references it, and nothing in CI catches it.
- These files are **learner-facing product**. They are deliberately excluded from `stampedTrees`
  in `.phaneslight/config.json`: a `new-file` module stamp would render as an H1 heading and
  corrupt the page the course exists to deliver.
