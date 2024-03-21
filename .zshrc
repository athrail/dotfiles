HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt extendedglob
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/athrail/.zshrc'

autoload -U compinit && compinit -u

# End of lines added by compinstall

# Ctrl arrow jumps
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

# Env vars
export EDITOR="nvim"
export VISUAL="nvim"
export PATH=$HOME/.local/bin:/usr/lib/cargo/bin:$PATH
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:$HOME/go/bin
export PAGER="most"
export BAT_THEME="Catppuccin-mocha"
export LIBVIRT_DEFAULT_URI="qemu:///system"
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(
  git
  zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

# Aliases
alias ..="cd .."
alias cd..="cd .."
alias ls="exa -1 --group-directories-first"
alias ll="ls -l"
alias la="ls -a"
alias nala="sudo nala"
alias cat="batcat"
alias vim="nvim"
alias vi="nvim"
alias cl="clear"
alias lg="lazygit"

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# zoxide
eval "$(zoxide init zsh)"

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

