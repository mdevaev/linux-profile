#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export EDITOR=vim

eval `dircolors -b`
alias grep='grep --color=auto'
alias ls='ls --color=auto'
alias la='ls -A'
alias ll='ls -l --group-directories-first'
alias mplayer='mplayer -vo gl_nosw'

complete -cf sudo


bldred='\[\e[1;31m\]'  # Red
bldgrn='\[\e[1;32m\]' # Green
bldblue='\[\e[1;34m\]' # Blue
bldcyn='\[\e[1;36m\]'  # Cyan
txtrst='\[\e[0m\]'     # Text Reset

color_user() {
    [ "$UID" -eq 0 ] && echo "$bldred\u$txtrst" || echo "$bldcyn\u$txtrst"
}
color_host() {
    [ -n "$SSH_CONNECTION" ] && echo "$bldgrn\h$txtrst" || echo "\h"
}
color_schroot() {
    [ -n "$SCHROOT_CHROOT_NAME" ] && echo "($bldred$SCHROOT_CHROOT_NAME$txtrst)"
}
prompt() {
    [ "$UID" -eq 0 ] && echo "#" || echo "$"
}

PS1="[$(color_user)@$(color_host)$(color_schroot) $bldblue\W$txtrst]$(prompt) "


export DEBFULLNAME="Devaev Maxim"
export DEBMAIL="mdevaev@yandex-team.ru"

