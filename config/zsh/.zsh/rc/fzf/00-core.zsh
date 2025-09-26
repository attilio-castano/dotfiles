#!/usr/bin/env zsh
# Core FZF defaults shared by helper functions

export FZF_DEFAULT_OPTS="
    --height 60%
    --layout reverse
    --border
    --inline-info
    --preview-window 'right:60%:wrap'
    --bind 'ctrl-/:toggle-preview'
    --bind 'ctrl-u:preview-half-page-up'
    --bind 'ctrl-d:preview-half-page-down'
    --bind 'ctrl-y:preview-up'
    --bind 'ctrl-e:preview-down'
    --bind 'ctrl-f:preview-page-down'
    --bind 'ctrl-b:preview-page-up'
    --bind 'ctrl-g:preview-top'
    --bind 'ctrl-h:preview-bottom'
    --bind '?:toggle-preview-wrap'
    --bind 'ctrl-a:select-all'
    --bind 'ctrl-s:deselect-all'
"

if command -v fd &>/dev/null; then
    export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    export FZF_CTRL_T_OPTS="--preview 'bat --color=always {}' --preview-window right:60%"
    export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'
    export FZF_ALT_C_OPTS="--preview 'eza -la --icons --color=always {}'"
fi

export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview'"
