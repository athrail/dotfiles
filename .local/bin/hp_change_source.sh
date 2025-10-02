#! /bin/bash

menu() {
  local prompt="Select source"
  local options="Type-C\nDisplay Port\nHDMI"

  local selection=$(echo -e "$options" | walker --dmenu --theme dmenu_250 -p "$prompt…" "${args[@]}")
  case $selection in
  *Display\ Port*) output="0x0f" ;;
  *HDMI*) output="0x11" ;;
  *Type-C*) output="0x13" ;;
  esac

  ddcutil -n 1CR3480038 setvcp 0x60 $output
}

menu
