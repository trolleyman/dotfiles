
Set-ExecutionPolicy Unrestricted -scope CurrentUser

function Set-GitConfig() {
	# Git aliases
	git config --global alias.aa 'add -A'
	git config --global alias.a 'add'

	git config --global alias.co checkout
	git config --global alias.st 'status --column'
	git config --global alias.br branch
	git config --global alias.ct commit

	git config --global alias.pp '!f(){ git pull && git push; }; f'

	git config --global alias.unstage 'reset HEAD --'

	git config --global alias.plog 'log --decorate --oneline'
	git config --global --unset alias.treea
	git config --global alias.tree 'log --oneline --decorate --color --graph --all'
	git config --global alias.treeq 'log --oneline --decorate --color --graph'
	git config --global --unset alias.grapha
	git config --global alias.graph 'log --oneline --decorate --color --graph --all'
	git config --global alias.graphq 'log --oneline --decorate --color --graph'

	git config --global alias.sm submodule

	git config --global alias.pullall '!f(){ git pull "$@" && git submodule update --init --recursive; }; f'
	#git config --global alias.prune "!bash -c `"f(){ git fetch -p && (git branch -r | awk '{print \\\`$1}' | egrep -v -f /dev/fd/0 <(git branch -vv | grep origin) | awk '{print \\\`$1}' | xargs -r git branch -d); }; f`""

	# Git config
	$NumCpus = (Get-CimInstance Win32_ComputerSystem).NumberOfLogicalProcessors
	git config --global color.ui auto                               # Enable colors
	git config --global submodule.recurse true                      # Recurse through submodules when pulling by default
	git config --global submodule.fetchJobs $NumCpus                # Parallelize submodule fetching
	git config --global fetch.parallel $NumCpus                     # Parallelize regular fetching
	git config --global core.preloadIndex true                      # Preload index -- helps on NFS
	git config --global push.default simple                         # Adopt new pushing format
	git config --global core.safecrlf false                         # Silence CRLF warnings

	git config --global core.excludesFile "$HOME\.dotfiles\git\global_gitignore"
	git config --global core.hooksPath "$HOME\.dotfiles\git\hooks"
}

Start-Job -ScriptBlock { Set-GitConfig } | Out-Null

# Helpers
#alias pd='pushd'
#alias pp='popd'
#alias ppd='popd'

#alias ll='ls -lXhF --color --group-directories-first'

# Mistyping helpers
#alias ..='cd ..'
#alias cd..='cd ..'

#alias gti=git
#alias itg=git
#alias igt=git

# Git aliases
#alias g=git
#alias gct='git commit'
#alias gst='git status'
#alias gap='git add -p'
#alias gpa='git add -p'
#alias ga='git add'
#alias gaa='git add --all'
#alias gss='git stash save'
#alias gsd='git stash drop'
#alias gsp='git stash pop'
#alias gsa='git stash apply'
#alias gsl='git stash list'
#alias gco='git checkout'
#alias gpl='git pull'
#alias gp='git push'
#alias gpf='git push -f'
#alias gps='git push'
#alias gph='git push'
#alias gpsh='git push'
#alias gpp='git pull && git push'
#alias gtree='git tree'
#alias gbase='git rebase'
#alias gd='git diff'
#alias gdiff='git diff'
#alias gm='git merge'
#alias gr='git rebase'
#alias gri='git rebase -i'
#alias grt='git reset'
#alias gf='git fetch'
#alias gfp='git fetch -p'
#alias gbr='git branch'
#alias grm='git rm'

# function gcm() (
# 	git commit -m "$(echo "$@")"
# )

# function gcma() (
# 	git commit --amend -m "$(echo "$@")"
# )

# function gcam() (
# 	git commit --amend -m "$(echo "$@")"
# )

# function gcmnv() (
# 	git commit --no-verify -m "$(echo "$@")"
# )

# function gcos() (
# 	set -x
# 	git stash save
# 	git checkout $@
# 	git stash pop
# )

# function gpls() (
# 	set -x
# 	git stash save
# 	git pull $@
# 	git stash pop
# )

# function gpu() (
# 	name=$(git rev-parse --abbrev-ref HEAD)
# 	if [[ "$name" == HEAD ]]; then
# 		echo "error: not on a branch"
# 		return 1
# 	else
# 		echo git push --set-upstream origin "$name"
# 		git push --set-upstream origin "$name"
# 	fi
# )

# Pretty print the path
#alias path='echo $PATH | tr -s ":" "\n"'
