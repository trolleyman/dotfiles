#!/bin/sh

set -e

# TODO: Handle installing Git, bash, etc.
if [ ! -d ~/.dotfiles ]; then
    set -x
    git clone --recursive https://github.com/trolleyman/dotfiles ~/.dotfiles
else
    set -x
    oldpath=$(pwd)
    cd ~/.dotfiles
    git fetch
    git reset --hard
    git checkout master
    git reset --hard origin/master
    git submodule init
    git submodule sync
    git submodule update
    cd "$oldpath"
fi

~/.dotfiles/bin/dotfiles-update -f
set +x

printf '\nTo update the shell, run: exec bash -l\n\n'
