#!/usr/bin/env bash

set -e

echo "🔗 Creating symlinks for dotconfig..."

mkdir -p ~/.config

ln -sf ~/dotconfig/.config/nvim ~/.config/nvim
ln -sf ~/dotconfig/.config/wezterm ~/.config/wezterm
ln -sf ~/dotconfig/.config/zsh ~/.config/zsh

echo "✅ All symlinks created successfully!"
