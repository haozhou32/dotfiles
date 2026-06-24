#!/bin/bash

INPUT_SOURCE_NOTIFICATION="com.apple.Carbon.TISNotifySelectedKeyboardInputSourceChanged"

input_method=(
  icon.drawing=off
  label="EN"
  label.font="$FONT:Bold:12.0"
  label.color=$BLUE
  label.padding_left=8
  label.padding_right=8
  padding_left=5
  padding_right=5
  background.drawing=off
  script="$PLUGIN_DIR/input_method.sh"
  updates=on
)

sketchybar --add event input_source_change "$INPUT_SOURCE_NOTIFICATION" \
           --add item input_method right                              \
           --set input_method "${input_method[@]}"                    \
           --subscribe input_method input_source_change system_woke
