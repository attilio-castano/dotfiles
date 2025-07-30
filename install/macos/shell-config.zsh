# macOS-specific shell configurations
# This file is sourced by the main zsh configuration when running on macOS

# Load all post-install configurations for installed tools
MACOS_DIR="$(dirname "${(%):-%x}")"
POST_INSTALL_DIR="$MACOS_DIR/post-install"

if [[ -d "$POST_INSTALL_DIR" ]]; then
    for config in "$POST_INSTALL_DIR"/*.zsh(N); do
        source "$config"
    done
fi