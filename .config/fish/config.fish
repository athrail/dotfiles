# general variables setup
set fish_greeting

fish_add_path "/home/athrail/.local/bin"

# exports
set -xU EDITOR nvim
set -xU MANPAGER 'nvim +Man!'

# aliases
alias ff fastfetch
alias .. "cd .."
alias ls eza
alias cl clear
alias cat bat
alias lg lazygit
alias vim nvim

if status is-interactive
    # Commands to run in interactive sessions can go here
    fastfetch --colors-block-range-end 7 --colors-block-width 3
end

starship init fish | source
fzf --fish | source
zoxide init fish | source

function update-mirrors
    sudo reflector --latest 30 --protocol http,https --sort rate --save /etc/pacman.d/mirrorlist
end

