#!/bin/sh

run() {
  if ! pgrep -f "$1" ;
  then
    "$@"&
  fi
}

# run picom -b
# run autorandr --change
# run blueman-applet
# run pasystray
/usr/local/libexec/pipewire-module-xrdp/load_pw_modules.sh
