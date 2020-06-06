#!/bin/sh

set -e

# TODO: Handle installing Git, bash, etc.
if [ ! -d ~/.dotfiles ]; then
    set -x
    git clone --recursive https://github.com/trolleyman/dotfiles ~/.dotfiles
else
    set -x
fi

~/.dotfiles/bin/dotfiles-setup -f
