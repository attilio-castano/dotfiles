# Zsh syntax highlighting configuration for macOS
# This file is sourced every shell session

# Load syntax highlighting if installed via Homebrew
if command -v brew &> /dev/null; then
    local syntax_file="$(brew --prefix 2>/dev/null)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
    if [[ -f "$syntax_file" ]]; then
        source "$syntax_file"
    fi
fi