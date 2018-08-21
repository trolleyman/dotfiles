
# Don't source completions if non-interactive
[[ $- == *i* ]] || return

# Source global bash completions
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
	. /etc/bash_completion
fi

# Git prompt
export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWSTASHSTATE=1
export GIT_PS1_SHOWUPSTREAM="verbose"
export GIT_PS1_SHOWCOLORHINTS=1
export GIT_PS1_SHOWUNTRACKEDFILES=1
source ~/.dotfiles/bash/lib/git-prompt.sh

# Git bash completion
source ~/.dotfiles/bash/lib/git-completion.bash
