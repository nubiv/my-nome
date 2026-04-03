#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
TEMPLATE_DIR="$REPO_DIR/home-manager/config/rust/repo"

if [ -z "$1" ]; then
    echo "Usage: $0 <target-directory>"
    exit 1
fi

TARGET="$1"

if [ ! -d "$TARGET" ]; then
    echo "Error: $TARGET does not exist."
    exit 1
fi

cp -r "$TEMPLATE_DIR"/. "$TARGET/" || { echo "Error: failed to copy files."; exit 1; }

echo "Rust repo initialized in $TARGET:"
for file in "$TEMPLATE_DIR"/*  "$TEMPLATE_DIR"/.*; do
    name="$(basename "$file")"
    [ "$name" = "." ] || [ "$name" = ".." ] && continue
    echo "  $name"
done
