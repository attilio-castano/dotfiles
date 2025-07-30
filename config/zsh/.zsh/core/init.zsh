# Core initialization - load platform-specific configurations
# This file should be sourced after platform detection

# Load platform-specific shell configurations
case "$PLATFORM" in
    macos)
        if [[ -f "$DOTFILES/install/macos/shell-config.zsh" ]]; then
            source "$DOTFILES/install/macos/shell-config.zsh"
        fi
        ;;
    linux)
        if [[ -f "$DOTFILES/install/linux/shell-config.zsh" ]]; then
            source "$DOTFILES/install/linux/shell-config.zsh"
        fi
        ;;
    # Add other platforms as needed
esac

# Load platform-independent functions
FUNCTIONS_DIR="$DOTFILES/config/zsh/.zsh/functions"
if [[ -d "$FUNCTIONS_DIR" ]]; then
    for func in "$FUNCTIONS_DIR"/*.zsh(N); do
        source "$func"
    done
fi