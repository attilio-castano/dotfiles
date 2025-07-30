#!/usr/bin/env zsh
# macOS package installation via Homebrew
# Assumes zsh is already the default shell

set -e

# Get the directory where this script is located
SCRIPT_DIR="$(dirname "$0")"

# Source pre-install configurations
PRE_INSTALL_DIR="$SCRIPT_DIR/pre-install"
if [[ -d "$PRE_INSTALL_DIR" ]]; then
    for config in "$PRE_INSTALL_DIR"/*.zsh; do
        [[ -f "$config" ]] && source "$config"
    done
fi

install_packages() {
    local brewfile_path="$SCRIPT_DIR/Brewfile"
    
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
    
    # Run pre-install setup (like installing Homebrew)
    install_homebrew
    
    # Install packages
    install_packages
    
    # Source post-install configurations
    echo "⚙️  Configuring installed tools..."
    POST_INSTALL_DIR="$SCRIPT_DIR/post-install"
    if [[ -d "$POST_INSTALL_DIR" ]]; then
        for config in "$POST_INSTALL_DIR"/*.zsh; do
            [[ -f "$config" ]] && source "$config"
        done
    fi
    
    echo "✅ macOS setup complete!"
}

# Run if executed directly
if [[ "${(%):-%x}" == "${0}" ]]; then
    main "$@"
fi