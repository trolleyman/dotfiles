#!/bin/sh

set -ex

# TODO: Handle installing Git, bash, etc.
if [[ ! -d ~/.dotfiles ]]; then
    git clone --recursive https://github.com/trolleyman/dotfiles ~/.dotfiles
fi

~/.dotfiles/bin/dotfiles-setup -f
