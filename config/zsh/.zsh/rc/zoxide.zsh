# Zoxide configuration
# Smart directory jumping based on usage frequency

# Only configure zoxide if it's installed
if command -v zoxide >/dev/null 2>&1; then
    # Initialize zoxide
    eval "$(zoxide init zsh)"
fi