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

GTK_THEME="catppuccin-mocha-lavender-standard+default"

# fzf catppuccin theme
export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"

export EDITOR="nvim"
export VISUAL="nvim"
export PATH=$HOME/.local/bin:/usr/lib/cargo/bin:$PATH
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:$HOME/go/bin
export PATH=$PATH:$HOME/.cargo/bin
export PAGER="most"
export BAT_THEME="Catppuccin Mocha"
export LIBVIRT_DEFAULT_URI="qemu:///system"

# autosuggestions
source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh

eval "$(zoxide init zsh)"
eval "$(starship init zsh)"

eval "$(fzf --zsh)"
