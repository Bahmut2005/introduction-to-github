# Installed Agent Skills

128 skills installed from 9 upstream repositories via the `skills` CLI
(`npx skills add <repo> --agent claude-code`).

They are committed here so they survive ephemeral sessions and travel with the repo.
Claude Code reads `.claude/skills/` automatically.

## Provenance

| Source repo | Skills | Notes |
|---|---:|---|
| [tt-a1i/archify](https://github.com/tt-a1i/archify) | 1 | Typed-JSON-IR architecture diagrams with deterministic validation |
| [gnipbao/dao-skill](https://github.com/gnipbao/dao-skill) | 1 | Meta-skill designer; SKILL.md body is largely Chinese |
| [citrolabs/ego-lite](https://github.com/citrolabs/ego-lite) | 1 | Browser automation — **macOS-only installer**, inert on Linux |
| [amtiYo/agents](https://github.com/amtiYo/agents) | 3 | Multi-agent config sync (the `agent-conf-sync` idea) |
| [freestylefly/awesome-gpt-image-2](https://github.com/freestylefly/awesome-gpt-image-2) | 1 | Structured image-prompt style library |
| [expo/skills](https://github.com/expo/skills) | 25 | Expo / EAS; several require a paid EAS account |
| [meteor/agent-skills](https://github.com/meteor/agent-skills) | 14 | Meteor 3 |
| [langfuse/skills](https://github.com/langfuse/skills) | 1 | Needs `LANGFUSE_PUBLIC_KEY` / `LANGFUSE_SECRET_KEY` |
| [trailofbits/skills](https://github.com/trailofbits/skills) | 81 | Security auditing, fuzzing, static analysis |

## Security review performed before commit

Scanned all 128 skills. No blocking issues found:

- **No package lifecycle hooks** (`preinstall` / `postinstall` / `prepare`) in any bundled `package.json`.
- **No credential access** — nothing references `~/.ssh`, `~/.aws/credentials`, `.netrc`, `.npmrc`,
  or reads `GITHUB_TOKEN` / `ANTHROPIC_API_KEY` / `OPENAI_API_KEY`.
- **No obfuscation** — no `base64 -d`, `b64decode`, `eval()`, or `new Function()` in any script.
- **No covert remote execution.** Every `curl | sh` match is documentation showing how to install a
  known tool (uv, rustup, Meteor, Docker base images), not a script that runs on skill load.
- **No nested `.git` directories**, and no files the repo `.gitignore` would silently drop.

Two behaviours worth knowing about:

1. `expo-skill-feedback` bundles PostHog telemetry (`https://us.i.posthog.com`) with a hardcoded
   project key. It is opt-in and honours `DO_NOT_TRACK=1`, and only fires if that skill is invoked.
2. `ego-browser/scripts/install.sh` downloads a `.dmg` from `cdn.ego.app` and uses `sudo`, `xattr`,
   and `/Applications`. It is macOS-only and cannot run in a Linux container.

Scans are pattern-based, not proof of safety. Skills run with full agent permissions — read a
SKILL.md before relying on it.

## Caveat: context cost

128 skill descriptions load into every session. Trail of Bits alone is 81 and is better treated as
a reference to read than a catalogue to keep loaded. To prune, delete the directory — nothing else
references it.

## Skills by source

### tt-a1i/archify

`archify`

### gnipbao/dao-skill

`dao-skill`

### citrolabs/ego-lite

`ego-browser`

### amtiYo/agents

`docs-research` `mcp-troubleshooting` `skill-guide`

### freestylefly/awesome-gpt-image-2

`gpt-image-2-style-library`

### expo/skills

`eas-app-stores` `eas-hosting` `eas-observe` `eas-simulator` `eas-update-insights` 
`eas-workflows` `expo-animation` `expo-app-clip` `expo-brownfield` `expo-data-fetching` 
`expo-design-system` `expo-dev-client` `expo-dom` `expo-examples` `expo-migrate-module` 
`expo-module` `expo-native-ui` `expo-overview` `expo-project-structure` `expo-router` 
`expo-skill-eval` `expo-skill-feedback` `expo-ui` `expo-upgrade` `expo-web-to-native`

### meteor/agent-skills

`meteor-accounts` `meteor-blaze` `meteor-community-packages` `meteor-debugging` 
`meteor-deployment` `meteor-methods` `meteor-modern-build-stack` `meteor-mongo-minimongo` 
`meteor-pubsub` `meteor-react` `meteor-security` `meteor-testing` `migrate-to-meteor-3` 
`migrate-to-rspack`

### langfuse/skills

`langfuse`

### trailofbits/skills

`address-sanitizer` `aflpp` `agentic-actions-auditor` `algorand-vulnerability-scanner` 
`atheris` `audit-augmentation` `audit-context-building` `audit-prep-assistant` 
`burpsuite-project-parser` `c-review` `cairo-vulnerability-scanner` `cargo-fuzz` 
`chrome-mcp-troubleshooting` `code-improver` `code-maturity-assessor` `codeql` 
`constant-time-analysis` `constant-time-testing` `cosmos-vulnerability-scanner` 
`coverage-analysis` `crypto-protocol-diagram` `devcontainer-setup` `diagramming-code` 
`differential-review` `dimensional-analysis` `dwarf-expert` `entry-point-analyzer` 
`firebase-apk-scanner` `fp-check` `fuzzing-dictionary` `fuzzing-obstacles` `genotoxic` `gh-cli` 
`github-triage` `goal-prompt` `graph-evolution` `guidelines-advisor` `harness-writing` 
`interpreting-culture-index` `let-fate-decide` `libafl` `libfuzzer` `mermaid-to-proverif` 
`modern-cpp` `modern-python` `mutation-testing` `open-sourcing` `ossfuzz` `pr-improver` 
`property-based-testing` `rust-review` `ruzzy` `sarif-parsing` `second-opinion` 
`secure-workflow-guide` `semgrep` `semgrep-rule-creator` `semgrep-rule-variant-creator` 
`sharp-edges` `skill-improver` `slicing-code-context` `solana-vulnerability-scanner` 
`spec-to-code-compliance` `substrate-vulnerability-scanner` `supply-chain-risk-auditor` 
`testing-handbook-generator` `token-integration-analyzer` `ton-vulnerability-scanner` 
`trailmark` `trailmark-finding-triage` `trailmark-review-gate` `trailmark-structural` 
`trailmark-summary` `trailmark-variant-neighborhood` `variant-analysis` `vector-forge` 
`vulnerability-triage-brocards` `writing-lean-proofs` `wycheproof` `yara-rule-authoring` 
`zeroize-audit`

