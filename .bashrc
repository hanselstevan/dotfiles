#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls -a --color=auto'
alias la='ls -la --color=auto'
alias neofetch='neofetch --source /home/hansel/.config/neofetch/cat.txt'
#PS1='[\u@\h \W]\$ '
neofetch --source /home/hansel/.config/neofetch/cat.txt
PS1="\[\e[1;0m\]┌──\e[1;32m\] \@ \e[1;32m\][\w] \n\[\e[1;0m\]└── \[\e[1;34m\]λ \[\033[0m\]"

