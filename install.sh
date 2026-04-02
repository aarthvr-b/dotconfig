#!/usr/bin/env bash

set -euo pipefail

repo_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ignore_pattern='^(README\.md|install\.sh|\.gitignore|\.luarc\.json)$'
backup_suffix=".pre-stow.$(date +%Y%m%d%H%M%S).bak"

backup_target() {
  local target="$1"

  if [ -L "$target" ] || [ ! -e "$target" ]; then
    return
  fi

  mv "$target" "${target}${backup_suffix}"
}

mkdir -p "$HOME/.config"

backup_target "$HOME/.config/BrewFile"
backup_target "$HOME/.config/ghostty"
backup_target "$HOME/.config/nvim"
backup_target "$HOME/.config/starship.toml"
backup_target "$HOME/.config/tmux"
backup_target "$HOME/.config/wezterm"
backup_target "$HOME/.config/zk"
backup_target "$HOME/.zshrc"

stow \
  --dir="$repo_dir" \
  --target="$HOME" \
  --restow \
  --ignore="$ignore_pattern" \
  .
