#!/usr/bin/env bash

DIR="$HOME/.cheatsheets"

if [[ ! -d "$DIR" ]]; then
   echo "No such directory: $DIR"
   exit 1
fi

open_cheatsheet() {
   local path="$1"

   if [[ ! -f "$path" ]]; then
      echo "File not found: $path"
      exit 1
   fi

   vi "$path"
   exit $?
}

if [[ -n "$1" ]]; then
   open_cheatsheet "$DIR/$1"
else
   selected=$(printf "%s\n" "$DIR"/* | fzf --header "Select Cheatsheet")
   # selected=$(find "$DIR" -type f -maxdepth 1 | fzf --header "Cheatsheets" --preview-window=right,60% --preview="cat {}")

   if [[ -n "$selected" ]]; then
      open_cheatsheet "$selected"
   fi

   exit 1
fi
