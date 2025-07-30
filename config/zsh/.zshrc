# Zsh configuration file
# Environment variables and early setup are in .zshenv

# Source core initialization (loads platform-specific configs)
source "$DOTFILES/config/zsh/.zsh/core/init.zsh"

# Source aliases
[[ -f "$DOTFILES/config/zsh/.zsh/core/aliases.zsh" ]] && source "$DOTFILES/config/zsh/.zsh/core/aliases.zsh"

# Interactive shell configuration can go here