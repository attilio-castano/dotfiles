# Homebrew package manager setup
# Cross-platform Homebrew installation and configuration

install_homebrew() {
    if ! command -v brew &> /dev/null; then
        echo "📦 Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        
        # Add Homebrew to PATH for current session
        setup_homebrew_path
    else
        echo "📦 Homebrew already installed"
    fi
}

setup_homebrew_path() {
    # Add Homebrew to PATH for Apple Silicon Macs
    if [[ -f "/opt/homebrew/bin/brew" ]]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    # Add Homebrew to PATH for Intel Macs
    elif [[ -f "/usr/local/bin/brew" ]]; then
        eval "$(/usr/local/bin/brew shellenv)"
    fi
}

# Configure Homebrew PATH if it exists (for shell configuration)
if command -v brew >/dev/null 2>&1; then
    setup_homebrew_path
fi