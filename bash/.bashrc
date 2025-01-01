stty -ixon

export PS1="\[$(tput bold)\]\[$(tput setaf 3)\][\[$(tput setaf 3)\]\A\[$(tput setaf 6)\] \W\[$(tput setaf 3)\]]\[$(tput setaf 7)\]\\$ \[$(tput sgr0)\]"
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
alias ll='ls -la --color=auto'
alias ls='ls --color=auto'
alias grep='grep --color=auto'

alias v='nvim'
alias c='xclip -selection clipboard'

alias gpunvidia='prime-offload && optimus-manager --switch nvidia'

