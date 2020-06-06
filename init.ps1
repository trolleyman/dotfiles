
# Set the execution policy so that anything can be executed for the current user
Set-ExecutionPolicy Unrestricted -scope CurrentUser

# TODO: Handle installing Git (probably through winget)
# Also, enable symbolic links on Windows

# Clone dotfiles repo to home directory
$dotfilesPath="$HOME\.dotfiles"
if ( -Not (Test-Path $dotfilesPath -PathType Container) ) {
    git clone --recursive https://github.com/trolleyman/dotfiles $dotfilesPath
}

# Run setup script
powershell -file $dotfilesPath/powershell/Dotfiles-Setup.ps1
