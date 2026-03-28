# LazyVim Profile

This is the default Neovim profile for this dotfiles repo.

It stays deliberately close to upstream LazyVim and keeps local
customization minimal.

## Usage

Launch it with plain `nvim`.

The previous handmade config is preserved separately under the
`nvim-handrolled` app name.

## Scope

This profile stays deliberately close to upstream LazyVim:

- starter structure from LazyVim
- no imported extras yet
- only one local customization: Ghostty-aware transparency for
  Tokyonight

## Legacy Profile

To launch the previous handmade setup:

```bash
NVIM_APPNAME=nvim-handrolled nvim
```
