# Homebrew environment setup
# Only loads on macOS when Homebrew is installed

# Source dependencies
[[ -f "$DOTFILES/config/zsh/.zsh/profile/platform.zsh" ]] && source "$DOTFILES/config/zsh/.zsh/profile/platform.zsh"
[[ -f "$DOTFILES/config/zsh/.zsh/profile/path.zsh" ]] && source "$DOTFILES/config/zsh/.zsh/profile/path.zsh"

# Only configure on macOS
if is_macos; then
    # Determine Homebrew prefix based on architecture
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
fi