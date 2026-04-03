#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

if [ ! -d "$HOME/.cargo" ]; then
    echo "Error: ~/.cargo directory does not exist. Install Rust first."
    exit 1
fi

LINKS=(
    "$REPO_DIR/home-manager/config/rust/cargo/config.toml"  "$HOME/.cargo/config.toml"
)

"$SCRIPT_DIR/symlink.sh" "${LINKS[@]}" || exit 1

echo "Cargo config linked:"
for ((i=0; i<${#LINKS[@]}; i+=2)); do
    echo "  ${LINKS[i+1]} -> ${LINKS[i]}"
done