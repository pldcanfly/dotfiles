#!/bin/bash


toggle() {
    current_value=$(hyprctl getoption misc:vrr | awk '/int:/ {gsub(/[^0-9]/, "", $2); printf "%.0f", $2}')
    # Toggle the value
    if [ "$current_value" -eq 0 ]; then
        hyprctl keyword misc:vrr 2
    else
        hyprctl keyword misc:vrr 0
    fi
}

set() {
	hyprctl keyword misc:vrr "$1"
}

if [ "$1" == "toggle" ]; then
	toggle
else
	set "$1"
fi


pkill -RTMIN+12 waybar
