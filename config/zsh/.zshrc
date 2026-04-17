# Zsh configuration file
# Environment variables and early setup are in .zshenv

# Load all interactive shell configurations
if [[ -d "$DOTFILES/config/zsh/.zsh/rc" ]]; then
    for rc_file in "$DOTFILES/config/zsh/.zsh/rc"/*.zsh(N); do
        source "$rc_file"
    done
fi

# Interactive shell configuration can go here
# bun completions
[ -s "/Users/attiliocastano/.bun/_bun" ] && source "/Users/attiliocastano/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
