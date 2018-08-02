
# == Shell options ==
# For rm **/*.pyc, etc.
shopt -s globstar

# Make Ctrl-D not end shell
set -o ignoreeof

# Append to history, don't rewrite it
shopt -s histappend

# History env
export HISTFILESIZE=20000
export HISTSIZE=5000
export HISTTIMEFORMAT='%F %T '

# == Env ==
# Make vim the default editor
export EDITOR=/usr/bin/vim

# Local binaries
export PATH=$PATH:~/.local/bin

# == Git ==
git config --global submodule.recurse true
git config --global credential.helper 'cache --timeout=3600'
