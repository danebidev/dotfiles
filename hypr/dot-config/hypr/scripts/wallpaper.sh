#!/bin/bash

if pgrep -f "$0" > /dev/null; then
    exit
fi

# Edit below to control the images transition
export SWWW_TRANSITION_FPS=165
export SWWW_TRANSITION_STEP=2
export SWWW_TRANSITION_TYPE=random

# This controls (in seconds) when to switch to the next image
INTERVAL=600

while true; do
	find "$DOTFILES/wallpapers/" \
		| while read -r img; do
			echo "$((RANDOM % 1000)):$img"
		done \
		| sort -n | cut -d':' -f2- \
		| while read -r img; do
            if [[ "$img" != "$1" ]]; then
			    swww img "$img"
			    sleep $INTERVAL
            fi 
		done
done
