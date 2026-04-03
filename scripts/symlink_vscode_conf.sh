#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

VSCODE_USER_DIR="$HOME/Library/Application Support/Code/User"

if [ ! -d "$VSCODE_USER_DIR" ]; then
    echo "Error: $VSCODE_USER_DIR does not exist. Install VS Code first."
    exit 1
fi

LINKS=(
    "$REPO_DIR/nix-darwin/config/vscode/settings.json"    "$VSCODE_USER_DIR/settings.json"
    "$REPO_DIR/nix-darwin/config/vscode/keybindings.json"  "$VSCODE_USER_DIR/keybindings.json"
)

"$SCRIPT_DIR/symlink.sh" "${LINKS[@]}"
