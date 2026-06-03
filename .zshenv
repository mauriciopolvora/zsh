export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

if [[ -d /opt/homebrew/bin ]]; then
  export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"
fi

export PATH="$HOME/.local/bin:$PATH"
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

export EDITOR="nvim"
export VISUAL="nvim"
export STARSHIP_CONFIG="$ZDOTDIR/starship.toml"

if [[ -n "${ZSH_VERSION:-}" && -d "$HOME/.local/opt/zsh" ]]; then
  for dir in "$HOME"/.local/opt/zsh/usr/lib/*/zsh/"$ZSH_VERSION"(N); do
    module_path=("$dir" $module_path)
  done

  for dir in "$HOME"/.local/opt/zsh/usr/share/zsh/functions(N) "$HOME"/.local/opt/zsh/usr/share/zsh/functions/*(N/); do
    fpath=("$dir" $fpath)
  done
fi

if tty -s; then
  export GPG_TTY="$(tty)"
fi
