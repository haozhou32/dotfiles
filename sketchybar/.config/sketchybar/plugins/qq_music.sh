#􀒷􀒷!/bin/bash

if sketchybar --query default_menu_items | grep "$NAME" >>/dev/null; then
	sketchybar --set "$NAME" alias.scale=1 icon="" label="" label.padding_right=0
else
	sketchybar --set "$NAME" alias.scale=0 icon="􀒷" icon.font="SF Pro:Bold:13.0" label="" label.padding_right=0
fi
