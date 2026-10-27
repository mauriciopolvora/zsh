#!/usr/bin/env sh
set -eu

repo_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
backup_dir="$HOME/.config/zsh.backup.$(date +%Y%m%d%H%M%S)"
bin_dir="$HOME/.local/bin"

say() {
  printf '%s\n' "$*"
}

has() {
  command -v "$1" >/dev/null 2>&1
}

link_path() {
  target="$1"
  path="$2"
  if [ -L "$path" ] && [ "$(readlink "$path")" = "$target" ]; then
    return
  fi
  if [ -e "$path" ] || [ -L "$path" ]; then
    mkdir -p "$backup_dir"
    mv "$path" "$backup_dir/"
  fi
  ln -s "$target" "$path"
}

# Ghostty sends TERM=xterm-ghostty, which most distros don't ship yet.
# Without it colors break and screen/curses tools (do-release-upgrade) fail.
install_ghostty_terminfo() {
  has tic && has infocmp || return 0
  src="$repo_dir/terminfo/xterm-ghostty.terminfo"

  if ! env -u TERMINFO -u TERMINFO_DIRS infocmp xterm-ghostty >/dev/null 2>&1; then
    tic -x "$src" 2>/dev/null
    say 'Installed xterm-ghostty terminfo into ~/.terminfo'
  fi

  # root (sudo) doesn't read ~/.terminfo, so also install system-wide on Linux.
  [ "$(uname -s)" = Linux ] || return 0
  if ! env -u TERMINFO -u TERMINFO_DIRS HOME=/nonexistent infocmp xterm-ghostty >/dev/null 2>&1; then
    if [ "$(id -u)" -eq 0 ]; then
      tic -x -o /usr/share/terminfo "$src" 2>/dev/null
      say 'Installed xterm-ghostty terminfo system-wide'
    elif has sudo && sudo -n true 2>/dev/null; then
      sudo tic -x -o /usr/share/terminfo "$src" 2>/dev/null
      say 'Installed xterm-ghostty terminfo system-wide'
    else
      say "For sudo/screen support run: sudo tic -x -o /usr/share/terminfo $src"
    fi
  fi
}

# Static starship build into ~/.local/bin on Linux hosts without it.
install_starship() {
  has starship || [ -x "$bin_dir/starship" ] && return 0

  if [ "$(uname -s)" != Linux ]; then
    say 'starship not found: brew install starship'
    return 0
  fi

  case "$(uname -m)" in
    x86_64 | amd64) arch=x86_64 ;;
    aarch64 | arm64) arch=aarch64 ;;
    *)
      say "starship not found and no prebuilt binary for $(uname -m); prompt falls back to (hostname) ~/path >"
      return 0
      ;;
  esac

  if ! has curl || ! has tar; then
    say 'starship not found and curl/tar are missing; prompt falls back to (hostname) ~/path >'
    return 0
  fi

  asset="starship-$arch-unknown-linux-musl.tar.gz"
  url="https://github.com/starship/starship/releases/latest/download/$asset"
  tmp=$(mktemp -d)
  curl -fsSL -o "$tmp/$asset" "$url"
  curl -fsSL -o "$tmp/$asset.sha256" "$url.sha256"
  if has sha256sum; then
    printf '%s  %s\n' "$(cat "$tmp/$asset.sha256")" "$tmp/$asset" | sha256sum -c - >/dev/null
  fi
  tar -xzf "$tmp/$asset" -C "$tmp"
  mkdir -p "$bin_dir"
  install -m 755 "$tmp/starship" "$bin_dir/starship"
  rm -rf "$tmp"
  say "Installed $("$bin_dir/starship" --version | head -n 1) into $bin_dir"
}

# Hosts that keep bash as the login shell hand interactive sessions to zsh.
install_bash_autostart() {
  if has getent; then
    login_shell=$(getent passwd "$(id -un)" | cut -d: -f7)
  else
    login_shell="${SHELL:-}"
  fi
  [ "${login_shell##*/}" = zsh ] && return 0
  [ -f "$HOME/.bashrc" ] || return 0
  grep -q '>>> mauricio-zsh-auto-start >>>' "$HOME/.bashrc" && return 0

  cat >>"$HOME/.bashrc" <<'EOF'

# >>> mauricio-zsh-auto-start >>>
if case $- in *i*) true;; *) false;; esac && [ -z "${ZSH_VERSION:-}" ]; then
  if [ -x "$HOME/.local/bin/zsh" ]; then
    exec "$HOME/.local/bin/zsh"
  elif command -v zsh >/dev/null 2>&1; then
    exec zsh
  fi
fi
# <<< mauricio-zsh-auto-start <<<
EOF
  say 'Added zsh auto-start to ~/.bashrc'
}

mkdir -p "$HOME/.config"

link_path "$repo_dir/.zshenv" "$HOME/.zshenv"
link_path "$repo_dir/.zshrc" "$HOME/.zshrc"
link_path "$repo_dir/.config/zsh" "$HOME/.config/zsh"

say "Installed zsh config from $repo_dir"
if [ -d "$backup_dir" ]; then
  say "Previous files were moved to $backup_dir"
fi

install_ghostty_terminfo
install_starship
install_bash_autostart

if ! has zsh && [ ! -x "$bin_dir/zsh" ]; then
  say 'zsh is not installed yet: sudo apt install zsh (or your package manager), then open a new shell'
fi
