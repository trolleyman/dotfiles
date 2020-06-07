
<#
.Synopsis
	goto [<option>] <alias> [<directory>]
.Description
	Quickly navigate around the file system
.Parameter Name

.Example
	goto <alias> - Changes to the directory registered for the given alias
	goto -r|-register <alias> <directory> - Registers an alias
	goto -u|-unregister <alias> - Unregisters an alias
	goto -pu|-push <alias> - Pushes the current directory onto the stack, then performs goto TODO
	goto -po|-pop - Pops the top directory from the stack, then changes to that directory TODO
	goto -l|-list - Lists aliases
	goto -e|-expand <alias> - Expands an alias
	goto -c|-cleanup - Cleans up non existent directory aliases
.Notes
	Author: Callum Tolley
	Date:   7th June 2020
#>
function goto() {
	param (
		[switch]
		$Register,
		[switch]
		$Unregister,
		[switch]
		$Push,
		[switch]
		$Pop,
		[switch]
		$List,
		[switch]
		$Expand,
		[switch]
		$Cleanup,
		[string]
		$Alias,
		[string]
		$Directory
	)

	$DatabasePath = "$HOME\.goto"

	function LoadDatabase() {
		if (Test-Path $DatabasePath) {
			$Content = Get-Content $DatabasePath
		} else {
			$Content = ""
		}

		# Parse $Content
		$Database = @{}
		foreach ($Line in $Content) {
			if (-Not $Line) {
				continue
			}

			$i = $Line.IndexOf(' ')
			if ($i -eq -1) {
				throw "Invalid .goto file at $DatabasePath"
			}
			$alias = $Line.Substring(0, $i)
			$path = $Line.Substring($i + 1)
			$Database[$alias] = $path
		}
		return $Database
	}

	function SaveDatabase($Database) {
		$DatabaseString = ""
		$Database.Keys | ForEach-Object { $DatabaseString += "$_ " + $Database[$_] + "`n" }

		Set-Content -Path $DatabasePath -Value $DatabaseString -Force
	}

	$count = ($Register,$Unregister,$Push,$Pop,$List,$Expand,$Cleanup | Where-Object { $_ -eq $true } | Measure-Object).Count
	if ($count -gt 1) {
		throw "Multiple options specified (only one allowed)"
	}

	# Check alias is valid
	if ($Alias) {
		foreach ($c in [char[]]$Alias) {
			if ([char]::IsWhiteSpace($c)) {
				throw "Alias contains whitespace: '$Alias'"
			}
		}
	}

	# Transform directory to absolue path
	if ($Directory) {
		Push-Location $Directory
		$Directory = Get-Location
		Pop-Location
	}

	Write-Host "Register=$Register"
	Write-Host "Unregister=$Unregister"
	Write-Host "Push=$Push"
	Write-Host "Pop=$Pop"
	Write-Host "List=$List"
	Write-Host "Expand=$Expand"
	Write-Host "Cleanup=$Cleanup"
	Write-Host "Alias=$Alias"
	Write-Host "Directory=$Directory"

	function CheckAlias($exists) {
		if ($exists) {
			if (-Not $Alias) {
				throw "Alias not specified"
			}
		} else {
			if ($Alias) {
				throw "Unexpected Alias specified"
			}
		}
	}

	function CheckDirectory($exists) {
		if ($exists) {
			if (-Not $Directory) {
				throw "Directory not specified"
			}
		} else {
			if ($Directory) {
				throw "Unexpected Directory specified"
			}
		}
	}

	# Process
	if ($Register) {
		CheckAlias $true
		CheckDirectory $true

		$Database = LoadDatabase
		$Database[$Alias] = $Directory
		SaveDatabase $Database
		Write-Host "Alias '$Alias' registered for path $Directory"
	} elseif ($Unregister) {
		CheckAlias $true
		CheckDirectory $false

		$Database = LoadDatabase
		$Database.Remove($Alias)
		SaveDatabase $Database
		Write-Host "Alias '$Alias' unregistered successfully"
	} elseif ($Push) {
		throw "Not yet implemented"
	} elseif ($Pop) {
		throw "Not yet implemented"
	} elseif ($List) {
		CheckAlias $false
		CheckDirectory $false
		return LoadDatabase
	} elseif ($Expand) {
		CheckAlias $true
		CheckDirectory $false

		$Database = LoadDatabase
		if (-not ($Database[$Alias])) {
			throw "Alias '$Alias' does not exist"
		} else {
			return $Database[$Alias]
		}
	} elseif ($Cleanup) {
		CheckAlias $false
		CheckDirectory $false
		$Database = LoadDatabase
		$RemoveKeys = @()
		foreach ($Alias in $Database.Keys) {
			$Directory = $Database[$Alias]
			if (-Not (Test-Path $Directory -PathType "Container")) {
				Write-Host "Removing alias '$Alias' as path does not exist: $Directory"
				$RemoveKeys += $Alias
			}
		}
		foreach ($Alias in $RemoveKeys) {
			$Database.Remove($Alias)
		}
		SaveDatabase $Database
		Write-Host "Cleaned up database (removed $($RemoveKeys.Length) entries)"
	} else {
		throw "Not yet implemented"
	}
}

function aaa() {
	param (
		[ValidateSet("Low", "Average", "High")]
		[string]
		$Level
	)
}
