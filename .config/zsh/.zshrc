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

source "$ZDOTDIR/completion.zsh"

if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh --cmd cd)"
fi

source "$ZDOTDIR/aliases.zsh"
source "$ZDOTDIR/tooling.zsh"

if [[ -t 0 && -t 1 ]]; then
  source "$ZDOTDIR/fzf.zsh"
  source "$ZDOTDIR/plugins.zsh"
  source "$ZDOTDIR/bindings.zsh"
  source "$ZDOTDIR/prompt.zsh"
fi

[[ -f "$ZDOTDIR/local.zsh" ]] && source "$ZDOTDIR/local.zsh"
