package handlers

import (
	"fmt"
	"os"
	"path/filepath"

	"github.com/pldcanfly/dotfiles/_themechanger/internal/builders"
	// "os"
	// "path/filepath"
)

type Handler struct {
	home     string
	repo     string
	theme    string
	computer string
}

func NewHandler(home string, repo string, theme string, computer string) (*Handler, error) {

	return &Handler{theme: theme, computer: computer, home: home, repo: repo}, nil
}

func (h *Handler) LinkWMs(wms []string) {
	fmt.Println("Window Managers:")

	for _, wm := range wms {
		fmt.Printf("- Linking %s\n", wm)

		if wm == "niri" {
			builders.BuildNiri(h.repo, h.computer, h.theme)
			h.SymLink("niri/config.kdl", ".config/niri/config.kdl")
		}

		if wm == "sway" {
			h.SymLink("sway", ".config/sway")
		}
	}
}

func (h *Handler) LinkTerminals(terminals []string) {
	fmt.Println("Terminals:")

	for _, t := range terminals {
		fmt.Printf("- Linking %s\n", t)

		if t == "kitty" {
			fmt.Println("NYI")
		}

		if t == "alacritty" {
			h.SymLink("alacritty", ".config/alacritty")
			h.SymLink(fmt.Sprintf("alacritty/themes/%s.toml", h.theme), ".config/alacritty/current.toml")
		}

		if t == "wezterm" {
			h.SymLink("wezterm", ".config/wezterm")
			h.SymLink(fmt.Sprintf("wezterm/themes/%s.lua", h.theme), ".config/wezterm/style.lua")
		}
	}
}

func (h *Handler) LinkLaunchers(launchers []string) {
	fmt.Println("Launchers:")

	for _, l := range launchers {
		fmt.Printf("- Linking %s\n", l)
	}
}

func (h *Handler) LinkNotifiers(notifiers []string) {
	fmt.Println("Launchers:")

	for _, n := range notifiers {
		fmt.Printf("- Linking %s\n", n)
	}
}

func (h *Handler) LinkMisc(misc []string) {
	fmt.Println("Misc:")

	for _, m := range misc {
		fmt.Printf("- Linking %s\n", m)
		if m == "nvim" {
			h.SymLink("nvim", ".config/nvim")
			h.SymLink(fmt.Sprintf("nvim/themes/%s.lua", h.theme), ".config/nvim/lua/plugins/style.lua")
			// Oh my posh?
		}

		if m == "zsh" {
			h.SymLink(".zshrc", ".zshrc")
			// Oh my posh?
		}
	}
}

func (h *Handler) SymLink(source string, target string) {

	fmt.Println("Linking", filepath.Join(h.repo, source), filepath.Join(h.home, target))
	err := os.RemoveAll(filepath.Join(h.home, target))
	if err != nil {
		fmt.Printf("removing: %s\n", err)
	}
	err = os.Symlink(filepath.Join(h.repo, source), filepath.Join(h.home, target))
	if err != nil {
		fmt.Printf("symlinking: %s\n", err)
	}
}
