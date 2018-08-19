
# == Shell options ==
# umask
umask 027

# For rm **/*.pyc, etc.
shopt -s globstar

# Make Ctrl-D not end shell
set -o ignoreeof

#so as not to be disturbed by Ctrl-S ctrl-Q in terminals:
stty -ixon

# Append to history, don't rewrite it
shopt -s histappend

# History env
export HISTFILESIZE=20000
export HISTSIZE=5000
export HISTTIMEFORMAT='%F %T '

# == Env ==
# GPG
export GPG_TTY=$(tty)

# Make vim the default editor
export EDITOR=/usr/bin/vim

# Local binaries
export PATH=$PATH:$HOME/.local/bin:$HOME/.dotfiles/bin:$HOME/bin

# X11 DISPLAY variable
if [[ -z "$DISPLAY" ]]; then
	export DISPLAY=localhost:0
fi

# == Git ==
git config --global submodule.recurse true                    2>&1 > /dev/null # Recurse through submodules when pulling
git config --global credential.helper 'cache --timeout=7200'  2>&1 > /dev/null # Cache passwords for 2 hours
git config --global core.preloadIndex true                    2>&1 > /dev/null # Preload index -- helps on NFS
git config --global push.default simple                       2>&1 > /dev/null # Adopt new pushing format
