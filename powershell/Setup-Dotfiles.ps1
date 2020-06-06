
if (([Version](Get-CimInstance Win32_OperatingSystem).version).Major -lt 10) {
	Write-Host -ForegroundColor Red "Error: Only supported on Windows 10"
	exit 1
}

# Set equivalent of `set -e`, note that this doesn't work for EXEs
$ErrorActionPreference = "Stop"

# Ensure that developer mode is activated
& "$PSScriptRoot\Enable-DeveloperMode.ps1"

# Create symbolic link (using mklink.exe as PowerShell 5 & 5.1 (which are installed by default) don't have support for symbolic links (Windows, sort your shit out FFS!))
function Make-Link {
	param(
		[string]$Link,
		[string]$Target,
		[switch]$Force = $false
	)

	$dir = (Split-Path $Link -Parent)
	if (-Not (Test-Path -Path $dir)) {
		New-Item -Path "$dir" -ItemType "Directory" | Out-Null
	}

	if (Test-Path -Path $Link) {
		# Delete current path
		Remove-Item -Path $Link
	}

	cmd /c mklink "$Link" "$Target"
}

Make-Link -Link "$Profile" -Target "$PSScriptRoot\Profile.ps1" -Force

# TODO: Link up SSH config, and other things

Write-Host "`nSetup-Dotfiles complete.`n"
