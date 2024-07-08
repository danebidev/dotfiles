#!/bin/bash

pkill -f xdg-desktop-portal-wlr
pkill -f xdg-desktop-portal-gtk
pkill -f xdg-desktop-portal

/usr/lib/xdg-desktop-portal-wlr &
/usr/lib/xdg-desktop-portal-gtk &
/usr/lib/xdg-desktop-portal &
