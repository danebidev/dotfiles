#!/bin/bash

hyprpicker -rz &
sleep 0.1
grim -g "$(slurp)" - | wl-copy && pkill hyprpicker
wl-paste > ~/pictures/screenshots/$(date -u +%Y%m%d-%H%M%S).png
