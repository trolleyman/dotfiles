
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

function reload {
	bash
	exit
}

alias cls=clear

alias ll="ls -lXkh --color"
alias ll='ls -Flh --group-directories-first'

# SSH
alias ssh-cs='ssh cxt510@tw.cs.bham.ac.uk'
alias ssh-csb='ssh -t cxt510@tw.cs.bham.ac.uk "bash"'

alias ssh-bb='ssh -t tolleyc@bluebear.bham.ac.uk "bash --rcfile ~/.rcforssh"'
alias ssh-bbn='ssh -t tolleyc@bluebear.bham.ac.uk "bash"'

# Pretty print the path
alias path='echo $PATH | tr -s ":" "\n"'

# Slurm
alias swatch="watch -n 1.0 \"showq -o '%17i %20P %10T %.3C %.3D %.11b %9u %10q %30j %7M %9l %19S %R'\""

# Helpful Git config aliases
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

# TODO: Bash script to print out total line count for users, in src/ directory
# git ls-tree -r HEAD --name-only | grep '^src/*' | xargs -I {} git blame --line-porcelain {} | sed -n 's/^author-mail //p' | sort | uniq -c | sort -rn
