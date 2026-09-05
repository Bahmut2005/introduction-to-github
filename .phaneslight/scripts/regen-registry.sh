#!/bin/sh
# phaneslight-generated v3.7.2 regen-registry
# GENERATED, not fetched. The manifest lists regen-registry under `generatedNotFetched` because
# its extractor is per-language and so cannot ship as a language-independent template.
#
# This project's extractor mode is "none" (.phaneslight/config.json -> extractor.mode). The
# repository is courseware: Markdown course prose, GitHub Actions workflow YAML and PNG
# screenshots. There are no exported symbols and no network-facing API contract, so there is
# nothing for a baseline to extract. This script therefore writes an EXPLICIT no-substrate
# baseline per module rather than an empty one that would be indistinguishable from a failed
# extraction, and it says so on stdout. Emitting a fabricated or silently-empty baseline here
# would hand `introduction-to-github-closure` a diff substrate that reports "no API drift" for
# a reason it could not tell apart from "the extractor broke".
#
# One-shot, non-interactive, self-terminating. Advisory: always exits 0.

find_root() {
  d=$(pwd)
  while [ -n "$d" ] && [ "$d" != "/" ]; do
    [ -f "$d/.phaneslight/config.json" ] && { printf '%s' "$d"; return 0; }
    d=$(dirname "$d")
  done
  return 1
}

root=$(find_root) || { echo "regen-registry: no .phaneslight/ root found; nothing to do." >&2; exit 0; }
cd "$root" || exit 0

cfg=".phaneslight/config.json"
mode=$(grep -o '"mode"[[:space:]]*:[[:space:]]*"[^"]*"' "$cfg" 2>/dev/null | head -1 \
  | sed 's/.*:[[:space:]]*"\(.*\)"$/\1/')
[ -n "$mode" ] || mode="none"

if [ "$mode" != "none" ]; then
  echo "regen-registry: extractor.mode is '$mode', but this generated script only implements the"
  echo "                no-substrate path. Regenerate the script for the new stack before trusting"
  echo "                any baseline it writes. Nothing was written."
  exit 0
fi

mods=$(tr '\n' ' ' < "$cfg" 2>/dev/null \
  | sed -n 's/.*"modules"[[:space:]]*:[[:space:]]*\[\([^]]*\)\].*/\1/p' \
  | grep -o '"[^"]*"' | sed 's/"//g')
[ -n "$mods" ] || { echo "regen-registry: no modules configured; nothing to do."; exit 0; }

mkdir -p .phaneslight/registry
stamp=$(date -u +%Y-%m-%dT%H:%M:%SZ)
n=0

for m in $mods; do
  cat > ".phaneslight/registry/$m.json" <<JSON
{
  "module": "$m",
  "generatedAt": "$stamp",
  "extractorMode": "none",
  "substrate": "absent",
  "reason": "Courseware module. No exported symbols and no declared network-facing API contract, so there is no API surface to baseline. This file records a VERIFIED ABSENCE of substrate, not a failed extraction and not an empty result.",
  "entries": []
}
JSON
  n=$((n + 1))
done

echo "regen-registry: wrote $n no-substrate baseline slice(s) to .phaneslight/registry/ (extractor.mode=none)."
echo "regen-registry: this project has NO API surface. A downstream 'no drift' verdict here means"
echo "                'nothing to drift', never 'the surface was checked and held'."
exit 0
