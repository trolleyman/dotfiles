
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
fi

# == Env ==
# GPG
$_INTERACTIVE_SHELL && export GPG_TTY=$(tty)

# Prevent other users from controlling the terminal
mesg n || true

# Set default less options
export LESS=-Rq

# Make vim the default editor
export EDITOR=/usr/bin/vim

# Anaconda env
if [[ -r "$HOME/anaconda3/etc/profile.d/conda.sh" ]]; then
	. "$HOME/anaconda3/etc/profile.d/conda.sh"
fi

# snap binaries
export PATH=/snap/bin${PATH:+:${PATH}}

# CUDA
if [[ -d /usr/local/cuda ]]; then
	export PATH=/usr/local/cuda/bin${PATH:+:${PATH}}
	export LD_LIBRARY_PATH=/usr/local/cuda/lib64:/usr/local/cuda/extras/CUPTI/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}
fi

# Cargo/rust, if they've been installed manually (i.e. on the CS lab computers)
if [[ -d ~/rust ]]; then
	export PATH=~/rust/rustc/bin:~/rust/cargo/bin${PATH:+:${PATH}}
	#export LD_LIBRARY_PATH=~/rust/rustc/lib:~/rust/rustc/lib/rustlib/x86_64-unknown-linux-gnu/lib${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}
	export RUSTFLAGS="-L $HOME/rust/rust-std-x86_64-unknown-linux-gnu/lib/rustlib/x86_64-unknown-linux-gnu/lib"
fi

# Cargo binaries
export PATH=$HOME/.cargo/bin${PATH:+:${PATH}}

# .dotfiles binaries
export PATH=$HOME/.dotfiles/bin${PATH:+:${PATH}}

# Local binaries
export PATH=$HOME/bin:$HOME/.local/bin:$PATH

# X11 DISPLAY variable
if [[ -z "$DISPLAY" ]]; then
	export DISPLAY=localhost:0
fi

# Docker, but only for Desktop PC
if [[ "$(hostname)" == "Callums-PC" ]]; then
	export DOCKER_HOST=localhost:2375
fi

