# Diffview.nvim Keybindings

Diffview provides a VS Code-like interface for viewing git diffs, file history, and resolving merge conflicts.

## Opening Diffview

From normal mode anywhere in Neovim:

| Keys | Action |
|------|--------|
| `<leader>gd` | Open diff view (shows current changes) |
| `<leader>gh` | File history for current file |
| `<leader>gH` | File history for entire repository |
| `<leader>gc` | Close diff view |

## File Panel Keybindings

When focused on the file panel (left side), these keys are available:

### Navigation
| Key | Action | Notes |
|-----|--------|-------|
| `<Tab>` | Select next file | Move down in the file list |
| `<S-Tab>` | Select previous file | Move up in the file list |
| `<CR>` | Open the diff | Shows diff in the right pane |
| `<C-b>` | Scroll list up | Page up |
| `<C-f>` | Scroll list down | Page down |

### Git Operations
| Key | Action | Notes |
|-----|--------|-------|
| `s` | Stage selected | Stage file/directory under cursor |
| `u` | Unstage selected | Unstage file/directory under cursor |
| `S` | Stage all | Stage all changes |
| `U` | Unstage all | Unstage all changes |
| `X` | Restore entry | Discard changes (with confirmation) |
| `R` | **Refresh files** | Update after external git operations |

### View Control
| Key | Action | Notes |
|-----|--------|-------|
| `<leader>e` | Focus file panel | Move cursor to file panel |
| `<leader>b` | Toggle file panel | Show/hide the file panel |
| `gf` | Open in split | Open file in horizontal split |
| `<C-w>gf` | Open in tab | Open file in new tab |
| `i` or `-` | Toggle stage | Stage/unstage (alternative binding) |

### Advanced
| Key | Action | Notes |
|-----|--------|-------|
| `L` | Open commit log | Show commit history |
| `g<C-x>` | Cycle layout | Change between diff layouts |
| `f` | Flatten directories | Toggle directory flattening |

## Diff View Keybindings

When viewing a diff (right side):

### Navigation
| Key | Action |
|-----|--------|
| `<Tab>` | Next file |
| `<S-Tab>` | Previous file |
| `[c` | Previous hunk |
| `]c` | Next hunk |

### Merge Conflict Resolution
| Key | Action | Use Case |
|-----|--------|----------|
| `<leader>co` | Choose ours | Accept your version |
| `<leader>ct` | Choose theirs | Accept incoming version |
| `<leader>cb` | Choose base | Accept base/ancestor version |
| `<leader>ca` | Choose all | Keep all versions |
| `dx` | Delete conflict | Remove conflict markers |
| `[x` | Previous conflict | Navigate conflicts |
| `]x` | Next conflict | Navigate conflicts |

## Common Workflows

### Reviewing Changes Before Commit
1. `<leader>gd` - Open diff view
2. `<Tab>`/`<S-Tab>` - Navigate through changed files
3. `s` - Stage files you want to commit
4. `<leader>gc` - Close when done

### Refreshing After External Changes
If you run `git add` or other git commands in a terminal:
1. Focus the file panel with `<leader>e`
2. Press `R` to refresh the file list
3. The view will update to reflect the new git status

### Comparing Branches
From command mode:
- `:DiffviewOpen main...feature` - Compare branches
- `:DiffviewOpen HEAD~3` - Compare with 3 commits ago

## Tips

- The file panel shows indicators:
  - `M` - Modified
  - `A` - Added
  - `D` - Deleted
  - `R` - Renamed
  - `?` - Untracked

- Use `:DiffviewFileHistory --follow` to follow file renames in history

- In file history view, press `<CR>` on a commit to see its changes

[Back to keybindings index](./README.md)