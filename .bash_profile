SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

if [[ -f "$SCRIPT_DIR/parts/.bash_aliases" ]] ; then
	source "$SCRIPT_DIR/parts/.bash_aliases"
fi
if [[ -f "$SCRIPT_DIR/parts/.bash_paths" ]] ; then
	source "$SCRIPT_DIR/parts/.bash_paths"
fi

if [[ -f "$SCRIPT_DIR/parts/.bash_completions" ]] ; then
	source "$SCRIPT_DIR/parts/.bash_completions"
fi

tic -x "$SCRIPT_DIR"/xterm-256color-italic.terminfo

#if [ -t 1 ]; then
export TERM=xterm-256color-italic
#fi

export force_color_prompt=yes
export EDITOR=vim
#export EDITOR="$HOME/.local/bin/toolsh/emacs-editor"
set -o vi
set show-mode-in-prompt on
bind '"C-i":complete'

# enable programmable completion features
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# FZF
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
# Autocompletion
[[ $- == *i* ]] && source "/opt/homebrew/Cellar/fzf/0.46.1/shell/completion.bash" 2> /dev/null
# key bindings
[[ $- == *i* ]] && source "/opt/homebrew/Cellar/fzf/0.46.1/shell/key-bindings.bash" 2> /dev/null


# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

export PS1='[📂 \[\033[1;34m\]\W\[\033[00m\]]▶ '
