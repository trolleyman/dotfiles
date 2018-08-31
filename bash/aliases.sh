
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

Screenshot of Terminal showing the zsh manpage with the above customizations.

# Helpers
alias reload='exec bash'

alias cls=clear

alias ll='ls -lXhF --color --group-directories-first'

# Mistyping helpers
alias ..='cd ..'
alias cd..='cd ..'

alias gti=git

# Git alias
alias g=git

# Pretty print the path
alias path='echo $PATH | tr -s ":" "\n"'

# Slurm
alias swatch="watch -n 1.0 \"showq -o '%17i %20P %10T %.3C %.3D %.11b %9u %10q %30j %7M %9l %19S %R'\""

