if command -v eza >/dev/null 2>&1; then
  alias ls='eza --icons=auto'
  alias ll='eza -lh --icons=auto --git'
  alias la='eza -lah --icons=auto --git'
  alias tree='eza --tree --icons=auto'
  whence -w compdef >/dev/null 2>&1 && compdef eza=ls 2>/dev/null
else
  alias ll='ls -lh'
  alias la='ls -lah'
  alias tree='find . -print'
fi

if command -v bat >/dev/null 2>&1; then
  alias cat='bat --paging=never'
fi

alias df='df -h'
alias -- -='cd -'
alias reload='exec zsh'

if command -v nvim >/dev/null 2>&1; then
  alias vim='nvim'
elif ! command -v vim >/dev/null 2>&1 && command -v vi >/dev/null 2>&1; then
  alias vim='vi'
fi

cc() {
  if command -v claude >/dev/null 2>&1; then
    claude --dangerously-skip-permissions "$@"
  else
    print -u2 'cc: claude is not installed on this machine'
    return 127
  fi
}

alias g='git'
alias gs='git status -sb'
alias gp='git push'
alias gc='git commit'

alias glog='PAGER="less -F -X" git log'
alias gadog='PAGER="less -F -X" git log --all --decorate --oneline --graph'

mkcd() {
  mkdir -p "$1" && cd "$1"
}
