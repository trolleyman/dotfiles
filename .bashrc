echo ~/.bashrc run.

source ~/work/lib/git-prompt.sh
export GIT_PS1_SHOWDIRTYSTATE=true
export GIT_PS1_SHOWUNTRACKEDFILES=true

PS1="\[\e[0;36m\]\t \[\e[0;31m\][bash] \[\e[0;33m\]\$(if ! ([ -z \"$SSH_CONNECTION\" ] || [ -z \"$SSH_CLIENT\" ] || [ -z \"$SSH_TTY\" ]); then echo \"[ssh]\"; fi)\[\e[0;32m\]\u@\[\e[0;37m\]\h \$(if [[ \$? == 0 ]]; then echo \"\[\033[0;32m\]\$?\"; else echo \"\[\033[1;31m\]\$?\"; fi) \[\e[0;33m\]\w\$(__git_ps1)\[\e[0;1;32m\] \$ \[\e[39;49m\]"

alias cls=clear
alias note=notepad
alias np=notepad
alias ll="ls -lXkh --color"
alias ssh-cs="ssh cxt510@tw.cs.bham.ac.uk"
alias ssh-csb="ssh -t cxt510@tw.cs.bham.ac.uk 'bash'"
function be {
	bash
	exit
}

yell() { echo "$0: $*" >&2; }
die() { yell "$*"; exit 1; }
try() { "$@" || die "cannot $*"; }

#alias git-graph="git log --graph --oneline --decorate"

git config --global alias.plog "log --decorate --oneline"
git config --global alias.tree "log --decorate --oneline --graph --all --color"

alias subl=sublime_text
alias st=sublime_text

export RUST_BACKTRACE=1
export DEV=~/work/HD/Dev/
export PATH=$PATH:$DEV/bin
export LIBRARY_PATH=$LIBRARY_PATH:$DEV/pkg-config/SDL2/lib/
export C_INCLUDE_PATH=$C_INCLUDE_PATH:$DEV/SDL2/include/
#:$DEV/Rust/rust-std-x86_64-unknown-linux-gnu/lib/rustlib/x86_64-unknown-linux-gnu/lib
export CARGO_HOME=$DEV/Rust/.cargo

export MULTIRUST_HOME=$DEV/.multirust
export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:$DEV/pkg-config/

export equ=$DEV/Rust/Projects/Equator/
export por=$DEV/Rust/Projects/Portal/
export dev=$DEV
export HD=~/work/HD/

