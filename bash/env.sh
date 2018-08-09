
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
export PATH=$PATH:~/.local/bin:~/.dotfiles/bin

# == Git ==
git config --global submodule.recurse true                    2>&1 > /dev/null # Recurse through submodules when pulling
git config --global credential.helper 'cache --timeout=7200'  2>&1 > /dev/null # Cache passwords for 2 hours
git config --global core.preloadIndex true                    2>&1 > /dev/null # Preload index -- helps on NFS

