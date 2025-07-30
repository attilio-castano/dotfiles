# Homebrew installation function for macOS
# This file is only sourced during setup

# Function to install Homebrew
install_homebrew() {
    if ! command -v brew &> /dev/null; then
        echo "📦 Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        
        # Determine where Homebrew was installed
        local brew_prefix
        if is_apple_silicon; then
            brew_prefix="/opt/homebrew"
        else
            brew_prefix="/usr/local"
        fi
        
        # Setup for current session after install
        if [[ -f "$brew_prefix/bin/brew" ]]; then
            eval "$("$brew_prefix/bin/brew" shellenv)"
        fi
        
        echo "📦 Homebrew installed successfully"
    else
        echo "📦 Homebrew already installed"
    fi
}

# Function to install packages from Brewfile
install_homebrew_packages() {
    if command -v brew &> /dev/null; then
        echo "📋 Installing packages from Brewfile..."
        brew bundle --file="$DOTFILES/install/macos/Brewfile"
    else
        echo "❌ Error: Homebrew not found"
        return 1
    fi
}