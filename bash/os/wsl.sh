#!/bin/bash

export WINHOME="$(cmd.exe /C "cd /D %USERPROFILE% && bash.exe -c pwd" 2>/dev/null)"

if command -v jupyter 2>&1 > /dev/null; then
    jupyter() {
        case $1 in
            notebook)
                command "jupyter" --no-browser "$@"
                ;;
            *)
                command "jupyter" "$@"
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

# TODO: Override 'cd' to handle Windows paths
cdw() {
    if [[ $# == 0 ]]; then
        cd ~
    elif [[ $# > 1 ]]; then
        echo "cdw: too many arguments" 1>&2
        return 1
    else
        if [[ "$1" == '~' ]]; then
            cd "$WINHOME"
            return
        elif [[ "$1" == '~/'* ]]; then
            cd "$WINHOME/${1##\~\/}"
            return
        fi
        path="$(wslpath "$1" 2>&1)"
        if [[ $? != 0 ]]; then
            echo "wslpath: invalid Windows path: $1"
            return 1
        fi
        cd "$path"
    fi
}

