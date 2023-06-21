#! /usr/bin/env bash

# colors
black=#21222c
green=#50fa7b
white=#f8f8f2
grey=#282a36
blue=#d6acff
red=#ff5555
darkblue=#bd93f9

cpu() {
    printf " $(grep -o "^[^ ]*" /proc/loadavg)"
}

battery() {
   #printf " %s" "$(acpi -b | awk -F',' '{print $2 $3}')"
   printf "  $(cat /sys/class/power_supply/BAT0/capacity)%%"
}

mem() {
    printf " $(free --mega -h | awk '/^Mem/ {print $3}')"
}

while true; do
    xsetroot -name "$(cpu)  $(mem)  $(battery)  $(date +'%H:%M')" && sleep 5
done
