#!/bin/sh

nitrogen --restore      # Wallpaper restore
xfce4-power-manager     # Power management
redshift-gtk &          # Redshift
pamac-tray &            # Pamac tray icon
nm-applet &             # NetworkManager applet
volumeicon &            # Volume management icon
setxkbmap pl            # Set Polish keyboard map
picom --experimental-backend &                                  # Picom compositor
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &     # Polkit agent

/usr/lib/xfce4/notifyd/xfce4-notifyd &        # Use xfce's own notification daemon