#!/bin/bash

if [ -z "${DEV_ENV}" ]; then
    echo "Need to set DEV_ENV variable first!"
    exit 1
fi

# Define the source and destination directories
SOURCE_DIR="$HOME/.config"
BACKUP_DIR="$DEV_ENV/.config"

# Create the backup directory if it doesn't exist
mkdir -p "$BACKUP_DIR"

# List of specific configuration files/directories to back up
CONFIG_FILES=(
    "fish"
    "fuzzel"
    "godot"
    "hypr"
    "mako"
    "nvim"
    "waybar"
    "niri"
    "kitty"
    "ghostty"
    "starship.toml"
)

# Loop through the list and copy each configuration file/directory
for CONFIG in "${CONFIG_FILES[@]}"; do
    if [ -e "$SOURCE_DIR/$CONFIG" ]; then
        cp -r "$SOURCE_DIR/$CONFIG" "$BACKUP_DIR/"
    fi
done

cp -r $HOME/.tmux.conf $DEV_ENV
cp -r $HOME/.gitconfig $DEV_ENV
cp -r $HOME/.zshrc $DEV_ENV
cp $HOME/.config/helix/config.toml "$BACKUP_DIR/helix/"
cp $HOME/.config/helix/languages.toml "$BACKUP_DIR/helix/"

echo "Backup completed."
