# Zsh configuration file
# Environment variables and early setup are in .zshenv

# Load all interactive shell configurations
if [[ -d "$DOTFILES/config/zsh/.zsh/rc" ]]; then
    for rc_file in "$DOTFILES/config/zsh/.zsh/rc"/*.zsh(N); do
        source "$rc_file"
    done
fi

# Interactive shell configuration can go here