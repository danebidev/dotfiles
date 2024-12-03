#!/bin/bash

mkdir -p ~/pictures/screenshots
hyprpicker -rz &
sleep 0.2

if [ $1 = "swappy" ]; then
    grim -g "$(slurp -d)" - | { pkill hyprpicker; swappy -f - -o - ; } | wl-copy
else
    grim -g "$(slurp -d)" - | wl-copy
    pkill hyprpicker
fi

wl-paste > ~/pictures/screenshots/screenshot_$(date -u +%Y%m%d-%H%M%S).png
