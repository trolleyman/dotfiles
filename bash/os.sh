#!/bin/bash

is_wsl() {
    grep -qiE "(Microsoft|WSL)" /proc/version &> /dev/null
    return $?
}

# Source os/ scripts
if is_wsl; then
    # WSL
    if [[ -d ~/.dotfiles/bin/os/wsl ]]; then
        export PATH=~/.dotfiles/bin/os/wsl:$PATH
    fi
    if [[ -r ~/.dotfiles/bash/os/wsl.sh ]]; then
        . ~/.dotfiles/bash/os/wsl.sh
    fi

    if [[ ! -d /run/wsl ]]; then
        # WSL1
        if [[ -d ~/.dotfiles/bin/os/wsl1 ]]; then
            export PATH=~/.dotfiles/bin/os/wsl1:$PATH
        fi
        if [[ -r ~/.dotfiles/bash/os/wsl1.sh ]]; then
            . ~/.dotfiles/bash/os/wsl1.sh
        fi
    else
        # WSL2
        if [[ -d ~/.dotfiles/bin/os/wsl2 ]]; then
            export PATH=~/.dotfiles/bin/os/wsl2:$PATH
        fi
        if [[ -r ~/.dotfiles/bash/os/wsl2.sh ]]; then
            . ~/.dotfiles/bash/os/wsl2.sh
        fi
    fi
fi

