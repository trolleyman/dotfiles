
# == Shell options ==
# For rm **/*.pyc, etc.
shopt -s globstar

# Make Ctrl-D not end shell
set -o ignoreeof

# == Env ==
# Make vim the default editor
export EDITOR=/usr/bin/vim

# Local binaries
export PATH=$PATH:~/.local/bin

# == Git ==
git config --global submodule.recurse true
git config --global credential.helper 'cache --timeout=3600'
