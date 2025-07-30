package builders

import (
	"bytes"
	"fmt"
	"os"
	"path/filepath"
	"text/template"
)

func BuildNiri(repo string, computer string, theme string) error {
	base, err := template.ParseFiles(filepath.Join(repo, "niri/base.text.tmpl"))
	if err != nil {
		return fmt.Errorf("parsing base: %w", err)
	}

	vars := make(map[string]any)

	as, err := template.ParseFiles(filepath.Join(repo, fmt.Sprintf("niri/autostart/%s.text.tmpl", computer)))
	if err != nil {
		return fmt.Errorf("parsing autostart: %w", err)
	}

	var asbuff bytes.Buffer
	if err = as.Execute(&asbuff, vars); err != nil {
		return fmt.Errorf("executing autostart: %w", err)
	}
	vars["Autostart"] = asbuff.String()

	o, err := template.ParseFiles(filepath.Join(repo, fmt.Sprintf("niri/outputs/%s.text.tmpl", computer)))
	if err != nil {
		return fmt.Errorf("parsing outputs: %w", err)
	}

	var obuff bytes.Buffer
	if err = o.Execute(&obuff, vars); err != nil {
		return fmt.Errorf("executing outputs: %w", err)
	}
	vars["Outputs"] = obuff.String()

	i, err := template.ParseFiles(filepath.Join(repo, "niri/input.text.tmpl"))
	if err != nil {
		return fmt.Errorf("parsing input: %w", err)
	}
	var ibuff bytes.Buffer
	if err = i.Execute(&ibuff, vars); err != nil {
		return fmt.Errorf("executing input: %w", err)
	}
	vars["Input"] = ibuff.String()

	b, err := template.ParseFiles(filepath.Join(repo, "niri/binds.text.tmpl"))
	if err != nil {
		return fmt.Errorf("parsing binds: %w", err)
	}
	var bbuff bytes.Buffer
	if err = b.Execute(&bbuff, vars); err != nil {
		return fmt.Errorf("executing binds: %w", err)
	}
	vars["Binds"] = bbuff.String()

	// This needs theming!!
	s, err := template.ParseFiles(filepath.Join(repo, "niri/style.text.tmpl"))
	if err != nil {
		return fmt.Errorf("parsing style: %w", err)
	}
	var sbuff bytes.Buffer
	if err = s.Execute(&sbuff, vars); err != nil {
		return fmt.Errorf("executing style: %w", err)
	}
	vars["Style"] = sbuff.String()

	wr, err := template.ParseFiles(filepath.Join(repo, "niri/windowrules.text.tmpl"))
	if err != nil {
		return fmt.Errorf("parsing windowrules: %w", err)
	}
	var wrbuff bytes.Buffer
	if err = wr.Execute(&obuff, vars); err != nil {
		return fmt.Errorf("executing windowrules: %w", err)
	}
	vars["Windowrules"] = wrbuff.String()

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
