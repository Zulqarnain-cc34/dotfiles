#!/usr/bin/env bash
# Build the csakura screensaver binary from its vendored source.
#
# The compiled binary is intentionally NOT committed (the repo keeps no binaries;
# see scripts/validate.sh), so it is built here on setup. setup.sh calls this, and
# you can also run it by hand. It only builds when the binary is missing; pass -f
# to force a rebuild.
set -euo pipefail

here="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
bin="$here/csakura"
src="$here/csakura.src"

[[ "${1:-}" == "-f" ]] && rm -f "$bin"

if [[ -x "$bin" ]]; then
    echo "csakura: already built ($bin)"
    exit 0
fi

if ! command -v make >/dev/null || ! command -v cc >/dev/null; then
    echo "csakura: a C compiler + make are needed to build it (install base-devel)." >&2
    exit 1
fi

echo "csakura: building from source..."
make -C "$src" >/dev/null
cp "$src/csakura" "$bin"
echo "csakura: built -> $bin"
