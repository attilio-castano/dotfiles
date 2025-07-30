# PostgreSQL tools PATH configuration
# Adds libpq tools (psql, pg_dump, etc.) to PATH if installed

# PostgreSQL tools via Homebrew (macOS)
if is_macos && command -v brew &> /dev/null; then
    local libpq_path="$(brew --prefix 2>/dev/null)/opt/libpq/bin"
    if [[ -d "$libpq_path" ]]; then
        path_add "$libpq_path"
    fi
fi

# PostgreSQL tools on Linux (common locations)
if is_linux; then
    # Check common PostgreSQL installation paths
    for pg_path in \
        "/usr/lib/postgresql/*/bin" \
        "/usr/pgsql-*/bin" \
        "/opt/postgresql/*/bin"; do
        for dir in $~pg_path(N); do
            if [[ -d "$dir" ]]; then
                path_add "$dir"
                break
            fi
        done
    done
fi