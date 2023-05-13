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

export PS1='[📂 \[\033[1;34m\]\W\[\033[00m\]]▶ '

