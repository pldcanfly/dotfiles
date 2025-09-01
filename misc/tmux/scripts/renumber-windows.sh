#!/usr/bin/env bash

# Selective window renumbering for tmux
# Only renumbers windows 1-60, preserving higher-numbered windows

# Get current window list
windows=$(tmux list-windows -F "#{window_index}:#{window_name}")

# Arrays to hold windows to renumber and preserve
declare -a to_renumber=()
declare -a to_preserve=()

# Separate windows into two groups
while IFS=: read -r index name; do
    if [[ $index -le 60 ]]; then
        to_renumber+=("$index:$name")
    else
        to_preserve+=("$index:$name")
    fi
done <<< "$windows"

# If no windows to renumber, exit
if [[ ${#to_renumber[@]} -eq 0 ]]; then
    echo "No windows 1-60 to renumber"
    exit 0
fi

# Sort windows to renumber by index
IFS=$'\n' sorted=($(sort -t: -k1n <<<"${to_renumber[*]}"))
unset IFS

# Calculate new indices (1, 2, 3, ...)
new_index=1
declare -a moves=()

for window in "${sorted[@]}"; do
    old_index=$(echo "$window" | cut -d: -f1)
    name=$(echo "$window" | cut -d: -f2-)

    # Only move if index actually changes
    if [[ $old_index -ne $new_index ]]; then
        moves+=("$old_index:$new_index:$name")
    fi

    ((new_index++))
done

# Execute moves in reverse order to avoid conflicts
for ((i=${#moves[@]}-1; i>=0; i--)); do
    IFS=: read -r old_index new_index name <<< "${moves[i]}"
    tmux move-window -s "$old_index" -t "$new_index"
    echo "Moved window $old_index ($name) to $new_index"
done

echo "Renumbered ${#moves[@]} windows (1-60 range)"
