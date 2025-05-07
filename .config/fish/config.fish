# general variables setup
set fish_greeting

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
end

starship init fish | source
fzf --fish | source
zoxide init fish | source

function update-mirrors
    sudo reflector --latest 30 --protocol http,https --sort rate --save /etc/pacman.d/mirrorlist
end
