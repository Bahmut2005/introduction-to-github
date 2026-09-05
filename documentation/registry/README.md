The registry: CURATED API annotations.

Hand-maintained by `introduction-to-github-orchestrator`; the generated baseline is written by `introduction-to-github-closure`. One file per module. Contents:
- Deprecations
- "Use X instead" redirects
- Contracts beyond type signatures (null-vs-throw, ordering guarantees, idempotency, etc.)
- Anti-patterns specific to a module
- "Do not extend Y, instead extend Z" architectural directives

The registry records what code search cannot see: intent, prohibition, and contract. The API
surface itself is NOT stored here, query it live (`semble search` where installed,
`phaneslight list-apis <module>` always). The generated API baseline in `.phaneslight/registry/` is
`introduction-to-github-closure`'s diff substrate, not agent reading material.

Target ceiling: 30 entries per module file. If a module's file grows past 30, the architecture
has drifted and warrants a snapshot review.

Single writer: `introduction-to-github-orchestrator`. It MUST read the affected modules'
registry files before producing a plan.
