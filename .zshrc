# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt extendedglob
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/athrail/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# Ctrl arrow jumps
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

# Env vars
export EDITOR="nvim"
export VISUAL="nvim"
export PATH=$HOME/.local/bin:/usr/lib/cargo/bin:$PATH
export PAGER="most"
export BAT_THEME="Catppuccin-mocha"
export LIBVIRT_DEFAULT_URI="qemu:///system"

# Aliases
alias ..="cd .."
alias cd..="cd .."
alias ls="exa -1 --icons --group-directories-first"
alias ll="ls -l"
alias la="ls -a"
alias nala="sudo nala"
alias cat="batcat"
alias vim="nvim"
alias vi='nvim'
alias svi='sudo vi'

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

#autojump
[[ -s /home/athrail/.autojump/etc/profile.d/autojump.sh ]] && source /home/athrail/.autojump/etc/profile.d/autojump.sh

autoload -U compinit && compinit -u

source ~/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
