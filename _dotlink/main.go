package main

import (
	"encoding/json"
	"fmt"
	"io"
	"os"
	"path/filepath"

	"github.com/charmbracelet/huh"
)

type Profiles struct {
	All     []string `json:"all"`
	Desktop []string `json:"desktop"`
	Work    []string `json:"work"`
}

func main() {
	profiles, err := os.Open("profiles.json")
	if err != nil {
		panic(fmt.Errorf("open file: %w", err))
	}
	defer profiles.Close()

	b, _ := io.ReadAll(profiles)
	var p Profiles

	err = json.Unmarshal(b, &p)
	if err != nil {
		panic(fmt.Errorf("unmarshaling: %w", err))
	}

	var (
		m    string
		home string = "/home/pldcanfly"
		repo string = "/home/pldcanfly/Projects/dotfiles"
	)

	form := huh.NewForm(
		huh.NewGroup(
			huh.NewSelect[string]().Title("Which machine are you on?").Options(
				huh.NewOption("Desktop", "desktop"),
				huh.NewOption("Work", "work"),
			).Value(&m),
			huh.NewInput().Title("Home directory").Value(&home),
			huh.NewInput().Title("dotfiles directory").Value(&repo),
		),
	)

	err = form.Run()
	if err != nil {
		panic(fmt.Errorf("form: %w", err))
	}

	fmt.Println(m)

	for _, dot := range p.All {
		install(dot, repo, home, m)
	}

	if m == "desktop" {
		for _, dot := range p.Desktop {
			install(dot, repo, home, m)
		}
	}

	if m == "work" {
		for _, dot := range p.Work {
			install(dot, repo, home, m)
		}
	}
}

func install(dot string, repo string, home string, machine string) {
	fmt.Println("Installing:", dot)
	switch dot {
	case "nvim":
		SymLink("nvim", ".config/nvim", repo, home)
	case "zsh":
		SymLink("zsh/.zshenv", ".zshenv", repo, home)

		MkDir(".config/zsh", home)
		SymLink("zsh/.zshrc", ".config/zsh/.zshrc", repo, home)
		SymLink("zsh/nvm", ".config/zsh/nvm", repo, home)

		SymLink("zsh/starship.toml", ".config/starship.toml", repo, home)
	case "tmux":
		MkDir(".config/tmux", home)
		SymLink("tmux/tmux.conf", ".config/tmux/tmux.conf", repo, home)
		SymLink("tmux/scripts", ".config/tmux/scripts", repo, home)

		MkDir(".config/tmux-sessionizer", home)
		SymLink(fmt.Sprintf("tmux/tmux-sessionizer.%s.conf", machine), ".config/tmux-sessionizer/tmux-sessionizer.conf", repo, home)
	case "alacritty":
		SymLink("alacritty", ".config/alacritty", repo, home)
	case "fontconfig":
		SymLink("fontconfig", ".config/fontconfig", repo, home)
	case "openrgb":
		SymLink("openrgb", ".config/OpenRGB", repo, home)
	case "easyeffects":
		SymLink("easyeffects", ".config/easyeffects", repo, home)
	case "rofi":
		SymLink("rofi", ".config/rofi", repo, home)
	case "niri":
		MkDir(".config/niri", home)
		SymLink(fmt.Sprintf("niri/config.%s.kdl", machine), ".config/niri/config.kdl", repo, home)
		SymLink("waybar", ".config/waybar", repo, home)
	}

}

func MkDir(dir string, home string) {

	err := os.MkdirAll(filepath.Join(home, dir), 0755)
	if err != nil {
		fmt.Printf("%s: %v\n", dir, err)
	}
}

func SymLink(source string, target string, repo string, home string) {

	fmt.Println("Linking", filepath.Join(repo, source), filepath.Join(home, target))
	err := os.RemoveAll(filepath.Join(home, target))
	if err != nil {
		fmt.Printf("removing: %s\n", err)
	}
	err = os.Symlink(filepath.Join(repo, source), filepath.Join(home, target))
	if err != nil {
		fmt.Printf("symlinking: %s\n", err)
	}
}
