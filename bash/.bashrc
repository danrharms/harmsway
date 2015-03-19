# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

echo "Loading .bashrc..."

# User specific aliases and functions
export PATH=.:$HOME/bin:/usr/local/gcc-4.5.1/bin:/sbin/:$PATH
export MANPATH=
export DISPLAY=10.10.102.229:0.0

alias snap-setup='export SNAP_ROOT=`pwd` && source ~/src/.snap_env'
source ~/.git-completion.sh
source ~/.git-prompt.sh
export PS1="\[\e[31m\]\h\[\e[m\]\[\e[31m\]:\[\e[m\]\[\e[33m\]\w\[\e[m\]\[\e[31m\]\$(__git_ps1 \" (%s)\")\[\e[m\]> "

# alias git-current-branch='git branch 2>&1 | grep '\''*'\'' | perl -pe '\''s/^\* (.*)/ \(\1\)/'\'''
# export PS1="\[\e[31m\]\h\[\e[m\]\[\e[31m\]:\[\e[m\]\[\e[33m\]\w\[\e[m\]\[\e[31m\]$(git-current-branch)\[\e[m\]> "

export CSTDLIB_ROOT=/usr/local/gcc-4.5.1/include/c++/4.5.1

# SNAP
export ONE_TICK_CONFIG=/opt/1tick/client_data/config/one_tick_config.txt
#export SNAP_STATIC_TRUNK=~/src/curr/snap-static
#export LD_LIBRARY_PATH=/usr/local/snap/lib:$LD_LIBRARY_PATH

# use gcc451
# ensure core dump on SEGV
ulimit -c unlimited
