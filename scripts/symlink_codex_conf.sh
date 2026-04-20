#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

if [ ! -d "$HOME/.codex" ]; then
    echo "Error: ~/.codex directory does not exist. Install Codex first."
    exit 1
fi

LINKS=(
    "$REPO_DIR/nix-darwin/config/claude/agents"           "$HOME/.codex/agents"
    "$REPO_DIR/nix-darwin/config/claude/rules"             "$HOME/.codex/rules"
    "$REPO_DIR/nix-darwin/config/claude/commands"          "$HOME/.codex/commands"
    "$REPO_DIR/nix-darwin/config/claude/skills"            "$HOME/.codex/skills"
)

"$SCRIPT_DIR/symlink.sh" "${LINKS[@]}" || exit 1

echo "Codex config linked:"
for ((i=0; i<${#LINKS[@]}; i+=2)); do
    echo "  ${LINKS[i+1]} -> ${LINKS[i]}"
done
