#!/bin/sh

# Keyboard delay
xset r rate 300 100

/usr/bin/pipewire &
/usr/bin/pipewire-pulse &
/usr/bin/wireplumber &

exec i3
