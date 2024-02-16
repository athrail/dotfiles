set -g theme_nerd_font yes
set -g theme_color_scheme light

function create
   $HOME/.scripts/create_project.py $argv
end

function dotfiles
   /usr/bin/git --git-dir=$HOME/code/dotfiles --work-tree=$HOME $argv
end