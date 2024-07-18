#!/bin/bash

sleep 0.2
grim  -g "$(slurp -d)" - | wl-copy && pkill hyprpicker
mkdir -p ~/pictures/screenshot
wl-paste > ~/pictures/screenshots/screenshot_$(date -u +%Y%m%d-%H%M%S).png
