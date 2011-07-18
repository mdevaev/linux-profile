#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

eval `dircolors -b`

export EDITOR=vim

alias grep='grep --color=auto'
alias ls='ls --color'
alias la='ls -A'
alias ll='ls -l --group-directories-first'

alias mplayer='mplayer -vo gl_nos'

complete -cf sudo

bldred='\[\e[1;31m\]'  # Red
bldblue='\[\e[1;34m\]' # Blue
bldcyn='\[\e[1;36m\]'  # Cyan
txtrst='\[\e[0m\]'     # Text Reset

if [ "$UID" -eq "0" ]; then
    PS1="[$bldred\u$txtrst@\h $bldblue\W$txtrst]\$ "
else
    PS1="[$bldcyn\u$txtrst@\h $bldblue\W$txtrst]\$ "
fi
