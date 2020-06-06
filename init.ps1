
# Enable echoing of commands
Set-PSDebug -trace 2;

# Set the execution policy so that anything can be executed for the current user
Set-ExecutionPolicy Unrestricted -scope CurrentUser

# TODO: Handle installing Git (probably through winget)

# Clone dotfiles repo to home directory
git clone --recursive https://github.com/trolleyman/dotfiles ~/.dotfiles

# Set as hidden
$f=Get-Item -Force ~/.dotfiles
$f.Attributes = $f.Attributes -bor "Hidden"

# Run setup script
powershell -file ~/.dotfiles/powershell/Setup.ps1
