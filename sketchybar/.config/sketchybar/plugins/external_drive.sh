#!/bin/bash


source "$HOME/.config/sketchybar/colors.sh"


DRIVE=$(ls /Volumes | grep -v "Macintosh HD" | grep -v "com.apple" | head -n 1)

if [ -n "$DRIVE" ]; then
  # Drive exists
  sketchybar --set $NAME drawing=on \
                         label="$DRIVE" \
             --set external_drive.eject label="Eject $DRIVE" \
                                        click_script="$PLUGIN_DIR/external_drive_click.sh \"$DRIVE\""
else
  # No drive found
  sketchybar --set $NAME drawing=off \
             --set external_drive popup.drawing=off
fi
