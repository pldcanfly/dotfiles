#!/bin/sh

cpu_temp=$(sensors -u | grep "k10temp" -A 3 | grep "temp1_input" | awk '{printf "%.0f", $2}')
gpu_temp=$(sensors -u | grep "amdgpu-pci-0300" -A 9 | grep "temp1_input:" | awk '{printf "%.0f", $2}')

echo '{"text": "   '$cpu_temp'°  󰍹   '$gpu_temp'°", "class": "temps"}'
