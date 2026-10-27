# zsh

My personal Zsh setup: clean, minimal, and fast.

It uses an XDG-style layout with a tiny bootstrap in `~/.zshenv`, a modular config in `~/.config/zsh`, `starship` for the prompt, and a few quality-of-life tools for navigation, search, and completion.

## Stack

- `starship`
- `eza`
- `bat`
- `fd`
- `fzf`
- `zoxide`
- `neovim`
- `fnm`
- `bun`
- `terraform` completion
- `zsh-autosuggestions`
- `zsh-history-substring-search`
- `fast-syntax-highlighting`

## Layout

```text
.
├── .zshenv
├── .zshrc
├── install.sh
├── terminfo
│   └── xterm-ghostty.terminfo
└── .config
    └── zsh
        ├── .zshrc
        ├── aliases.zsh
        ├── bindings.zsh
        ├── completion.zsh
        ├── fzf.zsh
        ├── plugins.zsh
        ├── prompt.zsh
        ├── starship.toml
        └── tooling.zsh
```

## Install

Install the core tools with Homebrew:

```bash
brew install starship eza bat fd fzf zoxide neovim
```

Then clone the repo and run the installer (same as on remote hosts below), or copy/symlink by hand:

- `.zshenv` to `~/.zshenv`
- `.zshrc` to `~/.zshrc`
- `.config/zsh` to `~/.config/zsh`

Open a new shell or run:

```bash
exec zsh
```

## Remote hosts

For SSH-heavy workflows, Starship shows the hostname only inside SSH sessions:

```text
(hostname) path git branch >
```

On a new machine, install zsh and git, then clone and install the config:

```bash
sudo apt install zsh git
mkdir -p ~/.local/share
git clone https://github.com/mauriciopolvora/zsh.git ~/.local/share/zsh-config
~/.local/share/zsh-config/install.sh
```

Then open a new SSH session. `install.sh` is safe to re-run. It:

- symlinks `~/.zshenv`, `~/.zshrc` and `~/.config/zsh` into the repo. Anything already there is moved to `~/.config/zsh.backup.<timestamp>`.
- installs Ghostty's `xterm-ghostty` terminfo into `~/.terminfo`. On Linux it also installs it system-wide when it can sudo without a password; otherwise it prints the command to run. Stock distros don't know `xterm-ghostty` yet. Without it, colors break and `screen`-based tools such as `sudo do-release-upgrade` fail with `Cannot find terminfo entry for 'xterm-ghostty'`.
- downloads a static, checksum-verified `starship` into `~/.local/bin` on Linux if it isn't installed.
- if the login shell isn't zsh, appends a small `mauricio-zsh-auto-start` block to `~/.bashrc`. The block hands interactive sessions to zsh, so the login shell can stay bash.

The config is defensive: if tools like `starship`, `eza`, `fzf`, `zoxide`, `bun`, `fnm`, or `terraform` are not installed on a remote host, those integrations are skipped. If `starship` is missing during SSH, the prompt falls back to:

```text
(hostname) ~/path >
```

## Notes

- The root `.zshrc` is just a compatibility shim that sources `~/.config/zsh/.zshrc`.
- Plugins are auto-cloned on first shell startup into `~/.config/zsh/plugins`.
- Machine-specific overrides can live in `~/.config/zsh/local.zsh`.

## Inspiration

This setup was heavily inspired by [radleylewis/zsh](https://github.com/radleylewis/zsh).
