
# _complete_alias function
. ~/.dotfiles/bash/lib/complete-alias/bash_completion.sh

args() {
	i=1
	while [[ $# -ge 1 ]]; do
		echo "\$$i=$1"
		i=$(( $i + 1 ))
		shift
	done
}

echo_cmd() {
	( set -x; "$@"; )
}

treedu() {
	local depth=''

	while getopts "hL:" opt ; do
		case "$opt" in
			L) depth="$OPTARG" ;;
			h) echo "Usage: $0 [-h] [-L level] <path>" 1>&2; exit 1;;
		esac
	done

	shift "$((OPTIND-1))"

	if [ -z "$depth" ] ; then
		tree --du -d -shaC "$@"
	else
		local PATTERN='(  *[^ ]* ){'"$depth"'}\['
		tree --du -d -shaC "$@" | grep -Ev "$PATTERN"
	fi
}

extract () {
	if [ -f $1 ] ; then
		case $1 in
			*.tar.bz2)   tar xvjf $1    ;;
			*.tar.gz)    tar xvzf $1    ;;
			*.bz2)       bunzip2 $1     ;;
			*.rar)       rar x $1       ;;
			*.gz)        gunzip $1      ;;
			*.tar)       tar xvf $1     ;;
			*.tbz2)      tar xvjf $1    ;;
			*.tgz)       tar xvzf $1    ;;
			*.zip)       unzip $1       ;;
			*.Z)         uncompress $1  ;;
			*.7z)        7z x $1        ;;
			*)           echo "don't know '$1'..." ;;
		esac
	else
		echo "'$1' is not a valid file!"
	fi
}

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

function each() {
	while read line; do
		for f in "$@"; do
			$f $line
		done
	done
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

function mkcd() {
	mkdircd $@
}

function mkdircd() {
	mkdir $@
	echo mkdir $@
	cd $@
	echo cd $@
}

# Open
alias open='~/.dotfiles/bin/open'

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

# Slurm
alias swatch="watch -n 1.0 \"squeue -o '%17i %20P %10T %.3C %.3D %11b %.9u %10q %30j %7M %9l %19S %R'\""

# ssh (if in CS labs)
if [[ "$HOST" == tinky-winky ]] || [[ "$HOST" == *.cs.bham.ac.uk ]]; then
	alias sshp="sshpass -f '$HOME/private/password.txt' ssh"

	readonly MAX_CONCURRENT_USERS=3
	readonly MAX_ATTEMPTS=100
	readonly CONNECT_TIMEOUT=2
	readonly SSH_OPTS="-x \
	                   -o ConnectTimeout=${CONNECT_TIMEOUT}"

	_check_machine_available() {
		local host=$1
		ping -q $host -c 1 -w 3 > /dev/null
		echo $?
	}

	_find_available_machine() {
		local machines=(cca-lg04-0{6{3,4,5,6,9},7{0,1,2,3,4}})
		local count=${#machines[@]}
		local host=
		local attempts=0
		while [[ $attempts -lt $MAX_ATTEMPTS ]]; do
			local index=$((RANDOM % ${count}))
			local candidate=${machines[index]}
			if [[ $(_check_machine_available $candidate) -ne 0 ]]; then
				continue
			fi
			#local load=$(_check_machine_load $candidate)
			local load=0
			if [[ $load -lt $MAX_CONCURRENT_USERS ]]; then
				host=$candidate
				break
			fi
			((attempts++))
		done
		echo $host
	}

	_ssh_to_machine() {
		local host=$1
		local args="${@:2}"
		sshpass -f "$HOME/private/password.txt" ssh ${SSH_OPTS} ${host} ${args}
	}

	ssh-gpu() {
		echo "Finding available lab machine..."
		local host=$(_find_available_machine)
		if [[ -z $host ]]; then
			echo "No suitable host could be found! Try again later."
			return
		fi
		echo "Using lab machine '${host}'..."
		_ssh_to_machine $host "$@"
	}
fi

