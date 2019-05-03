
# Don't source completions if non-interactive
$_INTERACTIVE_SHELL || return 0

# Source global bash completions
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
	. /etc/bash_completion
fi

# Git bash completion
. ~/.dotfiles/bash/lib/git-completion.bash

