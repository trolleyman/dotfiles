
# Set equivalent of `set -e`, note that this doesn't work for EXEs
$ErrorActionPreference = "Stop"

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

# TODO: Check out of date dotfiles repo

# Helpers
Set-Alias pd pushd
Set-Alias pp popd
Set-Alias ppd popd

Set-Alias ll 'dir'

Set-Alias which get-command

# Git aliases
Set-Alias g git
Set-Alias gti git
Set-Alias itg git
Set-Alias igt git

function gct() {
	git commit
}
function gst() {
	git status
}
function gap() {
	git add -p
}
function gpa() {
	git add -p
}
function ga() {
	git add
}
function gaa() {
	git add --all
}
function gss() {
	git stash save
}
function gsd() {
	git stash drop
}
function gsp() {
	git stash pop
}
function gsa() {
	git stash apply
}
function gsl() {
	git stash list
}
function gco() {
	git checkout
}
function gpl() {
	git pull
}
# Clashes with Get-ItemProperty
#function gp() {
#	git push
#}
function gpf() {
	git push -f
}
function gps() {
	git push
}
function gph() {
	git push
}
function gpsh() {
	git push
}
function gpp() {
	git pull
	git push
}
function gtree() {
	git tree
}
function gbase() {
	git rebase
}
function gd() {
	git diff
}
function gdiff() {
	git diff
}
function gm() {
	git merge
}
function gr() {
	git rebase
}
function gri() {
	git rebase -i
}
function grt() {
	git reset
}
function gf() {
	git fetch
}
function gfp() {
	git fetch -p
}
function gbr() {
	git branch
}
function grm() {
	git rm
}

# Clashes with Get-Command
#function gcm() {
#	git push
#}

function gctm() {
	git commit -m "$args"
}

function gctma() {
	git commit --amend -m "$args"
}

function gctam() {
	git commit --amend -m "$args"
}

function gctmnv() {
	git commit --no-verify -m "$args"
}

function gcos() {
	Write-Host + git stash save
	git stash save

	Write-Host + git checkout @args
	git checkout @args

	Write-Host + git stash pop
	git stash pop
}

function gpls() {
	Write-Host + git stash save
	git stash save

	Write-Host + git pull @args
	git pull @args

	Write-Host + git stash pop
	git stash pop
}

function gpu() {
	$name = git rev-parse --abbrev-ref HEAD
	if ($name -eq "HEAD") {
		Write-Host -ForegroundColor Red "error: not on a branch"
		return 1
	} else {
		Write-Host git push --set-upstream origin "$name"
		git push --set-upstream origin "$name"
	}
}

# Pretty print the path
function path() {
	$env:path.Split(';')
}

. "$HOME\.dotfiles\powershell\Set-Prompt.ps1"

if ($null -eq [Environment]::UserInteractive -or [Environment]::UserInteractive) {
	# Interactive mode
	Clear-Host
	Write-Host "$PSCommandPath run."
}
