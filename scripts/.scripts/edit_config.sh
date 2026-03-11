#! /usr/bin/env bash

menu() {
  local options="hyprland\nfish\nalacritty\nfuzzel\nmako\nnvim\nsway\nswaync\ntmux\nwaybar"
  local file=""
  local terminal="alacritty --command"
  local editor="nvim"

  local selection=$(echo -e "$options" | fuzzel --lines $(echo -e "$options" | wc -l) --width 14 --dmenu -p "󰐥 ")
  case $selection in
  *hyprland*) file="$HOME/.config/hypr" ;;
  *fish*) file="$HOME/.config/fish/config.fish" ;;
  *alacritty*) file="$HOME/.config/alacritty/alacritty.toml" ;;
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
