# Attilio’s Neovim-Lua configuration

Tiny, fast and focused – with first-class support for the **Ghostty**
terminal and a great Python editing experience out-of-the-box.

---

## Requirements

* Neovim **0.11 or higher** (compiled with LuaJIT)
* `git` – for lazy.nvim’s bootstrapper
* [ripgrep](https://github.com/BurntSushi/ripgrep) (`rg`) – super-fast recursive grep used by Telescope’s *live_grep*
* [fd](https://github.com/sharkdp/fd) – efficient file-finder (optional but recommended; Telescope falls back gracefully if missing)

Ghostty specific features are enabled automatically when the session is
believed to run inside Ghostty (`$TERM == "xterm-ghostty"` **or** the
`$GHOSTTY_RESOURCES_DIR` variable exists).  Nothing will break in other
terminals.

---

## Installation

```bash
# clone into the normal XDG location
git clone https://example.com/your/repo ~/.config/nvim

# first launch – plugins are installed & compiled automatically
nvim
```

No additional steps are required because the config bootstraps
[folke/lazy.nvim] on first start.

---

## Highlights

* **Treesitter** for modern, incremental syntax highlighting & indenting
* **Pyright** (type-checking) pre-configured through **mason.nvim**
* **nvim-tree** file explorer that replaces netrw and smart-opens on
  `nvim .`
* **Neogit** for comprehensive, Magit-inspired git workflow management
* **Octo** for GitHub integration (PRs, issues, code reviews) directly in Neovim
* **diffview.nvim** for VS Code-like git diff viewing and file history
* **render-markdown** for beautiful in-terminal markdown rendering with syntax highlighting
* **bufferline** / **lualine** UI polish with transparent background
  when inside Ghostty
* **Enhanced clipboard** with `<leader>y` for explicit system clipboard yanking
* Sensible defaults: absolute line numbers, clipboard=unnamedplus,
  `updatetime=250`, etc.

---

## Plugin index

| Plugin | Purpose |
| ------ | ------- |
| folke/lazy.nvim                | Fast, modern plugin manager |
| nvim-treesitter/nvim-treesitter| Highlight & indent engine |
| nvim-tree/nvim-tree.lua        | File explorer (replaces netrw) |
| nvim-lualine/lualine.nvim      | Statusline |
| akinsho/bufferline.nvim        | Buffer / tab line |
| lewis6991/gitsigns.nvim        | Git hunk decorations & actions |
| sindrets/diffview.nvim         | Git diff viewer (VS Code-like) |
| NeogitOrg/neogit              | Magit-inspired git interface |
| pwntester/octo.nvim           | GitHub integration (PRs, issues, reviews) |
| MeanderingProgrammer/render-markdown.nvim | Beautiful in-terminal markdown rendering |
| lukas-reineke/indent-blankline.nvim | Indent guides |
| folke/which-key.nvim           | Popup which-key hints |
| catppuccin/nvim               | Rich, semantic-aware colour scheme |
| nvim-telescope/telescope.nvim  | Fuzzy finding (files, grep, buffers…) |
| nvim-telescope/telescope-fzf-native.nvim | Fast C-implemented sorter for Telescope |
| neovim/nvim-lspconfig + mason-org/mason.nvim | LSP servers & installer |
| mason-org/mason-lspconfig.nvim | mason <-> lspconfig bridge |
| nvim-lua/plenary.nvim         | Lua utility library (dependency) |
| nvim-tree/nvim-web-devicons   | File type icons (dependency) |

(_nvim-autopairs_ used to live here; it is **disabled on purpose** – just
delete `lua/plugins/autopairs.lua` if you are sure you will never turn
it back on.)

---

## Keybindings

Leader key: `<Space>`

For a complete reference, see:
- [KEYBINDINGS.md](./KEYBINDINGS.md) - Quick reference for global mappings
- [keybindings/](./keybindings/) - Detailed plugin-specific documentation

---

## Project structure

```
init.lua                entry-point – sets options, bootstraps lazy.nvim
lua/plugins/*.lua       one file per plugin (lazy.nvim specs)
lua/util/ghostty.lua    helper that detects Ghostty – used everywhere
keybindings/            detailed plugin-specific keybinding documentation
├── README.md           index of detailed keybinding docs
├── diffview.md         diffview.nvim keybindings & workflows
├── neogit.md           neogit git workflow keybindings
├── octo.md             GitHub integration (PRs, issues, reviews)
├── nvim-tree.md        file explorer keybindings
├── telescope.md        fuzzy finder keybindings
├── lsp.md              language server keybindings
└── render-markdown.md  markdown rendering keybindings
KEYBINDINGS.md          quick reference for all mappings
lazy-lock.json          plugin lock-file (generated)
```

---

[folke/lazy.nvim]: https://github.com/folke/lazy.nvim
