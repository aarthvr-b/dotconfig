#!/usr/bin/env bash

set -e

echo "🔗 Creating symlinks for dotconfig..."

mkdir -p ~/.config

ln -sf ~/dotconfig/.config/ghostty ~/.config/ghostty
ln -sf ~/dotconfig/.config/nvim ~/.config/nvim
ln -sf ~/dotconfig/.config/tmux ~/.config/tmux
ln -sf ~/dotconfig/.config/wezterm ~/.config/wezterm
ln -sf ~/dotconfig/.config/zsh ~/.config/zsh
ln -sf ~/dotconfig/.config/starship.toml ~/.config/starship.toml
ln -sf ~/dotconfig/.zshrc ~/.zshrc

echo "✅ All symlinks created successfully!"
