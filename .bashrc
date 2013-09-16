# .bashrc

# Source global definitions
[ -f /etc/bashrc          ] && . /etc/bashrc
[ -f /etc/bash_completion ] && . /etc/bash_completion

# Source local definitions
[ -f ~/.bash_aliases ] && . ~/.bash_aliases
[ -f ~/.bash_custom  ] && . ~/.bash_custom

# shell
shopt -s globstar
shopt -s checkwinsize
shopt -s histappend

HISTCONTROL=ignoreboth
HISTSIZE=1000
HISTFILESIZE=2000

# git
if [ -e /usr/share/git-core/contrib/completion/git-prompt.sh ]
then
	. /usr/share/git-core/contrib/completion/git-prompt.sh
fi

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
