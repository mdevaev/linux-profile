export EDITOR=vim
which vimpager >/dev/null 2>&1 && export PAGER=vimpager || export PAGER=less
which chromium >/dev/null 2>&1 && export BROWSER=chromium


export QT_QPA_PLATFORMTHEME=qt5ct


# If not running interactively, don't do anything
[[ $- != *i* ]] && return


eval `dircolors -b`
alias grep='grep --color=auto'
alias ls='ls --group-directories-first --color=auto'
alias la='ls -A'
alias ll='ls -l --group-directories-first'
alias tree='tree --dirsfirst'
alias d='colordiff -u'
alias perm='stat -c "%a %n"'
alias cls='clear; clear'
alias cpr='rsync -ur --progress'
alias mvr='rsync -ur --progress --remove-sent-files'
alias git='LANG=C git'

complete -cf sudo
complete -cd killall


bldred='\[\e[1;31m\]'   # Red
bldgrn='\[\e[1;32m\]'   # Green
bldblue='\[\e[1;34m\]'  # Blue
bldcyn='\[\e[1;36m\]'   # Cyan
bldbrwn='\[\e[1;33m\]'  # Brown
bldmgn='\[\e[1;35m\]'   # Dark Brown
txtrst='\[\e[0m\]'      # Text Reset

prompt_user() {
	[ "$UID" -eq 0 ] && echo "$bldred\u$txtrst" || echo "$bldcyn\u$txtrst"
}

prompt_host() {
	if [ -n "$SSH_CONNECTION" ]; then
		echo "$bldgrn\h$txtrst"
	elif [ -n "$DOCKER" ]; then # Docker crutch
		echo "$bldmgn\h$txtrst"
	else
		echo "\h"
	fi
}

prompt_git() {
	which git >/dev/null 2>&1
	if [ "$?" -eq 0 ]; then
		local git_dir=`git rev-parse --git-dir 2>/dev/null`
		if [ -z "$git_dir" ] || [ "$HOME" == `dirname $(realpath "$git_dir")` ]; then
			echo " $bldblue\W$txtrst"
			return 0
		fi
		local git_branch=`git branch 2>/dev/null | sed -n '/^\*/s/^\* //p'`
		local git_path=g:/`git rev-parse --show-prefix | sed 's/\n//g'`
		[ -n "$git_branch" ] && echo "(g:$bldbrwn$git_branch$txtrst) $bldblue$git_path$txtrst"
	else
		echo " $bldblue\W$txtrst"
		return 0
	fi
}

prompt() {
	[ "$UID" -eq 0 ] && echo "#" || echo "$"
}

export PROMPT_COMMAND='PS1="[$(prompt_user)@$(prompt_host)$(prompt_git)]$(prompt) "'
