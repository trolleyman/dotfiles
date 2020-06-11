#!/bin/bash

is_wsl() {
    grep -qiE "(Microsoft|WSL)" /proc/version &> /dev/null
    return $?
}

# Source os/ scripts
if is_wsl; then
    # WSL
    export PATH=~/.dotfiles/bin/os/wsl:$PATH
    if [[ -r ~/.dotfiles/bash/os/wsl.sh ]]; then
        . ~/.dotfiles/bash/os/wsl.sh
    fi
fi

