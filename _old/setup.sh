#!/bin/bash

repo="$(pwd)"
hostname="$(hostname)"


create_symlink() {
    local src="$1"
    local tar="$2"

    rm -rf "$tar"
    ln -s "$src" "$tar"
}

echo "Install configs for which terminal emulator?"
echo "[k]itty, [a]lacritty, [w]ezterm,  [all]"
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
    w)
        echo "Linking alacritty config"
        create_symlink "${repo}/wezterm" "${HOME}/.config/wezterm"
        ;;
    all)
        echo "Linking kitty + alacritty config"
        create_symlink "${repo}/kitty" "${HOME}/.config/kitty"
        create_symlink "${repo}/alacritty" "${HOME}/.config/alacritty"
        create_symlink "${repo}/wezterm" "${HOME}/.config/wezterm"
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
	# create_symlink "${repo}/hypr/modules/display-${hostname}.conf" "${HOME}/.config/hypr/display.conf"
	create_symlink "${repo}/hypr/modules/display-${hostname}.conf" "${HOME}/.config/hypr/modules/display.conf"
        echo "Linking waybar config"
        create_symlink "${repo}/waybar/hypr" "${HOME}/.config/waybar"
	create_symlink "${repo}/waybar/hypr/scripts/temps-${hostname}.sh" "${HOME}/.config/waybar/scripts/temps.sh"
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

echo "Install sway?"
echo "[y]es, [n]o"
read -r sway_choice
case "$sway_choice" in
    y)
        echo "Linking sway config"
        create_symlink "${repo}/sway" "${HOME}/.config/sway"
        create_symlink "${repo}/waybar/sway" "${HOME}/.config/waybar"
	create_symlink "${repo}/waybar/sway/scripts/temps-${hostname}.sh" "${HOME}/.config/waybar/scripts/temps.sh"
	# create_symlink "${repo}/hypr/modules/display-${hostname}.conf" "${HOME}/.config/hypr/display.conf"
        ;;
    n)
        # Do nothing for "no"
        ;;
esac

echo "Install nvim?"
echo "[y]es, [n]o"
read -r nvim_choice
case "$nvim_choice" in
    y)
	echo "Linking nvim config"
	create_symlink "${repo}/nvim" "${HOME}/.config/nvim"
        ;;
    n)
        # Do nothing for "no"
        ;;
esac

echo "Install zsh?"
echo "[y]es, [n]o"
read -r zsh_choice
case "$zsh_choice" in
    y)
	echo "Linking .zshrc"
	create_symlink "${repo}/.zshrc" "${HOME}/.zshrc"
        ;;
    n)
        # Do nothing for "no"
        ;;
esac
