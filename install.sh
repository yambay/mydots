#!/usr/bin/env bash
# Links the dotfiles from this repository into $HOME.
set -euo pipefail

DOTS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

link() {
    local src="$1" dest="$2"
    if [[ "$(readlink "$dest" 2>/dev/null)" == "$src" ]]; then
        echo "Already linked: $dest"
        return
    fi
    # Back up regular files and symlinks pointing elsewhere (also broken ones)
    if [[ -e "$dest" || -L "$dest" ]]; then
        local backup="$dest.bak.$(date +%Y%m%d-%H%M%S)"
        mv "$dest" "$backup"
        echo "Backup: $dest -> $backup"
    fi
    ln -sfn "$src" "$dest"
    echo "Linked: $dest -> $src"
}

link "$DOTS_DIR/.vimrc" "$HOME/.vimrc"
link "$DOTS_DIR/zsh/.zshenv" "$HOME/.zshenv"
link "$DOTS_DIR/zsh/.zshrc" "$HOME/.zshrc"

if ! command -v zsh >/dev/null 2>&1; then
    echo "Note: zsh is not installed (Ubuntu: sudo apt install zsh vim git)."
elif [[ "$(basename "${SHELL:-}")" != "zsh" ]]; then
    echo "Note: your login shell is not zsh. Switch with: chsh -s \"$(command -v zsh)\""
fi
