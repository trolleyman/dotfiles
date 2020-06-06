#!/bin/sh

set -e

# TODO: Handle installing Git, bash, etc.
if [ ! -d ~/.dotfiles ]; then
    set -x
    git clone --recursive https://github.com/trolleyman/dotfiles ~/.dotfiles
else
    set -x
    pushd ~/.dotfiles
    git fetch
    git reset --hard
    git checkout master
    git reset --hard origin/master
    git submodule init
    git submodule sync
    git submodule update
    popd
fi

~/.dotfiles/bin/dotfiles-setup -f
