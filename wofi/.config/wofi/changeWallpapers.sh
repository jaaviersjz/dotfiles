#!/bin/zsh
# Script that changes the wallpaper used by hyprpaper

dir="$HOME/Pictures/Wallpapers"     # Directory containing wallpapers
files=""

for file in "$dir"/*; do
  filename=$(basename $file)        # Extract filename from path
  files="$files\n$filename"
done
files=${files:2}                    # Remove leading newline

image=$(echo $files | wofi --dmenu -M fuzzy -i -p "Select wallpaper")  # Open wofi menu to select wallpaper

if [[ -n $image ]]; then
  # Change the wallpaper using hyprpaper. Consult the documentation: https://wiki.hypr.land/Hypr-Ecosystem/hyprpaper  
  hyprctl hyprpaper reload ,"$HOME/Pictures/Wallpapers/$image" &> /dev/null 
fi
