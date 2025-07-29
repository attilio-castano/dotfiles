# Homebrew package manager setup
# Cross-platform Homebrew installation and configuration

# Source path utility function
source "$(dirname "$0")/../core/path.zsh"

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
    if [[ -d "/opt/homebrew/bin" ]]; then
        path_add "/opt/homebrew/bin"
        path_add "/opt/homebrew/sbin"
        # Set other Homebrew environment variables
        export HOMEBREW_PREFIX="/opt/homebrew"
        export HOMEBREW_CELLAR="/opt/homebrew/Cellar"
        export HOMEBREW_REPOSITORY="/opt/homebrew"
    # Add Homebrew to PATH for Intel Macs
    elif [[ -d "/usr/local/bin" ]] && [[ -f "/usr/local/bin/brew" ]]; then
        path_add "/usr/local/bin"
        path_add "/usr/local/sbin"
        # Set other Homebrew environment variables
        export HOMEBREW_PREFIX="/usr/local"
        export HOMEBREW_CELLAR="/usr/local/Cellar"
        export HOMEBREW_REPOSITORY="/usr/local/Homebrew"
    fi
}

# Configure Homebrew PATH if it exists (for shell configuration)
if command -v brew >/dev/null 2>&1 || [[ -f "/opt/homebrew/bin/brew" ]] || [[ -f "/usr/local/bin/brew" ]]; then
    setup_homebrew_path
fi