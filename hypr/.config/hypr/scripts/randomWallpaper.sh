#!/bin/zsh
# Script that selects a random wallpaper at startup
WALLPAPER_DIR="$HOME/Pictures/Wallpapers"
WALLPAPER=$(find "$WALLPAPER_DIR" -type f | shuf -n 1)

hyprctl hyprpaper reload ,"$WALLPAPER" &> /dev/null
