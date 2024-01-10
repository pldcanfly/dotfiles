#!/bin/bash


themes=("colorway", "cobaltcarbon")

repo="$(pwd)"

create_symlink() {
    local src="$1"
    local tar="$2"

    rm -rf "$tar"
    ln -s "$src" "$tar"
}
        

link_themes(){
    local sel="${themes[$1-1]}"


    echo "Linking waybar"
    create_symlink "${repo}/waybar/themes/$sel.json" "${repo}/waybar/themes/current.json"
    create_symlink "${repo}/waybar/themes/$sel.css" "${repo}/waybar/style.css"
   
    echo "Linking wofi"
    create_symlink "${repo}/wofi/themes/$sel.css" "${repo}/wofi/style.css"
    
    echo "Linking hyprland"
    create_symlink "${repo}/hypr/themes/$sel.conf" "${repo}/hypr/themes/current.conf"
    hyprctl reload > /dev/null
    
    echo "Theme '$sel' applied!" 
}

echo "Choose a theme:"

for ((i=0; i<${#themes[@]}; i++)); do
     echo "$((i+1)). ${themes[i]}"
done


read -p "?: " choice

if [[ "$choice" =~ ^[0-9]+$ && "$choice" -ge 1 && "$choice" -le ${#themes[@]} ]]; then
    link_themes "$choice"
else
    echo "Invalid choice"
fi
