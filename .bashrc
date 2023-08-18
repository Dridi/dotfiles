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

# tty
stty -ixon

# vim
export EDITOR=vim

# neovim
export NVIM_TUI_ENABLE_TRUE_COLOR=1

# git
PATH=~/.config/git/libexec:"$PATH"

source_if_exists /usr/share/git-core/contrib/completion/git-prompt.sh

if command -v __git_ps1 >/dev/null
then
	PS1='\[\033[38m\]\u@\h\[\033[01;34m\] \w \[\033[31m\]$(__git_ps1 "(%s)")\[\033[00m\]$ '

	GIT_PS1_SHOWDIRTYSTATE=true
	GIT_PS1_SHOWUNTRACKEDFILES=true
	GIT_PS1_SHOWSTASHSTATE=true
	GIT_PS1_SHOWUPSTREAM="git verbose"
fi

# less
export LESS=FRSX

export LESS_TERMCAP_mb=$(tput bold;tput setaf 2)		# blinking
export LESS_TERMCAP_md=$(tput bold;tput setaf 9)		# bold
export LESS_TERMCAP_mh=$(tput dim)				# half bright
export LESS_TERMCAP_mr=$(tput rev)				# reverse
export LESS_TERMCAP_so=$(tput bold;tput setaf 0;tput setab 11)	# standout
export LESS_TERMCAP_us=$(tput smul;tput bold;tput setaf 15)	# underlining

export LESS_TERMCAP_se=$(tput rmso;tput sgr0)	# end standout
export LESS_TERMCAP_ue=$(tput rmul;tput sgr0)	# end underlining
export LESS_TERMCAP_me=$(tput sgr0)		# end all

export LESS_TERMCAP_ZO=$(tput ssupm)	# superscript
export LESS_TERMCAP_ZN=$(tput ssubm)	# subscript

export LESS_TERMCAP_ZV=$(tput rsubm)	# end subscript
export LESS_TERMCAP_ZW=$(tput rsupm)	# end superscript

[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# tmux
source_if_exists /usr/share/gems/gems/tmuxinator*/completion/tmuxinator.bash

# X11
#xfix

# vagrant
export VAGRANT_DEFAULT_PROVIDER=virtualbox
