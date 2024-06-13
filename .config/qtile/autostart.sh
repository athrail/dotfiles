#!/bin/sh

nitrogen --restore      # Wallpaper restore
nm-applet &             # NetworkManager applet
setxkbmap pl            # Set Polish keyboard map
picom --daemon &        # Picom compositor
blueman-applet &
xsettingsd &
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &     # Polkit agent
dunst &
