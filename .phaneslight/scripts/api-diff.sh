#!/bin/sh
# phaneslight-generated v3.7.2 api-diff
# GENERATED, not fetched (manifest group `generatedNotFetched`; the extractor is per-language).
#
# `api-diff <since-ref>` normally extracts the API surface from a git ref's SOURCE and diffs it
# against the current surface. This project's extractor mode is "none": it is courseware with no
# exported symbols and no declared network-facing contract, so there is no surface at either end
# of the diff.
#
# The contract this script keeps is that it reports NO-BASELINE explicitly and exits 0. It must
# never print an empty diff, because an empty diff and an absent surface look identical to a
# reader and mean opposite things: one says "checked, nothing changed", the other says "there was
# nothing to check". `introduction-to-github-closure` grades on that distinction.
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

root=$(find_root) || { echo "api-diff: no .phaneslight/ root found; nothing to do." >&2; exit 0; }
cd "$root" || exit 0

since=$1
cfg=".phaneslight/config.json"
mode=$(grep -o '"mode"[[:space:]]*:[[:space:]]*"[^"]*"' "$cfg" 2>/dev/null | head -1 \
  | sed 's/.*:[[:space:]]*"\(.*\)"$/\1/')
[ -n "$mode" ] || mode="none"

if [ "$mode" != "none" ]; then
  echo "api-diff: extractor.mode is '$mode', but this generated script only implements the"
  echo "          no-substrate path. Regenerate it for the new stack before trusting any diff."
  exit 0
fi

echo "api-diff: NO-BASELINE"
echo "  since-ref     : ${since:-<none given>}"
echo "  extractor.mode: none"
echo "  verdict       : This project has no API surface to diff. Not 'no changes detected'."
echo "  reason        : Courseware repository (Markdown course prose, GitHub Actions workflow YAML,"
echo "                  PNG screenshots). No exported symbols; no OpenAPI/SDL/.proto contract."
echo
echo "  What DOES change here, and what to inspect instead of an API baseline:"
echo "    - .github/workflows/*.yml : the course automation. A change here alters what a learner"
echo "                                experiences. Review the diff directly."
echo "    - .github/steps/*.md      : the course prose the workflows publish into the learner's"
echo "                                README, in sequence. Verify step numbering and cross-links."
echo "    - README.md               : the course entry point and the start-course template link."
exit 0
