#!/usr/bin/env zsh
# Helpers to manage GNU Stow packages in this repo

# Preview linking all packages from $DOTFILES/config
stow_preview_all() {
    (
        cd "$DOTFILES/config" || return 1
        stow -nv */
    )
}

# Apply linking all packages from $DOTFILES/config
stow_apply_all() {
    (
        cd "$DOTFILES/config" || return 1
        stow -v */
    )
}

