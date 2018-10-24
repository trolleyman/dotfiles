
function check_dotfiles() (
	set -e
	pushd ~/.dotfiles 2>&1 1>/dev/null
	
	UPSTREAM=${1:-'@{u}'}
	LOCAL=$(git rev-parse @{0})
	REMOTE=$(git rev-parse "$UPSTREAM")
	BASE=$(git merge-base @{0} "$UPSTREAM")
	
	if [[ "$LOCAL" == "$REMOTE" ]]; then
		: # Up-to-date
	elif [[ "$LOCAL" == "$BASE" ]]; then
		printf "\e[93mWarning: Need to git pull ~/.dotfiles\e[0m\n"
	elif [[ "$REMOTE" == "$BASE" ]]; then
		printf "\e[93mWarning: Need to git push ~/.dotfiles\e[0m\n"
	else
		printf "\e[93mWarning: ~/.dotfiles has diverged from upstream\e[0m\n"
	fi
	
	# Do this in the background so there's no waiting -- we'll
	# get the warning next time we reload
	( git fetch -j 8 --quiet --no-recurse-submodules &>/dev/null </dev/null & ) &>/dev/null </dev/null
	
	popd 2>&1 1>/dev/null
)

if $_INTERACTIVE_SHELL && $_LOGIN_SHELL; then
	# Detect whether or not ~/.dotfiles is out of date
	pushd ~/.dotfiles 2>&1 >/dev/null
	if [[ -z "$( git remote -v | grep fetch | grep https:// )" ]]; then
		check_dotfiles
	fi
	popd 2>&1 >/dev/null
fi

