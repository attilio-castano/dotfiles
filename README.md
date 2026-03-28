# dotfiles

Personal development environment configuration.

## Setup

1. **Clone this repo**
   ```bash
   git clone https://github.com/YOUR_USERNAME/dotfiles.git ~/Developer/dotfiles
   cd ~/Developer/dotfiles
   ```

2. **Run the setup script**
   ```bash
   zsh install/macos/setup.zsh
   ```
   This will install Homebrew (if needed), all tools, and set up the environment.

3. **Create symlinks**
   ```bash
   cd config && stow -v */
   ```
   
   To preview what will happen without making changes:
   ```bash
   cd config && stow -nv */  # Dry run - shows what would be linked
   ```
   
   The setup script will automatically restart your shell when complete.

## What's Included

- Zsh configuration
- Neovim setup  
- Git config
- Ghostty terminal
- Tmux
- Starship prompt
- Various CLI tools (bat, ripgrep, fzf, etc.)

## Neovim Profiles

The default Neovim profile now lives under `config/nvim` and uses
LazyVim.

The previous handmade Neovim setup has been preserved as a legacy
profile under `config/nvim-handrolled`.

Use the default profile with plain `nvim`.

To launch the legacy profile explicitly:

```bash
NVIM_APPNAME=nvim-handrolled nvim
```

If the zsh config is loaded, you can also use:

```bash
nhandrolled
```
