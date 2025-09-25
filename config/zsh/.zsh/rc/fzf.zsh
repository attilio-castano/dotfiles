#!/usr/bin/env zsh
# FZF configuration loader; sources modular helpers under ./fzf/

if ! command -v fzf &>/dev/null; then
    echo "FZF is not installed. Please install it first."
    return 1
fi

fzf_rc_dir="${0:h}/fzf"
if [[ -d "$fzf_rc_dir" ]]; then
    for module in "$fzf_rc_dir"/*.zsh(N); do
        source "$module"
    done
fi

unset fzf_rc_dir module
