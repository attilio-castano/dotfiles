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
