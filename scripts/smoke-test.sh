#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TELLMESH_ROOT="$(cd "$ROOT/.." && pwd)"
export PYTHONPATH="$TELLMESH_ROOT/uricore/core/python:$TELLMESH_ROOT/urisys/src:$(find "$ROOT/packages/python" -mindepth 1 -maxdepth 1 -type d -printf '%p/src:')"
cd "$ROOT"

python -m urisys.cli --packs browser call browser://default/page/open --payload '{"url":"https://example.com"}' --approve
python -m urisys.cli --packs docker call docker://container/web/command/restart --approve --dry-run
python -m urisys.cli --packs all flow "$TELLMESH_ROOT/urisys/flows/device-maintenance.uri.flow.yaml" --approve --dry-run

python -m urisys.cli markpact validate "$TELLMESH_ROOT/urisys/markpacts/packs/uribrowser.markpact.md"
python -m urisys.cli markpact test "$TELLMESH_ROOT/urisys/markpacts/packs/uribrowser.markpact.md"
python -m urisys.cli markpact validate "$TELLMESH_ROOT/urisys/markpacts/packs/uriprinter.markpact.md"
python -m urisys.cli markpact test "$TELLMESH_ROOT/urisys/markpacts/packs/uriprinter.markpact.md"
python -m urisys.cli markpact validate "$TELLMESH_ROOT/urisys/markpacts/packs/uriusb.markpact.md"
python -m urisys.cli markpact test "$TELLMESH_ROOT/urisys/markpacts/packs/uriusb.markpact.md"
python -m urisys.cli markpact fetch "file://$TELLMESH_ROOT/urisys/markpacts/packs/uribrowser.markpact.md"

python -m urisys.cli --packs none --markpact "$TELLMESH_ROOT/urisys/markpacts/packs/urisystemd.markpact.md" call systemd://unit/docker.service/query/status
python -m urisys.cli --packs none --markpact "$TELLMESH_ROOT/urisys/markpacts/packs/uriprinter.markpact.md" call printer://epson/query/status
python -m urisys.cli --packs none --markpact "$TELLMESH_ROOT/urisys/markpacts/packs/uriusb.markpact.md" call usb://host/local/query/ports

if command -v nl2uricore >/dev/null 2>&1; then
  TMP_MARKPACT="$(mktemp /tmp/uricache.XXXXXX.markpact.md)"
  nl2uricore generate --prefix cache --no-llm --prompt "Stwórz URI pack cache:// do statusu i komendy run" --out "$TMP_MARKPACT"
  python -m urisys.cli markpact validate "$TMP_MARKPACT"
  python -m urisys.cli markpact test "$TMP_MARKPACT"
fi
