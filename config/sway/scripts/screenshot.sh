#!/bin/bash

hyprpicker -rz &
sleep 0.2
grim  -g "$(slurp -d)" - | wl-copy && pkill hyprpicker
mkdir -p ~/pictures/screenshots
wl-paste > ~/pictures/screenshots/screenshot_$(date -u +%Y%m%d-%H%M%S).png
