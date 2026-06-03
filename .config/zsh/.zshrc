HISTFILE="$XDG_STATE_HOME/zsh/history"
HISTSIZE=100000
SAVEHIST=100000

setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_FIND_NO_DUPS
setopt AUTOCD
setopt NOBEEP
setopt NUMERIC_GLOB_SORT

mkdir -p "$XDG_STATE_HOME/zsh" "$XDG_CACHE_HOME/zsh"

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

if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh)"
fi

source "$ZDOTDIR/aliases.zsh"
source "$ZDOTDIR/tooling.zsh"

if [[ -t 0 && -t 1 ]]; then
  if [[ -f /opt/homebrew/opt/fzf/shell/key-bindings.zsh ]]; then
    source /opt/homebrew/opt/fzf/shell/key-bindings.zsh
    source /opt/homebrew/opt/fzf/shell/completion.zsh
  elif [[ -f /usr/local/opt/fzf/shell/key-bindings.zsh ]]; then
    source /usr/local/opt/fzf/shell/key-bindings.zsh
    source /usr/local/opt/fzf/shell/completion.zsh
  fi

  source "$ZDOTDIR/fzf.zsh"
  source "$ZDOTDIR/plugins.zsh"
  source "$ZDOTDIR/bindings.zsh"
  source "$ZDOTDIR/prompt.zsh"
fi

[[ -f "$ZDOTDIR/local.zsh" ]] && source "$ZDOTDIR/local.zsh"
