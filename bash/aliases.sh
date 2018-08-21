
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

