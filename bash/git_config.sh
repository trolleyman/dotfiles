#!/bin/bash

# Git aliases
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

# TODO: Bash script to print out total line count for users, in src/ directory
# git ls-tree -r HEAD --name-only | grep '^src/*' | xargs -I {} git blame --line-porcelain {} | sed -n 's/^author-mail //p' | sort | uniq -c | sort -rn

# Git config
git config --global color.ui always                             # Enable colors
git config --global submodule.recurse true                      # Recurse through submodules when pulling
git config --global credential.helper 'cache --timeout=7200'    # Cache passwords for 2 hours
git config --global core.preloadIndex true                      # Preload index -- helps on NFS
git config --global push.default simple                         # Adopt new pushing format
