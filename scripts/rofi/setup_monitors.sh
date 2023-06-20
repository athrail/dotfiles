#!/bin/bash

declare options=("expand
VGA only
LVDS only")

choice=$(echo -e "${options[@]}" | \
    rofi -dmenu -i \
    -p "Configure monitors" \
    -lines 5 \
    -width 30 \
    -no-show-icons)

if [ $? -ne 0 ]; then
    exit
fi

case "$choice" in
    expand)
        xrandr --output LVDS1 --mode 1366x768 --pos 1680x282 --rotate normal --output VGA1 --primary --mode 1680x1050 --pos 0x0 --rotate normal
    ;;
    "VGA only")
        xrandr --output LVDS1 --off --output VGA1 --primary --mode 1680x1050 --pos 0x0 --rotate normal
    ;;
    "LVDS only")
        xrandr --output LVDS1 --primary --mode 1366x768 --pos 0x0 --rotate normal --output VGA1 --off
    ;;
esac

bspc wm -r