#!/bin/bash

type entr >/dev/null 2>&1 || { echo >&2 "I require entr but it's not installed.  Aborting."; exit 1; }
type fzf >/dev/null 2>&1 || { echo >&2 "I require fzf but it's not installed.  Aborting."; exit 1; }
type bat >/dev/null 2>&1 || { type batcat >/dev/null 2>&1 || { echo "I require bat but it's not installed.  Aborting."; exit 1; };}

SCRIPT_DIR=$( cd -- "$( dirname -- "$(readlink -f ${BASH_SOURCE[0]})" )" &> /dev/null && pwd )

echo "source $SCRIPT_DIR/.bash_profile" > "$HOME"/.bash_profile
echo "source $SCRIPT_DIR/.bashrc" > "$HOME"/.bashrc
cp "$SCRIPT_DIR"/.gtdrc "$HOME"

ln -sf "$HOME/.local/dotfiles/.tmux.conf" "$HOME/.tmux.conf"
ln -sf "$HOME/.local/dotfiles/.vimrc" "$HOME/.vimrc"
