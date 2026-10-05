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

# A real (non-symlink) ~/.claude/CLAUDE.md means this machine keeps its own
# Claude setup (work PC): leave ~/.claude and ~/.agents alone.
if [ -f "$HOME/.claude/CLAUDE.md" ] && [ ! -L "$HOME/.claude/CLAUDE.md" ]; then
  printf 'Local ~/.claude detected; skipping .claude and .agents.\n'
  ignore_pattern="${ignore_pattern}|(^|/)\.(claude|agents)$"
else
  # Real directories so stow links individual entries instead of folding ~/.claude
  # and ~/.agents into the repo, where agents would write their runtime state.
  # The skills directories are the exception: they are linked whole, so that
  # `npx skills add -g` writes new skills straight into the repo.
  mkdir -p "$HOME/.claude" "$HOME/.agents"
  backup_target "$HOME/.agents/.skill-lock.json"
  backup_target "$HOME/.agents/skills"
  backup_target "$HOME/.claude/AGENTS.md"
  backup_target "$HOME/.claude/CLAUDE.md"
  backup_target "$HOME/.claude/settings.json"
  backup_target "$HOME/.claude/skills"
fi

backup_target "$HOME/.config/BrewFile"
backup_target "$HOME/.config/ghostty"
backup_target "$HOME/.config/nvim"
backup_target "$HOME/.config/starship.toml"
backup_target "$HOME/.config/wezterm"
backup_target "$HOME/.config/zk"
backup_target "$HOME/.editorconfig"
backup_target "$HOME/.zshrc"

stow \
  --dir="$repo_dir" \
  --target="$HOME" \
  --restow \
  --ignore="$ignore_pattern" \
  .
