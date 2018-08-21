
# Select git info displayed, see ~/.dotfiles/bash/lib/git-prompt.sh for more
export GIT_PS1_SHOWDIRTYSTATE=1           # '*' = unstaged, '+' = staged
export GIT_PS1_SHOWSTASHSTATE=1           # '$' = stashed
export GIT_PS1_SHOWUNTRACKEDFILES=1       # '%' = untracked
export GIT_PS1_SHOWUPSTREAM="verbose"     # 'u=' = no difference, 'u+1' = ahead by 1 commit
export GIT_PS1_STATESEPARATOR=''          # No space between branch and index status
export GIT_PS1_DESCRIBE_STYLE="describe"  # detached HEAD style:
#  contains      relative to newer annotated tag (v1.6.3.2~35)
#  branch        relative to newer tag or branch (master~4)
#  describe      relative to older annotated tag (v1.6.3.1-13-gdd42c2f)
#  default       exactly eatching tag

# Source __git_ps1
source ~/.dotfiles/bash/lib/git-prompt.sh

# Check if we support colours
__colour_enabled() {
	local -i colors=$(tput colors 2>/dev/null)
	[[ $? -eq 0 ]] && [[ $colors -gt 2 ]]
}
unset __colourise_prompt && __colour_enabled && __colourise_prompt=1

if [[ $__colourise_prompt ]]; then
	export GIT_PS1_SHOWCOLORHINTS=1

	# Wrap the colour codes between \[ and \], so that
	# bash counts the correct number of characters for line wrapping:
	# regular colors
	__COL_K="\[\033[0;30m\]"    # black
	__COL_R="\[\033[0;31m\]"    # red
	__COL_G="\[\033[0;32m\]"    # green
	__COL_Y="\[\033[0;33m\]"    # yellow
	__COL_B="\[\033[0;34m\]"    # blue
	__COL_M="\[\033[0;35m\]"    # magenta
	__COL_C="\[\033[0;36m\]"    # cyan
	__COL_W="\[\033[0;37m\]"    # white

	# emphasized (bolded) colors
	__COL_BK="\[\033[1;30m\]"
	__COL_BR="\[\033[1;31m\]"
	__COL_BG="\[\033[1;32m\]"
	__COL_BY="\[\033[1;33m\]"
	__COL_BB="\[\033[1;34m\]"
	__COL_BM="\[\033[1;35m\]"
	__COL_BC="\[\033[1;36m\]"
	__COL_BW="\[\033[1;37m\]"

	# reset
	__COL_RESET="\[\033[0m\]"
	
	__COL_CX=$(context-color -p)
else # No color
	unset GIT_PS1_SHOWCOLORHINTS
	
	__COL_K=''
	__COL_R=''
	__COL_G=''
	__COL_Y=''
	__COL_B=''
	__COL_M=''
	__COL_C=''
	__COL_W=''

	# emphasized (bolded) colors
	__COL_BK=''
	__COL_BR=''
	__COL_BG=''
	__COL_BY=''
	__COL_BB=''
	__COL_BM=''
	__COL_BC=''
	__COL_BW=''

	# reset
	__COL_RESET=''
	
	__COL_CX=''
fi

__set_bash_prompt()
{
	local exit="$?" # Save the exit status of the last command

	if [[ $__colourise_prompt ]]; then
		export GIT_PS1_SHOWCOLORHINTS=1
	else
		unset GIT_PS1_SHOWCOLORHINTS
	fi

	if [[ $exit != 0 ]]; then
		local exitString="$__COL_BR$exit"
	else
		local exitString="$__COL_G$exit"
	fi

	# PS1 is made from $preGitPS1 + <git-status> + $postGitPS1
	local preGitPS1="$__COL_CX\t $__COL_W\u$__COL_CX@$__COL_W\h $exitString$__COL_Y\w $__COL_BW"
	local postGitPS1="\n$__COL_G\\$ $__COL_BW$__COL_RESET"

	# Set PS1 from $preGitPS1 + <git-status> + $postGitPS1
	__git_ps1 "$preGitPS1" "$postGitPS1" '(%s)'
}

if [[ $- == *i* ]]; then
	# Only set prompt if interactive
	
	PS1=''
	# This tells bash to reinterpret PS1 after every command, which we
	# need because __git_ps1 will return different text and colors
	PROMPT_COMMAND=__set_bash_prompt
fi
