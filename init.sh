#!/bin/sh

set -ex

# TODO: Handle installing Git, bash, etc.
git clone --recursive https://github.com/trolleyman/dotfiles ~/.dotfiles

~/.dotfiles/bin/dotfiles-setup -f
