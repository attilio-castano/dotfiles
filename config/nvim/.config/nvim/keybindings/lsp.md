# LSP (Language Server Protocol) Keybindings

These keybindings are available when a language server is attached to a buffer. In this configuration, Pyright is configured for Python files.

## LSP Keybindings

These work in buffers where an LSP server is active:

### Navigation

| Key | Action | Description |
|-----|--------|-------------|
| `gd` | Go to definition | Jump to symbol definition |
| `gr` | Go to references | List all references |
| `K` | Hover | Show hover documentation |

### Code Actions

| Key | Action | Description |
|-----|--------|-------------|
| `<leader>r` | Rename | Rename symbol under cursor |
| `<leader>a` | Code action | Show available code actions |

### Diagnostics

| Key | Action | Description |
|-----|--------|-------------|
| `[d` | Previous diagnostic | Jump to previous error/warning |
| `]d` | Next diagnostic | Jump to next error/warning |
| `<leader>q` | Diagnostic list | Show all diagnostics in quickfix |

## Built-in LSP Commands

These Vim commands are available when LSP is active:

| Command | Description |
|---------|-------------|
| `:LspInfo` | Show LSP server status |
| `:LspRestart` | Restart LSP servers |
| `:LspStop` | Stop LSP servers |
| `:LspStart` | Start LSP servers |

## Python-Specific Features

With Pyright configured:

### Type Checking & Navigation
- Real-time type checking
- Import resolution
- Go to definition across modules
- Find references
- Hover for type information
- Basic diagnostics without opinionated style rules

## Common Workflows

### Navigate Code
1. Place cursor on a symbol
2. `gd` to jump to definition
3. `<C-o>` to jump back

### Fix Import Issues
1. When you see an import error
2. Place cursor on the import
3. `<leader>a` for code actions
4. Select "Organize imports" or relevant fix

### Rename Across Project
1. Place cursor on symbol
2. `<leader>r` to rename
3. Type new name
4. Press `<CR>` to confirm

### Review All Errors
1. `<leader>q` to populate quickfix with diagnostics
2. `:copen` to open quickfix window
3. Navigate with `:cnext` and `:cprev`

## Diagnostic Signs

In the sign column (left of line numbers):

| Sign | Meaning |
|------|---------|
| `E` | Error |
| `W` | Warning |
| `I` | Information |
| `H` | Hint |

## Tips

1. **Hover Documentation**: Hold `K` to keep hover window open longer
2. **Multiple References**: Use `gr` then navigate with quickfix
3. **Chain Navigation**: `gd` to definition, then `gr` to see usage
4. **Auto-completion**: Works automatically as you type (if configured)

## Troubleshooting

### Check LSP Status
```vim
:LspInfo
```

### View LSP Logs
```vim
:lua vim.cmd('e'..vim.lsp.get_log_path())
```

### Restart Misbehaving Server
```vim
:LspRestart
```

[Back to keybindings index](./README.md)