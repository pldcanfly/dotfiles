#!/bin/sh

cpu_temp=$(sensors -u | grep "k10temp" -A 3 | grep "temp1_input" | awk '{printf "%.0f", $2}')

echo '{"text": " ' $cpu_temp'°", "class": "temps"}'
