_zsh_prepend_fpath() {
  local dir="$1"

  [[ -d "$dir" ]] || return
  fpath=("$dir" "${fpath[@]:#$dir}")
}

_zsh_prepend_fpath "$ZDOTDIR/completions"
_zsh_prepend_fpath /opt/homebrew/share/zsh/site-functions
_zsh_prepend_fpath /usr/local/share/zsh/site-functions
unfunction _zsh_prepend_fpath

autoload -Uz compinit
compinit -d "$XDG_CACHE_HOME/zsh/zcompdump"

zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' group-name ''
zstyle ':completion:*' verbose yes
zstyle ':completion:*' use-cache yes
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh"
zstyle ':completion:*' squeeze-slashes true
zstyle ':completion:*' special-dirs true

if [[ -s "$HOME/.bun/_bun" ]]; then
  source "$HOME/.bun/_bun"
fi

if command -v terraform >/dev/null 2>&1; then
  autoload -Uz +X bashcompinit && bashcompinit
  complete -o nospace -C "$(command -v terraform)" terraform
fi
