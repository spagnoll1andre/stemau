#!/usr/bin/env bash
# sanity_checks.sh — Verify Python syntax and XML well-formedness for all addons
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
ADDONS_DIR="$REPO_ROOT/addons"
ERRORS=0

echo "=== Sanity Checks ==="
echo "Repo root : $REPO_ROOT"
echo "Addons dir: $ADDONS_DIR"
echo ""

# ── Structure checks ──────────────────────────────────────────────────────────
echo "[1/3] Checking required directories..."
for dir in addons docker scripts; do
  if [ -d "$REPO_ROOT/$dir" ]; then
    echo "  OK  $dir/"
  else
    echo "  FAIL  $dir/ not found"
    ERRORS=$((ERRORS + 1))
  fi
done

# ── Python syntax ─────────────────────────────────────────────────────────────
echo ""
echo "[2/3] Checking Python syntax..."
if ! command -v python3 &>/dev/null; then
  echo "  SKIP  python3 not found in PATH"
else
  PY_FILES=$(find "$ADDONS_DIR" -name "*.py" 2>/dev/null || true)
  if [ -z "$PY_FILES" ]; then
    echo "  SKIP  No .py files found in addons/"
  else
    while IFS= read -r file; do
      if python3 -m py_compile "$file" 2>&1; then
        echo "  OK  $file"
      else
        echo "  FAIL  $file"
        ERRORS=$((ERRORS + 1))
      fi
    done <<< "$PY_FILES"
  fi
fi

# ── XML well-formedness ───────────────────────────────────────────────────────
echo ""
echo "[3/3] Checking XML well-formedness..."
XML_CHECKER=""
if command -v xmllint &>/dev/null; then
  XML_CHECKER="xmllint"
elif command -v python3 &>/dev/null; then
  XML_CHECKER="python3"
fi

if [ -z "$XML_CHECKER" ]; then
  echo "  SKIP  neither xmllint nor python3 found"
else
  XML_FILES=$(find "$ADDONS_DIR" -name "*.xml" 2>/dev/null || true)
  if [ -z "$XML_FILES" ]; then
    echo "  SKIP  No .xml files found in addons/"
  else
    while IFS= read -r file; do
      if [ "$XML_CHECKER" = "xmllint" ]; then
        if xmllint --noout "$file" 2>&1; then
          echo "  OK  $file"
        else
          echo "  FAIL  $file"
          ERRORS=$((ERRORS + 1))
        fi
      else
        if python3 -c "import xml.etree.ElementTree as ET; ET.parse('$file')" 2>&1; then
          echo "  OK  $file"
        else
          echo "  FAIL  $file"
          ERRORS=$((ERRORS + 1))
        fi
      fi
    done <<< "$XML_FILES"
  fi
fi

# ── Result ────────────────────────────────────────────────────────────────────
echo ""
if [ "$ERRORS" -eq 0 ]; then
  echo "All checks passed."
  exit 0
else
  echo "$ERRORS check(s) failed."
  exit 1
fi
