#!/bin/sh

set -ex

# TODO: Handle installing Git, bash, etc.
git clone https://github.com/trolleyman/dotfiles ~/.dotfiles
cd ~/.dotfiles

./bin/
