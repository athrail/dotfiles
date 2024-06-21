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

# autosuggestions
source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh

eval "$(zoxide init zsh)"
eval "$(starship init zsh)"
