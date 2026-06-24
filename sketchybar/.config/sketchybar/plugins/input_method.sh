#!/bin/bash

source "$CONFIG_DIR/colors.sh"

SELECTED_SOURCE="$(defaults read com.apple.HIToolbox AppleSelectedInputSources 2>/dev/null)"

case "$SELECTED_SOURCE" in
  *SCIM*|*TCIM*|*Squirrel*|*Rime*|*Pinyin*|*Shuangpin*|*Wubi*|*Zhuyin*|*Cangjie*|*Chinese*)
    LABEL="中文"
    COLOR=$RED
    ;;
  *)
    LABEL="EN"
    COLOR=$BLUE
    ;;
esac

sketchybar --set "$NAME" label="$LABEL" label.color="$COLOR"
