
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

alias reload='exec bash'

alias cls=clear

alias ll='ls -lXhF --color --group-directories-first'

# SSH
alias ssh-cs='ssh cxt510@tw.cs.bham.ac.uk'
alias ssh-csb='ssh -t cxt510@tw.cs.bham.ac.uk "bash"'

alias ssh-bb='ssh -t tolleyc@bluebear.bham.ac.uk "bash --rcfile ~/.rcforssh"'
alias ssh-bbn='ssh -t tolleyc@bluebear.bham.ac.uk bash'

alias ssh-django='ssh -t centos@172.31.8.69 bash'

# Pretty print the path
alias path='echo $PATH | tr -s ":" "\n"'

# Slurm
alias swatch="watch -n 1.0 \"showq -o '%17i %20P %10T %.3C %.3D %.11b %9u %10q %30j %7M %9l %19S %R'\""

(
	git config --global alias.aa 'add -A'
	git config --global alias.a 'add'

	git config --global alias.co checkout
	git config --global alias.st status
	git config --global alias.br branch
	git config --global alias.ct commit

	git config --global alias.diff 'diff --color'
	git config --global alias.unstage 'reset HEAD --'

	git config --global alias.plog 'log --decorate --oneline'
	git config --global alias.tree 'log --oneline --decorate --color --graph'
	git config --global alias.treea 'log --oneline --decorate --color --graph --all'
	git config --global alias.graph 'log --oneline --decorate --color --graph'
	git config --global alias.grapha 'log --oneline --decorate --color --graph --all'

	git config --global alias.pullall '!f(){ git pull "$@" && git submodule update --init --recursive; }; f'
	git config --global alias.prune-all "!bash -c \"f(){ git fetch -p && (git branch -r | awk '{print \\\$1}' | egrep -v -f /dev/fd/0 <(git branch -vv | grep origin) | awk '{print \\\$1}' | xargs -r git branch -d); }; f\""
) 2>&1 >/dev/null

# TODO: Bash script to print out total line count for users, in src/ directory
# git ls-tree -r HEAD --name-only | grep '^src/*' | xargs -I {} git blame --line-porcelain {} | sed -n 's/^author-mail //p' | sort | uniq -c | sort -rn
