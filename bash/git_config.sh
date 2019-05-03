#!/bin/bash

function config_git {
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
	git config --global alias.prune "!bash -c \"f(){ git fetch -p && (git branch -r | awk '{print \\\$1}' | egrep -v -f /dev/fd/0 <(git branch -vv | grep origin) | awk '{print \\\$1}' | xargs -r git branch -d); }; f\""

	# TODO: Bash script to print out total line count for users, in src/ directory
	# git ls-tree -r HEAD --name-only | grep '^src/*' | xargs -I {} git blame --line-porcelain {} | sed -n 's/^author-mail //p' | sort | uniq -c | sort -rn

	# Git config
	git config --global color.ui auto                               # Enable colors
	git config --global submodule.recurse false                     # Don't recurse through submodules when pulling by default
	git config --global credential.helper 'cache --timeout=7200'    # Cache passwords for 2 hours
	git config --global core.preloadIndex true                      # Preload index -- helps on NFS
	git config --global push.default simple                         # Adopt new pushing format

	git config --global core.excludesFile '~/.dotfiles/git/global_gitignore'
}
$_INTERACTIVE_SHELL && $_LOGIN_SHELL && config_git 2>&1 >/dev/null

