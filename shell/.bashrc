stty -ixon

export PS1="\[$(tput bold)\][\A \W]\$ \[$(tput sgr0)\]"
shopt -s autocd #Allows you to cd into directory merely by typing the directory name.

# Bash history settings
HISTCONTROL=ignoredups:ignorespace
HISTSIZE=1000
HISTFILESIZE=2000

# autcompletion
complete -cf sudo
source /usr/share/git/completion/git-completion.bash

export EDITOR=nvim

# Aliases
alias ls='ls --color=auto'

alias c='xclip -selection clipboard'
