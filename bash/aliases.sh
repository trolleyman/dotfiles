
function treedu() {
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
alias reload='exec bash'

alias cls=clear

alias ll='ls -lXhF --color --group-directories-first'

# Mistyping helpers
alias ..='cd ..'
alias cd..='cd ..'

alias gti=git
alias itg=git
alias igt=git

# Git alias
alias g=git
alias gct='git commit'
alias gst='git status'
alias gap='git add -p'
alias ga='git add'
alias gaa='git add --all'
alias gss='git stash save'
alias gsp='git stash pop'
alias gsa='git stash apply'
alias gco='git checkout'
alias gpl='git pull'
alias gps='git push'
alias gph='git push'
alias gpsh='git push'
alias gpp='git pull && git push'
alias gtree='git tree'
alias gbase='git rebase'

function gcm() (
	git commit -m "$(echo "$@")"
)

function gcma() (
	git commit --amend -m "$(echo "$@")"
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

# Color grep
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

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

