
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
	git commit @args
}
function gst() {
	git status @args
}
function gap() {
	git add -p @args
}
function gpa() {
	git add -p @args
}
function ga() {
	git add @args
}
function gaa() {
	git add --all @args
}
function gss() {
	git stash save @args
}
function gsd() {
	git stash drop @args
}
function gsp() {
	git stash pop @args
}
function gsa() {
	git stash apply @args
}
function gsl() {
	git stash list @args
}
function gco() {
	git checkout @args
}
function gpl() {
	git pull @args
}
# Clashes with Get-ItemProperty
#function gp() {
#	git push @args
#}
function gpf() {
	git push -f @args
}
function gps() {
	git push @args
}
function gph() {
	git push @args
}
function gpsh() {
	git push @args
}
function gpp() {
	git pull @args
	git push @args
}
function gtree() {
	git tree @args
}
function gbase() {
	git rebase @args
}
function gd() {
	git diff @args
}
function gdiff() {
	git diff @args
}
function gm() {
	git merge @args
}
function gr() {
	git rebase @args
}
function gri() {
	git rebase -i @args
}
function grt() {
	git reset @args
}
function gf() {
	git fetch @args
}
function gfp() {
	git fetch -p @args
}
function gbr() {
	git branch @args
}
function grm() {
	git rm @args
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
