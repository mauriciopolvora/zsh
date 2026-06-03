# Compatibility shim for tools that explicitly source ~/.zshrc.
if [[ -n "${ZDOTDIR:-}" && -f "$ZDOTDIR/.zshrc" ]]; then
  source "$ZDOTDIR/.zshrc"
fi
