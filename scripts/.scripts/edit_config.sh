#! /bin/bash

menu() {
  local options=" hyprland\n fish\n fuzzel\n mako\n nvim\n sway\n swaync\n tmux\n waybar"
  local file=""
  local terminal="foot"
  local editor="nvim"

  local selection=$(echo -e "$options" | fuzzel --lines $(echo -e "$options" | wc -l) --width 11 --dmenu -p "󰐥 ")
  case $selection in
  *hyprland*) file="$HOME/.config/hypr" ;;
  *fish*) file="$HOME/.config/fish/config.fish" ;;
  *fuzzel*) file="$HOME/.config/fuzzel/fuzzel.ini" ;;
  *mako*) file="$HOME/.config/mako" ;;
  *nvim*) file="$HOME/.config/nvim" ;;
  *sway*) file="$HOME/.config/sway/config" ;;
  *swaync*) file="$HOME/.config/swaync/config.json" ;;
  *tmux*) file="$HOME/.config/tmux/tmux.conf" ;;
  *waybar*) file="$HOME/.config/waybar" ;;
  esac

  if [[ $file != "" ]]; then
    $terminal $editor $file
  fi
}

menu
