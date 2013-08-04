# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

if [ -f ~/.bash_aliases ]; then
	source ~/.bash_aliases
fi

if [ -e /usr/share/git-core/contrib/completion/git-prompt.sh ]; then
	. /usr/share/git-core/contrib/completion/git-prompt.sh

	PS1='\[\033[38m\]\u@\h\[\033[01;34m\] \w \[\033[31m\]$(__git_ps1 "(%s)")\[\033[00m\]$ '

	GIT_PS1_SHOWDIRTYSTATE=true
	GIT_PS1_SHOWUNTRACKEDFILES=true
	GIT_PS1_SHOWSTASHSTATE=true
	GIT_PS1_SHOWUPSTREAM="git verbose"
fi
