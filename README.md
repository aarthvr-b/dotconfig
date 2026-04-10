# Dotconfig

My personal configuration files managed in a version-controlled repository.

This repo contains my core developer environment setup:

- **Neovim** (`~/.config/nvim`)
- **Ghostty** (`~/.config/ghostty`)
- **Tmux** (`~/.config/tmux`)
- **WezTerm** (`~/.config/wezterm`)
- **Zsh** (`~/.zshrc`)
- **Zk** (`~/.config/zk`)
- **Starship** (`~/.config/starship.toml`)
- **Brew** (`~/.config/BrewFile` for macOS packages)

All configs are stored here (`~/dotconfig`) and linked into `$HOME` with GNU Stow.

---

## Repo structure

```bash
📂 dotconfig/
├── 📁 .config/
│   ├── BrewFile         # 🍺 Homebrew packages
│   ├── 📁 ghostty/       # 👻 Ghostty terminal configuration
│   ├── 📁 nvim/          # 📝 Neovim configuration
│   ├── starship.toml     # 🚀 Starship prompt configuration
│   ├── 📁 tmux/          # 🖥️ Tmux configuration
│   ├── 📁 wezterm/       # 💻 WezTerm terminal configuration
│   └── 📁 zk/            # 🗒️ Zk configuration
├── .luarc.json          # Lua tooling configuration
├── .zshrc               # 🐚 Zsh run commands
├── ⚙️ install.sh        # Convenience wrapper around GNU Stow
└── 📘 README.md         # Project overview & setup instructions
```

---

## Installation

Clone the repo and use the [stow](https://www.gnu.org/software/stow/) wrapper for the first install:

```bash
git clone git@github.com:aarthvr-b/dotconfig.git ~/dotconfig
~/dotconfig/install.sh
```

That wrapper:

- Backs up conflicting real files or directories to `*.pre-stow.<timestamp>.bak`
- Refuses to run if the repo contains transient artifacts such as `*.bak` or `*.log`
- Runs GNU Stow against the repo root
- Leaves existing symlinks in place and refreshes them with `--restow`

For repeat runs, the equivalent raw Stow command is:

```bash
cd ~/dotconfig
stow --target="$HOME" --restow --ignore='^(README\.md|install\.sh|\.gitignore|\.luarc\.json)$' .
```

This will:

- Ensure `~/.config` exists
- Create symlinks from `~/dotconfig/.config/{BrewFile,ghostty,nvim,starship.toml,tmux,wezterm,zk}` → `~/.config/{BrewFile,ghostty,nvim,starship.toml,tmux,wezterm,zk}`
- Create a symlink from `~/dotconfig/.config/starship.toml` → `~/.config/starship.toml`
- Create a symlink from `~/dotconfig/.zshrc` → `~/.zshrc`
- Back up conflicting non-symlink targets before linking them
- Refresh existing symlinks if necessary

## Notes

- Stow is the only supported install path for this repo.
- `install.sh` is the safest first-run path because it handles pre-existing real files and directories.
- Running the command again is safe; `--restow` will refresh the links.
- If `install.sh` aborts because it found transient files, remove those repo-local artifacts before re-running it.
- On a new machine, bootstrap with:

```bash
git clone git@github.com:aarthvr-b/dotconfig.git ~/dotconfig
~/dotconfig/install.sh
```

- BrewFile can be used with `brew bundle install` to install listed packages.

---

## License

This repo is shared for educational and personal purposes.
Feel free to adapt it to your own workflow!.
