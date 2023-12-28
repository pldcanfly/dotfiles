#!/bin/bash

repo="$(pwd)"

rm -rf "${HOME}/.config/alacritty"
ln -s "${repo}/alacritty" "${HOME}/.config/alacritty"

rm -rf "${HOME}/.config/nnn"
ln -s "${repo}/nnn" "${HOME}/.config/nnn"

rm -rf "${HOME}/.config/nvim"
ln -s "${repo}/nvim" "${HOME}/.config/nvim"

rm -rf "${HOME}/.config/OpenRGB"
ln -s "${repo}/OpenRGB" "${HOME}/.config/OpenRGB"

rm -rf "${HOME}/.config/tmux"
ln -s "${repo}/tmux" "${HOME}/.config/tmux"

rm -rf "${HOME}/.zshrc"
ln -s "${repo}/.zshrc" "${HOME}/.zshrc"
