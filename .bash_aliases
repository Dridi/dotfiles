# ~/.bash_aliases

# ls
alias ll='ls -l  --color=auto'
alias la='ls -la --color=auto'

alias tree='tree -C'

# grep
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# cd
alias cdt="cd $(mktemp -d)"

alias   ..="cd .."
alias  ...="cd ../.."
alias ....="cd ../../.."
alias -- -="cd -"

alias dl="cd ~/Downloads"

# gpg
alias gpg=gpg2

# svn
alias di="svn di | view -c 'setf diff' -"
alias st="svn st"

# rpm
rpmqf() {
	for f
	do
		absolute_path="$(which --skip-alias "$f")" \
		&& rpm -qf "$absolute_path"
	done
}

# misc
crc32() {
	for i
	do
		local CRC=$(echo -n "$i" | cksum | cut -d' ' -f1)
		printf "0x%08x\n" "$CRC"
	done
}

# X11
alias xfix="xset s 0 0 dpms 0 0 0"
