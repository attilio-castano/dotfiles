# LazyVim Parallel Profile

This is a staged LazyVim migration profile for this dotfiles repo.

It intentionally does **not** replace the existing hand-rolled Neovim
config in `config/nvim/.config/nvim`.

## Usage

After stowing `config/nvim-lazy`, launch it with:

```bash
NVIM_APPNAME=nvim-lazy nvim
```

Or use the shell helper:

```bash
nlazy
```

## Scope

This profile stays deliberately close to upstream LazyVim:

- starter structure from LazyVim
- no imported extras yet
- only one local customization: Ghostty-aware transparency for
  Tokyonight

## Why This Exists

This keeps the current handmade config available while taking LazyVim
for a real test drive outside the default `nvim` hot path.
