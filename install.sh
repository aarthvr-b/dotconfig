#!/usr/bin/env bash

set -e

echo "🔗 Creating symlinks for dotconfig..."

mkdir -p ~/.config

ln -sf ~/dotconfig/nvim ~/.config/nvim
ln -sf ~/dotconfig/wezterm ~/.config/wezterm
ln -sf ~/dotconfig/zsh ~/.config/zsh

echo "✅ All symlinks created successfully!"
