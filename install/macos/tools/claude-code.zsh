#!/usr/bin/env zsh
# Claude Code installation script

install_claude_code() {
    if command -v npm >/dev/null 2>&1; then
        if ! command -v claude-code >/dev/null 2>&1; then
            echo "Installing Claude Code..."
            npm install -g @anthropic-ai/claude-code
        else
            echo "Claude Code is already installed"
        fi
    else
        echo "npm not available for Claude Code installation"
        echo "Please install Node.js first (e.g., via fnm)"
        return 1
    fi
}

# Run if executed directly
if [[ "${(%):-%x}" == "${0}" ]]; then
    install_claude_code
fi