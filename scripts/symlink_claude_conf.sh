#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

if [ ! -d "$HOME/.claude" ]; then
    echo "Error: ~/.claude directory does not exist. Install Claude Code first."
    exit 1
fi

LINKS=(
    "$REPO_DIR/nix-darwin/config/claude/settings.json"   "$HOME/.claude/settings.json"
    "$REPO_DIR/nix-darwin/config/claude/statusline.sh"   "$HOME/.claude/statusline.sh"
    "$REPO_DIR/nix-darwin/config/claude/agents"           "$HOME/.claude/agents"
    "$REPO_DIR/nix-darwin/config/claude/hooks"             "$HOME/.claude/hooks"
    "$REPO_DIR/nix-darwin/config/claude/rules"             "$HOME/.claude/rules"
    "$REPO_DIR/nix-darwin/config/claude/commands"          "$HOME/.claude/commands"
    "$REPO_DIR/nix-darwin/config/claude/skills"            "$HOME/.claude/skills"
)

"$SCRIPT_DIR/symlink.sh" "${LINKS[@]}"
