# Starship prompt configuration
# Cross-platform setup for enhanced shell prompt

# Only configure starship if it's installed
if command -v starship >/dev/null 2>&1; then
    # Initialize starship prompt
    eval "$(starship init zsh)"
fi