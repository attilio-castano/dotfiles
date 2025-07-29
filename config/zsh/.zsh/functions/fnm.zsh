# Fast Node Manager (fnm) configuration
# Cross-platform setup for Node.js version management

# Only configure fnm if it's installed
if command -v fnm >/dev/null 2>&1; then
    # Initialize fnm and enable automatic version switching
    eval "$(fnm env --use-on-cd)"
fi