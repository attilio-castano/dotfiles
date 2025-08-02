# TODO

## SSH Enhancements

### SSH Agent Management
- [ ] Add `ssh_agent_setup()` function to detect and manage SSH agent status
- [ ] Show loaded keys in agent
- [ ] Auto-start agent if not running (Linux environments)
- [ ] Handle agent forwarding detection

### SSH Key Setup Refinements
- [ ] Enhance `ssh_key_setup()` to detect SSH agent forwarding
- [ ] Distinguish between local keys and forwarded keys
- [ ] Show which keys are being used for different operations
- [ ] Better feedback when keys are already in agent

### Use Cases to Address
- SSH into remote servers with agent forwarding (`ssh -A`)
- Clear indication of which keys are available (local vs forwarded)
- Seamless key management across different environments
- Better user feedback about SSH agent status

## Neovim Dashboard & Project Management

### Dashboard Improvements
- [ ] Add project management integration to dashboard
- [ ] Show recent projects alongside recent files
- [ ] Add quick project switching from dashboard
- [ ] Customize dashboard shortcuts for common workflows

### Telescope Project Integration
- [ ] Add project.nvim plugin for project detection and management
- [ ] Configure telescope-project picker for finding directories
- [ ] Set up keybindings for quick project switching
- [ ] Integrate with dashboard for seamless project navigation

## FZF Telescope-like Experience

### Core FZF Commands
- [ ] Create FZF file finder with preview (like Telescope find_files)
  ```bash
  # Find files with preview
  alias ff='fd --type f --hidden --exclude .git | fzf --preview "bat --color=always {}" --preview-window=right:60%'
  
  # With file type filtering and toggle preview
  alias fft='fd --type f --hidden --exclude .git | fzf --prompt="Files> " --header="CTRL-T: Toggle preview" --bind "ctrl-t:toggle-preview" --preview "bat --color=always {}" --preview-window=right:60%:hidden'
  ```

- [ ] Implement live grep functionality (like Telescope live_grep)
  ```bash
  # Interactive ripgrep
  alias lg='rg --color=always --line-number --no-heading --smart-case "${*:-}" | fzf --ansi --delimiter : --preview "bat --color=always {1} --highlight-line {2}" --preview-window "right:60%:+{2}+3/3"'
  
  # Live ripgrep that updates as you type
  alias rgl='rg --color=always --line-number --no-heading --smart-case "" | fzf --ansi --disabled --query "$1" --bind "change:reload:rg --color=always --line-number --no-heading --smart-case {q} || true" --delimiter : --preview "bat --color=always {1} --highlight-line {2}" --preview-window "right:60%:+{2}+3/3"'
  ```

### Directory Navigation
- [ ] Integrate zoxide with FZF for directory jumping
  ```bash
  # Interactive directory jumping with zoxide
  alias zf='cd "$(zoxide query -l | fzf --preview "ls -la {}" --preview-window=right:50%)"'
  
  # Find and cd to any directory
  alias fcd='cd "$(fd --type d --hidden --exclude .git | fzf --preview "ls -la {}" --preview-window=right:50%)"'
  ```

### Project Management
- [ ] Create project finder for git repositories
  ```bash
  # Find git projects in common directories
  alias fp='cd "$(fd --type d --hidden ".git$" ~/Developer ~/Projects 2>/dev/null | sed "s/\/.git$//" | fzf --preview "ls -la {} && echo && git -C {} status -sb" --preview-window=right:60%)"'
  ```

### Recent Files
- [ ] Implement recent files functionality
  ```bash
  # Using zsh history to track recent files opened in nvim
  alias fr='nvim "$(fc -l 1 | grep "nvim " | sed "s/.*nvim //" | awk "!seen[\$0]++" | fzf --preview "bat --color=always {}")"'
  ```

### Configuration & Integration
- [ ] Create dedicated FZF configuration file (e.g., `~/.zsh/rc/fzf.zsh`)
- [ ] Set up FZF default options for consistent behavior
- [ ] Add keybindings for quick access (CTRL-T, CTRL-R, ALT-C)
- [ ] Configure FZF color scheme to match terminal theme
- [ ] Add support for multi-select where appropriate
- [ ] Create helper functions for common workflows
- [ ] Document all aliases and functions

### Dependencies to Install
- [ ] Ensure `fd` (find alternative) is installed
- [ ] Ensure `rg` (ripgrep) is installed
- [ ] Ensure `bat` (cat alternative with syntax highlighting) is installed
- [ ] Ensure `fzf` is installed with shell integration
- [ ] Ensure `zoxide` is installed and configured

### Bat Configuration
- [ ] Configure bat to disable pager by default
  ```bash
  # Option 1: Environment variable in .zshenv
  export BAT_PAGER=""
  # or
  export BAT_PAGING=never
  ```
  
- [ ] Create bat config file
  ```bash
  # Create config directory and file
  mkdir -p ~/.config/bat
  echo "--paging=never" > ~/.config/bat/config
  ```
  
- [ ] Consider creating aliases for different bat modes
  ```bash
  # Always print without pager
  alias bcat='bat --paging=never'
  
  # Plain output without decorations
  alias bplain='bat --paging=never --style=plain'
  
  # Keep original bat with pager available
  alias bpager='bat --paging=always'
  ```

## Future Enhancements
- [ ] Add more installation scripts (homebrew, packages, fonts)
- [ ] Create bootstrap script for one-command setup
- [ ] Add bin/ directory for utility scripts
- [ ] Add docs/ directory for documentation