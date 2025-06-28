#!/bin/bash

alias chmox="chmod +x"
alias ls="ls --color=auto"
alias ll="ls -lah"
alias tmux="tmux -u" # Always load with unicode support
alias path='echo $PATH | tr -s ":" "\n"'

# Always use emacs daemon + client
alias e='$HOME/.local/bin/toolsh/emacs-editor' 
alias v="vim"

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
alias t="task"
alias tui="taskwarrior-tui"
alias ta="task add"
alias tc="task completed"
alias tp="task projects"
alias tl="task next"
alias tw="task waiting"
alias te="task edit"
alias tm="taskmodify"
alias in="inbox" # `inbox` is a custom script that uses taskwarrior
alias tn="task -rnr +UNBLOCKED"
alias prjl="prj list"
alias in="inbox" # `inbox` is a custom script that uses taskwarrior

# Generic shortcuts
alias less="less -iR"
alias ??="ai"
alias swipl="~/.local/swipl-devel/build/src/swipl"

# tmux shortcuts
alias tmls="tmux ls"
alias tma="tmux attach -t"
alias tms="tmux new -s"

# toolsh specific
alias z="zet"
alias zn="zet new"
alias ze="zet edit"
alias zls="zet ls"
alias zl="zet last"
alias zt="zet todo"
