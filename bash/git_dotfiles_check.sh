
function check_dotfiles() (
	set -e
	pushd ~/.dotfiles 2>&1 1>/dev/null
	
	local UPSTREAM=${1:-'@{u}'}
	local LOCAL=$(git rev-parse @{0})
	local REMOTE=$(git rev-parse "$UPSTREAM")
	local BASE=$(git merge-base @{0} "$UPSTREAM")
	
	if [[ "$LOCAL" == "$REMOTE" ]]; then
		: # Up-to-date
	elif [[ "$LOCAL" == "$BASE" ]]; then
		printf "\e[1m\e[33mWarning:\e[0m Out of date dotfiles: Run dotfiles-update\n"
	elif [[ "$REMOTE" == "$BASE" ]]; then
		printf "\e[1m\e[33mWarning:\e[0m Need to git push ~/.dotfiles\n"
	else
		printf "\e[1m\e[33mWarning:\e[0m ~/.dotfiles has diverged from upstream\n"
	fi
	
	# Do this in the background so there's no waiting -- we'll
	# get the warning next time we reload
	( git fetch -j 8 --quiet --no-recurse-submodules 2>&1 >/dev/null </dev/null & ) 2>&1 >/dev/null </dev/null
	
	popd 2>&1 1>/dev/null
)

if [[ $_INTERACTIVE_SHELL == "true" ]] && [[ $_LOGIN_SHELL == "true" ]]; then
	# Detect whether or not ~/.dotfiles is out of date
	pushd ~/.dotfiles 2>&1 >/dev/null
	if [[ -z "$( git remote -v | grep fetch | grep https:// )" ]]; then
		check_dotfiles
	fi
	popd 2>&1 >/dev/null
fi

