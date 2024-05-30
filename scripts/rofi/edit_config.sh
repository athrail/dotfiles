#!/bin/bash

declare options=("i3
zshrc
scripts")

terminal=kitty

choice=$(echo -e "${options[@]}" | \
    rofi -dmenu \
    -i -p 'Edit a config file '\
    -theme-str 'window { width:20%; height: 30%; } listview { columns: 1; lines: 3; }')

if [ $? -ne 0 ]; then
    exit
fi

case "$choice" in
  i3)
    $terminal $EDITOR ~/.config/i3/config
    ;;
  zshrc)
    $terminal $EDITOR ~/.zshrc
    ;;
  scripts)
    $terminal $EDITOR ~/scripts
    ;;
  *)
    exit
    ;;
esac

