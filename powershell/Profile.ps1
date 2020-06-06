
Set-ExecutionPolicy Unrestricted -scope CurrentUser

# Git aliases
git config --global alias.aa 'add -A'
git config --global alias.a 'add'

git config --global alias.co checkout
git config --global alias.st 'status --column'
git config --global alias.br branch
git config --global alias.ct commit

git config --global alias.pp '!f(){ git pull && git push; }; f'

git config --global alias.unstage 'reset HEAD --'

git config --global alias.plog 'log --decorate --oneline'
git config --global --unset alias.treea
git config --global alias.tree 'log --oneline --decorate --color --graph --all'
git config --global alias.treeq 'log --oneline --decorate --color --graph'
git config --global --unset alias.grapha
git config --global alias.graph 'log --oneline --decorate --color --graph --all'
git config --global alias.graphq 'log --oneline --decorate --color --graph'

git config --global alias.sm submodule
