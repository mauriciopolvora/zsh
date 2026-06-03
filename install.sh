#!/usr/bin/env sh
set -eu

repo_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
backup_dir="$HOME/.config/zsh.backup.$(date +%Y%m%d%H%M%S)"

backup_path() {
  path="$1"
  if [ -e "$path" ] || [ -L "$path" ]; then
    mkdir -p "$backup_dir"
    mv "$path" "$backup_dir/"
  fi
}

mkdir -p "$HOME/.config"

backup_path "$HOME/.zshenv"
backup_path "$HOME/.zshrc"
backup_path "$HOME/.config/zsh"

ln -s "$repo_dir/.zshenv" "$HOME/.zshenv"
ln -s "$repo_dir/.zshrc" "$HOME/.zshrc"
ln -s "$repo_dir/.config/zsh" "$HOME/.config/zsh"

printf 'Installed zsh config from %s\n' "$repo_dir"
if [ -d "$backup_dir" ]; then
  printf 'Previous files were moved to %s\n' "$backup_dir"
fi
