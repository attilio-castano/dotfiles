#!/usr/bin/env zsh
# Codex CLI installation script (npm-based)

install_codex() {
    if command -v npm >/dev/null 2>&1; then
        if ! command -v codex >/dev/null 2>&1; then
            echo "Installing Codex CLI..."
            npm install -g @openai/codex
        else
            echo "Codex CLI is already installed"
        fi
    else
        echo "npm not available for Codex installation"
        echo "Please install Node.js first (e.g., via fnm)"
        return 1
    fi
}

# Run if executed directly
if [[ "${(%):-%x}" == "${0}" ]]; then
    install_codex
fi

