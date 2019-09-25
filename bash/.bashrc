# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

#echo "Loading .bashrc..."

function ahead_behind {
    curr_branch=$(git rev-parse --abbrev-ref HEAD);
    curr_remote=$(git config branch.$curr_branch.remote);
    curr_merge_branch=$(git config branch.$curr_branch.merge | cut -d / -f 3);
    git rev-list --left-right --count $curr_branch...$curr_remote/$curr_merge_branch | tr -s '\t' '|';
}

function git-list-branches {
    git for-each-ref --format='%(authorname) %09 %(refname)'
}

# pip bash completion start
_pip_completion()
{
    COMPREPLY=( $( COMP_WORDS="${COMP_WORDS[*]}" \
                   COMP_CWORD=$COMP_CWORD \
                   PIP_AUTO_COMPLETE=1 $1 ) )
}
complete -o default -F _pip_completion pip
# pip bash completion end

set -o emacs
shopt -s cdspell
if [[ $BASH_VERSINFO -ge 4 ]]; then
    shopt -s dirspell
fi
# verify commands before running abbrev.
shopt -s histverify
# append to history from multiple sessions
shopt -s histappend
export HISTCONTROL=ignoredups:erasedups
export HISTSIZE=100000
export HISTFILESIZE=100000
# ensure core dump on SEGV
ulimit -c unlimited
source ~/config/git-completion.sh
source ~/config/git-prompt.sh

alias magit='emax -e "(magit-status \"$(pwd)\")" > /dev/null 2>&1'

export PROMPT_COMMAND=__prompt_command
function __prompt_command() {
    local EXIT="$?"             # needs to be first
    PS1=""
    local rst='\[\e[0m\]'
    local red='\[\e[0;31m\]'
    local redb='\[\e[1;31m\]'
    local green='\[\e[0;32m\]'
    local yellow='\[\e[0;33m\]'
    local blue='\[\e[0;34m\]'
    local purple='\[\e[0;35m\]'

    PS1+="${red}\h:${rst}"
    if [ ! -z "$CONDA_DEFAULT_ENV" ] && [ "$CONDA_DEFAULT_ENV" != "base" ]; then
        PS1+=" ${green}($(basename $CONDA_DEFAULT_ENV)) ${rst}"
    fi
    PS1+="${yellow}\w${rst}${purple}\$(__git_ps1 \" (%s)\")${rst}"
    if [ $EXIT != 0 ]; then
        PS1+=" ${redb}[${EXIT}]${rst}${blue}>${rst} "
    else
        PS1+="${blue}>${rst} "
    fi
}

user=$(id -nu)
os=$(uname)
# use $HOSTNAME if available (which works on windows);
# if a FQDN, just take the device.
domain=$(echo $HOSTNAME | sed -e 's/\..*$//')
host=${domain:-$(hostname -s)}

# load any user settings
[ -r ~/."$user".env ] && . ~/."$user".env
[ -r ~/.bash_"$user" ] && . ~/.bash_"$user"

# Load any os settings
[ -r ~/."$os".env ] && . ~/."$os".env
[ -r ~/.bash_"$os" ] && . ~/.bash_"$os"

# Load any local settings
[ -r ~/."$host".env ] && . ~/."$host".env
[ -r ~/.bash_"$host" ] && . ~/.bash_"$host"

# If we are in a container, initialize it
[ -r ~/.singularity_profile ] && test "${SINGULARITY_NAME}" && . ~/.singularity_profile

# Source personal data
[ -r ~/.personal.env ] && . ~/.personal.env

[ -r ~/.emacs_bash ] && . ~/.emacs_bash
