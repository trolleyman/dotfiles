# `.dotfiles`
My collection of scripts, helpers, and misc gunk that's accumulated over the years.

## Linux Setup
**Warning:** This will overwrite your current `.bashrc`, `.ssh/config`, and a few other files. Use with caution.
```sh
curl --proto '=https' --tlsv1.2 -sSf https://raw.githubusercontent.com/trolleyman/dotfiles/master/init.sh | sh
```

## Windows Setup
**Warning:** This will overwrite your current `Profile.ps1`. Use with caution.
```powershell
iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/trolleyman/dotfiles/master/init.ps1'))
```
