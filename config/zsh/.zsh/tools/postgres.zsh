# PostgreSQL client tools configuration
# Cross-platform PATH setup for psql, pg_dump, etc.

# Source path utility function
source "$(dirname "$0")/../core/path.zsh"

# macOS (Homebrew Apple Silicon)
if [[ -d "/opt/homebrew/opt/libpq/bin" ]]; then
    path_add "/opt/homebrew/opt/libpq/bin"
# macOS (Homebrew Intel)
elif [[ -d "/usr/local/opt/libpq/bin" ]]; then
    path_add "/usr/local/opt/libpq/bin"
# Linux (common locations)
elif [[ -d "/usr/lib/postgresql/bin" ]]; then
    path_add "/usr/lib/postgresql/bin"
elif [[ -d "/usr/pgsql-*/bin" ]]; then
    # Find the newest PostgreSQL version
    local pgsql_bin=$(ls -d /usr/pgsql-*/bin 2>/dev/null | head -1)
    [[ -n "$pgsql_bin" ]] && path_add "$pgsql_bin"
fi