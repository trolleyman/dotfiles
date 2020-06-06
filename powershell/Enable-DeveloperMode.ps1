
$RegistryKeyPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock"
$RegistryKeyName = "AllowDevelopmentWithoutDevLicense"
$Value = 1

if ((Test-Path -Path $RegistryKeyPath) `
		-And (Get-ItemProperty -Path $RegistryKeyPath -Name $RegistryKeyName -ErrorAction SilentlyContinue) `
		-And ((Get-ItemProperty -Path $RegistryKeyPath -Name $RegistryKeyName).$RegistryKeyName -Eq $Value)) {
	# Already set, no need for admin
	Write-Host "Windows Developer Mode already activated"
	exit
}

if (-Not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
	# If not admin, rerun script as admin
	$arguments = "& '" + $MyInvocation.mycommand.definition + "'"
	Start-Process powershell -Verb runAs -ArgumentList $arguments
	Write-Host "Windows Developer Mode activated"
} else {
	if (! (Test-Path -Path $RegistryKeyPath)) {
		# Create container
		New-Item -Path $RegistryKeyPath -ItemType Directory -Force
	}

	if (! (Get-ItemProperty -Path $RegistryKeyPath -Name $RegistryKeyName -ErrorAction SilentlyContinue)) {
		# Add registry value to enable Developer Mode
		New-ItemProperty -Path $RegistryKeyPath -Name $RegistryKeyName -PropertyType DWORD -Value $Value
	} else {
		# Set registry value to $Value
		Set-ItemProperty -Path $RegistryKeyPath -Name $RegistryKeyName -Value $Value
	}
}
