IMPORTANT: Critical Insights and Instructions related to the contents of this module MUST be documented below.
Ensure your information or instruction is accurate, you must never poison context here or elsewhere. No Hallucinations or Invention.
If you discover and confirm poisoned context you must remove it from here so it does not mislead other agents.
Language must be module-specific, unambiguous, and kept current by agents.
The instructions and knowledge below are not mandates, treat them as guidance only.
---

# Module: `workflows` — the course state machine

Five workflows advance a learner from step 0 to the terminal step X. Each one: reads the cursor
`.github/steps/-step.txt` in a `get_current_step` job, gates the main job on
`!github.event.repository.is_template && current_step == N`, then calls
`skills/action-update-step@v2` with `from_step`/`to_step` and `branch_name: my-first-branch`.

| File | Trigger | Transition |
|---|---|---|
| `0-welcome.yml` | `push` to `main` | 0 → 1 |
| `1-create-a-branch.yml` | `create` | 1 → 2 |
| `2-commit-a-file.yml` | `push` | 2 → 3 |
| `3-open-a-pull-request.yml` | `pull_request` | 3 → 4 |
| `4-merge-your-pull-request.yml` | `push` (merge) | 4 → X |

Things worth knowing before you edit anything here:

- **The `is_template` guard is load-bearing.** Remove it and this template repository starts
  running the course on itself. Never drop it "to test the workflow" — use `workflow_dispatch`,
  which every file already carries.
- **A step number is asserted in three places per transition:** the filename prefix, `from_step`,
  and the cursor value the gate compares against. Changing one means changing all three, plus the
  step prose in `.github/steps/`. That makes any renumbering a T3 task.
- **A workflow named for step N publishes step N+1's prose.** It fires when the learner *completes*
  step N. This reads as an off-by-one and is not one.
- **You cannot run these from this repository.** They execute on a learner's fork only. Anything
  that needs a real run is reported as unverified, never as a pass.
- `permissions: contents: write` is required — the action rewrites the learner's `README.md`.
- External pins (`actions/checkout@v4`, `skills/action-update-step@v2`) are maintained by
  Dependabot monthly. Don't bump them by hand without checking the action's release notes.
