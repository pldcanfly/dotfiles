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
			h.MkDir(".config/niri")

			builders.BuildNiri(h.repo, h.computer, h.theme)
			h.SymLink("niri/config.kdl", ".config/niri/config.kdl")

			h.MkDir(".config/waybar")
			h.SymLink("waybar/niri/config.jsonc", ".config/waybar/config.niri.jsonc")
			h.SymLink(fmt.Sprintf("waybar/themes/%s.css", h.theme), ".config/waybar/style.css")
		}

		if wm == "sway" {
			h.SymLink("wms/sway", ".config/sway")

			h.MkDir(".config/waybar")
			h.SymLink("misc/waybar/sway/config.jsonc", ".config/waybar/config.jsonc")
			h.SymLink(fmt.Sprintf("misc/waybar/themes/%s.css", h.theme), ".config/waybar/style.css")
		}

		if wm == "hypr" {
			h.MkDir(".config/hypr")

			h.SymLink("wms/hypr/hyprland.conf", ".config/hypr/hyprland.conf")
			h.SymLink("wms/hypr/config", ".config/hypr/config")
			h.SymLink(fmt.Sprintf("wms/hypr/themes/%s.conf", h.theme), ".config/hypr/current.conf")
			h.SymLink(fmt.Sprintf("wms/hypr/monitors/monitor.%s.conf", h.computer), ".config/hypr/monitor.conf")

			h.MkDir(".config/waybar")
			h.SymLink(fmt.Sprintf("misc/waybar/hypr/config.%s.jsonc", h.computer), ".config/waybar/config")
			h.SymLink(fmt.Sprintf("misc/waybar/themes/%s.css", h.theme), ".config/waybar/style.css")
			h.SymLink("misc/waybar/scripts/", ".config/waybar/scripts")
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
		}

		if t == "wezterm" {
			h.SymLink("wezterm", ".config/wezterm")
		}
	}
}

func (h *Handler) LinkLaunchers(launchers []string) {
	fmt.Println("Launchers:")

	for _, l := range launchers {
		fmt.Printf("- Linking %s\n", l)
		if l == "rofi" {
			h.SymLink("rofi", ".config/rofi")
		}
	}
}

func (h *Handler) LinkNotifiers(notifiers []string) {
	fmt.Println("Notifiers:")

	for _, n := range notifiers {
		fmt.Printf("- Linking %s\n", n)

		if n == "mako" {
			h.MkDir(".config/mako")
			h.SymLink(fmt.Sprintf("notifiers/mako/themes/%s", h.theme), ".config/mako/config")
		}
	}
}

func (h *Handler) LinkMisc(misc []string) {
	fmt.Println("Misc:")

	for _, m := range misc {
		fmt.Printf("- Linking %s\n", m)

		if m == "fontconfig" {
			h.SymLink("fontconfig", ".config/fontconfig")
		}

		if m == "nvim" {
			h.SymLink("nvim", ".config/nvim")
			h.SymLink(fmt.Sprintf("nvim/themes/%s.lua", h.theme), ".config/nvim/lua/plugins/style.lua")
		}

		if m == "zsh" {
			h.SymLink("zsh/.zshenv", ".zshenv")

			h.MkDir(".config/zsh")
			h.SymLink("zsh/.zshrc", ".config/zsh/.zshrc")
			h.SymLink("zsh/nvm", ".config/zsh/nvm")

			h.SymLink("zsh/starship.toml", ".config/starship.toml")
		}

		if m == "tmux" {
			h.MkDir(".config/tmux")
			h.SymLink("tmux/tmux.conf", ".config/tmux/tmux.conf")
			h.SymLink(fmt.Sprintf("tmux/themes/%s.conf", h.theme), ".config/tmux/current.conf")
			h.SymLink("tmux/scripts", ".config/tmux/scripts")

			h.MkDir(".config/tmux-sessionizer")
			h.SymLink(fmt.Sprintf("tmux/tmux-sessionizer.%s.conf", h.computer), ".config/tmux-sessionizer/tmux-sessionizer.conf")
		}

		if m == "easyeffects" {
			h.MkDir(".config/easyeffects")
			h.SymLink("easyeffects", ".config/easyeffects")
		}

	}
}
