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
			h.SymLink("wms/niri/config.kdl", ".config/niri/config.kdl")

			h.MkDir(".config/waybar")
			h.SymLink("misc/waybar/niri/config.jsonc", ".config/waybar/config.niri.jsonc")
			h.SymLink(fmt.Sprintf("misc/waybar/themes/%s.css", h.theme), ".config/waybar/style.css")
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
			h.SymLink("terminals/alacritty", ".config/alacritty")
			h.SymLink(fmt.Sprintf("terminals/alacritty/themes/%s.toml", h.theme), ".config/alacritty/current.toml")
		}

		if t == "wezterm" {
			h.SymLink("terminals/wezterm", ".config/wezterm")
			h.SymLink(fmt.Sprintf("terminals/wezterm/themes/%s.lua", h.theme), ".config/wezterm/style.lua")
		}
	}
}

func (h *Handler) LinkLaunchers(launchers []string) {
	fmt.Println("Launchers:")

	for _, l := range launchers {
		fmt.Printf("- Linking %s\n", l)
		if l == "rofi" {
			h.MkDir(".config/rofi")
			h.SymLink("launchers/rofi/config.rasi", ".config/rofi/config.rasi")
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
			h.SymLink("misc/fontconfig", ".config/fontconfig")
		}

		if m == "nvim" {
			h.SymLink("misc/nvim", ".config/nvim")
			h.SymLink(fmt.Sprintf("misc/nvim/themes/%s.lua", h.theme), ".config/nvim/lua/plugins/style.lua")
		}

		if m == "zsh" {
			h.SymLink("misc/zsh/.zshenv", ".zshenv")

			h.MkDir(".config/zsh")
			h.SymLink("misc/zsh/.zshrc", ".config/zsh/.zshrc")
			h.SymLink("misc/zsh/nvm", ".config/zsh/nvm")

			h.SymLink("misc/zsh/starship.toml", ".config/starship.toml")
		}

		if m == "tmux" {
			h.MkDir(".config/tmux")
			h.SymLink("misc/tmux/tmux.conf", ".config/tmux/tmux.conf")
			h.SymLink(fmt.Sprintf("misc/tmux/themes/%s.conf", h.theme), ".config/tmux/current.conf")
			h.SymLink("misc/tmux/scripts", ".config/tmux/scripts")

			h.MkDir(".config/tmux-sessionizer")
			h.SymLink(fmt.Sprintf("misc/tmux/tmux-sessionizer.%s.conf", h.computer), ".config/tmux-sessionizer/tmux-sessionizer.conf")
		}

		if m == "easyeffects" {
			h.MkDir(".config/easyeffects")
			h.SymLink("misc/easyeffects", ".config/easyeffects")
		}

		if m == "cheatsheets" {
			h.MkDir(".cheatsheets")
			h.SymLink("cheatsheets", ".cheatsheets")
		}
	}
}

func (h *Handler) MkDir(dir string) {

	err := os.MkdirAll(filepath.Join(h.home, dir), 0755)
	if err != nil {
		fmt.Printf("%s: %v\n", dir, err)
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
