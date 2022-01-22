#!/usr/bin/env sh

## Add this to your wm startup file.

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch transparent bars
# polybar bottombar -c ~/.config/polybar/config.nord.simple.color.ini &
polybar topbar -c ~/.config/polybar/config.nord.simple.color.detached.ini &
