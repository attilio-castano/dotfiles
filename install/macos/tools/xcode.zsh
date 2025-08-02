#!/usr/bin/env zsh
# Xcode Command Line Tools installer

install_xcode_tools() {
    if command -v make &> /dev/null && command -v git &> /dev/null; then
        echo "✅ Xcode Command Line Tools already installed"
        return 0
    fi
    
    echo "📱 Installing Xcode Command Line Tools..."
    echo "   This will open a dialog - please follow the prompts"
    
    # Install command line tools
    xcode-select --install
    
    # Wait for installation to complete
    echo "⏳ Waiting for installation to complete..."
    until command -v make &> /dev/null && command -v git &> /dev/null; do
        sleep 5
        echo "   Still waiting..."
    done
    
    echo "✅ Xcode Command Line Tools installed successfully"
}