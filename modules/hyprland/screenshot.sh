#!/usr/bin/env bash

# Takes a screenshot in four different ways
# Behavior is determined by defining the following environmental variables
#
# TO_FILE 
#   true: save to file
#   false: copy to clipboard
# FULL_SCREEN
#   true: captures all screen estate of all monitors
#   false: lets user select an area to catch

SAVE_FOLDER="$HOME/pictures/screenshots"
TMP="/tmp/screenshot.png"
DATE=$(date +%Y-%m-%d_%H-%M-%S)

grim "$SAVE_FOLDER/$DATE" | wl-copy -t image/png

if [ "$TO_FILE" = true ]; then
    if [ "$FULL_SCREEN" = true ]; then
        grim "$SAVE_FOLDER/$DATE".png
    else
        grim -g "$(slurp)" "$SAVE_FOLDER/$DATE".png
    fi
    notify-desktop "Screenshot saved" "$DATE.png" -i "$SAVE_FOLDER/$DATE".png
else
    if [ "$FULL_SCREEN" = true ]; then
        grim - | wl-copy -t image/png
    else
        grim -g "$(slurp)" - | wl-copy -t image/png
    fi
    wl-paste -n > "$TMP"
    notify-desktop "Screenshot copied" -i "$TMP"
fi
