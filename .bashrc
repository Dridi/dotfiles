# .bashrc

source_if_exists() {
	for f; do [ -f "$f" ] && . "$f"; done
}

# Source global definitions
source_if_exists /etc/bashrc /etc/bash_completion

# Source local definitions
source_if_exists ~/.bash_aliases ~/.bash_custom

# shell
shopt -s globstar
shopt -s checkwinsize
shopt -s histappend

HISTCONTROL=ignoreboth
HISTSIZE=1000
HISTFILESIZE=2000

# git
source_if_exists /usr/share/git-core/contrib/completion/git-prompt.sh

if type __git_ps1 >/dev/null 2>&1
then
	PS1='\[\033[38m\]\u@\h\[\033[01;34m\] \w \[\033[31m\]$(__git_ps1 "(%s)")\[\033[00m\]$ '

	GIT_PS1_SHOWDIRTYSTATE=true
	GIT_PS1_SHOWUNTRACKEDFILES=true
	GIT_PS1_SHOWSTASHSTATE=true
	GIT_PS1_SHOWUPSTREAM="git verbose"
fi

# less
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"
