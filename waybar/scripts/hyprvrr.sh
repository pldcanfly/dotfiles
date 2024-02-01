#!/bin/bash

# vrr=$(hyprctl getoption misc:vrr | grep int | awk '{printf "%.0f", $2}');
vrr=$(hyprctl getoption misc:vrr | awk '/int:/ {gsub(/[^0-9]/, "", $2); printf "%.0f", $2}')

if [ "$vrr" -eq 0 ]; then
	status="Off"
else
	status="On"
fi

echo '{"text": "󱎴    '$status'", "class": "hyprvrr"}'
