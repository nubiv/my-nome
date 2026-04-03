#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

SCRIPTS=(
    "symlink_cargo_conf.sh"
    "symlink_claude_conf.sh"
    "symlink_karabiner_conf.sh"
    "symlink_vscode_conf.sh"
)

FAILED=0

for script in "${SCRIPTS[@]}"; do
    echo "--- Running $script ---"
    if "$SCRIPT_DIR/$script"; then
        echo "[OK] $script succeeded"
    else
        echo "[FAIL] $script failed"
        FAILED=$((FAILED + 1))
    fi
    echo ""
done

if [ "$FAILED" -gt 0 ]; then
    echo "$FAILED script(s) failed."
    exit 1
else
    echo "All scripts succeeded."
fi
