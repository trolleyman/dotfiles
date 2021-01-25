
Start-Job -ScriptBlock {
	# Git aliases
	git config --global alias.aa 'add -A'
	git config --global alias.a 'add'

	git config --global alias.co checkout
	git config --global alias.st 'status --column'
	git config --global alias.br branch
	git config --global alias.ct commit

	git config --global alias.p push
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
	git config --global push.recurseSubmodules on-demand            # Push submodules that have had their revisions changed
	git config --global submodule.fetchJobs $NumCpus                # Parallelize submodule fetching
	git config --global fetch.parallel $NumCpus                     # Parallelize regular fetching
	git config --global core.preloadIndex true                      # Preload index -- helps on NFS
	git config --global push.default simple                         # Adopt new pushing format
	git config --global core.safecrlf false                         # Silence CRLF warnings
	git config --global fetch.prune true                            # Prune branches that have been deleted on origin

	git config --global core.excludesFile "$HOME\.dotfiles\git\global_gitignore"
	git config --global core.hooksPath "$HOME\.dotfiles\git\hooks"
} | Out-Null

$env:GIT_MERGE_AUTOEDIT="no"
