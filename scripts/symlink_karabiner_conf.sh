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

"$SCRIPT_DIR/symlink.sh" "${LINKS[@]}" || exit 1

echo "Karabiner config linked:"
for ((i=0; i<${#LINKS[@]}; i+=2)); do
    echo "  ${LINKS[i+1]} -> ${LINKS[i]}"
done