# ~/.bash_aliases

# ls
alias ls='ls --color=auto --group-directories-first'
alias ll='ls -l'
alias la='ls -la'

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

download() {
	ff_ver=$(
		firefox -version |
		tr ' ' '\n' |
		awk -F. '$1 ~ "[0-9]+" {print $1 "." $2}'
	)
	ff_ua="Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:$ff_ver) Gecko/20100101 Firefox/$ff_ver"
	wget --user-agent="$ff_ua" "$@"
}

# X11
alias xfix="xset s 0 0 dpms 0 0 0"
