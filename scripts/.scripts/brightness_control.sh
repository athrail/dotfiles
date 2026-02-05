#!/bin/bash

CHANGE=$1

if [ -z "$CHANGE" ]; then
  echo "Usage: $0 <+/- amount>"
  exit 1
fi

# Get the focused monitor name
MONITOR=$(hyprctl monitors -j | jq -r '.[] | select(.focused == true) | .name')

# Map monitor names to I2C bus numbers or handle laptop display
case $MONITOR in
"DP-1")
  BUS=6 # HP 4K USB-C monitor
  ;;
*)
  echo "Unknown monitor: $MONITOR"
  exit 1
  ;;
esac

# Get current brightness for external monitors
CURRENT=$(ddcutil --bus $BUS getvcp 10 --terse | cut -d' ' -f4)

# Calculate new brightness
NEW=$((CURRENT + CHANGE))

# Clamp to 0-100 range
if [ $NEW -lt 0 ]; then NEW=0; fi
if [ $NEW -gt 100 ]; then NEW=100; fi

notify-send "☀️ Brightness $NEW" -t 500
# Set new brightness
ddcutil --bus $BUS setvcp 10 $NEW
