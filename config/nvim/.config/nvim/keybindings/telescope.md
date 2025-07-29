# Telescope Keybindings

Telescope is a fuzzy finder for files, text, buffers, and more. It provides a powerful interface for searching and navigating.

## Opening Telescope

From normal mode anywhere in Neovim:

| Keys | Action | Description |
|------|--------|-------------|
| `<leader>ff` | Find files | Search files by name |
| `<leader>fg` | Live grep | Search file contents |
| `<leader>fb` | Buffers | List open buffers |
| `<leader>fh` | Help tags | Search Neovim help |

## Inside Telescope Picker

These keybindings work in any Telescope picker window.

### Navigation (Insert Mode)

| Key | Action | Notes |
|-----|--------|-------|
| `<C-j>` or `<Down>` | Next item | Move selection down |
| `<C-k>` or `<Up>` | Previous item | Move selection up |
| `<C-n>` | Next item | Alternative |
| `<C-p>` | Previous item | Alternative |
| `<PageDown>` | Scroll preview down | In preview window |
| `<PageUp>` | Scroll preview up | In preview window |
| `<C-d>` | Scroll preview down | Half page |
| `<C-u>` | Scroll preview up | Half page |
| `<C-f>` | Scroll preview right | Horizontal scroll |
| `<C-b>` | Scroll preview left | Horizontal scroll |

### Navigation (Normal Mode)

| Key | Action | Notes |
|-----|--------|-------|
| `j` | Next item | Vim-style |
| `k` | Previous item | Vim-style |
| `H` | Move to top | First result |
| `M` | Move to middle | Middle result |
| `L` | Move to bottom | Last result |
| `gg` | Move to first | Alternative |
| `G` | Move to last | Alternative |

### Selection Actions

| Key | Action | Notes |
|-----|--------|-------|
| `<CR>` | Open (default) | Open in current window |
| `<C-x>` | Open horizontal split | Split below |
| `<C-v>` | Open vertical split | Split right |
| `<C-t>` | Open in tab | New tab |
| `<C-q>` | Send to quickfix | All items to quickfix |
| `<M-q>` | Send selected to quickfix | Selected items only |

### Multi-Selection

| Key | Action | Notes |
|-----|--------|-------|
| `<Tab>` | Toggle selection | Select/deselect item |
| `<S-Tab>` | Toggle selection + move up | Select and move |
| `<C-a>` | Select all | Select all results |
| `<C-s>` | Drop all | Clear all selections |

### Other Actions

| Key | Action | Notes |
|-----|--------|-------|
| `<C-c>` or `<Esc>` | Close | Exit telescope |
| `<C-u>` | Clear prompt | Delete input |
| `<C-w>` | Delete word | Delete word backward |
| `<C-h>` | Show help | Which-key style help |
| `<C-/>` | Show help | Alternative (insert mode) |
| `?` | Show help | In normal mode |
| `<C-r><C-w>` | Insert word | Word under cursor |
| `<C-r><C-a>` | Insert WORD | WORD under cursor |
| `<C-r><C-f>` | Insert file | File under cursor |
| `<C-r><C-l>` | Insert line | Line under cursor |

## File-Specific Actions

When using file pickers (`find_files`, `git_files`, etc.):

| Key | Action | Notes |
|-----|--------|-------|
| `<C-o>` | Open with system | Use system default app |
| `<C-y>` | Copy path | Copy file path to clipboard |

## Search-Specific Actions

When using grep pickers (`live_grep`, `grep_string`, etc.):

| Key | Action | Notes |
|-----|--------|-------|
| `<C-space>` | Toggle preview | Show/hide preview |
| `<C-l>` | Complete | Auto-complete |

## Advanced Features

### Refining Results

While in a picker:
1. Type to filter results
2. Use `<C-/>` in insert mode to see all available mappings
3. Use fuzzy matching: `fb` matches `foo_bar.txt`

### Search Syntax (Live Grep)

| Pattern | Meaning | Example |
|---------|---------|---------|
| `foo` | Contains foo | Basic search |
| `^foo` | Starts with foo | Line beginning |
| `foo$` | Ends with foo | Line ending |
| `foo.*bar` | foo followed by bar | Regex |
| `'foo` | Exact match foo | Literal string |

### File Pattern Syntax

| Pattern | Meaning | Example |
|---------|---------|---------|
| `foo` | Contains foo | `foobar.txt` |
| `^foo` | Starts with foo | `foo.txt` |
| `.lua$` | Ends with .lua | `init.lua` |
| `!test` | Exclude test | Hide test files |

## Tips

1. **Quick Selection**: Use `<Tab>` to select multiple files, then `<C-q>` to send to quickfix
2. **Preview Control**: `<C-space>` toggles preview when it gets in the way
3. **Case Sensitivity**: Searches are smart-case (case-insensitive unless you use capitals)
4. **Hidden Files**: Configure telescope to show hidden files in setup if needed

## Common Workflows

### Find and Replace Across Files
1. `<leader>fg` to live grep
2. Search for pattern
3. `<Tab>` to select files
4. `<C-q>` to send to quickfix
5. `:cdo s/old/new/g | update`

### Jump to Definition
1. `<leader>ff` to find files
2. Start typing filename
3. Use fuzzy matching for speed

### Search in Specific Directories
1. `:Telescope find_files cwd=path/to/dir`
2. Or `:Telescope live_grep search_dirs={"path1","path2"}`

[Back to keybindings index](./README.md)