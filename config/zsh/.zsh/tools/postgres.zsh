# PostgreSQL client tools configuration
# Cross-platform PATH setup for psql, pg_dump, etc.

# macOS (Homebrew)
if [[ -d "/opt/homebrew/opt/libpq/bin" ]]; then
    export PATH="/opt/homebrew/opt/libpq/bin:$PATH"
# macOS (Intel Homebrew)
elif [[ -d "/usr/local/opt/libpq/bin" ]]; then
    export PATH="/usr/local/opt/libpq/bin:$PATH"
# Linux (common locations)
elif [[ -d "/usr/lib/postgresql/bin" ]]; then
    export PATH="/usr/lib/postgresql/bin:$PATH"
elif [[ -d "/usr/pgsql-*/bin" ]]; then
    export PATH="$(ls -d /usr/pgsql-*/bin | head -1):$PATH"
fi