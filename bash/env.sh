
# == Dir colors ==
if [ -r ~/.dir_colors ]; then
	$_INTERACTIVE_SHELL && eval `dircolors ~/.dir_colors`
fi

# == Shell options ==
# prevent other users from writing to my files by default
umask go-w

if $_INTERACTIVE_SHELL; then
	# For rm **/*.pyc, etc.
	shopt -s globstar
	# If a directory is executed, then cd to that directory
	shopt -s autocd
	# Correct minor spelling mistakes as arguments to cd
	shopt -s cdspell
	# Check for running jobs before exiting shell. To force exit, run exit again.
	shopt -s checkjobs
	
	# Make Ctrl-D not end shell
	set -o ignoreeof
	
	# So as not to be disturbed by Ctrl-S ctrl-Q in terminals
	stty -ixon
	
	# Append to history, don't rewrite it
	shopt -s histappend
	
	# History env
	export HISTFILESIZE=20000
	export HISTSIZE=5000
	export HISTTIMEFORMAT='%F %T '
	export HISTCONTROL=ignorespace
fi

# == Environment variables ==
# GPG
$_INTERACTIVE_SHELL && export GPG_TTY=$(tty)

# Prevent other users from controlling the terminal
if [[ $(tty -s ) ]]; then
	mesg n
fi

# Set default less options
export LESS=-Rq

# Make vim the default editor
export EDITOR=/usr/bin/vim

# Anaconda env
if [[ -r "$HOME/anaconda3/etc/profile.d/conda.sh" ]]; then
	. "$HOME/anaconda3/etc/profile.d/conda.sh"
fi

# X11 DISPLAY variable
if [[ -z "$DISPLAY" ]]; then
	export DISPLAY=localhost:0
fi

# === PATH ===
# snap binaries
export PATH=/snap/bin:$PATH

# CUDA
if [[ -d /usr/local/cuda ]]; then
	export PATH=/usr/local/cuda/bin:$PATH
	export LD_LIBRARY_PATH=/usr/local/cuda/lib64:/usr/local/cuda/extras/CUPTI/lib64:$LD_LIBRARY_PATH
fi

# Cargo binaries
export PATH=$HOME/.cargo/bin:$PATH

# .dotfiles binaries
export PATH=$HOME/.dotfiles/bin:$PATH

# Other local binaries
export PATH=$HOME/bin:$HOME/.local/bin:$PATH

