#!/bin/bash

menu="$1"

if [ "$menu" = "powermenu" ]; then
    rofi -modi 'Powermenu:~/.config/rofi/rofi-powermenu.sh' -show Powermenu -theme powermenu
#    rofi -modi 'Powermenu:~/Scripts/rofi/rofi-powermenu.sh' -show Powermenu -theme powermenu -location 3 -xoffset -24 -yoffset 70
fi
