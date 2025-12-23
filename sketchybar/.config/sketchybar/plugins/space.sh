#!/bin/sh

# The $SELECTED variable is available for space components and indicates if
# the space invoking this script (with name: $NAME) is currently selected:
# https://felixkratz.github.io/SketchyBar/config/components#space----associate-mission-control-spaces-with-an-item

source "$CONFIG_DIR/colors.sh" # Loads all defined colors

if [ $SELECTED = true ]; then
  sketchybar --set $NAME background.drawing=on \
                         background.color=$BLUE \
                         background.border_color=$WHITE\
                         background.height=23 \
                         label.color=$BLACK \
                         icon.color=$BLACK
else
  sketchybar --set $NAME background.drawing=on \
                         background.color=$GREY \
                         background.border_color=$BACKGROUND_2 \
                         background.height=23 \
                         label.color=$WHITE\
                         icon.color=$WHITE
fi



