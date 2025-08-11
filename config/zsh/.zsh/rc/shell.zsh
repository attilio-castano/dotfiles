#!/usr/bin/env zsh
# Shell helpers: reset/reload utilities for interactive sessions

# Reset the current shell as a login shell.
# Uses the user's default shell when available, falling back to zsh.
reset_shell() {
    local sh
    sh=${SHELL:-zsh}
    echo "↻ Resetting shell as login: $sh -l"
    exec "$sh" -l
}

# Reload interactive config without replacing the process
# Useful for quick alias/function changes in this repo
reload_shell() {
    if [[ -f "$HOME/.zshrc" ]]; then
        echo "🔄 Reloading ~/.zshrc"
        source "$HOME/.zshrc"
    else
        echo "~/.zshrc not found"
        return 1
    fi
}

# Aliases live in aliases.zsh
