#!/bin/bash

music=(
  script="$PLUGIN_DIR/qq_music.sh"
  click_script="open -a /Applications/QQMusic.app"
  update_freq=5
)

sketchybar --add alias 'QQ音乐' right
sketchybar --set 'QQ音乐' "${music[@]}" alias.color=$WHITE
