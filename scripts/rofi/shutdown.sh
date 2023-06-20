#!/bin/bash

declare options=("suspend
hibernate
shutdown
reboot")

choice=$(echo -e "${options[@]}" | \
    rofi -dmenu -i \
    -p "Exit" \
    -lines 4 \
    -width 20 \
    -no-show-icons)

if [ $? -ne 0 ]; then
    exit
fi

case "$choice" in
    suspend)
        systemctl suspend
    ;;
    hibernate)
        systemctl hibernate
    ;;
    shutdown)
        systemctl poweroff
    ;;
    reboot)
        systemctl reboot
    ;;
esac