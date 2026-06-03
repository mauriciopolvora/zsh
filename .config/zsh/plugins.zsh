ZPLUGINDIR="${ZDOTDIR}/plugins"

_zplugin_load() {
  local org="$1"
  local repo="$2"
  local plugin_path="${ZPLUGINDIR}/${repo}"

  if [[ ! -d "$plugin_path" ]]; then
    mkdir -p "$ZPLUGINDIR"
    echo "Installing ${repo}..."
    git clone --depth=1 "https://github.com/${org}/${repo}" "$plugin_path" || return 1
  fi

  source "${plugin_path}/${repo}.plugin.zsh"
}

zplugin-update() {
  local dir
  for dir in "${ZPLUGINDIR}"/*/; do
    [[ -d "$dir" ]] || continue
    echo "Updating ${dir:t}..."
    git -C "$dir" pull --ff-only
  done
}

_zplugin_load zsh-users zsh-autosuggestions
_zplugin_load zsh-users zsh-history-substring-search
_zplugin_load zdharma-continuum fast-syntax-highlighting
