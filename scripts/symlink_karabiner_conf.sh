#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

if [ ! -d "$HOME/.config/karabiner" ]; then
    echo "Error: ~/.config/karabiner directory does not exist. Install Karabiner-Elements first."
    exit 1
fi

LINKS=(
    "$REPO_DIR/nix-darwin/config/karabiner/karabiner.json"  "$HOME/.config/karabiner/karabiner.json"
)

"$SCRIPT_DIR/symlink.sh" "${LINKS[@]}"