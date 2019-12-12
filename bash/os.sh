#!/bin/bash

# Source os/ scripts
if grep -q Microsoft /proc/version; then
    # WSL
    if [[ -r ~/.dotfiles/bash/os/wsl.sh ]]; then
        . ~/.dotfiles/bash/os/wsl.sh
    fi
fi

