(set -o igncr) 2>/dev/null && set -o igncr; # this comment is needed
# ^ For CRLF-unfriendly systems

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Git prompt
export GIT_PS1_SHOWDIRTYSTATE=true
export GIT_PS1_SHOWUNTRACKEDFILES=true
#source ~/git-prompt.sh

# == PS1 ==
_CLR_RED='\e[1;31m'
_CLR_GRAY='\e[0;37m'
_CLR_BLU='\e[0;36m'
_CLR_DGRN='\e[0;32m'
_CLR_GRN='\e[0;1;32m'
_CLR_DYLW='\e[0;33m'
_CLR_RST='\e[0m'

_PS1_SHELL=''
#_PS1_SHELL='\[\e[0;31m\][bash] '

#_PS1_SSH=''
_PS1_SSH="$_CLR_DYLW\$(if ! ([ -z \"$SSH_CONNECTION\" ] || [ -z \"$SSH_CLIENT\" ] || [ -z \"$SSH_TTY\" ]); then echo '[ssh] '; fi)"

#_PS1_RET=''
_PS1_RET="\$( if [[ \$? == 0 ]]; then echo \"$_CLR_DGRN\$?\"; else echo \"$_CLR_RED\$?\"; fi )"

_PS1_GIT=''
#_PS1_GIT="\$(__git_ps1)"

#_PS1_PROMPT=" $_CLR_GRN\\$ $_CLR_RST" # no newline
_PS1_PROMPT="\n$_CLR_GRN\\$ $_CLR_RST" # newline

PS1="$_CLR_BLU\t $_CLR_DGRN\u@$_CLR_GRAY\h $_PS1_RET $_CLR_DYLW\w$_PS1_GIT$_PS1_PROMPT"

# == Helpful Settings ==
# For rm **/*.pyc, etc.
shopt -s globstar

export PATH=$PATH:~/.local/bin

# Make vim the default editor
export EDITOR=/usr/bin/vim

# Make Ctrl-D not end shell
set -o ignoreeof

# == Aliases ==
alias cls=clear

# ll alias
alias ll="ls -lXkh --color"
alias ll='ls -Flh --group-directories-first'

alias ssh-cs='ssh cxt510@tw.cs.bham.ac.uk'
alias ssh-csb='ssh -t cxt510@tw.cs.bham.ac.uk "bash"'

alias ssh-bb='ssh -t tolleyc@bluebear "bash --rcfile ~/.rcforssh"'
alias ssh-bbn='ssh -t tolleyc@bluebear "bash"'
function be {
	bash
	exit
}

# Needs further improvement -- swatch
alias swatch="watch squeue -O jobarrayid:.20,name:30,account:20,state:15,starttime:10,timeleft:10,exit_code:.3,partition:20,priority:4,qos:8,cpuspertask:.3,maxnodes:.2,numcpus:.2,numnodes:.2"

# Helpful Git aliases
git config --global alias.co checkout
git config --global alias.st status
git config --global alias.br branch
git config --global alias.ct commit
git config --global alias.unstage "reset HEAD --"
git config --global alias.plog "log --decorate --oneline"
git config --global alias.tree "log --oneline --decorate --color --graph"
git config --global alias.treea "log --oneline --decorate --color --graph --all"
git config --global alias.graph "log --oneline --decorate --color --graph"
git config --global alias.grapha "log --oneline --decorate --color --graph --all"
git config --global alias.pullall "!f(){ git pull "$@" && git submodule update --init --recursive; }; f"

# Bash script to print out total line count for users, in src/ directory
# git ls-tree -r HEAD --name-only | grep '^src/*' | xargs -I {} git blame --line-porcelain {} | sed -n 's/^author-mail //p' | sort | uniq -c | sort -rn

if [ -t 1 ]; then
	# This is attached to a terminal
	echo ~/.bashrc run.
fi
