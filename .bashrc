# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

SCRIPT_DIR=$( cd -- "$( dirname -- "$(readlink ~/.bashrc)" )" &> /dev/null && pwd )

if [[ -f "$SCRIPT_DIR/parts/.bash_aliases" ]] ; then
	source "$SCRIPT_DIR/parts/.bash_aliases"
fi
if [[ -f "$SCRIPT_DIR/parts/.bash_paths" ]] ; then
	source "$SCRIPT_DIR/parts/.bash_paths"
fi
