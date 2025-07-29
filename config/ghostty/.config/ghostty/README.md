# Ghostty Configuration

This directory contains a minimal Ghostty terminal configuration optimized for the Neovim setup in this repository.

## What's included

- **Nerd Font setup**: Configured to use `JetBrainsMono NFM Regular` for proper icon rendering in Neovim plugins
- **Minimal config**: Just the essentials needed for the best experience with this dotfiles setup

## Configuration Location

Ghostty looks for its configuration in different locations depending on your system and environment:

### Standard XDG Path (Linux/Unix)
```
~/.config/ghostty/config
```

### macOS Default
```
~/Library/Application Support/ghostty/config
```

### Using XDG on macOS
To use the standard XDG path on macOS (recommended for consistency), set the `XDG_CONFIG_HOME` environment variable in your shell:

**For Zsh (default on macOS):**
```bash
echo 'export XDG_CONFIG_HOME="$HOME/.config"' >> ~/.zshrc
source ~/.zshrc
```

**For Bash:**
```bash
echo 'export XDG_CONFIG_HOME="$HOME/.config"' >> ~/.bash_profile
source ~/.bash_profile
```

## Installation

The `install.sh` script in the repository root automatically handles the configuration placement:

- Installs to `$XDG_CONFIG_HOME/ghostty/config` if `XDG_CONFIG_HOME` is set
- Falls back to `~/.config/ghostty/config` otherwise
- Shows a warning on macOS if `XDG_CONFIG_HOME` is not set

## Font Requirements

The configuration specifies `JetBrainsMono NFM Regular` as the font family. To ensure proper icon rendering:

1. **Download JetBrains Mono Nerd Font** from [nerdfonts.com](https://www.nerdfonts.com/)
2. **Install the font** on your system
3. **Restart Ghostty** if it was running

If you prefer a different Nerd Font, edit the `font-family` setting in the config file:

```bash
font-family = YourPreferredNerdFont Regular
```

## Current Configuration

The current minimal config includes:

- **Font**: JetBrainsMono NFM Regular for Nerd Font icon support
- **Keybinding**: `Shift+Enter` sends a newline character (useful for some terminal applications)

## Customization

Feel free to extend this configuration with additional Ghostty settings. Common additions:

```bash
# Theme
theme = catppuccin-mocha

# Font size
font-size = 13

# Window transparency
window-theme = dark
unfocused-split-opacity = 0.7

# Cursor
cursor-style = bar
cursor-style-blink = true
```

For a complete list of available options, see the [Ghostty configuration documentation](https://ghostty.org/docs/config/).

## Troubleshooting

### Icons not showing in Neovim
1. Verify the Nerd Font is installed and active in Ghostty
2. Check that the font name matches exactly in the config
3. Restart Ghostty after font installation

### Config not loading
1. Verify the config file location using the paths above
2. Check that `XDG_CONFIG_HOME` is set correctly (if using XDG on macOS)
3. Ensure the config file is named exactly `config` (no extension)