#!/bin/bash


themes=("colorway" "cobaltcarbon" "neocarbon" "terafox" "tokyonight_night" "gruvbox")

repo="$(pwd)"
echo ${HOME}


create_symlink() {
    local src="$1"
    local tar="$2"

    # echo $1
    # echo $2 

    rm -rf "$tar"
    ln -s "$src" "$tar"
}
        

link_themes(){
    local sel="${themes[$1-1]}"


    # echo "Linking waybar"
    # create_symlink "${repo}/waybar/themes/$sel.json" "${HOME}/.config/waybar/themes/current.json"
    # create_symlink "${repo}/waybar/themes/$sel.css" "${HOME}/.config/waybar/style.css"
   # 
   #  echo "Linking wofi"
   #  create_symlink "${repo}/wofi/themes/$sel.css" ".config/wofi/style.css"
   #  
    # echo "Linking hyprland"
    # create_symlink "${repo}/hypr/themes/$sel.conf" "${HOME}/.config/hypr/themes/current.conf"
    # hyprctl reload > /dev/null
   #
    # echo "Linking Tmux - ${repo}/tmux/themes/$sel.conf"
    # create_symlink "${repo}/tmux/themes/$sel.conf" "${HOME}/.config/tmux/themes/current.conf"
    echo "Linking wezterm - ${repo}/wezterm/themes/$sel.lua"
    create_symlink "${repo}/wezterm/themes/$sel.lua" "${HOME}/.config/wezterm/style.lua"
   
    echo "Linking Oh-My-Posh - ${repo}/ohmyposh/themes/$sel.json"
    create_symlink "${repo}/ohmyposh/themes/$sel.json" "${HOME}/.config/omp.json"

    echo "Linking Nvim - ${repo}/nvim/themes/$sel.lua"
    create_symlink "${repo}/nvim/themes/$sel.lua" "${HOME}/.config/nvim/lua/plugins/style.lua"

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
