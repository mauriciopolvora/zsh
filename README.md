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
└── .config
    └── zsh
        ├── .zshrc
        ├── aliases.zsh
        ├── bindings.zsh
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

Then copy or symlink:

- `.zshenv` to `~/.zshenv`
- `.zshrc` to `~/.zshrc`
- `.config/zsh` to `~/.config/zsh`

Open a new shell or run:

```bash
exec zsh
```

## Notes

- The root `.zshrc` is just a compatibility shim that sources `~/.config/zsh/.zshrc`.
- Plugins are auto-cloned on first shell startup into `~/.config/zsh/plugins`.
- Machine-specific overrides can live in `~/.config/zsh/local.zsh`.

## Inspiration

This setup was heavily inspired by [radleylewis/zsh](https://github.com/radleylewis/zsh).
