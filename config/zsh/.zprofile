# Zsh profile - loaded for login shells only
# This runs after .zshenv but before .zshrc

# Default editor configuration
export EDITOR="nvim"
export VISUAL="nvim"

# Load all profile configuration files
for profile_file in "$DOTFILES/config/zsh/.zsh/profile"/*.zsh(N); do
    source "$profile_file"
done
