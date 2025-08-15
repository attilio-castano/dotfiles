#!/usr/bin/env zsh
# uv (Astral) installation script

install_uv() {
    local has_brew=false
    local brew_has_uv=false

    if command -v brew >/dev/null 2>&1; then
        has_brew=true
        if brew list --formula 2>/dev/null | grep -qx "uv"; then
            brew_has_uv=true
        fi
    fi

    if [[ "$brew_has_uv" == true ]]; then
        echo "🔄 Found Homebrew 'uv'; uninstalling to migrate..."
        brew uninstall uv || true
    fi

    # If uv exists and not via Homebrew, keep it
    if command -v uv >/dev/null 2>&1 && [[ "$brew_has_uv" == false ]]; then
        echo "uv already installed (non-Homebrew)"
        return 0
    fi

    echo "Installing uv (Astral)..."
    mkdir -p "${XDG_BIN_HOME:-$HOME/.local/bin}"
    # Official installer
    curl -LsSf https://astral.sh/uv/install.sh | sh

    if command -v uv >/dev/null 2>&1; then
        echo "uv installed successfully"
    else
        echo "uv installation completed, but 'uv' not found in PATH"
        echo "Ensure ${XDG_BIN_HOME:-$HOME/.local/bin} is in your PATH"
        return 1
    fi
}

# Run if executed directly
if [[ "${(%):-%x}" == "${0}" ]]; then
    install_uv
fi
