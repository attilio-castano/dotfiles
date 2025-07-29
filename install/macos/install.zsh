#!/usr/bin/env zsh
# macOS package installation via Homebrew
# Assumes zsh is already the default shell

set -e

install_homebrew() {
    if ! command -v brew &> /dev/null; then
        echo "📦 Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        
        # Add Homebrew to PATH for Apple Silicon Macs
        if [[ -f "/opt/homebrew/bin/brew" ]]; then
            eval "$(/opt/homebrew/bin/brew shellenv)"
        fi
    else
        echo "📦 Homebrew already installed"
    fi
}

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