#!/usr/bin/env bash

# This script gets the current pane's path and removes the $HOME prefix.

HOME_DIR="$HOME"

current_path=$(tmux display-message -p '#{pane_current_path}')

echo "${current_path#$HOME_DIR/}"
