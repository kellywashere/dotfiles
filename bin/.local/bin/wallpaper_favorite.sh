#!/bin/bash

LOGFILE=~/wallpaper.log
dt=$(date '+%d/%m/%Y %H:%M:%S');

WALLPAPER_FAV_DIR="$HOME/Pictures/wallpapers/favorite/"
CURRENT_WALL=$(hyprctl hyprpaper listloaded)
cp $CURRENT_WALL $WALLPAPER_FAV_DIR

echo "[$dt] Copied to favorites: $CURRENT_WALL" | tee -a $LOGFILE
