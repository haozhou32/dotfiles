#!/bin/bash


DRIVE_NAME="$1"

if [ -z "$DRIVE_NAME" ]; then
  # Fallback if no argument passed (shouldn't happen if Step 2 is correct)
  DRIVE_NAME=$(ls /Volumes | grep -v "Macintosh HD" | grep -v "com.apple" | head -n 1)
fi

if [ -n "$DRIVE_NAME" ]; then
  # Attempt to eject
  diskutil eject "/Volumes/$DRIVE_NAME"
  
  # Close the popup immediately after clicking
  sketchybar --set external_drive popup.drawing=off
  
  # Force an update of the main item so it disappears immediately
  sketchybar --trigger system_woke
fi
