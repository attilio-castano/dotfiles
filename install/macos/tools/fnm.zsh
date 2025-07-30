#!/usr/bin/env zsh
# Node.js setup via fnm (Fast Node Manager)

setup_nodejs() {
    if command -v fnm &> /dev/null; then
        echo "🟢 Setting up Node.js environment..."
        eval "$(fnm env)"
        fnm install --lts
        fnm use lts-latest
    else
        echo "⚠️  fnm not found - skipping Node.js setup"
        echo "   Node.js is required for npm-based tools"
        return 1
    fi
}