
# Set equivalent of `set -e`, note that this doesn't work for EXEs
$ErrorActionPreference = "Stop"

# TODO: Check out of date dotfiles repo

. "$HOME\.dotfiles\powershell\Goto.ps1"

. "$HOME\.dotfiles\powershell\Aliases.ps1"
. "$HOME\.dotfiles\powershell\GitConfig.ps1"

. "$HOME\.dotfiles\powershell\Prompt.ps1"

if ($null -eq [Environment]::UserInteractive -or [Environment]::UserInteractive) {
	# Interactive mode
	Clear-Host
	Write-Host "$PSCommandPath run."
}
