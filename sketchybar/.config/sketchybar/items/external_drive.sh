#!/bin/bash

# sketchybar -m --add event external_drive_update \
#               --add item external_drive right \
#               --set external_drive update_freq=30 \
#               --set external_drive script="~/.config/sketchybar/plugins/external_drive.sh" \
#               --set external_drive click_script="~/.config/sketchybar/plugins/external_drive_click.sh" \
#               --subscribe external_drive external_drive_update
#

sketchybar --add item external_drive right \
           --set external_drive \
                 update_freq=5 \
                 icon="􀤃" \
                 script="$PLUGIN_DIR/external_drive.sh" \
                 click_script="sketchybar --set external_drive popup.drawing=toggle" \
                 popup.align=right \
                 popup.height=30

sketchybar --add item external_drive.eject popup.external_drive \
           --set external_drive.eject \
                 icon="⏏" \
                 label="Eject Drive" \
                 click_script="$PLUGIN_DIR/external_drive_click.sh"
