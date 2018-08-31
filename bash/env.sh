
# == Dir colors ==
if [ -r ~/.dir_colors ]; then
	eval `dircolors ~/.dir_colors`
fi

# == Shell options ==
# umask
umask 027

# For rm **/*.pyc, etc.
shopt -s globstar

# Make Ctrl-D not end shell
set -o ignoreeof

# So as not to be disturbed by Ctrl-S ctrl-Q in terminals (interactive only):
[[ $- == *i* ]] && stty -ixon

# Append to history, don't rewrite it
shopt -s histappend

# History env
export HISTFILESIZE=20000
export HISTSIZE=5000
export HISTTIMEFORMAT='%F %T '

# == Env ==
# GPG
export GPG_TTY=$(tty)

# Set default less options
export LESS=-Rq

# Make vim the default editor
export EDITOR=/usr/bin/vim

# Local binaries
export PATH=$PATH:$HOME/.local/bin:$HOME/.dotfiles/bin:$HOME/bin

# X11 DISPLAY variable
if [[ -z "$DISPLAY" ]]; then
	export DISPLAY=localhost:0
fi

