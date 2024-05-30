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
export PATH=$PATH:$HOME/.local/kitty.app/bin
export PAGER="most"
export BAT_THEME="Catppuccin Mocha"
export LIBVIRT_DEFAULT_URI="qemu:///system"
export ZSH="$HOME/.oh-my-zsh"

# Aliases
alias ..="cd .."
alias cd..="cd .."
alias ls="exa -1 --group-directories-first"
alias ll="ls -l"
alias la="ls -a"
alias nala="sudo nala"
alias cat="bat"
alias vim="nvim"
alias vi="nvim"
alias cl="clear"
alias lg="lazygit"

# fzf catppuccin theme
export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"

# zoxide
eval "$(zoxide init zsh)"
eval "$(starship init zsh)"
