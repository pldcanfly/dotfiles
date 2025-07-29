package main

import (
	"log"

	"github.com/charmbracelet/huh"
	"github.com/pldcanfly/dotfiles/_themechanger/internal/handlers"
)

func main() {
	var (
		computer  string
		terminals []string
		theme     string
		misc      []string
		wms       []string
		home      string = "/home/pldcanfly"
	)

	form := huh.NewForm(

		huh.NewGroup(
			huh.NewSelect[string]().Title("Which machine is this?").Options(
				huh.NewOption("Desktop", "desktop"),
				huh.NewOption("Private Laptop", "priv"),
				huh.NewOption("Work Laptop", "work"),
			).Value(&computer),
			huh.NewInput().Title("Home directory").Value(&home),
		),
		huh.NewGroup(

			huh.NewSelect[string]().Title("Choose your themeing").Options(
				huh.NewOption("colorway", "colorway"),
				huh.NewOption("cobaltcarbon", "cobaltcarbon"),
				huh.NewOption("neocarbon", "neocarbon"),
				huh.NewOption("terafox", "terafox"),
				huh.NewOption("tokyonight_night", "tokyonight_night"),
				huh.NewOption("gruvbox", "gruvbox"),
			).Value(&theme),
		),
		huh.NewGroup(
			huh.NewMultiSelect[string]().Title("Choose Window Manager").Options(
				huh.NewOption("Hyprland", "hypr"),
				huh.NewOption("Sway", "sway"),
				huh.NewOption("Niri", "niri"),
			).Value(&wms),
		),
		huh.NewGroup(
			huh.NewMultiSelect[string]().Title("Choose your terminal").Options(
				huh.NewOption("kitty", "kitty"),
				huh.NewOption("alacritty", "alacritty"),
				huh.NewOption("wezterm", "wezterm"),
			).Value(&terminals),
		),
		huh.NewGroup(
			huh.NewMultiSelect[string]().Title("Misc Options").Options(
				huh.NewOption("nvim", "nvim"),
				huh.NewOption("OpenRGB", "openrgb"),
				huh.NewOption("tmux", "tmux"),
				huh.NewOption("easyeffects", "easyeffects"),
				huh.NewOption("easyeffects (Flatpak)", "easyeffectsflat"),
				huh.NewOption("zsh", "zsh"),
			).Value(&misc),
		),
	)

	err := form.Run()
	if err != nil {
		log.Fatal(err)
	}

	h := handlers.NewHandler(home, theme, computer)
	h.LinkTerminals(terminals)
	h.LinkWMs(wms)
	h.LinkMisc(misc)

}
