#!/usr/bin/env zsh
# OpenCode configuration and installation

# Set OpenCode installation directory
# This environment variable is used by the OpenCode installer
export OPENCODE_INSTALL_DIR="$XDG_BIN_HOME"

install_opencode() {
    if command -v npm >/dev/null 2>&1; then
        if ! command -v opencode >/dev/null 2>&1; then
            echo "Installing OpenCode..."
            npm install -g opencode-ai@latest
        else
            echo "OpenCode is already installed"
        fi
    else
        echo "npm not available for OpenCode installation"
        echo "Please install Node.js first (e.g., via fnm)"
        return 1
    fi
}

# Run if executed directly
if [[ "${(%):-%x}" == "${0}" ]]; then
    install_opencode
fi