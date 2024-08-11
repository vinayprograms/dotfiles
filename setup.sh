#!/bin/bash

type entr >/dev/null 2>&1 || { echo >&2 "I require entr but it's not installed.  Aborting."; exit 1; }
type fzf >/dev/null 2>&1 || { echo >&2 "I require fzf but it's not installed.  Aborting."; exit 1; }
type bat >/dev/null 2>&1 || { echo >&2 "I require bat but it's not installed.  Aborting."; exit 1; }

ln -sf "$HOME/.local/dotfiles/.bashrc" "$HOME/.bashrc"
ln -sf "$HOME/.local/dotfiles/.bash_profile" "$HOME/.bash_profile"
ln -sf "$HOME/.local/dotfiles/.gtdrc" "$HOME/.gtdrc"
ln -sf "$HOME/.local/dotfiles/.tmux.conf" "$HOME/.tmux.conf"
ln -sf "$HOME/.local/dotfiles/.vimrc" "$HOME/.vimrc"
