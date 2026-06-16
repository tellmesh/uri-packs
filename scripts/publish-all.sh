#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

publish_python() {
  local pkg_dir="$1"
  local name
  name="$(basename "$pkg_dir")"
  echo "=== publish python: $name ==="
  (
    cd "$pkg_dir"
    rm -rf dist build *.egg-info 2>/dev/null || true
    python -m build
    python -m twine upload dist/*
  )
}

publish_node() {
  local pkg_dir="$1"
  local name
  name="$(basename "$pkg_dir")"
  echo "=== publish node: $name ==="
  (cd "$pkg_dir" && npm publish --access public)
}

for pkg in "$ROOT"/packages/python/*/; do
  publish_python "$pkg"
done

for pkg in "$ROOT"/packages/js/*/; do
  publish_node "$pkg"
done

echo "All uri-packs subpackages published."
