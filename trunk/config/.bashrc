
# Check for an interactive session
[ -z "$PS1" ] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

# Alias persos

alias halt="sudo halt"
alias reboot="sudo reboot"

export PATH=$PATH":$HOME/bin"

# Variables d'environnement pour Go
export GOROOT=$HOME/Programmation/Go
export GOARCH=386
export GOOS=linux
export GOBIN=$HOME/bin
###################################
