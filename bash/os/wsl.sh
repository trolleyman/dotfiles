#!/bin/bash

if command -v jupyter 2>&1 > /dev/null; then
    jupyter() {
        case $1 in
            notebook)
                command "jupyter" $@ --no-browser
                ;;
            *)
                command "jupyter" $@
                ;;
        esac
    }
fi

cmd() (
    args=()
    for arg in "$@"; do
        args+=("$arg")
    done
    set -x
    cmd.exe /C "${args[@]}"
)

