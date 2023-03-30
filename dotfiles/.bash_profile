if [[ -f "$HOME/dotfiles/.bash_aliases" ]] ; then
	source "$HOME/dotfiles/.bash_aliases"
fi
if [[ -f "$HOME/dotfiles/.bash_paths" ]] ; then
	source "$HOME/dotfiles/.bash_paths"
fi

export TERM=xterm
export force_color_prompt=yes

export EDITOR=vim

export PS1='[📂 \[\033[1;34m\]\W\[\033[00m\]]▶ '

