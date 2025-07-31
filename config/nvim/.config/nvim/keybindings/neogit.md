# Neogit Keybindings

Neogit provides a Magit-inspired git interface for comprehensive git workflow management within Neovim.

## Opening Neogit

From normal mode anywhere in Neovim:

| Keys | Action |
|------|--------|
| `<leader>gg` | Open Neogit status (main interface) |
| `<leader>gC` | Commit popup |
| `<leader>gP` | Push popup |
| `<leader>gl` | Pull popup |
| `<leader>gB` | Branch popup |

## Status Window Navigation

When in the main Neogit status window, these keys are available:

### Basic Navigation
| Key | Action | Notes |
|-----|--------|-------|
| `j` / `k` | Move down/up | Navigate through items |
| `<Tab>` | Toggle expand/collapse | Show/hide file contents |
| `<Enter>` | Go to file/view details | Open file or show commit details |
| `q` | Close Neogit | Standard way to exit |
| `<C-r>` | Refresh buffer | Update git status |

### File Operations
| Key | Action | Notes |
|-----|--------|-------|
| `s` | Stage file/hunk | Stage item under cursor |
| `u` | Unstage file/hunk | Unstage item under cursor |
| `S` | Stage all unstaged | Stage all changes |
| `U` | Unstage all staged | Unstage all changes |
| `<C-s>` | Stage all | Alternative staging |
| `x` | Discard changes | Discard item under cursor |

### Opening Files
| Key | Action | Notes |
|-----|--------|-------|
| `<Enter>` | Go to file | Open file at cursor position |
| `<C-v>` | Open in vertical split | Split right |
| `<C-x>` | Open in horizontal split | Split below |
| `<C-t>` | Open in new tab | New tab |

### Git Operations
| Key | Action | Notes |
|-----|--------|-------|
| `c` | Commit menu | Opens commit popup |
| `p` | Push menu | Opens push popup |
| `P` | Pull menu | Opens pull popup |
| `b` | Branch menu | Branch management |
| `l` | Log view | Show commit history |
| `$` | Command history | Show git command history |
| `Y` | Yank selected | Copy git data |

## Understanding Status Sections

The status window shows several sections:

### Head
- Shows local commits not yet pushed to remote
- Empty if you're up-to-date with remote

### Merge
- Shows commits from other branches during merges
- Appears during merge conflicts or when pulling changes

### Untracked/Unstaged/Staged
- **Untracked**: New files git doesn't know about
- **Unstaged**: Modified files not yet staged
- **Staged**: Files ready to be committed

### Recent
- Shows recent commits on current branch
- Limited view - use log (`l`) for full history

### Stashes
- Shows git stashes if any exist
- Usually collapsed by default

## Log View

Press `l` in status to open the log view for commit history.

### Log Navigation
| Key | Action | Notes |
|-----|--------|-------|
| `j` / `k` | Move through commits | Navigate history |
| `<Enter>` | View commit details | Show diff and message |
| `<Tab>` | Toggle commit expansion | Show/hide commit files |
| `q` | Close log view | Return to status |

### Log Filtering Options
| Key | Action | Description |
|-----|--------|-------------|
| `-n` | Limit number of commits | Default: 256 |
| `-A` | Filter by author | Show specific author |
| `-F` | Search commit messages | Grep in messages |
| `-G` | Search changes | Search in diffs |
| `-S` | Search occurrences | Search specific strings |
| `-s` | Commits since date | Time-based filtering |
| `-g` | Show graph | Visual branch structure |
| `-d` | Show branch names | Display branch decorations |

### Log View Types
| Key | Action | Shows |
|-----|--------|--------|
| `l` | Current branch | Current branch history |
| `h` | HEAD | HEAD history |
| `b` | All branches | All branch history |
| `a` | All references | Branches + tags |
| `L` | Local branches | Local branches only |

## Branch Management

Press `b` in status to open branch management (NOT branch history).

### Branch Operations
| Key | Action | Notes |
|-----|--------|-------|
| `b` | Checkout branch/revision | Switch branches |
| `l` | Checkout local branch | Local branches only |
| `r` | Checkout recent branch | Recently used |
| `c` | Create new branch | New branch from current |
| `s` | Create spin-off | New branch with current changes |
| `m` | Rename branch | Rename current branch |
| `D` | Delete branch | Delete selected branch |
| `X` | Reset branch | Hard reset |

## Commit View

When you press `<Enter>` on a commit, you see the commit details:

### Commit Navigation
| Key | Action | Notes |
|-----|--------|-------|
| `<Tab>` | Toggle file expansion | Show/hide file diffs |
| `{` | Previous hunk header | Navigate between hunks |
| `}` | Next hunk header | Navigate between hunks |
| `q` | Close commit view | Return to previous view |

### Understanding Hunks
A **hunk** is a contiguous block of changes in a file:
- Shows context lines around actual changes
- Can be staged/unstaged individually
- Allows fine-grained commit control

## Integration with Diffview

Neogit integrates with Diffview for enhanced diff viewing:

### From Normal Mode
| Keys | Action | Notes |
|------|--------|-------|
| `<leader>gd` | Open current changes in Diffview | Working directory diff |
| `<leader>gh` | File history (current file) | Current file's git history |
| `<leader>gH` | File history (repository) | Full repository history |
| `<leader>gc` | Close Diffview | Return to normal editing |

### For Specific Commits
From anywhere in Neovim:
```
:DiffviewOpen <commit-hash>
:DiffviewOpen HEAD~1
```

## Common Workflows

### Basic Git Workflow
1. `<leader>gg` - Open Neogit status
2. Navigate with `j`/`k` to files
3. `s` - Stage files/hunks you want to commit
4. `c` - Open commit popup, write message
5. `p` - Push when ready

### Reviewing Changes
1. `<leader>gg` - Open status
2. `<Tab>` - Expand files to see changes
3. `<Enter>` - View detailed file diff
4. `s`/`u` - Stage/unstage specific hunks

### Viewing History
1. `<leader>gg` - Open status
2. `l` - Open log view
3. `b` - Show all branches (for branch history)
4. `<Enter>` - View specific commit details

### Branch Management
1. `<leader>gg` - Open status
2. `b` - Open branch popup
3. `c` - Create new branch, or `b` to checkout existing

## Troubleshooting

### Nvim-Tree Conflicts
If Neogit doesn't play well with nvim-tree:
1. Close nvim-tree first: `<leader>e`
2. Then open Neogit: `<leader>gg`
3. Or use `<A-h/j/k/l>` to navigate between windows

### Exiting Neogit
- **Preferred**: `q` (configured in Neogit)
- **Alternative**: `:q` (standard Vim command)
- Both work, but `q` is more convenient

### View Confusion
- **Status `b`**: Opens branch management popup
- **Log `b`**: Shows all branches in history
- Context matters - same key, different actions!

## Tips

1. **Start with Status**: `<leader>gg` is your main entry point
2. **Use Tab Liberally**: `<Tab>` expands/collapses sections and files
3. **Stage Granularly**: Stage individual hunks for better commit messages
4. **Learn the Views**: Status → Log → Branch - each has different purposes
5. **Integration Power**: Use with Diffview for enhanced diff viewing
6. **Keyboard-Driven**: Everything can be done without mouse
7. **Refresh Often**: `<C-r>` updates status after external git commands

## Quick Reference Card

| Context | Key | Action |
|---------|-----|--------|
| Anywhere | `<leader>gg` | Open Neogit |
| Status | `s`/`u` | Stage/unstage |
| Status | `l` | Log view (history) |
| Status | `b` | Branch management |
| Status | `c` | Commit |
| Log | `b` | All branches view |
| Any | `q` | Close/exit |
| Any | `<Tab>` | Expand/collapse |

[Back to keybindings index](./README.md)