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
    
    # Phase 1: Install Xcode Command Line Tools (required for build tools)
    install_xcode_tools
    
    # Phase 2: Install Homebrew (required for most other tools)
    install_homebrew
    
    # Phase 3: Install Homebrew packages
    install_homebrew_packages
    
    # Phase 4: Setup Node.js environment (required for npm tools)
    setup_nodejs
    
    # Phase 5: Install npm-based tools
    if command -v npm &> /dev/null; then
        echo "📦 Installing npm-based tools..."
        install_codex
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
