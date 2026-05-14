#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

CODEX_HOME="$HOME/.codex"

if [ ! -d "$CODEX_HOME" ]; then
    echo "Error: $CODEX_HOME directory does not exist. Install Codex first."
    exit 1
fi

LINKS=(
    "$REPO_DIR/nix-darwin/config/claude/agents"           "$CODEX_HOME/agents"
    "$REPO_DIR/nix-darwin/config/claude/rules"             "$CODEX_HOME/rules"
    "$REPO_DIR/nix-darwin/config/claude/commands"          "$CODEX_HOME/commands"
    "$REPO_DIR/nix-darwin/config/claude/skills"            "$CODEX_HOME/skills"
)

"$SCRIPT_DIR/symlink.sh" "${LINKS[@]}" || exit 1

echo "Codex config linked:"
for ((i=0; i<${#LINKS[@]}; i+=2)); do
    echo "  ${LINKS[i+1]} -> ${LINKS[i]}"
done
