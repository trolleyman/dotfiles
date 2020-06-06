#!/bin/sh

set -ex

# TODO: Handle installing Git, bash, etc.
git clone https://github.com/trolleyman/dotfiles ~/.dotfiles

pushd ~/.dotfiles
git submodule init
git submodule sync
git submodule update
popd

~/.dotfiles/bin/dotfiles-setup -f
