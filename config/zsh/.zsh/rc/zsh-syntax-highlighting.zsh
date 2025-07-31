# Zsh syntax highlighting - interactive shell feature
# Provides syntax coloring as you type commands

# Load syntax highlighting based on platform/package manager
if is_macos && command -v brew &> /dev/null; then
    # macOS with Homebrew
    local syntax_file="$(brew --prefix 2>/dev/null)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
    [[ -f "$syntax_file" ]] && source "$syntax_file"
elif is_linux; then
    # Common Linux locations
    for syntax_file in \
        "/usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" \
        "/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" \
        "/usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"; do
        if [[ -f "$syntax_file" ]]; then
            source "$syntax_file"
            break
        fi
    done
fi