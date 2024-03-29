#!/usr/bin/env sh

set -e

all_sinks=$(pactl list short sinks | cut -f 2)

default_sink=$(pactl get-default-sink)

active_sink=$(echo "$all_sinks" | grep -n $default_sink | cut -d : -f 1)

selected_sink=$(echo "$all_sinks" | rofi -dmenu -i -a $(($active_sink - 1)) -p 'Select a device: ')

pactl set-default-sink $selected_sink
