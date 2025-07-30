#!/usr/bin/env zsh
# One-time macOS setup script
# Installs Homebrew and packages from Brewfile
# Assumes DOTFILES environment variable is set (via .zshenv)

set -e

# Source required utilities
source "$DOTFILES/config/zsh/.zsh/profile/platform.zsh"
source "$DOTFILES/config/zsh/.zsh/profile/path.zsh"
source "$DOTFILES/install/macos/shell/homebrew.zsh"

main() {
    echo "🍎 Setting up macOS..."
    echo "📁 Using DOTFILES: $DOTFILES"
    
    # Install Homebrew if needed
    install_homebrew
    
    # Set OpenCode installation directory before installing packages
    export OPENCODE_INSTALL_DIR="$XDG_BIN_HOME"
    
    # Install packages from Brewfile
    if command -v brew &> /dev/null; then
        echo "📋 Installing packages from Brewfile..."
        brew bundle --file="$DOTFILES/install/macos/Brewfile"
    else
        echo "❌ Error: Homebrew not found"
        return 1
    fi
    
    echo "✅ macOS setup complete!"
    echo "🔄 Restarting shell..."
    exec zsh -l
}

# Run if executed directly
if [[ "${(%):-%x}" == "${0}" ]]; then
    main "$@"
fi