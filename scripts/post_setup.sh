#!/bin/bash

# Define pairs as a flat array (source target source target ...)
LINKS=(
    /location_a/file_a /location_b/file_b
    /location_c/file_c /location_d/file_d
    /location_e/dir_a  /location_f/dir_b
)

./symlink.sh "${LINKS[@]}"