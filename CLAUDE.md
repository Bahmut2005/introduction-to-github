<!-- PINNED DIRECTIVES, DO NOT MOVE FROM TOP, DO NOT DELETE WITHOUT USER CONSENT -->
> **PINNED PROJECT DIRECTIVES, ALWAYS READ, BINDING.**
> This block stays at the top of this file. Do NOT delete or relocate any entry
> without explicit user consent; always ask before removal. It contains binding
> operating rules from PhanesLight and companion tools. Each tool owns its own
> namespaced entries and is that namespace's single writer.

<!-- pinned:phaneslight (GENERATED, single-writer PhanesLight, regenerated every run) -->
> **Per-agent model and effort (v3.6.1).** Model is fixed by role, not by judgment: `introduction-to-github-orchestrator` runs Opus 5, `introduction-to-github-reviewer` runs Fable 5, and `introduction-to-github-worker` and `introduction-to-github-closure` run Sonnet 5, all at `high` effort; `introduction-to-github-mechanic` runs Haiku 4.5 with no effort dial. Effort is a single session-wide level: launch with `--effort high`. The `model:` frontmatter **is** honored natively by the in-session spawn path. Where a pinned model is UNREACHABLE (quota, rate limit, outage): retry three times with exponential backoff (~5s, 15s, 45s, jittered), then substitute down the documented ladder (orchestrator: Fable→Sonnet; reviewer: Opus→Sonnet, *upward*, because review is load-bearing; worker: Haiku; closure: Haiku→Opus; mechanic: Sonnet) and record the substitution in the step session summary, in the dispatch's persisted return, and in `pinned:project` where it outlives the step. "Fixed by role" governs the choice, not the availability.
> **The lineup, and who may do what.** Five agents, and only five. `introduction-to-github-orchestrator` writes without restriction, because it is the main executor as well as the orchestrator. `introduction-to-github-worker` and `introduction-to-github-mechanic` write only within their dispatched scope and MUST name every edit in their reports; the mechanic's scope **excludes code entirely**. `introduction-to-github-reviewer` never writes code but **does** write plan files and review artifacts. `introduction-to-github-closure` never writes code. Only the orchestrator and the reviewer hold a spawn grant, and **no agent is ever forked**. On a planned launch the reviewer reviews the plan before the first execution step. Every finding graded MED or above travels up to the agent that spawned the finder — **LOW and above when the finder is a mechanic**, because it cannot fix anything itself — with HIGH and CRIT reaching the orchestrator's decision matrix, which either defers with a recorded justification or dispatches the reviewer. Code edits are **not** routed through a review gate: what is mandatory is disclosure of every edit and independent re-derivation by closure at every close.
> **Procedure precedence.** Current phaneslight.md/skill and `.claude/workflows/` YAML outrank session-summary narrative on any operating-procedure conflict. Summaries record what happened; they do not define procedure. Re-read the skill, never recall procedure from a summary.
> **This project has no build, typecheck or test command, and that is a finding, not a gap to paper over.** It is courseware. Closure duty 2 MUST report `NO-SUCH-COMMAND`; it must never claim a pass it did not run. Likewise `api-diff` reports `NO-BASELINE`, which means "nothing to diff", never "no changes detected".
> **Authorized deviations from the directives above are recorded in `pinned:project` below and OVERRIDE them.** This namespace is regenerated on every run and cannot carry one.
<!-- /pinned:phaneslight -->
<!-- pinned:project (OWNER-OWNED, NEVER generated, NEVER regenerated, NEVER deleted by any run) -->
> **Authorized deviations.** Owner-authorized departures from a generated directive live here, one line each, and OVERRIDE the generated line they name. Empty is the normal state; delete an entry only when the deviation ends.
> *(no deviations recorded)*
<!-- /pinned:project -->
<!-- /PINNED DIRECTIVES -->

# Introduction to GitHub — primary agent instructions

## What this project is

A **GitHub Skills course template**, not an application. A learner creates a repository from it,
and the course advances itself through five steps by rewriting that learner's `README.md` in
response to the Git actions they perform. Read it as a **state machine whose state lives in git**:
the cursor is `.github/steps/-step.txt`, the transitions are the five workflows in
`.github/workflows/`, and the prose each transition publishes is in `.github/steps/`.

Full map: `documentation/architecture/2026-09-05_initial/overview.md`.

**The one coupling that governs almost every change here:** a step's prose, the workflow that
publishes it, and the cursor value that workflow gates on are three files that must agree.
Break the agreement and nothing errors — the learner simply stops advancing. There is no CI to
catch it, so the check is yours.

**Everything in this repository is copied into every learner's fork.** That is the product. Weigh
any addition against the learner who has to look at it on day one of their first GitHub course.

## Workflow Execution Strategy

When performing tasks, Claude Code **MUST**

1. Triage every task into a workflow tier (T1/T2/T3) before selecting agents; load only the context that tier requires.
2. Analyze the task to identify independent subtasks.
3. Dispatch by tier, never by domain: the roster is the fixed five. `introduction-to-github-worker` for authored content and workflow YAML, `introduction-to-github-mechanic` for mechanical transforms and fetch-and-digest retrieval, `introduction-to-github-closure` for close-time verification, `introduction-to-github-reviewer` for HIGH and CRIT findings and for the plan review at every planned launch. Domain expertise is composed into the spawn prompt from this file, the documentation tree and the registry; it is never selected from a roster.
4. Where work genuinely decomposes into independent pieces, dispatch several workers at once within **Bounded Fan-Out**: never more than 5 in flight per spawner. The dispatching agent consolidates what comes back. There is no Synthesizer.
5. Escalate by severity, never by review pass: MED and above travel up to the spawner, and **LOW and above when the finder is a mechanic**. There is no Critic step, no security-review step and no Synthesizer step in any chain.
6. Employ Git-based checkpoints like `git checkout -b claude-session-[timestamp]-[purpose]`.
7. **Critical:** Ensure agent outputs are trackable with unique IDs when issues are identified.
8. For T2/T3 tasks the work MUST end with `introduction-to-github-closure`, which independently re-derives the baseline, re-runs the project's verification command itself, and reconciles what was applied against what was intended. Its output is a flag graded on the severity ladder, never a fix. **Here, the verification command does not exist**, so closure reports `NO-SUCH-COMMAND` and falls back to the checks in "Verifying work" below.
9. Bulky one-time-use retrieval (sweeping every step file, every workflow, every image reference) is dispatched to `introduction-to-github-mechanic` on the `haiku` tier by whichever agent holds a spawn grant, and the mechanic returns a structured digest with `file:line` references and no judgment of its own. Judgment is **NEVER** delegated to a retrieval dispatch. Below roughly 2,000 tokens of raw material, read it directly: the dispatch costs more than it saves. This repository is small — that threshold is reached less often than you would think.
10. **The Visual Evidence Mandate does not engage here.** This project renders no UI. The screenshots in `images/` depict GitHub's own interface and cannot be captured or verified by any tooling in this repository; they are checked by a human eye against live GitHub, or not at all. Never claim a screenshot is current.
11. **Orchestrator engagement (scope check):** at plan-execution launch, count the effective steps in scope. Full or ambiguous invocation ("run the plan") with 5 or more steps (`orchestratorStepThreshold` in `.phaneslight/config.json`, default 5): you MUST NOT orchestrate the steps yourself. Spawn `introduction-to-github-orchestrator` and stay slim: read the plan's step and phase list once, build the todolist, then handle only the spawn and the close. Explicit user narrowing ("only step 1"), a plan of 4 or fewer steps, or a non-plan task: work directly. Ambiguity defaults to ENGAGED.
12. **Session-summary ownership:** engaged, the orchestrator writes one session summary per step and the primary NEVER authors one for those steps. Not engaged, you write them yourself. On the orchestrator's close, copy its handover's register lines verbatim into the `CLAUDE.local.md` register.
13. **The context ceiling is a first-class stop condition:** at 350k tokens the orchestrator closes out and asks you for a successor. Spawn a fresh orchestrator, point it at the handover session summary, and let it resume. This is a normal outcome of a long run, never a reason to take the remaining steps into the primary session yourself.
14. **Spawn grants:** only the orchestrator and the reviewer spawn agents. No agent is ever forked. Escalation is not invocation. No agent may *invoke* the orchestrator; it is spawned ONLY by the primary session, at plan launch, and its FIRST act on a planned launch is a plan review.

## Tier triage (your first action on every task)

| Tier | Trigger | Default loaded context | Agents | Documentation weight |
|---|---|---|---|---|
| **T1, Quick fix** | Single-file change: a typo in step prose, a broken link, one screenshot swap. Must not touch the step/workflow/cursor coupling — if it does, promote to T2. | Architecture overview only | Orchestrator alone, or one mechanic | One-line entry in the current session summary (what / why / files). No standalone report. |
| **T2, Feature work** | A change within one module: rewording a whole step, retiming a workflow trigger, renaming a screenshot and its inbound link. | Architecture overview + that module's deep-dive + that module's registry file + latest session summary | Orchestrator + worker(s) + closure at step close | Standalone report + session summary entry. |
| **T3, Cross-cutting** | Anything touching ≥2 modules. **Adding, removing or renumbering a course step is always T3**, because it touches prose, workflow and cursor at once. | Architecture overview + all touched module deep-dives + their registry files + active plan | Orchestrator + worker(s), closure between phases | Plan in `documentation/plans/` + reports + session summary entry. |

**Promotion rule:** any sub-agent realising mid-task that scope exceeds its tier MUST halt and
request promotion via the orchestrator before continuing. Improvising structural decisions outside
loaded context is forbidden and is a reportable drift event.

**Disclosure is universal; documentation weight scales.** No tier skips the disclosure obligation.

## Verifying work in a repository with no test suite

The five workflows are the closest thing to a test suite here and they **cannot be run from this
repository**: they execute only on a learner's fork, and the `is_template` guard deliberately
disables them here. So closure reports `NO-SUCH-COMMAND` for duty 2 and verifies these instead:

1. **Cursor coherence.** For every workflow `N-*.yml`: its `from_step` equals `N`, its `to_step`
   equals the next state, and a `.github/steps/<to_step>-*.md` exists.
2. **Link integrity.** Every image and relative link in `.github/steps/*.md` and `README.md`
   resolves to a file that exists.
3. **Guard intact.** Every workflow still carries `!github.event.repository.is_template`.
4. **YAML parses.** Each workflow file is valid YAML.
5. **Honest reporting.** Anything that genuinely needs a live fork is reported as unverified with
   the reason — never as a pass.

## Documentation Navigation

**Documentation Navigation:** NEVER bulk-read or glob-scan `documentation/`. Every folder in it
carries a GENERATED `_index.md`, read the index first, pick the entry, recurse, and load only
the target file(s). This binds every agent, the mechanic tier included. Indexes are generated by
`phaneslight doc-index` and hand-editing them is FORBIDDEN, regenerate to update.
Audit documentation hygiene with `phaneslight doc-check`.

## Scripts

Invoke the dispatcher as **`node .phaneslight/scripts/cli.js <cmd> [args]`**, never as a bare
`phaneslight`. One invocation string that works in every shell. Available: `new-file`, `loc-check`,
`doc-check`, `doc-index`, `register-check`, `module-list`, `list-apis`, `regen-registry`,
`api-diff`, `repo-manifest`, `batch-apply`, `ledger`, `preflight`, `update-preflight`, `scaffold`,
`census-diff`, `manifest-write`, `install-templates`.

**`phaneslight new-file` is the only sanctioned method of file creation.** One exception is
recorded in `.phaneslight/config.json`: `stampedTrees` is limited to `documentation`, because a
module stamp written into `.github/steps/*.md` renders as an H1 heading and corrupts the course
page. Create learner-facing content directly and say so in your report.

**The enforcement hooks are installed but NOT armed.** `hook-stamp-guard`, `hook-size-check` and
`hook-ledger-status` are on disk in `.phaneslight/scripts/` and verified, but hook *registration*
lives in the PhanesLight plugin, which is not installed here. Until it is, these rules are
prompt-enforced, not machine-enforced — which means they can be forgotten. Treat them as binding
anyway. Retry command in `.phaneslight/config.json` → `capabilities.failures[]`.

## Workflows

Task sequences for this project are codified in **`.claude/workflows/`**. Choose the workflow that
matches the task. Those files codify *sequences only*; the lineup, write rights, spawn grants and
escalation routing are fixed by the Pinned Directives block above and win on any conflict.

## Installed Capability Register (GENERATED, regenerated by every /phaneslight:run run; hand-editing FORBIDDEN)

- semble (MCP) → `introduction-to-github-orchestrator`, `introduction-to-github-worker`: indexed search across course prose and workflow YAML before any grep-and-read sweep; matched: the 5 step Markdown files and 5 Actions workflows that cross-reference each other and `images/` by name (Phase 1); fallback: Grep/Glob sweeps, which cost tokens but never correctness.
- context7 (MCP) → `introduction-to-github-orchestrator`, `introduction-to-github-worker`: live GitHub Actions and `actions/*` documentation; matched: the five `.github/workflows/*.yml` files using Actions expression, permissions and trigger syntax (Phase 1); fallback: targeted reads plus the `docs.github.com` links already cited in the course prose.
- deepwiki (MCP) → `introduction-to-github-orchestrator`, `introduction-to-github-worker`: digest answers about the external repositories the workflows depend on; matched: `.github/dependabot.yml` and the pinned `skills/action-update-step@v2` and `actions/checkout@v4` (Phase 1); fallback: context7, or a targeted read of the action's own README.

**Serena is deliberately NOT granted.** Its value is symbol intelligence, which is a function of a
language server existing for the stack. This project's primary language is Markdown and YAML, both
on the known-uncovered list; the grant would cost its schema every session and degrade silently to
file search, which `semble` already does better. Recorded in `.phaneslight/config.json` so future
runs do not re-litigate it.
