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

colors='\033[0;30m 30\033[1;30m 30\n\033[0;31m 31\033[1;31m 31\n\033[0;32m 32\033[1;32m 32\n\033[0;33m 33\033[1;33m 33\n\033[0;34m 34\033[1;34m 34\n\033[0;35m 35\033[1;35m 35\n\033[0;36m 36\033[1;36m 36\n\033[0;37m 37\033[1;37m 37\n'

txtblk='\e[0;30m' # Black - Regular
txtred='\e[0;31m' # Red
txtgrn='\e[0;32m' # Green
txtylw='\e[0;33m' # Yellow
txtblu='\e[0;34m' # Blue
txtpur='\e[0;35m' # Purple
txtcyn='\e[0;36m' # Cyan
txtwht='\e[0;37m' # White
bldblk='\e[1;30m' # Black - Bold
bldred='\e[1;31m' # Red
bldgrn='\e[1;32m' # Green
bldylw='\e[1;33m' # Yellow
bldblu='\e[1;34m' # Blue
bldpur='\e[1;35m' # Purple
bldcyn='\e[1;36m' # Cyan
bldwht='\e[1;37m' # White
unkblk='\e[4;30m' # Black - Underline
undred='\e[4;31m' # Red
undgrn='\e[4;32m' # Green
undylw='\e[4;33m' # Yellow
undblu='\e[4;34m' # Blue
undpur='\e[4;35m' # Purple
undcyn='\e[4;36m' # Cyan
undwht='\e[4;37m' # White
bakblk='\e[40m'   # Black - Background
bakred='\e[41m'   # Red
bakgrn='\e[42m'   # Green
bakylw='\e[43m'   # Yellow
bakblu='\e[44m'   # Blue
bakpur='\e[45m'   # Purple
bakcyn='\e[46m'   # Cyan
bakwht='\e[47m'   # White
txtrst='\e[0m'    # Text Reset

