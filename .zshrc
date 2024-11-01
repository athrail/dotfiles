HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt extendedglob
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/athrail/.zshrc'

autoload -U compinit && compinit -u

# End of lines added by compinstall

# Ctrl arrow jumps
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
# xmodmap -e 'clear Lock' -e 'keycode 0x42 = Escape'

# aliases
source ~/.aliases


# fzf catppuccin theme
# export FZF_DEFAULT_OPTS=" \
# --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
# --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
# --color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"

export EDITOR="nvim"
export VISUAL="nvim"
export PATH=$HOME/.local/bin:/usr/lib/cargo/bin:$PATH
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:$HOME/go/bin
export PATH=$PATH:$HOME/.cargo/bin
export LIBVIRT_DEFAULT_URI="qemu:///system"

# plugins configuration

# Always starting with insert mode for each command line
ZVM_LINE_INIT_MODE=$ZVM_MODE_INSERT
# Do the initialization when the script is sourced (i.e. Initialize instantly)
ZVM_INIT_MODE=sourcing

# plugins
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-vi-mode/zsh-vi-mode.zsh

eval "$(zoxide init zsh)"
eval "$(starship init zsh)"
eval "$(fzf --zsh)"
