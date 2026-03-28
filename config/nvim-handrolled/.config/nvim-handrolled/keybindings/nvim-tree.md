# Nvim-Tree Keybindings

Nvim-tree is the file explorer that replaces netrw. It opens automatically when you `nvim .` on a directory.

## Opening Nvim-Tree

From normal mode anywhere in Neovim:

| Keys | Action |
|------|--------|
| `<leader>e` | Toggle file tree |

## Inside Nvim-Tree

These keybindings are active when your cursor is in the nvim-tree window.

### Navigation

| Key | Action | Notes |
|-----|--------|-------|
| `j` / `k` | Move down/up | Standard vim navigation |
| `h` | Close directory / Go to parent | Smart close |
| `l` | Open directory / Open file | Smart open |
| `<CR>` or `o` | Open file/directory | Default open |
| `<BS>` | Close directory | Alternative to `h` |
| `P` | Go to parent directory | Jump to parent |
| `K` | Show file info | Size, permissions, etc. |

### Opening Files

| Key | Action | Notes |
|-----|--------|-------|
| `<CR>` or `o` | Open in current window | Default action |
| `v` | Open in vertical split | Split right |
| `s` | Open in horizontal split | Split below |
| `t` | Open in new tab | New tab |
| `<Tab>` | Open with preview | Keep focus on tree |
| `<C-t>` | Open in new tab | Alternative |
| `<C-v>` | Open in vertical split | Alternative |
| `<C-x>` | Open in horizontal split | Alternative |

### File Operations

| Key | Action | Notes |
|-----|--------|-------|
| `a` | Create file/directory | End with `/` for directory |
| `d` | Delete | Prompts for confirmation |
| `r` | Rename | Edit the name |
| `x` | Cut | Move to clipboard |
| `c` | Copy | Copy to clipboard |
| `p` | Paste | From clipboard |
| `y` | Copy name | Filename to system clipboard |
| `Y` | Copy relative path | Path from CWD |
| `gy` | Copy absolute path | Full path |

### View Options

| Key | Action | Notes |
|-----|--------|-------|
| `H` | Toggle hidden files | Show/hide dotfiles |
| `I` | Toggle git ignored | Show/hide gitignored files |
| `R` | Refresh | Reload tree |
| `W` | Collapse all | Close all directories |
| `E` | Expand all | Open all directories |
| `S` | Search | Interactive search |
| `f` | Filter | Filter files |
| `F` | Clear filter | Remove active filter |
| `z` | Collapse all | Our custom mapping |

### Tree Root Operations

| Key | Action | Notes |
|-----|--------|-------|
| `C` | Change root to node | CD into directory |
| `-` | Change root to parent | Go up one level |
| `.` | Run command | Execute on file |

### Git Integration

| Key | Action | Notes |
|-----|--------|-------|
| `[c` | Previous git item | Previous changed file |
| `]c` | Next git item | Next changed file |

### Bookmarks

| Key | Action | Notes |
|-----|--------|-------|
| `m` | Toggle bookmark | Mark/unmark |
| `bmv` | Move bookmarked | Bulk move bookmarked items |

## Custom Mappings

Our configuration adds these custom behaviors:

| Key | Action | Replaces |
|-----|--------|---------|
| `l` | Smart open | Standard `l` movement |
| `h` | Smart close/parent | Standard `h` movement |
| `z` | Collapse all | Custom addition |

## Tips

1. **Quick Navigation**: Use `h` and `l` for fast directory traversal
2. **Multiple Files**: Use `m` to bookmark multiple files, then operate on all
3. **Preview Mode**: Use `<Tab>` to preview files without leaving the tree
4. **Git Status**: Modified files show git status indicators:
   - `M` - Modified
   - `A` - Added  
   - `?` - Untracked
   - `!` - Ignored

## Common Workflows

### Create a New File
1. Navigate to desired directory
2. Press `a`
3. Type filename and press `<CR>`

### Move Files
1. Navigate to file, press `x` (cut)
2. Navigate to destination
3. Press `p` (paste)

### Bulk Operations
1. Press `m` on multiple files to bookmark
2. Use `bmv` to move all bookmarked files

[Back to keybindings index](./README.md)