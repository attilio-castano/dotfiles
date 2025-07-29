# Homebrew installation (pre-install)
# Cross-platform Homebrew installation function

install_homebrew() {
    if ! command -v brew &> /dev/null; then
        echo "📦 Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        echo "📦 Homebrew installed successfully"
    else
        echo "📦 Homebrew already installed"
    fi
}