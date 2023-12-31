#!/bin/sh

run() {
  if ! pgrep -f "$1" ;
  then
    "$@"&
  fi
}

run dex --environment Awesome --autostart
run picom -b --config ~/.config/picom/picom.conf
