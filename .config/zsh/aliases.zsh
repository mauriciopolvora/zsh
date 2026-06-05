if command -v eza >/dev/null 2>&1; then
  alias ls='eza --icons=auto'
  alias ll='eza -lh --icons=auto --git'
  alias la='eza -lah --icons=auto --git'
  alias tree='eza --tree --icons=auto'
  compdef eza=ls
else
  alias ll='ls -lh'
  alias la='ls -lah'
  alias tree='find . -print'
fi

if command -v bat >/dev/null 2>&1; then
  alias cat='bat --paging=never'
fi

alias df='df -h'
alias vim='nvim'
alias cc='claude --dangerously-skip-permissions'
alias -- -='cd -'
alias reload='exec zsh'

alias g='git'
alias gs='git status -sb'
alias gp='git push'
alias gc='git commit'

alias glog='PAGER="less -F -X" git log'
alias gadog='PAGER="less -F -X" git log --all --decorate --oneline --graph'

mkcd() {
  mkdir -p "$1" && cd "$1"
}
