
# == Dir colors ==
if [ -r ~/.dir_colors ]; then
	$_INTERACTIVE_SHELL && eval `dircolors ~/.dir_colors`
fi

# == Shell options ==
# umask
#umask 027

if $_INTERACTIVE_SHELL; then
	# For rm **/*.pyc, etc.
	shopt -s globstar
	
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

# CUDA binaries
export PATH=/usr/local/cuda-9.0/bin${PATH:+:${PATH}}
export LD_LIBRARY_PATH=/usr/local/cuda/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}

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

