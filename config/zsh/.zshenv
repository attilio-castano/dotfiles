# Zsh environment variables - loaded by all zsh instances

# Dotfiles repository path (dynamically detected from this file's location)
export DOTFILES="${${(%):-%x}:h:h:h}"

# Load personal configuration variables (USER_NAME, USER_EMAIL, etc.)
source "$DOTFILES/config/zsh/.zsh/config.zsh"

# XDG Base Directory Specification - standard locations for user files
export XDG_CONFIG_HOME="${HOME}/.config"    # Configuration files (dotfiles, app settings)
export XDG_CACHE_HOME="${HOME}/.cache"      # Cache files (temporary, can be deleted safely)
export XDG_DATA_HOME="${HOME}/.local/share" # Data files (user data, application data)
export XDG_STATE_HOME="${HOME}/.local/state" # State files (logs, history, runtime state)

# XDG-adjacent directories (for consistency/documentation)
export XDG_BIN_HOME="${HOME}/.local/bin"    # User executables (personal scripts, binaries)
export XDG_LIB_HOME="${HOME}/.local/lib"    # User libraries (shared libraries, modules)
