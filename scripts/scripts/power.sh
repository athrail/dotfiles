#! /usr/bin/env bash

declare options=("suspend
reboot
shutdown")

choice=$(echo -e "${options[@]}" | \
    rofi -dmenu -i -p "Power menu" \
    -theme-str 'window {width:20%; height: 20%;}')

if [ $? -ne 0 ]; then
    exit
fi

case "$choice" in
    suspend)
        systemctl suspend
    ;;
    reboot)
        systemctl reboot
    ;;
    shutdown)
        systemctl poweroff
    ;;
esac
