export EDITOR=vim
export PAGER=less
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

fv() {
	local search=""
	if [[ $# -gt 0 ]]; then
		search="$1"
		shift
	fi
	command rg --color=always --line-number --no-heading --smart-case "$@" "$search" \
		| command fzf -d':' --ansi \
			--preview "command bat -p --color=always {1} --highlight-line {2}" \
			--preview-window ~8,+{2}-5 \
			--bind 'enter:execute(vim `echo {} | cut -d : -f 1` +`echo {} | cut -d : -f 2`)' \
			--bind 'ctrl-o:become(vim `echo {} | cut -d : -f 1` +`echo {} | cut -d : -f 2`)'
}

complete -cf sudo
complete -cd killall


cred='\[\e[1;31m\]'   # Red
cgrn='\[\e[1;32m\]'   # Green
cblue='\[\e[1;34m\]'  # Blue
ccyn='\[\e[1;36m\]'   # Cyan
cbrwn='\[\e[1;33m\]'  # Brown
cmgn='\[\e[1;35m\]'   # Dark Brown
txtrst='\[\e[0m\]'      # Text Reset

prompt_user() {
	[ "$UID" -eq 0 ] && echo "$cred\u$txtrst" || echo "$ccyn\u$txtrst"
}

prompt_host() {
	if [ -n "$SSH_CONNECTION" ]; then
		echo "$cgrn\h$txtrst"
	elif [ -n "$DOCKER" ]; then # Docker crutch
		echo "$cmgn\h$txtrst"
	else
		echo "\h"
	fi
}

prompt_git() {
	which git >/dev/null 2>&1
	if [ "$?" -eq 0 ]; then
		local git_dir=`git rev-parse --git-dir 2>/dev/null`
		if [ -z "$git_dir" ] || [ "$HOME" == `dirname $(realpath "$git_dir")` ]; then
			echo " $cblue\W$txtrst"
			return 0
		fi
		local git_project=$(basename `git rev-parse --show-toplevel`)
		local git_branch=`git branch 2>/dev/null | sed -n '/^\*/s/^\* //p'`
		local git_path=/`git rev-parse --show-prefix | sed 's/\n//g'`
		[ -n "$git_branch" ] && echo " g:$cmgn$git_project$txtrst:$cbrwn$git_branch$txtrst:$cblue$git_path$txtrst"
	else
		echo " $cblue\W$txtrst"
		return 0
	fi
}

prompt() {
	[ "$UID" -eq 0 ] && echo "#" || echo "$"
}

export PROMPT_COMMAND='PS1="[$(prompt_user)@$(prompt_host)$(prompt_git)]$(prompt) "'
