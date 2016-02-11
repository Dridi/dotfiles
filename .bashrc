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

# vim
export EDITOR=vim

# git
export GIT_EXEC_PATH=~/.config/git/libexec:"$(GIT_EXEC_PATH= git --exec-path)"

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
export LESS=FRSX
export LESS_TERMCAP_mb=$'\e[01;31m'       # begin blinking
export LESS_TERMCAP_md=$'\e[01;38;5;74m'  # begin bold
export LESS_TERMCAP_me=$'\e[0m'           # end mode
export LESS_TERMCAP_se=$'\e[0m'           # end standout-mode
export LESS_TERMCAP_so=$'\e[38;5;246m'    # begin standout-mode - info box
export LESS_TERMCAP_ue=$'\e[0m'           # end underline
export LESS_TERMCAP_us=$'\e[04;38;5;146m' # begin underline

[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# tmux
source_if_exists /usr/share/gems/gems/tmuxinator*/completion/tmuxinator.bash

# X11
xfix
