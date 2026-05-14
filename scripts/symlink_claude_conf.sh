#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

CLAUDE_HOME="$HOME/.claude"

if [ ! -d "$CLAUDE_HOME" ]; then
    echo "Error: $CLAUDE_HOME directory does not exist. Install Claude Code first."
    exit 1
fi

LINKS=(
    "$REPO_DIR/nix-darwin/config/claude/settings.json"   "$CLAUDE_HOME/settings.json"
    "$REPO_DIR/nix-darwin/config/claude/statusline.sh"   "$CLAUDE_HOME/statusline.sh"
    "$REPO_DIR/nix-darwin/config/claude/agents"           "$CLAUDE_HOME/agents"
    "$REPO_DIR/nix-darwin/config/claude/hooks"             "$CLAUDE_HOME/hooks"
    "$REPO_DIR/nix-darwin/config/claude/rules"             "$CLAUDE_HOME/rules"
    "$REPO_DIR/nix-darwin/config/claude/commands"          "$CLAUDE_HOME/commands"
    "$REPO_DIR/nix-darwin/config/claude/skills"            "$CLAUDE_HOME/skills"
)

"$SCRIPT_DIR/symlink.sh" "${LINKS[@]}" || exit 1

echo "Claude config linked:"
for ((i=0; i<${#LINKS[@]}; i+=2)); do
    echo "  ${LINKS[i+1]} -> ${LINKS[i]}"
done
