#!/bin/bash

if [ $(($# % 2)) -ne 0 ]; then
    echo "Error: arguments must be in pairs (source target)"
    exit 1
fi

link_with_backup() {
    local SOURCE="$1"
    local TARGET="$2"
    local BAK="${TARGET}.bak"

    if [ -e "$TARGET" ] || [ -L "$TARGET" ]; then
        if [ -e "$BAK" ] || [ -L "$BAK" ]; then
            echo "Error: backup path $BAK already exists, skipping $TARGET"
            return 1
        fi
        mv "$TARGET" "$BAK" || { echo "Error: failed to rename $TARGET"; return 1; }
        echo "Renamed $TARGET -> $BAK"
    fi

    ln -s "$SOURCE" "$TARGET" || { echo "Error: failed to link $SOURCE -> $TARGET"; return 1; }
    echo "Linked $SOURCE -> $TARGET"
}

while [ $# -gt 0 ]; do
    link_with_backup "$1" "$2"
    shift 2
done