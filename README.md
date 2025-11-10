# Dotconfig

My personal configuration files managed in a version-controlled repository.

This repo contains my core developer environment setup:

- **Neovim** (`~/.config/nvim`)
- **WezTerm** (`~/.config/wezterm`)
- **Zsh** (`~/.zshrc` and `~/.config/zsh`)
- **Ghostty** (`~/.config/ghostty`)
- **Tmux** (`~/.config/tmux`)
- **Starship** (`~/.config/starship.toml`)
- **Brew** (`BrewFile` for macOS packages)

All configs are stored here (`~/dotconfig`) and linked to their expected locations using a simple install script.

---

## Repo structure

```bash
📂 dotconfig/
├── 📁 .config/
│   ├── 📁 ghostty/       # 👻 Ghostty terminal configuration
│   ├── 📁 nvim/          # 📝 Neovim configuration
│   ├── 📁 tmux/          # 🖥️ Tmux configuration
│   ├── 📁 wezterm/       # 💻 WezTerm terminal configuration
│   ├── 📁 zsh/           # 🐚 Zsh shell configuration
│   └── starship.toml     # 🚀 Starship prompt configuration
├── BrewFile             # 🍺 Homebrew packages
├── .zshrc               # 🐚 Zsh run commands
├── ⚙️ install.sh        # Cross-platform installer for macOS/Linux/WSL
└── 📘 README.md         # Project overview & setup instructions
```

---

## Installation

Clone the repo and run the shell installer

```bash
git clone git@github.com:aarthvr-b/dotconfig.git ~/dotconfig
cd ~/dotconfig
chmod +x install.sh
./install.sh
```

This will:

- Ensure `~/.config` exists
- Create sym links from `~/dotconfig/.config/{ghostty,nvim,tmux,wezterm,zsh}` → `~/.config/{ghostty,nvim,tmux,wezterm,zsh}`
- Create sym link for `~/dotconfig/.config/starship.toml` → `~/.config/starship.toml`
- Create sym link for `~/dotconfig/.zshrc` → `~/.zshrc`
- Safely overwrite existing symlinks if necessary

## Notes

- If you later add new folders (e.g. alacritty, git), just update the install scripts with one more ln -s or New-Item command.
- The installer is idempotent — running it again will simply refresh the links.
- On new machines, you can bootstrap your dev environment in seconds:

```bash
git clone https://github.com/<your-username>/dotconfig.git ~/dotconfig && ~/dotconfig/install.sh
```

- BrewFile can be used with `brew bundle install` to install listed packages.

---

## License

This repo is shared for educational and personal purposes.
Feel free to adapt it to your own workflow!.

