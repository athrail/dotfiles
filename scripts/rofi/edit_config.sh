#!/bin/bash

declare options=("qtile
bashrc
rofi
scripts
Xresources
fish
omf")

choice=$(echo -e "${options[@]}" | \
    rofi -dmenu \
    -i -p 'Edit a config file '\
    -lines 10 \
    -width 25 \
    -no-show-icons)

if [ $? -ne 0 ]; then
    exit
fi

case "$choice" in
	qtile) choice="$HOME/.config/qtile";;
	bashrc) choice="$HOME/.bashrc";;
	rofi) choice="$HOME/.config/rofi/config.rasi";;
	scripts) choice="$HOME/.scripts/";;
	Xresources) choice="$HOME/.Xresources" ;;
	fish) choice="$HOME/.config/fish";;
	omf) choice="$HOME/.config/omf";;

    *)
        exit
    ;;
esac

code "$choice"
