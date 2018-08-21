
# Don't source completions if non-interactive
[[ $- == *i* ]] || return

# Source global bash completions
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
	. /etc/bash_completion
fi

# Git bash completion
source ~/.dotfiles/bash/lib/git-completion.bash

