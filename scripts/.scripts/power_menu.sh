#! /bin/bash

menu() {
  local prompt="Power menu"
  local options="Lock\nSleep\nRestart\nShut down"

  local selection=$(echo -e "$options" | rofi -fixed-num-lines 4 -dmenu "${args[@]}")
  case $selection in
  *Lock*) loginctl lock-session ;;
  *Sleep*) systemctl suspend ;;
  *Restart*) systemctl reboot ;;
  *Shut\ down*) systemctl poweroff ;;
  esac
}

menu
