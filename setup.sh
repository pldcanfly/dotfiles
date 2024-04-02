#!/bin/bash

repo="$(pwd)"


create_symlink() {
    local src="$1"
    local tar="$2"

    rm -rf "$tar"
    ln -s "$src" "$tar"
}

echo "Install configs for which terminal emulator?"
echo "[k]itty, [a]lacritty, [all]"
read -r choice
case "$choice" in
    k)
        echo "Linking kitty config"
        create_symlink "${repo}/kitty" "${HOME}/.config/kitty"
        ;;
    a)
        echo "Linking alacritty config"
        create_symlink "${repo}/alacritty" "${HOME}/.config/alacritty"
        create_symlink "${repo}/tmux" "${HOME}/.config/tmux"
        ;;
    all)
        echo "Linking kitty + alacritty config"
        create_symlink "${repo}/kitty" "${HOME}/.config/kitty"
        create_symlink "${repo}/alacritty" "${HOME}/.config/alacritty"
        create_symlink "${repo}/tmux" "${HOME}/.config/tmux"
        ;;
esac

echo "Install OpenRGB?"
echo "[y]es, [n]o"
read -r openrgb_choice
case "$openrgb_choice" in
    y)
        echo "Linking OpenRGB config"
        create_symlink "${repo}/OpenRGB" "${HOME}/.config/OpenRGB"
        ;;
    n)
        # Do nothing for "no"
        ;;
esac

echo "Install EasyEffects Presets?"
echo "n[a]tive, [f]latpak, [n]o"
read -r easyeffects_choice
case "$easyeffects_choice" in
    a)
        # Native version
        echo "Linking EasyEffects native config"
        create_symlink "${repo}/easyeffects/config" "${HOME}/.config/easyeffects"
        ;;
    f)

        # Flatpak .var/app/com.github.wwmm.easyeffects/config
        echo "Linking EasyEffects flatpak config"
        echo -e "\033[0;31mDO NOT FORGET TO ALLOW ACCESS!\033[0m"
        create_symlink "${repo}/easyeffects/config" "${HOME}/.var/app/com.github.wwmm.easyeffects/config"
        ;;
    n)
        # Do nothing for "no"
        ;;
esac


echo "Install Hyprland?"
echo "[y]es, [n]o"
read -r hyprland_choice
case "$hyprland_choice" in
    y)
        echo "Linking hyprland config"
        create_symlink "${repo}/hypr" "${HOME}/.config/hypr"
        echo "Linking waybar config"
        create_symlink "${repo}/waybar" "${HOME}/.config/waybar"
        echo "Linking wofi config"
        create_symlink "${repo}/wofi" "${HOME}/.config/wofi"
        echo "Linking colors config"
        create_symlink "${repo}/colors.css" "${HOME}/.config/colors.colors.css"
        echo "Linking dunst config"
        create_symlink "${repo}/dunst" "${HOME}/.config/dunst"
        ;;
    n)
        # Do nothing for "no"
        ;;
esac

echo "Linking nnn config"
create_symlink "${repo}/nnn" "${HOME}/.config/nnn"
echo "Linking nvim config"
create_symlink "${repo}/nvim" "${HOME}/.config/nvim"
echo "Linking .zshrc"
create_symlink "${repo}/.zshrc" "${HOME}/.zshrc"
