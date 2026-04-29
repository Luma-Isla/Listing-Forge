#!/usr/bin/env bash
# Listing Forge — GUI update helper
# Updates the GUI file without rebuilding the container.
# Run after pulling new changes from git, or after editing index.html.

set -e

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo "==> Updating Listing Forge GUI"
echo

if [ ! -f "$REPO_ROOT/gui/index.html" ]; then
  echo "ERROR: gui/index.html not found in repo."
  exit 1
fi

# The container has the gui folder mounted, so changes are live.
# We just need to make sure the file is fresh and notify the user.

echo "==> Current GUI file:"
ls -la "$REPO_ROOT/gui/index.html"
echo
echo "==> Done. The container picks up changes automatically."
echo "==> Hard-refresh your browser (Cmd+Shift+R / Ctrl+Shift+R) to bypass cache."
echo
echo "If you have a remote NAS or VPS deployment, scp the file:"
echo "    scp gui/index.html user@host:/path/to/gui/index.html"
