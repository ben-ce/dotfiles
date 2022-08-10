#!/bin/bash


if [ -z "$@" ]; then
    echo -en "Shutdown\0icon\x1fsystem-shutdown\n"
    echo -en "Logout\0icon\x1fsystem-log-out\n"
    echo -en "Suspend\0icon\x1fsystem-suspend\n"
    echo -en "Reboot\0icon\x1fsystem-restart\n"
else
    if [ "$1" = "Shutdown" ]; then
        systemctl poweroff
    elif [ "$1" = "Logout" ]; then
       	if [[ "$DESKTOP_SESSION" == "Openbox" ]]; then
				    openbox --exit
			  elif [[ "$DESKTOP_SESSION" == "bspwm" ]]; then
    				bspc quit
	  		elif [[ "$DESKTOP_SESSION" == "i3" ]]; then
    				i3-msg exit
  			elif [[ "$DESKTOP_SESSION" == "awesome" ]]; then
    				awesome-client "awesome.quit()"
  			fi
    elif [ "$1" = "Reboot" ]; then
        reboot
    elif [ "$1" = "Suspend" ]; then
        systemctl suspend
    fi
fi
