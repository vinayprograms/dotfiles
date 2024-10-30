#!/bin/bash

test -z $(command -v entr) && { echo >&2 "I require entr but it's not installed.  Aborting."; exit 1; }
test -z $(command -v fzf) && { echo >&2 "I require fzf but it's not installed.  Aborting."; exit 1; }
test -z $(command -v bat || command -v batcat) && { echo >&2 "I require bat but it's not installed.  Aborting."; exit 1; }


SCRIPT_DIR=$( cd -- "$( dirname -- "$(readlink -f ${BASH_SOURCE[0]})" )" &> /dev/null && pwd )

echo "source $SCRIPT_DIR/.bash_profile" > "$HOME"/.bash_profile
echo "source $SCRIPT_DIR/.bashrc" > "$HOME"/.bashrc
cp "$SCRIPT_DIR"/.gtdrc "$HOME"

ln -sf "$HOME/.local/dotfiles/.tmux.conf" "$HOME/.tmux.conf"
ln -sf "$HOME/.local/dotfiles/.vimrc" "$HOME/.vimrc"
