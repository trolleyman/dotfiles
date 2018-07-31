
_CLR_RED='\[\e[1;31m\]'
_CLR_GRAY='\[\e[0;37m\]'
_CLR_BLU='\[\e[0;36m\]'
_CLR_DGRN='\[\e[0;32m\]'
_CLR_GRN='\[\e[0;1;32m\]'
_CLR_DYLW='\[\e[0;33m\]'
_CLR_RST='\[\e[0m\]'

_PS1_SHELL=''
#_PS1_SHELL='\[\e[0;31m\][bash] '

#_PS1_SSH=''
_PS1_SSH="$_CLR_DYLW\$(if ! ([ -z \"$SSH_CONNECTION\" ] || [ -z \"$SSH_CLIENT\" ] || [ -z \"$SSH_TTY\" ]); then echo '[ssh] '; fi)"

#_PS1_RET=''
_PS1_RET="\$( if [[ \$? == 0 ]]; then echo \"$_CLR_DGRN\$?\"; else echo \"$_CLR_RED\$?\"; fi )"

_PS1_GIT=''
if [[ `whoami` -ne 'tolleyc' ]]; then
    _PS1_GIT="\$(__git_ps1)"
fi

#_PS1_PROMPT=" $_CLR_GRN\\$ $_CLR_RST" # no newline
_PS1_PROMPT="\n$_CLR_GRN\\$ $_CLR_RST" # newline

PS1="$_CLR_BLU\t $_CLR_DGRN\u@$_CLR_GRAY\h $_PS1_RET $_CLR_DYLW\w$_PS1_GIT$_PS1_PROMPT"