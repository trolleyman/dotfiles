
<#
.Synopsis
	goto - quickly navigate around the file system using custom aliases
.Description
	goto <alias>                          - Changes to the directory registered for the given alias
	goto -r|-register <alias> <directory> - Registers an alias
	goto -u|-unregister <alias>           - Unregisters an alias
	goto -pu|-push <alias>                - Pushes the current directory onto the stack, then performs goto
	goto -po|-pop                         - Pops the top directory from the stack, then changes to that directory
	goto -l|-list                         - Lists aliases
	goto -e|-expand <alias>               - Expands an alias
	goto -c|-cleanup                      - Cleans up non existent directory aliases
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
			if (-not $Line) {
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

	function CheckAlias($exists) {
		if ($exists) {
			if (-not $Alias) {
				throw "Expected dlias, but was not specified"
			} else {
				foreach ($c in [char[]]$Alias) {
					if ([char]::IsWhiteSpace($c)) {
						throw "Alias contains whitespace: '$Alias'"
					}
				}
			}
		} else {
			if ($Alias) {
				throw "Unexpected alias encountered"
			}
		}
	}

	function CheckDirectory($exists) {
		if ($exists) {
			if (-not $Directory) {
				throw "Expected directory, but was not specified"
			} else {
				# Transform directory to absolue path
				try {
					Push-Location $Directory
					$Directory = Get-Location
				} finally {
					Pop-Location
				}
			}
		} else {
			if ($Directory) {
				throw "Unexpected directory encountered"
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
		CheckAlias $true
		CheckDirectory $false

		$Database = LoadDatabase
		if (-not ($Database[$Alias])) {
			throw "Alias '$Alias' does not exist"
		} else {
			Push-Location $Database[$Alias]
		}

	} elseif ($Pop) {
		Pop-Location

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
			if (-not (Test-Path $Directory -PathType "Container")) {
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
		CheckAlias $true
		CheckDirectory $false

		$Database = LoadDatabase
		if (-not ($Database[$Alias])) {
			throw "Alias '$Alias' does not exist"
		} else {
			Set-Location $Database[$Alias]
		}
	}
}

function aaa() {
	param (
		[ValidateSet("Low", "Average", "High")]
		[string]
		$Level
	)
}
