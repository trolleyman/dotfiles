
function prompt() {
	$StoredSuccess = $?
	$StoredExitCode = $LastExitCode

	$ResetColor = [char]27 + '[0m'
	Write-Host -NoNewline "$ResetColor"
	Write-Host -NoNewline -ForegroundColor Gray '['
	Write-Host -NoNewline -ForegroundColor DarkGray 'PS'
	Write-Host -NoNewline -ForegroundColor Gray '] '

	# TODO: Get context color
	$ContextColor = [char]27 + '[1;31m'

	# TODO: Check conda/venv
	Write-Host -NoNewline "$ContextColor$(Get-Date -Format "HH:mm:ss")"
	Write-Host -NoNewline -ForegroundColor Gray " $([Environment]::UserName)"
	Write-Host -NoNewline "$ContextColor@"
	Write-Host -NoNewline -ForegroundColor Gray "$([Environment]::MachineName) "

	if ($StoredExitCode) {
		# For internal/external commands
		if ($StoredExitCode -eq 0) {
			if (-Not $StoredSuccess) {
				Write-Host -NoNewline -ForegroundColor Red "1 "
			} else {
				Write-Host -NoNewline -ForegroundColor Green "$StoredExitCode "
			}
		} else {
			if ($StoredSuccess) {
				Write-Host -NoNewline -ForegroundColor Green "0 "
			} else {
				Write-Host -NoNewline -ForegroundColor Red "$StoredExitCode "
			}
		}
	} else {
		# For internal commands
		if ($StoredSuccess) {
			Write-Host -NoNewline -ForegroundColor Green "0 "
		} else {
			Write-Host -NoNewline -ForegroundColor Red "1 "
		}
	}

	Write-Host -ForegroundColor DarkYellow "$($executionContext.SessionState.Path.CurrentLocation)"

	Write-Host -NoNewline -ForegroundColor DarkYellow "$('+' * (Get-Location -Stack).ToArray().Length)"

	if ((New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
		Write-Host -NoNewline -ForegroundColor Green '#'
	} else {
		Write-Host -NoNewline -ForegroundColor Green '$'
	}
	return ' '
}
