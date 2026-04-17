# ==============================
# 🧩 arthur's zsh configuration
# ==============================

# ==============================
# ⚙️Zinit setup 
# ==============================

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
if [ -d "$ZINIT_HOME" ]; then
    source "${ZINIT_HOME}/zinit.zsh"
else
    if [[ -o interactive ]]; then
        print -u2 "zinit is not installed; skipping zsh plugin setup."
    fi
fi

# ==============================
# 🔌 Plugins
# ==============================

if [ -d "$ZINIT_HOME" ]; then
    zinit ice depth=1
    zinit light zsh-users/zsh-syntax-highlighting
    zinit light zsh-users/zsh-completions
    zinit light zsh-users/zsh-autosuggestions
    zinit light Aloxaf/fzf-tab
    zinit snippet OMZP::git
    zinit snippet OMZP::command-not-found
fi


# =========================
# 🧠 Completion & Keybinds
# =========================

autoload -U compinit && compinit
if [ -d "$ZINIT_HOME" ]; then
    zinit cdreplay -q
fi


bindkey '^j' history-search-backward
bindkey '^k' history-search-forward

# =========================
# 📜 History
# =========================
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors '${(s.:.)LS_COLORS}'
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# =========================
# 🌎 Environment
# =========================
export PATH="/opt/homebrew/bin:$HOME/bin:$PATH"
export EDITOR="nvim"

# =========================
# 🧱 Aliases
# =========================
alias ..='cd ..'
alias ...='cd ../..'
alias tree='eza -T'
# alias ls='eza --color=always --color-scale=all --color-scale-mode=gradient --icons=always --group-directories-first -la -h'  # lists everything with dir first
alias ls='eza --color=always --color-scale=all --color-scale-mode=gradient --icons=always --group-directories-first -l'
alias gl='git log --oneline'
alias gs='git status --short'
alias lz='lazygit'
alias c='clear'
alias python='python3'
alias pip='pip3'
alias cat='bat'

# Force Ghostty back to the primary screen if a session gets stuck in alt-screen.
ghostty_primary_screen() {
    printf '\033[?1049l\033[?47l'
}
alias fix-scroll='ghostty_primary_screen'

eval "$(starship init zsh)"
eval "$(zoxide init --cmd cd zsh)"
eval "$(fzf --zsh)"

# Auto-start rmux (only if not already inside it)
if [[ -o interactive ]] && command -v tmux >/dev/null 2>&1; then
    if [ -z "$TMUX" ]; then
        exec tmux
    fi
fi
