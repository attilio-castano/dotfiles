# Zsh configuration file
# Environment variables and early setup are in .zshenv

# Load platform-specific shell configurations
if [[ -n "$PLATFORM" ]] && [[ -d "$DOTFILES/install/$PLATFORM/shell" ]]; then
    for config in "$DOTFILES/install/$PLATFORM/shell"/*.zsh(N); do
        source "$config"
    done
fi

# Load platform-independent functions
if [[ -d "$DOTFILES/config/zsh/.zsh/functions" ]]; then
    for func in "$DOTFILES/config/zsh/.zsh/functions"/*.zsh(N); do
        source "$func"
    done
fi

# Source aliases
[[ -f "$DOTFILES/config/zsh/.zsh/core/aliases.zsh" ]] && source "$DOTFILES/config/zsh/.zsh/core/aliases.zsh"

# Interactive shell configuration can go here