#!/usr/bin/env zsh
# macOS setup script - orchestrates installation of all tools
# Assumes DOTFILES environment variable is set (via .zshenv)

set -e

# Source all tool installers
for tool in "$DOTFILES/install/macos/tools"/*.zsh(N); do
    source "$tool"
done

main() {
    echo "🍎 Setting up macOS..."
    echo "📁 Using DOTFILES: $DOTFILES"
    
    # Phase 1: Install Homebrew (required for most other tools)
    install_homebrew
    
    # Phase 2: Install Homebrew packages
    if command -v brew &> /dev/null; then
        echo "📋 Installing packages from Brewfile..."
        brew bundle --file="$DOTFILES/install/macos/Brewfile"
    else
        echo "❌ Error: Homebrew not found"
        return 1
    fi
    
    # Phase 3: Setup Node.js environment (required for npm tools)
    if command -v fnm &> /dev/null; then
        echo "🟢 Setting up Node.js environment..."
        eval "$(fnm env)"
        fnm install --lts
        fnm use lts-latest
    fi
    
    # Phase 4: Install npm-based tools
    if command -v npm &> /dev/null; then
        echo "📦 Installing npm-based tools..."
        install_opencode
        install_claude_code
    fi
    
    echo "✅ macOS setup complete!"
    echo "🔄 Restarting shell..."
    exec zsh -l
}

# Run if executed directly
if [[ "${(%):-%x}" == "${0}" ]]; then
    main "$@"
fi