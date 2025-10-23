# general variables setup
set fish_greeting

# exports
set -xg VISUAL "$HOME/.local/share/bob/nvim-bin/nvim"
set -xg EDITOR "$HOME/.local/share/bob/nvim-bin/nvim"
set -xg MANPAGER "$HOME/.local/share/bob/nvim-bin/nvim +Man!"
set -xg GEM_HOME "$(gem env user_gemhome)"

fish_add_path "/home/athrail/.local/bin"
fish_add_path "$GEM_HOME/bin"

mise activate fish | source

# aliases
alias ff fastfetch
alias nvim "$HOME/.local/share/bob/nvim-bin/nvim"
alias vim "$HOME/.local/share/bob/nvim-bin/nvim"
alias .. "cd .."
alias ls eza
alias cl clear
alias cat bat
alias lg lazygit

if status is-interactive
    # Commands to run in interactive sessions can go here
end

fzf --fish | source
zoxide init fish | source

fish_config prompt choose astronaut

function update-mirrors
    sudo reflector --country France,Germany,Poland,Netherlands,Czech,Slovakia --age 12 --protocol https --sort rate --save /etc/pacman.d/mirrorlist
    # sudo reflector --latest 30 --protocol http,https --sort rate --save /etc/pacman.d/mirrorlist
end

function tms
    # Choose a directory: argument or fzf picker
    if test (count $argv) -eq 1
        set selected $argv[1]
    else
        set selected (find ~/probe -mindepth 1 -maxdepth 1 -type d | fzf)
    end

    # Abort if nothing was chosen
    if test -z "$selected"
        return
    end

    # Session name: replace dots with underscores
    set selected_name (basename "$selected" | tr . _)

    # Detect any running tmux process
    set tmux_running (pgrep tmux)

    # No tmux at all → start a new session and exit
    if test -z "$TMUX" -a -z "$tmux_running"
        tmux new-session -s $selected_name -c $selected
        return
    end

    # Create a detached session if it doesn't exist yet
    if not tmux has-session -t $selected_name ^/dev/null
        tmux new-session -ds $selected_name -c $selected
    end

    # Attach or switch depending on whether we are already inside tmux
    if test -z "$TMUX"
        tmux attach -t $selected_name
    else
        tmux switch-client -t $selected_name
    end
end
