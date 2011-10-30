#
# ~/.bashrc
#

export EDITOR=vim
export PAGER="/bin/sh -c \"unset PAGER; col -b -x | \
	vim -R -c 'set ft=man nomod nolist' -c 'map q :q<CR>' \
	-c 'map <SPACE> <C-D>' -c 'map b <C-U>' \
	-c 'nmap K :Man <C-R>=expand(\\\"<cword>\\\")<CR><CR>' -\""


# If not running interactively, don't do anything
[[ $- != *i* ]] && return


eval `dircolors -b`
alias grep='grep --color=auto'
alias ls='ls --color=auto'
alias la='ls -A'
alias ll='ls -l --group-directories-first'
alias cpr='rsync -ur --progress'
alias mvr='rsync -ur --progress --remove-sent-files'

alias mplayer='mplayer -lavdopts threads=4 -vo gl2:yuv=3 -framedrop -nodr -double -ao alsa'
alias xrandr_dock='xrandr --output VGA1 --preferred -s 1600x1200 && xrandr --output LVDS1 --off'
alias xrandr_free='xrandr --output LVDS1 --preferred -s 1366x768 && xrandr --output VGA1 --off'

complete -cf sudo
complete -cd killall


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

export PS1="[$(color_user)@$(color_host)$(color_schroot) $bldblue\W$txtrst]$(prompt) "

