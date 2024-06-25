#!/bin/bash

killall -q pipewire-pulse
killall -q pipewire
killall -q wireplumber

pipewire &
pipewire-pulse &
wireplumber &
