#! /usr/bin/env bash

shutdown=" shutdown"
suspend="󰒲 suspend"
reboot="󰜉 reboot"

uptime=$(uptime -p | sed -e 's/up //g')

options="$suspend\n$reboot\n$shutdown"

choice=$(echo -e "$options" | \
    rofi -dmenu -i -p "$uptime" \
    -theme-str 'window {width:20%; height: 20%;}')

if [ $? -ne 0 ]; then
    exit
fi

case "$choice" in
    $suspend)
        systemctl suspend
    ;;
    $reboot)
        systemctl reboot
    ;;
    $shutdown)
        systemctl poweroff
    ;;
esac
