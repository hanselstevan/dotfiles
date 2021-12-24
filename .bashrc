#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls -a --color=auto'
alias la='ls -la --color=auto'
alias neofetch='neofetch --source /home/hansel/.config/neofetch/arch.txt'
PS1='[\u@\h \W]\$ '
neofetch --source /home/hansel/.config/neofetch/arch.txt
eval "$(starship init bash)"
