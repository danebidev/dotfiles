#!/bin/sh

run() {
  if ! pgrep -f "$1" ;
  then
    "$@"&
  fi
}

run dex --environment Awesome --autostart
# Getting some problems with picom, so I'm not running it for now
# run picom -b --config ~/.config/picom/picom.conf
