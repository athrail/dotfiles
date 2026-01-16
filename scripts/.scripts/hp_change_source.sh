#! /bin/bash

menu() {
  local options="Type-C\nDP\nHDMI"

  local selection=$(echo -e "$options" | fuzzel --lines 3 --width 10 --dmenu -p "󰍹  ")
  case $selection in
  *DP*) output="0x0f" ;;
  *HDMI*) output="0x11" ;;
  *Type-C*) output="0x13" ;;
  esac

  ddcutil setvcp 0x60 $output
}

menu
