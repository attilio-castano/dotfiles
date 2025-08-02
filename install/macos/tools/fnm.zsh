#!/usr/bin/env zsh
# Node.js setup via fnm (Fast Node Manager)

# Clean up orphaned fnm multishell directories
cleanup_fnm_multishells() {
    local multishell_dir="${HOME}/.local/state/fnm_multishells"
    if [[ -d "$multishell_dir" ]]; then
        echo "🧹 Cleaning up orphaned fnm multishell directories..."
        local cleaned=0
        for dir in "$multishell_dir"/*_*(N); do
            local pid="${dir:t:r:s/_*/}"
            if ! ps -p "$pid" >/dev/null 2>&1; then
                rm "$dir"
                ((cleaned++))
            fi
        done
        if ((cleaned > 0)); then
            echo "   Removed $cleaned orphaned directories"
        fi
    fi
}

setup_nodejs() {
    if command -v fnm &> /dev/null; then
        echo "🟢 Setting up Node.js environment..."
        cleanup_fnm_multishells
        eval "$(fnm env)"
        fnm install --lts
        fnm use lts-latest
    else
        echo "⚠️  fnm not found - skipping Node.js setup"
        echo "   Node.js is required for npm-based tools"
        return 1
    fi
}