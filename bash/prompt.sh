#!/bin/bash

# Dotfiles root
export DOTFILES_ROOT="$HOME/git/dotfiles"

# Git
source "${DOTFILES_ROOT}/git/git-prompt.sh"
export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWUPSTREAM=0

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# timer stuff
function timer_start {
	timer=${timer:-$SECONDS}
}
function timer_stop {
	timer_show=$((SECONDS - timer))
	if (( timer_show >= 5 )); then
		timer_show=" • took "$(gotimelaps ${timer_show}s)
	else
		timer_show=""
	fi
	unset timer
}
trap 'timer_start' DEBUG
if [ "$PROMPT_COMMAND" == "" ]; then
	PROMPT_COMMAND="timer_stop"
else
	PROMPT_COMMAND="$PROMPT_COMMAND; timer_stop"
fi

# Prompt
if [ "$color_prompt" = yes ]; then
	PS1='${debian_chroot:+($debian_chroot)}\[\e[1;33m\]\u@\h\[\e[34m\] • \w\[\e[36m\]$(__git_ps1 " • %s")\[\e[35m\]$timer_show\n\[\e[$([ "$?" == "0" ] && printf "32" || printf "31")m\]$([ \j -gt 0 ] && echo "[\j] ")\$ \[\e[0m\]'
else
	PS1='${debian_chroot:+($debian_chroot)}\u@\h \w$(__git_ps1)${timer_show}\n\$ '
fi
unset color_prompt
