
# Don't source completions if non-interactive
[[ $_INTERACTIVE_SHELL == "true" ]] || return 0

# Source global bash completions
if [ -r /etc/bash_completion ] && ! shopt -oq posix; then
	. /etc/bash_completion
fi

# Git bash completion
. ~/.dotfiles/bash/lib/git-completion.bash

for f in ~/.dotfiles/bash/completion/*; do
	name="$(basename "$f" | sed 's/.bash-completion$//g')"
	if  [[ "$(alias | grep "$name" | wc -l)" != 0 ]] || command -v "$name" 2>&1 >/dev/null; then
		. $f
	else
		: #printf "\e[1m\e[33mWarning:\e[0m Skipped bash completion for $name\n"
	fi
done

