
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

mkdircd() {
	mkdir $@
	echo mkdir $@
	cd $@
	echo cd $@
}

mkcd() {
	mkdircd $@
}

