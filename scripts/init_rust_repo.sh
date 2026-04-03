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

for file in "$TEMPLATE_DIR"/* "$TEMPLATE_DIR"/.*; do
    name="$(basename "$file")"
    [ "$name" = "." ] || [ "$name" = ".." ] && continue
    dest="$TARGET/$name"
    if [ -e "$dest" ] || [ -L "$dest" ]; then
        bak="${dest}.bak"
        if [ -e "$bak" ] || [ -L "$bak" ]; then
            echo "Error: backup $bak already exists, skipping $name"
            continue
        fi
        mv "$dest" "$bak" || { echo "Error: failed to backup $dest"; exit 1; }
        echo "Backed up $dest -> $bak"
    fi
    cp -r "$file" "$dest" || { echo "Error: failed to copy $name"; exit 1; }
    echo "Copied $name"
done

echo "Rust repo initialized in $TARGET."
