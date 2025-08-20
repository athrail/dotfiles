# general variables setup
set fish_greeting

fish_add_path "/home/athrail/.local/bin"

# exports
set -xU VISUAL "/home/athrail/.local/share/bob/nvim-bin/nvim"
set -xU EDITOR "/home/athrail/.local/share/bob/nvim-bin/nvim"
set -xU MANPAGER "/home/athrail/.local/share/bob/nvim-bin/nvim +Man!"

source "$HOME/.local/share/bob/env/env.fish"

# aliases
alias ff fastfetch
alias vim nvim
alias .. "cd .."
alias ls eza
alias cl clear
alias cat bat
alias lg lazygit

if status is-interactive
    # Commands to run in interactive sessions can go here
end

starship init fish | source
fzf --fish | source
zoxide init fish | source

function update-mirrors
    sudo reflector --latest 30 --protocol http,https --sort rate --save /etc/pacman.d/mirrorlist
end
