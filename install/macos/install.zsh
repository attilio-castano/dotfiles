#!/usr/bin/env zsh
# macOS package installation via Homebrew
# Assumes zsh is already the default shell

set -e

# Source homebrew setup from tools directory
SCRIPT_DIR="$(dirname "$0")"
TOOLS_DIR="$SCRIPT_DIR/../../config/zsh/.zsh/tools"
source "$TOOLS_DIR/homebrew.zsh"

install_packages() {
    local brewfile_path="$(dirname "$0")/Brewfile"
    
    if [[ -f "$brewfile_path" ]]; then
        echo "📋 Installing packages from Brewfile..."
        brew bundle --file="$brewfile_path"
    else
        echo "❌ Brewfile not found at $brewfile_path"
        return 1
    fi
}

main() {
    echo "🍎 Setting up macOS packages..."
    install_homebrew
    install_packages
    echo "✅ macOS setup complete!"
}

# Run if executed directly
if [[ "${(%):-%x}" == "${0}" ]]; then
    main "$@"
fi