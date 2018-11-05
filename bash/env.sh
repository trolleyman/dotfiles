
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

# Local binaries
export PATH=$HOME/.dotfiles/bin:$HOME/.local/bin:$HOME/bin:$HOME/.cargo/bin:$PATH

# X11 DISPLAY variable
if [[ -z "$DISPLAY" ]]; then
	export DISPLAY=localhost:0
fi

