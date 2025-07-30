# PostgreSQL configuration for macOS
# This file is sourced every shell session

# Add PostgreSQL tools to PATH if installed via Homebrew
if command -v brew &> /dev/null; then
    local libpq_path="$(brew --prefix 2>/dev/null)/opt/libpq/bin"
    if [[ -d "$libpq_path" ]]; then
        path_add "$libpq_path"
    fi
fi