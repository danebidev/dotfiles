#!/bin/bash

grim  -g "$(slurp -d)" - | wl-copy
mkdir -p ~/pictures/screenshot
wl-paste > ~/pictures/screenshots/screenshot_$(date -u +%Y%m%d-%H%M%S).png
