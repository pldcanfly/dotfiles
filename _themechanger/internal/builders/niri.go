package builders

import (
	"bytes"
	"fmt"
	"os"
	"path/filepath"
	"text/template"
)

func parse(path string, vars map[string]any) (string, error) {
	t, err := template.ParseFiles(path)
	if err != nil {
		return "", fmt.Errorf("parsing: %w", err)
	}

	// That pattern is way to repated... sort that out and make it a loop

	var buff bytes.Buffer
	if err = t.Execute(&buff, vars); err != nil {
		return "", fmt.Errorf("executing: %w", err)
	}
	return buff.String(), nil
}

func BuildNiri(repo string, computer string, theme string) error {
	base, err := template.ParseFiles(filepath.Join(repo, "niri/base.text.tmpl"))
	if err != nil {
		return fmt.Errorf("parsing base: %w", err)
	}

	vars := make(map[string]any)

	vars["Autostart"], err = parse(filepath.Join(repo, fmt.Sprintf("niri/autostart/%s.text.tmpl", computer)), vars)
	if err != nil {
		return fmt.Errorf("autostart: %w", err)
	}

	vars["Outputs"], err = parse(filepath.Join(repo, fmt.Sprintf("niri/outputs/%s.text.tmpl", computer)), vars)
	if err != nil {
		return fmt.Errorf("outputs: %w", err)
	}

	vars["Input"], err = parse(filepath.Join(repo, "niri/input.text.tmpl"), vars)
	if err != nil {
		return fmt.Errorf("input: %w", err)
	}

	vars["Binds"], err = parse(filepath.Join(repo, "niri/binds.text.tmpl"), vars)
	if err != nil {
		return fmt.Errorf("binds: %w", err)
	}

	// This needs theming!! Prolly some vars... key-value-stuff pretty much
	vars["Style"], err = parse(filepath.Join(repo, "niri/style.text.tmpl"), vars)
	if err != nil {
		return fmt.Errorf("style: %w", err)
	}

	vars["Windowrules"], err = parse(filepath.Join(repo, "niri/windowrules.text.tmpl"), vars)
	if err != nil {
		return fmt.Errorf("windowrules: %w", err)
	}

	// This can just fail .. not a biggie
	os.Remove(filepath.Join(repo, "niri/config.kdl"))

	f, err := os.Create(filepath.Join(repo, "niri/config.kdl"))
	if err != nil {
		return fmt.Errorf("creating new file: %w", err)
	}
	defer f.Close()

	base.Execute(f, vars)

	return nil
}
