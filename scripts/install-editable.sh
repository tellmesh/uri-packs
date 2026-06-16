#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TELLMESH_ROOT="$(cd "$ROOT/.." && pwd)"

python -m pip install -e "$TELLMESH_ROOT/uricore"
for pkg in "$ROOT"/packages/python/uri*; do
  python -m pip install -e "$pkg"
done
python -m pip install -e "$TELLMESH_ROOT/urisys"
if [ -d "$TELLMESH_ROOT/nl2uricore" ]; then
  python -m pip install -e "$TELLMESH_ROOT/nl2uricore"
fi

echo "Installed uricore, uri* packs, urisys and optional nl2uricore."
