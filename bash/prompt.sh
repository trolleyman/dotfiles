
bash_prompt() {
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

    #_PS1_RET=''
    local _PS1_RET="\$( if [[ \$? == 0 ]]; then echo \"$G\$?\"; else echo \"$BR\$?\"; fi )"

    local _PS1_GIT=''
    if [[ "`whoami`" != "tolleyc" ]]; then
        _PS1_GIT="\$(__git_ps1)"
    fi

    local CX=$(context-color -p)
    PS1="$CX\t $W\u$CX@$W\h $_PS1_RET $Y\w$_PS1_GIT\n$G\\$ $BW$RESET"
}

# Only set prompt if interactive
[[ $- == *i* ]] && bash_prompt
unset bash_prompt
