
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

__set_bash_prompt()
{
	local exit="$?" # Save the exit status of the last command

	if [[ $__colourise_prompt ]]; then
		export GIT_PS1_SHOWCOLORHINTS=1

		# Wrap the colour codes between \[ and \], so that
		# bash counts the correct number of characters for line wrapping:
		# regular colors
		local K="\[\033[0;30m\]"    # black
		local R="\[\033[0;31m\]"    # red
		local G="\[\033[0;32m\]"    # green
		local Y="\[\033[0;33m\]"    # yellow
		local B="\[\033[0;34m\]"    # blue
		local M="\[\033[0;35m\]"    # magenta
		local C="\[\033[0;36m\]"    # cyan
		local W="\[\033[0;37m\]"    # white

		# emphasized (bolded) colors
		local BK="\[\033[1;30m\]"
		local BR="\[\033[1;31m\]"
		local BG="\[\033[1;32m\]"
		local BY="\[\033[1;33m\]"
		local BB="\[\033[1;34m\]"
		local BM="\[\033[1;35m\]"
		local BC="\[\033[1;36m\]"
		local BW="\[\033[1;37m\]"

		# reset
		local RESET="\[\033[0m\]"
		
		local CX=$(context-color -p)
	else # No color
		unset GIT_PS1_SHOWCOLORHINTS
		
		local K=''
		local R=''
		local G=''
		local Y=''
		local B=''
		local M=''
		local C=''
		local W=''

		# emphasized (bolded) colors
		local BK=''
		local BR=''
		local BG=''
		local BY=''
		local BB=''
		local BM=''
		local BC=''
		local BW=''

		# reset
		local RESET=''
		
		local CX=''
	fi

	if [[ $exit != 0 ]]; then
		local exitString='$BR$exit'
	else
		local exitString='$G$exit'
	fi

	# PS1 is made from $preGitPS1 + <git-status> + $postGitPS1
	local preGitPS1="$CX\t $W\u$CX@$W\h $exitString $Y\w"
	local postGitPS1="\n$G\\$ $BW$RESET"

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
