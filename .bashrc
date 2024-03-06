#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias ..='cd ..'
PS1='[\u@\h \W]\$ '

export MANGOHUD=1
export PATH=$PATH:$HOME/.local/bin

. "$HOME/.cargo/env"
