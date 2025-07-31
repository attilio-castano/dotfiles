#!/bin/bash
# Make zsh the default shell
# Handles installation and shell switching for SSH environments

set -e

change_shell_to_zsh() {
    if command -v zsh &> /dev/null; then
        ZSH_PATH=$(which zsh)
        
        # Add zsh to allowed shells if not present
        if ! grep -q "$ZSH_PATH" /etc/shells; then
            echo "Adding zsh to /etc/shells..."
            echo "$ZSH_PATH" | sudo tee -a /etc/shells
        fi
        
        # Change user shell
        if [[ "$SHELL" != "$ZSH_PATH" ]]; then
            echo "Changing shell to zsh..."
            chsh -s "$ZSH_PATH"
            echo "Shell changed for future logins."
            echo "Switching to zsh immediately..."
            exec zsh -l
        else
            echo "zsh is already the default shell"
        fi
    else
        echo "zsh not found. Install it first."
        return 1
    fi
}

# Install zsh if missing
install_zsh() {
    if ! command -v zsh &> /dev/null; then
        echo "Installing zsh..."
        if command -v apt-get &> /dev/null; then
            sudo apt-get update && sudo apt-get install -y zsh
        elif command -v yum &> /dev/null; then
            sudo yum install -y zsh
        elif command -v dnf &> /dev/null; then
            sudo dnf install -y zsh
        elif command -v pacman &> /dev/null; then
            sudo pacman -S zsh
        elif command -v brew &> /dev/null; then
            brew install zsh
        else
            echo "Unable to install zsh automatically. Please install manually:"
            echo "  Ubuntu/Debian: sudo apt-get install zsh"
            echo "  RHEL/CentOS:   sudo yum install zsh"
            echo "  Fedora:        sudo dnf install zsh"
            echo "  Arch:          sudo pacman -S zsh"
            echo "  macOS:         brew install zsh"
            return 1
        fi
    else
        echo "zsh is already installed"
    fi
}

main() {
    echo "🐚 Setting up zsh as default shell..."
    install_zsh && change_shell_to_zsh
    echo "✅ zsh setup complete!"
}

# Run if executed directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi