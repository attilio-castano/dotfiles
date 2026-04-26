# Starship prompt configuration
# Cross-platform setup for enhanced shell prompt

# Only configure starship for real terminals when it's installed
if [[ "$TERM" != "dumb" && -t 1 ]] && command -v starship >/dev/null 2>&1; then
    # Initialize starship prompt
    eval "$(starship init zsh)"
fi
