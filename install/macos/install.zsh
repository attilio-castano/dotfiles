#!/usr/bin/env zsh
# macOS package installation via Homebrew
# Assumes zsh is already the default shell

set -e

# Source pre-install tool configurations
TOOLS_DIR="$DOTFILES/config/zsh/.zsh/tools"
for tool_config in "$TOOLS_DIR"/*.zsh; do
    [[ -f "$tool_config" ]] && source "$tool_config"
done

install_packages() {
    local brewfile_path="$(dirname "$0")/Brewfile"
    
    if [[ -f "$brewfile_path" ]]; then
        echo "📋 Installing packages from Brewfile..."
        brew bundle --file="$brewfile_path"
    else
        echo "❌ Brewfile not found at $brewfile_path"
        return 1
    fi
}

main() {
    echo "🍎 Setting up macOS packages..."
    install_homebrew
    install_packages
    
    # Source post-install function configurations
    echo "⚙️  Configuring installed tools..."
    FUNCTIONS_DIR="$DOTFILES/config/zsh/.zsh/functions"
    for func_config in "$FUNCTIONS_DIR"/*.zsh; do
        [[ -f "$func_config" ]] && source "$func_config"
    done
    
    echo "✅ macOS setup complete!"
}

# Run if executed directly
if [[ "${(%):-%x}" == "${0}" ]]; then
    main "$@"
fi