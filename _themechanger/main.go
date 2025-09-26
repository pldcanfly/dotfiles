package main

import (
	"fmt"
	"log"
	"os"

	"github.com/charmbracelet/huh"
	"github.com/pldcanfly/dotfiles/_themechanger/internal/builders"
	"github.com/pldcanfly/dotfiles/_themechanger/internal/handlers"
)

func main() {
	args := os.Args[1:]
	if len(args) == 0 {
		c := builders.NewColorBuilder("gruvbox", "/home/pldcanfly/Projects/dotfiles")
		fmt.Println(c.ParseString("my bg1 is {{.bg}}"))
		tui()
	} else if args[0] == "build" {
		build(args)
	} else {
		// This should maybe be a help...
		fmt.Println("unknown build options")
	}
}

func build(args []string) {
	var (
		repo     string = "/home/pldcanfly/Projects/dotfiles"
		theme    string
		computer string
	)
	form := huh.NewForm(
		huh.NewGroup(
			huh.NewSelect[string]().Title("Which machine is this?").Options(
				huh.NewOption("Desktop", "desktop"),
				huh.NewOption("Private Laptop", "priv"),
				huh.NewOption("Work Laptop", "work"),
			).Value(&computer),
			huh.NewSelect[string]().Title("Choose your theming").Options(
				huh.NewOption("colorway", "colorway"),
				huh.NewOption("cobaltcarbon", "cobaltcarbon"),
				huh.NewOption("neocarbon", "neocarbon"),
				huh.NewOption("terafox", "terafox"),
				huh.NewOption("tokyonight_night", "tokyonight_night"),
				huh.NewOption("gruvbox", "gruvbox"),
			).Value(&theme),
			huh.NewInput().Title("dotfiles directory").Value(&repo),
		),
	)

	err := form.Run()
	if err != nil {
		log.Fatal(err)
	}

	if len(args) == 1 {
		// Build all
	} else {
		if args[1] == "niri" {
			err := builders.BuildNiri(repo, computer, theme)
			if err != nil {
				log.Fatalf("niri: %v", err)
			}
		}
	}
}

func tui() {
	var (
		home      string = "/home/pldcanfly"
		repo      string = "/home/pldcanfly/Projects/dotfiles"
		theme     string
		computer  string
		terminals []string
		notifiers []string
		misc      []string
		wms       []string
		launchers []string
	)

	form := huh.NewForm(

		huh.NewGroup(
			huh.NewSelect[string]().Title("Which machine is this?").Options(
				huh.NewOption("Desktop", "desktop"),
				huh.NewOption("Private Laptop", "priv"),
				huh.NewOption("Work Laptop", "work"),
			).Value(&computer),
			huh.NewInput().Title("Home directory").Value(&home),
			huh.NewInput().Title("dotfiles directory").Value(&repo),
			huh.NewSelect[string]().Title("Choose your theming").Options(
				huh.NewOption("colorway", "colorway"),
				huh.NewOption("cobaltcarbon", "cobaltcarbon"),
				huh.NewOption("neocarbon", "neocarbon"),
				huh.NewOption("terafox", "terafox"),
				huh.NewOption("tokyonight_night", "tokyonight_night"),
				huh.NewOption("gruvbox", "gruvbox"),
			).Value(&theme),
		),
		huh.NewGroup(
			huh.NewMultiSelect[string]().Title("Choose window managers").Options(
				huh.NewOption("Hyprland", "hypr"),
				huh.NewOption("Niri", "niri"),
				huh.NewOption("Sway", "sway"),
			).Value(&wms),
		),
		huh.NewGroup(
			huh.NewMultiSelect[string]().Title("Choose your terminals").Options(
				huh.NewOption("alacritty", "alacritty"),
				huh.NewOption("kitty", "kitty"),
				huh.NewOption("wezterm", "wezterm"),
			).Value(&terminals),
		),
		huh.NewGroup(
			huh.NewMultiSelect[string]().Title("Fancy a launcher?").Options(
				huh.NewOption("fuzzel", "fuzzel"),
				huh.NewOption("rofi", "rofi"),
				huh.NewOption("walker", "walker"),
				huh.NewOption("wofi", "wofi"),
			).Value(&launchers),
		),
		huh.NewGroup(
			huh.NewMultiSelect[string]().Title("Fancy a notifier?").Options(
				huh.NewOption("dunst", "dunst"),
				huh.NewOption("mako", "mako"),
			).Value(&notifiers),
		),

		huh.NewGroup(
			huh.NewMultiSelect[string]().Title("Misc Options").Options(
				huh.NewOption("nvim", "nvim"),
				huh.NewOption("OpenRGB", "openrgb"),
				huh.NewOption("tmux", "tmux"),
				huh.NewOption("cheatsheets", "cheatsheets"),
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

	h, err := handlers.NewHandler(home, repo, theme, computer)
	if err != nil {
		panic(err)
	}
	h.LinkTerminals(terminals)
	h.LinkWMs(wms)
	h.LinkNotifiers(notifiers)
	h.LinkLaunchers(launchers)
	h.LinkMisc(misc)

}
