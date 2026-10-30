#!/usr/bin/env bash
# verify.sh — test suite for the Free KDP Publishing Kit.
# Runs with no network and writes results to stdout. Exits non-zero on any failure.
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

FAIL=0

note() { printf '  [ok] %s\n' "$1"; }
fail() { printf '  [FAIL] %s\n' "$1"; FAIL=1; }

HTML_FILES=(
  html/pre-launch-checklist.html
  html/metadata-worksheet.html
  html/upload-checklist.html
  html/launch-week-calendar.html
)

MD_FILES=(
  kit/pre-launch-checklist.md
  kit/metadata-worksheet.md
  kit/upload-checklist.md
  kit/launch-week-calendar.md
)

echo "== Free KDP Publishing Kit — verification =="

# 1. Required files exist
echo "-> Required files"
for f in LICENSE README.md "${HTML_FILES[@]}" "${MD_FILES[@]}" html/style.css; do
  if [[ -f "$f" ]]; then note "$f"; else fail "missing: $f"; fi
done

# 2. No .github/workflows
echo "-> No GitHub Actions workflows"
if [[ -e .github/workflows ]]; then fail ".github/workflows exists"; else note "absent"; fi

# 3. HTML parses and links shared CSS
echo "-> HTML validity + stylesheet link"
python3 - "$ROOT" "${HTML_FILES[@]}" <<'PY'
import sys, os
from html.parser import HTMLParser

root, files = sys.argv[1], sys.argv[2:]
ok = True

class Checker(HTMLParser):
    def __init__(self):
        super().__init__()
        self.errors = []
    def error(self, message):
        self.errors.append(message)

for f in files:
    path = os.path.join(root, f)
    with open(path, encoding="utf-8") as fh:
        src = fh.read()
    c = Checker()
    c.feed(src)
    if c.errors:
        ok = False
        print(f"  [FAIL] {f}: {len(c.errors)} parse error(s)")
        for e in c.errors:
            print(f"      {e}")
    else:
        print(f"  [ok]   {f}: parses cleanly")
    if 'style.css' not in src:
        ok = False
        print(f"  [FAIL] {f}: does not link style.css")
    else:
        print(f"  [ok]   {f}: links style.css")

sys.exit(0 if ok else 1)
PY
if [[ ${PIPESTATUS[0]} -ne 0 ]]; then FAIL=1; fi

# 4. LICENSE exact copyright line
echo "-> LICENSE copyright line"
LICENSE_LINE="Copyright (c) 2026 Asdale Dynamics, LLC"
if grep -qF "$LICENSE_LINE" LICENSE; then
  note "exact line present: $LICENSE_LINE"
else
  fail "exact line missing: $LICENSE_LINE"
fi

# 5. README credits Asdale Dynamics, LLC
echo "-> README credit"
if grep -q "Asdale Dynamics, LLC" README.md; then
  note "README credits Asdale Dynamics, LLC"
else
  fail "README does not credit Asdale Dynamics, LLC"
fi

# 6. No secrets / API keys / personal data patterns
echo "-> Secrets scan"
SECRET_PATTERNS='sk-|AKIA|api_key|apikey|password|secret\s*=|BEGIN (RSA|EC|OPENSSH) PRIVATE KEY'
HITS=0
while IFS= read -r -d '' f; do
  case "$f" in
    */.git/*) continue ;;
    */scripts/verify.sh) continue ;;
  esac
  if grep -IqiE "$SECRET_PATTERNS" "$f" 2>/dev/null; then
    fail "possible secret in: $f"
    HITS=$((HITS+1))
  fi
done < <(find . -type f -print0)
if [[ $HITS -eq 0 ]]; then note "no secret-like patterns found"; fi

# 7. Fillable controls present in HTML
echo "-> Fillable controls"
for f in "${HTML_FILES[@]}"; do
  if grep -qE '<input|<textarea' "$f"; then
    note "$f: has fillable controls"
  else
    fail "$f: no fillable controls"
  fi
done

echo
if [[ $FAIL -eq 0 ]]; then
  echo "== All checks passed =="
  exit 0
else
  echo "== Verification FAILED =="
  exit 1
fi
