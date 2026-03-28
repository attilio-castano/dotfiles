# Render-Markdown Keybindings

render-markdown.nvim provides beautiful in-terminal markdown rendering, displaying headers, code blocks, tables, and more with enhanced visual formatting.

## Toggle Rendering

From normal mode in any markdown file:

| Keys | Action | Description |
|------|--------|-------------|
| `<leader>m` | Toggle rendering | Enable/disable markdown rendering |

## Available Commands

The plugin provides several commands you can use:

| Command | Description |
|---------|-------------|
| `:RenderMarkdown enable` | Enable rendering for current buffer |
| `:RenderMarkdown disable` | Disable rendering for current buffer |
| `:RenderMarkdown toggle` | Toggle rendering on/off |

## Features

When rendering is enabled, you'll see:

- **Headers**: Displayed with icons and background highlights
- **Code blocks**: Language-aware with borders and syntax highlighting
- **Tables**: Pretty borders and proper alignment
- **Checkboxes**: Visual checkboxes for task lists (`- [ ]` and `- [x]`)
- **Links**: Concealed URLs with highlighted link text
- **Block quotes**: Indented with visual indicators
- **Lists**: Bullet points with custom icons
- **Horizontal rules**: Rendered as continuous lines

## Tips

1. **Performance**: The plugin automatically disables for files larger than 10MB
2. **File types**: Works best with `.md`, `.markdown` files
3. **Modes**: Rendering is active in normal and command modes by default
4. **Anti-conceal**: When your cursor is on a line, concealed elements (like link URLs) become visible

## Integration

- Works seamlessly with treesitter for accurate syntax parsing
- Respects your colorscheme for consistent theming
- Compatible with other markdown plugins

Return to [keybindings overview](./README.md)