#!/bin/bash

alias chmox="chmod +x"
alias ls="ls --color=auto"
alias ll="ls -lah"
alias tmux="tmux -u" # Always load with unicode support
alias path='echo $PATH | tr -s ":" "\n"'

# Always use emacs daemon + client
alias e='$HOME/.local/bin/toolsh/emacs-editor' 
# KVM
alias vm="virsh -c qemu+ssh://devru@homelab/system"
alias kube='kubectl'
alias mkube='/usr/local/bin/minikube'

# git shortcuts
alias status="git status"
alias add="git add"
alias commit="git commit"
alias push="git push"
alias pull="git pull"

# taskwarrior shortcuts
alias t="tasksync"
alias ta="taskpush add"
alias tc="taskpull completed"
alias tp="taskpull projects"
alias tl="taskpull list"
alias tw="tasksync waiting"
alias te="tasksync edit"
alias in="inbox" # `inbox` is a custom script that uses taskwarrior
alias n="tasksync -rnr +UNBLOCKED"
alias '??'="chatgpt"
alias tmls="tmux ls"
alias tma="tmux attach -t"
alias tms="tmux new -s"
