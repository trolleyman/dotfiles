
# Set the execution policy so that anything can be executed for the current user
Set-ExecutionPolicy Unrestricted -scope CurrentUser

# TODO: Handle installing Git (probably through winget)
# Also, enable symbolic links on Windows

# Clone dotfiles repo to home directory
$dotfilesPath="$HOME\.dotfiles"
if ( -Not (Test-Path $dotfilesPath -PathType Container) ) {
    git clone --recursive https://github.com/trolleyman/dotfiles $dotfilesPath
} else {
    pushd $dotfilesPath
    git fetch
    git reset --hard
    git checkout master
    git reset --hard origin/master
    git submodule init
    git submodule sync
    git submodule update
    popd
}

# Run setup script
powershell -file $dotfilesPath/powershell/Dotfiles-Setup.ps1

printf "\nTo update the shell, re-run: powershell\n\n"
