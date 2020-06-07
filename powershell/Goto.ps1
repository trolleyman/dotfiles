
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
	goto -p|-push <alias> - Pushes the current directory onto the stack, then performs goto TODO
	goto -o|-pop - Pops the top directory from the stack, then changes to that directory TODO
	goto -l|-list - Lists aliases TODO
	goto -e|-expand <alias> - Expands an alias TODO
	goto -c|-cleanup - Cleans up non existent directory aliases TODO
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
	foreach ($c in [char[]]$Alias) {
		if ([char]::IsWhiteSpace($c)) {
			throw "Alias contains whitespace: '$Alias'"
		}
	}

	# Transform directory to absolue path
	Push-Location $Directory
	$Directory = Get-Location
	Pop-Location

	Write-Host "Register=$Register"
	Write-Host "Unregister=$Unregister"
	Write-Host "Push=$Push"
	Write-Host "Pop=$Pop"
	Write-Host "List=$List"
	Write-Host "Expand=$Expand"
	Write-Host "Cleanup=$Cleanup"
	Write-Host "Alias=$Alias"
	Write-Host "Directory=$Directory"

	# Process
	if ($Register) {
		if (-Not $Alias) {
			throw "Alias not specified"
		}
		if (-Not $Directory) {
			throw "Directory not specified"
		}
		$Database = LoadDatabase
		$Database[$Alias] = $Directory
		SaveDatabase $Database
	} elseif ($Unregister) {
		if (-Not $Alias) {
			throw "Alias not specified"
		}
		if ($Directory) {
			throw "Unexpected Directory specified"
		}
		$Database = LoadDatabase
		$Database.Remove($Alias)
		SaveDatabase $Database
	} elseif ($Push) {
		throw "Not yet implemented"
	} elseif ($Pop) {
		throw "Not yet implemented"
	} elseif ($List) {
		return LoadDatabase
	} elseif ($Expand) {
		throw "Not yet implemented"
	} elseif ($Cleanup) {
		throw "Not yet implemented"
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
