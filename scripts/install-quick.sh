#!/usr/bin/env bash
# Listing Forge — quick install helper
# Brings up the GUI nginx container. Assumes Docker is already installed.
# Run from the repo root.

set -e

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo "==> Listing Forge quick install"
echo "==> Repo root: $REPO_ROOT"
echo

# Sanity checks
if ! command -v docker >/dev/null 2>&1; then
  echo "ERROR: docker is not installed or not in PATH."
  echo "Install Docker first — see docs/01-prerequisites.md"
  exit 1
fi

if ! docker compose version >/dev/null 2>&1; then
  echo "ERROR: docker compose plugin is not installed."
  echo "Install with: sudo apt install docker-compose-plugin"
  exit 1
fi

if [ ! -f "$REPO_ROOT/gui/index.html" ]; then
  echo "ERROR: gui/index.html not found. Are you running this from the repo?"
  exit 1
fi

echo "==> Starting listing-forge-web container..."
cd "$REPO_ROOT/deploy"
docker compose up -d

echo
echo "==> Waiting for healthcheck..."
sleep 5

if docker ps --filter name=listing-forge-web --format '{{.Status}}' | grep -q "healthy\|Up"; then
  echo "==> SUCCESS: GUI is running"
  echo
  echo "Open: http://$(hostname -I 2>/dev/null | awk '{print $1}' || echo 'YOUR_IP'):8088"
  echo
  echo "Next steps:"
  echo "  1. Set up n8n if you haven't yet — see docs/02-install-n8n.md"
  echo "  2. Import the workflow — see docs/03-import-workflow.md"
  echo "  3. Get API keys — see docs/04-get-api-keys.md"
  echo "  4. Add credentials and forge — see docs/05-add-credentials.md"
else
  echo "==> Container started but healthcheck not passing yet. Wait a moment and try:"
  echo "    docker ps"
  echo "    curl http://localhost:8088/healthz"
fi
