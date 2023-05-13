SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

if [[ -f "$SCRIPT_DIR/.bash_aliases" ]] ; then
	source "$SCRIPT_DIR/.bash_aliases"
fi
if [[ -f "$SCRIPT_DIR/.bash_paths" ]] ; then
	source "$SCRIPT_DIR/.bash_paths"
fi

if [[ -f "$SCRIPT_DIR/.bash_completions" ]] ; then
	source "$SCRIPT_DIR/.bash_completions"
fi

export TERM=xterm
export force_color_prompt=yes
export EDITOR=vim

# enable programmable completion features
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# enable color support of ls and also add handy aliases
#if [ -x /usr/bin/dircolors ]; then
#    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
#fi


export PS1='[📂 \[\033[1;34m\]\W\[\033[00m\]]▶ '

