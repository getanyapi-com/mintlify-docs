#!/usr/bin/env bash
# Protect the contract-first instructions that coding agents receive from the docs root.
set -euo pipefail
cd "$(dirname "$0")/.."

python3 - <<'PY'
from pathlib import Path
import re
import sys

index = Path("index.mdx").read_text()
normalized_index = " ".join(index.split())

required = {
    "SKU detail lookup": "GET https://api.getanyapi.com/v1/apis/{sku}",
    "schema authority": "Use only the fields declared in `inputSchema`.",
    "no guessed aliases": "Do not retry with guessed field names.",
}

forbidden = {
    "unqualified limit instruction": re.compile(r"Set `limit` in\s+your input", re.IGNORECASE),
    "universal pagination claim": re.compile(r"works everywhere", re.IGNORECASE),
    "universal paginated-API claim": re.compile(r"every paginated API", re.IGNORECASE),
}

errors = []
for label, text in required.items():
    if text not in normalized_index:
        errors.append(f"index.mdx is missing {label}: {text}")

for path in sorted(Path(".").glob("*.mdx")):
    content = path.read_text()
    for label, pattern in forbidden.items():
        if match := pattern.search(content):
            line = content.count("\n", 0, match.start()) + 1
            errors.append(f"{path}:{line} contains {label}: {match.group(0)!r}")

if errors:
    print("agent contract guard FAILED:")
    for error in errors:
        print(f"  - {error}")
    sys.exit(1)

print("agent contract guard: ok (docs root is schema-first; universal field claims absent)")
PY
