#!/usr/bin/env bash
# test_local.sh — Start Docker stack, install module and run Odoo tests
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
COMPOSE_FILE="$REPO_ROOT/docker/docker-compose.yml"
MODULE="${1:-stemau_stock}"        # pass module name as first arg, or set default
DB="odoo_test"
ODOO_CONTAINER="stemau_odoo"
TIMEOUT=60

echo "=== Local Test Runner ==="
echo "Module : $MODULE"
echo "DB     : $DB"
echo ""

# ── Sanity checks first ───────────────────────────────────────────────────────
echo "[1/4] Running sanity checks..."
"$REPO_ROOT/scripts/sanity_checks.sh"

# ── Start stack ───────────────────────────────────────────────────────────────
echo ""
echo "[2/4] Starting Docker stack..."
docker compose -f "$COMPOSE_FILE" up -d --wait --wait-timeout "$TIMEOUT"
echo "  Stack is up."

# ── Install module ────────────────────────────────────────────────────────────
echo ""
echo "[3/4] Installing module '$MODULE' into database '$DB'..."
docker exec "$ODOO_CONTAINER" odoo \
  --config /etc/odoo/odoo.conf \
  --database "$DB" \
  --init "$MODULE" \
  --stop-after-init \
  --no-http

# ── Run tests ─────────────────────────────────────────────────────────────────
echo ""
echo "[4/4] Running tests for module '$MODULE'..."
docker exec "$ODOO_CONTAINER" odoo \
  --config /etc/odoo/odoo.conf \
  --database "$DB" \
  --test-enable \
  --test-tags "$MODULE" \
  --stop-after-init \
  --no-http

echo ""
echo "All tests completed successfully."
