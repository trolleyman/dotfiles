
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

function truecolortest() {
	awk 'BEGIN{
		s="/\\/\\/\\/\\/\\"; s=s s s s s s s s;
		for (colnum = 0; colnum<77; colnum++) {
			r = 255-(colnum*255/76);
			g = (colnum*510/76);
			b = (colnum*255/76);
			if (g>255) g = 510-g;
			printf "\033[48;2;%d;%d;%dm", r,g,b;
			printf "\033[38;2;%d;%d;%dm", 255-r,255-g,255-b;
			printf "%s\033[0m", substr(s,colnum+1,1);
		}
		printf "\n";
	}'
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
