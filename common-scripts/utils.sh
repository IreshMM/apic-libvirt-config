#!/bin/bash

function merge_dict() {
    local -n DEST_VAR=$1
    shift

    local -n SRC_VAR
    local KEY

    for SRC_VAR in $@; do
        for KEY in "${!SRC_VAR[@]}"; do
            DEST_VAR[$KEY]="${SRC_VAR[$KEY]}"
        done
    done
}
