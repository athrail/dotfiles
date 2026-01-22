#!/bin/bash
# Launch Waybar with the Showcase configuration

# Kill any running waybar instances
killall -q waybar

# Wait for waybar to fully exit
while pgrep -x waybar >/dev/null; do sleep 0.1; done

# Launch waybar with showcase config
waybar -c ~/.config/waybar/config-showcase -s ~/.config/waybar/style-showcase.css &

echo "Waybar Showcase launched!"
