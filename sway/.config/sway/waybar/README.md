# Waybar Configuration

This directory contains multiple Waybar configurations for the Sway setup.

## Available Configurations

### 1. Default Config (config + style.css)
The standard, working configuration that's used by default.
- **Launch:** Automatically starts with Sway
- **Style:** Dark theme with colored nerd font icons
- **Modules:** CPU, Memory, Disk, Sway workspaces, Window title, Audio, Battery, Notifications, Tray

### 2. Showcase Config (config-showcase + style-showcase.css)
The "WOW" configuration with all bells and whistles - perfect for demos and tutorials.
- **Launch:** `./launch-showcase.sh` or `waybar -c ~/.config/waybar/config-showcase -s ~/.config/waybar/style-showcase.css`
- **Style:** Gradient backgrounds, glow effects, smooth animations, colored borders
- **Features:**
  - App launcher button
  - Workspace icons with persistent workspaces
  - Mode indicator
  - Weather module
  - Update checker
  - VPN status
  - Media player controls
  - Enhanced tooltips everywhere
  - Click and scroll actions on all modules
  - Power menu button
  - Volume control via scroll
  - Interactive calendar
  - System monitoring with click-to-open

### 3. Minimal Config (config-minimal)
Ultra-simple configuration with just the essentials.
- **Launch:** `waybar -c ~/.config/waybar/config-minimal`
- **Style:** Uses default style.css
- **Modules:** Workspaces, Clock, Volume, Battery, Tray

## Quick Start

### Switch to Showcase Config
```bash
cd ~/.config/waybar
./launch-showcase.sh
```

### Switch Back to Default
```bash
killall waybar
waybar &
```

### Test a Config
```bash
# Test without killing current waybar
waybar -c ~/.config/waybar/config-showcase -s ~/.config/waybar/style-showcase.css
```

## Customization Guide

### Changing Module Order
Edit the `modules-left`, `modules-center`, and `modules-right` arrays in any config file:
```json
"modules-left": ["custom/launcher", "sway/workspaces"],
"modules-center": ["clock"],
"modules-right": ["pulseaudio", "battery", "tray"]
```

### Changing Colors
Edit the color variables at the top of the CSS file:
```css
@define-color bg #0a0e14;
@define-color cyan #80d8ff;
@define-color red #ff6b6b;
```

### Enabling/Disabling Modules
Simply remove module names from the modules arrays, or comment them out in the config.

### Custom Scripts
Custom module scripts are located in `scripts/` directory:
- `weather.sh` - Fetches weather from wttr.in
- `check-updates.sh` - Checks for system updates
- `vpn-status.sh` - Shows VPN connection status

Make sure scripts are executable:
```bash
chmod +x ~/.config/waybar/scripts/*.sh
```

## Module Interactions (Showcase Config)

### Click Actions
- **Launcher:** Opens rofi
- **Clock:** Right-click to switch format, scroll to navigate calendar
- **CPU/Memory/Disk:** Click to open htop
- **Network:** Click to open network settings
- **Volume:** Click for mixer, right-click to mute, scroll to adjust
- **Battery:** Click to show detailed battery info
- **Media:** Click to play/pause, right-click for next, scroll to navigate
- **Updates:** Click to upgrade packages
- **Weather:** Click to open wttr.in in browser
- **Power:** Click to open power menu

### Tooltips
Hover over any module to see detailed information:
- CPU shows usage, frequency, and load
- Memory shows RAM and swap details
- Disk shows used/free space breakdown
- Network shows connection details and bandwidth
- Battery shows charge, status, time remaining, and health

## Styling Features (Showcase Config)

- **Gradient backgrounds** on launcher, clock, and power button
- **Glow effects** on hover for all modules
- **Smooth animations** using cubic-bezier easing
- **Colored left borders** on modules for visual grouping
- **Pulsing animations** for urgent states and charging
- **Scale effects** on hover for interactive elements
- **Custom urgent/warning states** with different colors

## Multi-Monitor Setup

For multiple monitors, create separate config files:
```bash
waybar -c ~/.config/waybar/config-primary &
waybar -c ~/.config/waybar/config-secondary &
```

Or specify output in the config:
```json
{
    "output": "DP-1",
    ...
}
```

## Troubleshooting

### Waybar won't start
```bash
# Check for errors
waybar -l debug

# Kill all instances and restart
killall waybar && waybar &
```

### Config syntax error
```bash
# Validate JSON
python -m json.tool ~/.config/waybar/config-showcase
```

### Module not showing
1. Check if module name is in modules-left/center/right array
2. Verify module is defined in the config
3. Check if required dependencies are installed (playerctl for media, etc.)

### Custom script not working
```bash
# Make sure it's executable
chmod +x ~/.config/waybar/scripts/script-name.sh

# Test the script directly
~/.config/waybar/scripts/script-name.sh
```

## Resources

- [Waybar Wiki](https://github.com/Alexays/Waybar/wiki)
- [Configuration Documentation](https://github.com/Alexays/Waybar/wiki/Configuration)
- [Module Documentation](https://github.com/Alexays/Waybar/wiki/Module:-*modulename*)
- [Styling Guide](https://github.com/Alexays/Waybar/wiki/Styling)

## Video Tutorial

This showcase config was created for the "60 Videos in 60 Days" series:
- **Day 7: Waybar Deep Dive** - Complete walkthrough of all features

Watch at: [JustAGuyLinux YouTube Channel]
