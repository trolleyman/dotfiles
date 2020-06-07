
<#
.Synopsis
	goto [<option>] <alias> [<directory>]
.Description
	Quickly navigate around the file system
.Parameter Name

.Example
	goto <alias> - Changes to the directory registered for the given alias TODO
	goto -r|--register <alias> <directory> - Registers an alias TODO
	goto -u|--unregister <alias> - Unregisters an alias TODO
	goto -p|--push <alias> - Pushes the current directory onto the stack, then performs goto TODO
	goto -o|--pop - Pops the top directory from the stack, then changes to that directory TODO
	goto -l|--list - Lists aliases TODO
	goto -x|--expand <alias> - Expands an alias TODO
	goto -c|--cleanup - Cleans up non existent directory aliases TODO
.Notes
	Author: Callum Tolley
	Date:   7th June 2020
#>
function goto() {
	param (
		[Parameter()]
		[string]
		$Alias,
		[Parameter()]
		[string]
		$Directory
	)

	Write-Host "Alias=$Alias"
	Write-Host "Directory=$Directory"
}
