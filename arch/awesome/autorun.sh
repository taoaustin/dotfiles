#!/bin/sh

run() {
  if ! pgrep -f "$1" ;
  then
    "$@"&
  fi
}

#run picom -b
run autorandr --change
run blueman-applet
#run pulseaudio &
