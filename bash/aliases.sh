
# _complete_alias function
. ~/.dotfiles/bash/lib/complete-alias/bash_completion.sh

man() {
	env \
		LESS_TERMCAP_mb=$(printf "\e[1;31m") \
		LESS_TERMCAP_md=$(printf "\e[1;31m") \
		LESS_TERMCAP_me=$(printf "\e[0m") \
		LESS_TERMCAP_se=$(printf "\e[0m") \
		LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
		LESS_TERMCAP_ue=$(printf "\e[0m") \
		LESS_TERMCAP_us=$(printf "\e[1;32m") \
			man "$@"
}

# Helpers
alias reload='exec bash -l'

alias cls=clear
complete -F _complete_alias cls

alias pd='pushd'
complete -F _complete_alias pd
alias pp='popd'
complete -F _complete_alias pp
alias ppd='popd'
complete -F _complete_alias ppd

alias ll='ls -lXhF --color --group-directories-first'
complete -F _complete_alias ll

# Mistyping helpers
alias ..='cd ..'
alias cd..='cd ..'

alias gti=git
complete -F _complete_alias gti
alias itg=git
complete -F _complete_alias itg
alias igt=git
complete -F _complete_alias igt

# Git alias
alias g=git
complete -F _complete_alias g
alias gct='git commit'
complete -F _complete_alias gct
alias gst='git status'
complete -F _complete_alias gst
alias gap='git add -p'
complete -F _complete_alias gap
alias gpa='git add -p'
complete -F _complete_alias gpa
alias ga='git add'
complete -F _complete_alias ga
alias gaa='git add --all'
complete -F _complete_alias gaa
alias gss='git stash save'
complete -F _complete_alias gss
alias gsd='git stash drop'
complete -F _complete_alias gsd
alias gsp='git stash pop'
complete -F _complete_alias gsp
alias gsa='git stash apply'
complete -F _complete_alias gsa
alias gsl='git stash list'
complete -F _complete_alias gsl
alias gco='git checkout'
complete -F _complete_alias gco
alias gpl='git pull'
complete -F _complete_alias gpl
alias gp='git push'
complete -F _complete_alias gp
alias gpf='git push -f'
complete -F _complete_alias gpf
alias gps='git push'
complete -F _complete_alias gps
alias gph='git push'
complete -F _complete_alias gph
alias gpsh='git push'
complete -F _complete_alias gpsh
alias gpp='git pull && git push'
alias gtree='git tree'
complete -F _complete_alias gtree
alias gbase='git rebase'
complete -F _complete_alias gbase
alias gd='git diff'
complete -F _complete_alias gd
alias gdiff='git diff'
complete -F _complete_alias gdiff
alias gm='git merge'
complete -F _complete_alias gm
alias gr='git rebase'
complete -F _complete_alias gr
alias gri='git rebase -i'
complete -F _complete_alias gri
alias grt='git reset'
complete -F _complete_alias grt
alias gf='git fetch'
complete -F _complete_alias gf
alias gfp='git fetch -p'
complete -F _complete_alias gfp
alias gbr='git branch'
complete -F _complete_alias gbr
alias grm='git rm'
complete -F _complete_alias grm

function gcm() (
	git commit -m "$(echo "$@")"
)

function gcma() (
	git commit --amend -m "$(echo "$@")"
)
function gcam() (
	git commit --amend -m "$(echo "$@")"
)

function gcmnv() (
	git commit --no-verify -m "$(echo "$@")"
)

function gcos() (
	set -x
	git stash save
	git checkout $@
	git stash pop
)

function gpls() (
	set -x
	git stash save
	git pull $@
	git stash pop
)

function gpu() (
	name=$(git rev-parse --abbrev-ref HEAD)
	if [[ "$name" == HEAD ]]; then
		echo "error: not on a branch"
		return 1
	else
		echo git push --set-upstream origin "$name"
		git push --set-upstream origin "$name"
	fi
)

# Docker
alias d='docker'
complete -F _complete_alias d
alias dc='docker container'
complete -F _complete_alias dc
alias di='docker image'
complete -F _complete_alias di

# Color grep
alias grep='grep --color=auto'
complete -F _complete_alias grep
alias egrep='egrep --color=auto'
complete -F _complete_alias egrep
alias fgrep='fgrep --color=auto'
complete -F _complete_alias fgrep

# Helper to fix fake xauth generation warning
alias fix-xauth='xauth generate $DISPLAY'

# Fix terminal
alias fix='echo -e "\e<"; reset; stty sane; tput rs1; clear; echo -e "\033c"'

# Pretty print the path
alias path='echo $PATH | tr -s ":" "\n"'

