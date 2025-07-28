# Key-binding Quick Reference

This file is a condensed cheat-sheet of every non-trivial key-mapping
defined by the configuration (plugins included).  The leader key is
`<Space>`.

> **Note**: For detailed plugin-specific keybindings (like diffview's file panel),
> see the [keybindings directory](./keybindings/README.md).

---

## Core Neovim

Basic editor commands and window navigation.

| Mode | Keys | Action |
|------|------|--------|
| **Normal** | `<leader>w` | Save current buffer |
| Normal | `<leader>y` | Yank to system clipboard |
| Normal | `<A-h>` | Focus split **left** |
| Normal | `<A-j>` | Focus split **below** |
| Normal | `<A-k>` | Focus split **above** |
| Normal | `<A-l>` | Focus split **right** |
| **Visual** | `<leader>y` | Yank selection to system clipboard |

---

## Bufferline

Buffer (tab) navigation and management.

| Mode | Keys | Action |
|------|------|--------|
| Normal | `<A-,>` | Previous buffer |
| Normal | `<A-.>` | Next buffer |
| Normal | `<A-1>`…`<A-9>` | Jump to buffer *n* |
| Normal | `<leader>bp` | Previous buffer |
| Normal | `<leader>bn` | Next buffer |
| Normal | `<leader>bd` | Delete buffer (safe) |
| Normal | `<leader>bD` | Delete buffer (force) |
| Normal | `<leader>bo` | Close other buffers |
| Normal | `<leader>ba` | Close all buffers (return to tree) |
| Normal | `<leader>bA` | Force close all (return to tree) |

---

## Nvim-Tree

File explorer toggle and navigation.

| Mode | Keys | Action |
|------|------|--------|
| Normal | `<leader>e` | Toggle file tree |

### Inside Nvim-Tree window

| Key | Description |
|-----|-------------|
| `l` | Smart open (just like `o`) |
| `h` | Collapse directory / go to parent |
| `v` | Open node in **vertical** split |
| `s` | Open node in **horizontal** split |
| `t` | Open node in **new tab** |
| `C` | Change root to node |
| `-` | Change root to parent |
| `H` | Toggle dot-files |
| `z` | Collapse all |

---

## Git Integration

### Gitsigns

In-editor git hunk navigation and actions.

| Mode | Keys | Action |
|------|------|--------|
| Normal | `]c` | Next Git hunk |
| Normal | `[c` | Previous Git hunk |
| Normal | `<leader>gs` | Stage hunk |
| Normal | `<leader>gr` | Reset hunk |
| Normal | `<leader>gS` | Stage buffer |
| Normal | `<leader>gR` | Reset buffer |
| Normal | `<leader>gp` | Preview hunk |
| Normal | `<leader>gb` | Blame line |
| Visual | `<leader>gs` | Stage selected lines |
| Visual | `<leader>gr` | Reset selected lines |

### Diffview

VS Code-like git diff viewing and file history.

| Mode | Keys | Action |
|------|------|--------|
| Normal | `<leader>gd` | Open diff view |
| Normal | `<leader>gh` | File history (current file) |
| Normal | `<leader>gH` | File history (repository) |
| Normal | `<leader>gc` | Close diff view |

### Neogit

Magit-inspired git interface for comprehensive git workflow management.

| Mode | Keys | Action |
|------|------|--------|
| Normal | `<leader>gg` | Open Neogit status |
| Normal | `<leader>gC` | Commit popup |
| Normal | `<leader>gP` | Push popup |
| Normal | `<leader>gl` | Pull popup |
| Normal | `<leader>gB` | Branch popup |

### Inside Neogit status window

| Key | Description |
|-----|-------------|
| `s` | Stage file/hunk |
| `u` | Unstage file/hunk |
| `x` | Discard changes |
| `<tab>` | Toggle section/file |
| `c` | Commit menu |
| `p` | Push menu |
| `P` | Pull menu |
| `b` | Branch menu |
| `q` | Close Neogit |

For comprehensive Neogit workflows, branch management, commit viewing, and troubleshooting, see [Neogit keybindings](./keybindings/neogit.md).

### Octo (GitHub Integration)

GitHub pull requests, issues, and code reviews within Neovim.

| Mode | Keys | Action |
|------|------|--------|
| Normal | `<leader>go` | Open Octo |
| Normal | `<leader>gpr` | List PRs |
| Normal | `<leader>gpi` | List issues |
| Normal | `<leader>gpc` | Create PR |
| Normal | `<leader>gic` | Create issue |

### Inside Octo PR/Issue buffers

| Key | Description |
|-----|-------------|
| `]c` / `[c` | Next/previous comment |
| `<space>ca` | Add comment |
| `<space>cd` | Delete comment |
| `<space>pd` | Show PR diff |
| `<space>r+` | 👍 reaction |
| `<space>po` | Checkout PR |
| `<space>pm` | Merge PR |
| `<C-b>` | Open in browser |

For comprehensive GitHub workflows, authentication setup, and code review features, see [Octo keybindings](./keybindings/octo.md).

---

## Telescope

Fuzzy finding for files, text, and more.

| Mode | Keys | Action |
|------|------|--------|
| Normal | `<leader>ff` | Find files |
| Normal | `<leader>fg` | Live grep |
| Normal | `<leader>fb` | List buffers |
| Normal | `<leader>fh` | Help tags |

### Inside Telescope picker

| Mode | Key | Action |
|------|-----|--------|
| Insert | `<C-j>` / `<C-k>` | Move selection down / up |
| Insert | `<Esc>` or `<C-c>` | Close picker |

*(These are plugin defaults and can be changed via Telescope's
`defaults.mappings` table.)*

---

## Render Markdown

Beautiful in-terminal markdown rendering.

| Mode | Keys | Action |
|------|------|--------|
| Normal | `<leader>m` | Toggle markdown rendering |

For more render-markdown features, see [render-markdown keybindings](./keybindings/render-markdown.md).

---

Keep this file open in a split (`:vsplit KEYBINDINGS.md`) for quick
reference while you are getting used to the bindings.