# Homebrew configuration for macOS
# This file is sourced every shell session

# Setup Homebrew environment based on architecture
if is_apple_silicon; then
    BREW_PREFIX="/opt/homebrew"
else
    BREW_PREFIX="/usr/local"
fi

# Configure Homebrew if installed
if [[ -f "$BREW_PREFIX/bin/brew" ]]; then
    # Add Homebrew to PATH
    path_add "$BREW_PREFIX/bin"
    path_add "$BREW_PREFIX/sbin"
    
    # Set Homebrew environment variables
    export HOMEBREW_PREFIX="$BREW_PREFIX"
    export HOMEBREW_CELLAR="$BREW_PREFIX/Cellar"
    export HOMEBREW_REPOSITORY="$BREW_PREFIX"
    
    # Use Homebrew's shellenv if available (includes completions, etc.)
    if [[ -x "$BREW_PREFIX/bin/brew" ]]; then
        eval "$("$BREW_PREFIX/bin/brew" shellenv)"
    fi
fi

# Function to install Homebrew (can be called manually)
install_homebrew() {
    if ! command -v brew &> /dev/null; then
        echo "📦 Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        
        # Setup for current session after install
        if [[ -f "$BREW_PREFIX/bin/brew" ]]; then
            eval "$("$BREW_PREFIX/bin/brew" shellenv)"
        fi
        
        echo "📦 Homebrew installed successfully"
    else
        echo "📦 Homebrew already installed"
    fi
}