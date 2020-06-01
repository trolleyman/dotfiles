#!/bin/bash

# Source os/ scripts
if grep -q -i Microsoft /proc/version; then
    # WSL
    export PATH=~/.dotfiles/bin/os/wsl:$PATH
    if [[ -r ~/.dotfiles/bash/os/wsl.sh ]]; then
        . ~/.dotfiles/bash/os/wsl.sh
    fi
fi

