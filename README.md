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

## TODO
- Set `.ssh/` on PowerShell
- Add Git in PowerShell prompt (like posh git)
- Add `Update-Dotfiles.ps1` for Windows
- Add automatic update warning (like with Linux)
- Add a `[y/n]` option when overwriting files using `dotfiles-setup` or `Setup-Dotfiles.ps1`
- Store VS Code `settings.json`
- Store VS Code `keybindings.json`
- Store Windows Terminal `settings.json`
