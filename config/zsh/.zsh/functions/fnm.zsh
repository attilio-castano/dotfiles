# Fast Node Manager (fnm) configuration
# Cross-platform setup for Node.js version management

install_claude_code() {
    if command -v npm >/dev/null 2>&1; then
        if ! command -v claude-code >/dev/null 2>&1; then
            echo "Installing Claude Code..."
            npm install -g @anthropic-ai/claude-code
        fi
    else
        echo "npm not available for Claude Code installation"
        return 1
    fi
}

# Only configure fnm if it's installed
if command -v fnm >/dev/null 2>&1; then
    # Initialize fnm and enable automatic version switching
    eval "$(fnm env --use-on-cd)"
    
    # Install Claude Code after fnm setup
    install_claude_code
fi