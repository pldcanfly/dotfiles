package handlers

import (
	"fmt"
	// "os"
	// "path/filepath"
)

type Handler struct {
	home     string
	theme    string
	computer string
}

func NewHandler(home string, theme string, computer string) *Handler {
	// err := os.Symlink(filepath.Join(home, ".zshrc"), filepath.Join(home, "test"))
	// fmt.Println(err)
	return &Handler{theme: theme, computer: computer, home: home}
}

func (h *Handler) LinkWMs(wms []string) {
	fmt.Println("Window Managers:")
	for _, wm := range wms {
		fmt.Printf("- Linking %s\n", wm)
	}

}

func (h *Handler) LinkTerminals(terminals []string) {}

func (h *Handler) LinkMisc(misc []string) {}
