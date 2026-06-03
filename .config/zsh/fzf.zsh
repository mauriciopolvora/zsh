if command -v fd >/dev/null 2>&1; then
  export FZF_DEFAULT_COMMAND='fd --type f --hidden --strip-cwd-prefix --exclude .git'
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
fi

export FZF_DEFAULT_OPTS='--height=60% --layout=reverse --border=rounded --prompt=" " --pointer=" " --preview-window=right:65%:wrap:border-left'

if command -v bat >/dev/null 2>&1; then
  export _FZF_PREVIEW_CMD='bat --color=always --style=plain,numbers --line-range=:500 {}'
else
  export _FZF_PREVIEW_CMD='sed -n "1,500p" {}'
fi

export FZF_CTRL_T_OPTS="--preview '$_FZF_PREVIEW_CMD'"

_fzf_file_no_hidden() {
  local cmd result

  if command -v fd >/dev/null 2>&1; then
    cmd='fd --type f --strip-cwd-prefix --exclude .git'
  else
    cmd='find . -type f'
  fi

  result=$(eval "$cmd" | fzf --preview "$_FZF_PREVIEW_CMD") || return
  LBUFFER+="$result"
  zle reset-prompt
}

zle -N _fzf_file_no_hidden
