# ~/.bash_aliases

alias ll='ls -l  --color=auto'
alias la='ls -la --color=auto'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias cdt="cd $(mktemp -d)"

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias -- -="cd -"

alias dl="cd ~/Downloads"

alias tree='tree -C'

alias di="svn di | view -c 'setf diff' -"
alias st="svn st"
