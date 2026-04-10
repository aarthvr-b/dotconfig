#!/usr/bin/env bash

set -euo pipefail

repo_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ignore_pattern='(^|/)(README\.md|install\.sh|\.gitignore|\.luarc\.json|\.DS_Store|.*\.bak|.*\.log|.*~)$'
backup_suffix=".pre-stow.$(date +%Y%m%d%H%M%S).bak"

check_for_transient_files() {
  local -a transient_files=()

  while IFS= read -r path; do
    transient_files+=("${path#"$repo_dir"/}")
  done < <(
    find "$repo_dir" \
      -path "$repo_dir/.git" -prune -o \
      -path "$repo_dir/.ruff_cache" -prune -o \
      \( -name '.DS_Store' -o -name '*.bak' -o -name '*.log' -o -name '*~' \) \
      -print
  )

  if [ "${#transient_files[@]}" -gt 0 ]; then
    printf 'Refusing to stow transient files from the repo:\n' >&2
    printf '  - %s\n' "${transient_files[@]}" >&2
    printf 'Remove them and run install.sh again.\n' >&2
    exit 1
  fi
}

backup_target() {
  local target="$1"

  if [ -L "$target" ] || [ ! -e "$target" ]; then
    return
  fi

  mv "$target" "${target}${backup_suffix}"
}

mkdir -p "$HOME/.config"
check_for_transient_files

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
