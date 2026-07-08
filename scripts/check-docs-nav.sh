#!/usr/bin/env bash
# docs.json navigation guard.
#
# Every navigation group that references an OpenAPI spec (an `openapi` key) MUST
# also carry a `pages` key. Mintlify silently DROPS an openapi group that has no
# `pages` key at all, 404ing the entire auto-generated API Reference on the
# deployed build (prod incident 2026-07-08: removing the pin by deleting `pages`
# took the whole /api-reference/* section down). Use `"pages": []` to
# auto-generate one page per operation with nothing pinned.
#
# Also fails if docs.json is not valid JSON. Cheap, deterministic, no Mintlify
# install needed - the first line of defense before the heavier build check.
set -euo pipefail
cd "$(dirname "$0")/.."

python3 - <<'PY'
import json, sys

try:
    with open("docs.json") as f:
        doc = json.load(f)
except (OSError, json.JSONDecodeError) as e:
    print(f"docs.json nav guard FAILED: docs.json is not valid JSON: {e}")
    sys.exit(1)

bad = []

def walk(node, path):
    if isinstance(node, dict):
        if "openapi" in node and "pages" not in node:
            label = node.get("group") or node.get("tab") or node.get("anchor") or "?"
            bad.append(f"{path}  (group: {label})")
        for k, v in node.items():
            walk(v, f"{path}/{k}")
    elif isinstance(node, list):
        for i, v in enumerate(node):
            walk(v, f"{path}[{i}]")

walk(doc, "")

if bad:
    print("docs.json nav guard FAILED: group(s) reference `openapi` but have no `pages` key:")
    for b in bad:
        print("  -", b)
    print()
    print('Fix: add `"pages": []` to auto-generate every operation with nothing pinned.')
    print("Removing `pages` entirely drops the whole group and 404s the API Reference")
    print("(see the docs-hosting incident, 2026-07-08).")
    sys.exit(1)

print("docs.json nav guard: ok (every openapi group carries a pages key)")
PY
