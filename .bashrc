#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias la='ls -a --color=auto'
alias ll='ls -la --color=auto'
alias debl='apt list --installed'
alias deb='sudo dpkg -i'
alias broken='sudo apt --fix-broken install'
alias auto='sudo apt autoremove'
alias neofetch='neofetch --source /home/hansel/.config/neofetch/kitten.txt'
cd() { builtin cd "$@" && ls -a --color=auto; }
PS1="\[\e[1;32m\]┌──\e[1;35m\] \@ \e[1;39m\][\w] \n\[\e[1;32m\]└── \[\e[1;35m\]λ \[\033[37m\]"
#printf "\e[1;32m  __   __  ______     __     _____    
# /\ \ / / /\  __ \   /\ \   /\  __-.    \e[1;35mhost \e[1;0m toaster\e[1;32m
# \ \ \' /  \ \ \/\ \  \ \ \  \ \ \/\ \   \e[1;32m├ \e[1;35mshell \e[1;0m bash\e[1;32m
#  \ \__|   \ \_____\  \ \_\  \ \____-   \e[1;32m├ \e[1;35mwm \e[1;0m awesome\e[1;32m
#   \/_/     \/_____/   \/_/   \/____/   \e[1;32m└ \e[1;35mtty \e[1;0m kitty\e[1;32m
#
#"
