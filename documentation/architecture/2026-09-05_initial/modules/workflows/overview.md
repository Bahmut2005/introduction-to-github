<!-- DOC | Bootstrap module snapshot for the workflows area of the course -->
<!-- DOC DISCIPLINE | Soft ceiling: 500 lines. One topic per file; structure under ## headings.
     The DOC line above feeds `phaneslight doc-index`, keep it accurate; it is this file's line in _index.md.
     If this file exceeds the ceiling: split it into a same-named folder of focused topic files;
     carry both header lines into every part; update every inbound reference in the same change set;
     finish by running `phaneslight doc-index`.
     Consumers: NEVER bulk-read documentation folders, read _index.md first, load only what you need.
     Audit: `phaneslight doc-check`. -->

# Module: `workflows`

**Path:** `.github/workflows/`
**Apparent purpose:** the course automation. Five workflows drive the learner from step 0 to the
terminal step X by rewriting their `README.md` in response to Git events.

## Key files

| File | Trigger | Transition |
|---|---|---|
| `0-welcome.yml` | `push` to `main` | 0 → 1 |
| `1-create-a-branch.yml` | `create` | 1 → 2 |
| `2-commit-a-file.yml` | `push` | 2 → 3 |
| `3-open-a-pull-request.yml` | `pull_request` | 3 → 4 |
| `4-merge-your-pull-request.yml` | `push` (merge to `main`) | 4 → X |

## Internal structure

Every file shares one shape:

1. `get_current_step` job — checks out, reads `.github/steps/-step.txt`, exposes it as an output.
2. Main job — `needs: get_current_step`, gated on
   `!github.event.repository.is_template && current_step == N`.
3. A single `skills/action-update-step@v2` step carrying `token`, `from_step`, `to_step`,
   `branch_name: my-first-branch`.

Permissions are `contents: write` throughout. All five carry `workflow_dispatch` for manual
re-firing. Runner is `ubuntu-latest` in every job, chosen for cost over macOS/Windows.

## External dependencies

`actions/checkout@v4`, `skills/action-update-step@v2`. Both are kept current by
`.github/dependabot.yml` on a monthly `github-actions` schedule.

## Gotchas for future work

- The `is_template` guard is load-bearing. Removing it makes the template advance its own course.
- The step number is asserted in **three** places per transition: the filename prefix, `from_step`,
  and the cursor it gates on. Renumbering means editing all three plus the step prose.
- TODO for `introduction-to-github-orchestrator`: these workflows cannot be executed from this
  repository, so their current correctness is unverified here. Confirm on a live fork.
