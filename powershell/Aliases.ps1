
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
		Write-Error "error: not on a branch"
	} else {
		Write-Host git push --set-upstream origin "$name"
		git push --set-upstream origin "$name"
	}
}

# Pretty print the path
function path() {
	$env:path.Split(';')
}

function reload() {
	. "$Profile"
}
