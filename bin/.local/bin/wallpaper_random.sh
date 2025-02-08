#!/bin/bash

LOGFILE=~/wallpaper.log
dt=$(date '+%d/%m/%Y %H:%M:%S');

WALLPAPER_DIR="$HOME/Pictures/wallpapers"
CURRENT_WALL=$(hyprctl hyprpaper listloaded)

# Get a random wallpaper that is not the current one
WALLPAPER=$(find "$WALLPAPER_DIR" -type f ! -name "$(basename "$CURRENT_WALL")" | shuf -n 1)

# Apply the selected wallpaper
hyprctl hyprpaper reload ,"$WALLPAPER"


echo "[$dt] Current wallpaper: $CURRENT_WALL" | tee -a "$LOGFILE"
echo "[$dt] Loaded wallpaper: $WALLPAPER" | tee -a "$LOGFILE"
