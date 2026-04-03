#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

if [ ! -d "$HOME/.cargo" ]; then
    echo "Error: ~/.cargo directory does not exist. Install Rust first."
    exit 1
fi

"$SCRIPT_DIR/symlink.sh" \
    "$REPO_DIR/home-manager/config/rust/cargo/config.toml" \
    "$HOME/.cargo/config.toml"