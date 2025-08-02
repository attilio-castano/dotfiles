#!/usr/bin/env zsh
# FZF configuration and helper functions

# Check if FZF is installed
if ! command -v fzf &> /dev/null; then
    echo "FZF is not installed. Please install it first."
    return 1
fi

# =============================================================================
# FZF Default Options
# =============================================================================

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

# Use fd for default command if available
if command -v fd &> /dev/null; then
    export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
fi

# =============================================================================
# FZF Key Binding Options
# =============================================================================

# CTRL-T - Paste the selected file path(s) into the command line
if command -v fd &> /dev/null; then
    export FZF_CTRL_T_OPTS="--preview 'bat --color=always {}' --preview-window right:60%"
fi

# ALT-C - cd into the selected directory
if command -v fd &> /dev/null; then
    export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'
    export FZF_ALT_C_OPTS="--preview 'ls -la {}'"
fi

# CTRL-R - Paste the selected command from history into the command line
export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview'"

# =============================================================================
# Helper Functions
# =============================================================================

# File finder with preview
ff() {
    fd --type f --hidden --exclude .git | fzf --bind "esc:abort" --preview "bat --color=always --style=numbers,changes,header {}" --preview-window=right:60% "$@"
}

# File editor - uses ff to find files then opens in editor
fe() {
    local files
    IFS=$'\n' files=($(ff --multi))
    [[ -n "$files" ]] && ${EDITOR:-nvim} "${files[@]}"
}

# Find and cd to any directory
fcd() {
    local dir
    dir=$(fd --type d --hidden --exclude .git --exclude node_modules --exclude Library --max-depth 5 | fzf --bind "esc:abort" --preview "ls -la {}" --preview-window=right:50%)
    [[ -n "$dir" ]] && cd "$dir"
}

# Interactive directory jumping with zoxide
zf() {
    if ! command -v zoxide &> /dev/null; then
        echo "zoxide is not installed"
        return 1
    fi
    
    local dir
    dir=$(zoxide query -l | fzf --bind "esc:abort" --preview "realpath {} 2>/dev/null && echo && ls -la {}" --preview-window=right:50%)
    [[ -n "$dir" ]] && cd "$dir"
}

# Grep for pattern in files (like Telescope grep_string)
lg() {
    if ! command -v rg &> /dev/null; then
        echo "ripgrep is not installed"
        return 1
    fi
    
    rg --color=always --line-number --no-heading --smart-case "${*:-}" | 
    fzf --ansi \
        --bind "esc:abort" \
        --delimiter : \
        --preview "bat --color=always {1} --highlight-line {2}" \
        --preview-window "right:60%:+{2}+3/3"
}

# Live ripgrep that updates as you type (like Telescope live_grep)
rgl() {
    if ! command -v rg &> /dev/null; then
        echo "ripgrep is not installed"
        return 1
    fi
    
    rg --color=always --line-number --no-heading --smart-case "" | 
    fzf --ansi \
        --bind "esc:abort" \
        --disabled \
        --query "$1" \
        --bind "change:reload:rg --color=always --line-number --no-heading --smart-case {q} || true" \
        --delimiter : \
        --preview "bat --color=always {1} --highlight-line {2}" \
        --preview-window "right:60%:+{2}+3/3"
}

# Find git projects in common directories
fp() {
    local selected_project
    selected_project=$(
        fd --type d --hidden --glob ".git" ~/Developer ~/Projects 2>/dev/null | 
        sed 's/\/.git\/$//' | 
        fzf --bind "esc:abort" \
            --preview "ls -la {} && echo && git -C {} status -sb" \
            --preview-window=right:60%
    )
    [[ -n "$selected_project" ]] && cd "$selected_project"
}

# Open recent files (from shell history)
fr() {
    local selected_file
    selected_file=$(
        fc -l 1 | 
        grep "nvim " | 
        sed "s/.*nvim //" | 
        awk "!seen[\$0]++" | 
        fzf --bind "esc:abort" --preview "bat --color=always {}"
    )
    [[ -n "$selected_file" ]] && nvim "$selected_file"
}

# Interactive git branch switcher
gb() {
    if ! command -v git &> /dev/null; then
        echo "git is not installed"
        return 1
    fi
    
    local branch
    branch=$(
        git branch -a | 
        grep -v HEAD | 
        fzf --bind "esc:abort" \
            --preview "git log --oneline --graph --color=always --decorate {}" | 
        sed "s/.* //" | 
        sed "s#remotes/[^/]*/##"
    )
    [[ -n "$branch" ]] && git checkout "$branch"
}

# Interactive git log browser
glog() {
    if ! command -v git &> /dev/null; then
        echo "git is not installed"
        return 1
    fi
    
    git log --oneline --color=always | 
    fzf --ansi \
        --bind "esc:abort" \
        --preview "git show --color=always {1}" \
        --preview-window=right:60%
}

# Kill process(es) with FZF
fkill() {
    local pid
    pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')
    if [ "x$pid" != "x" ]; then
        echo $pid | xargs kill -${1:-9}
    fi
}

# Search with ripgrep and edit the selected file at the specific line
rge() {
    local file line
    read -r file line <<<"$(rg --color=always --line-number --no-heading --smart-case "${*:-}" | fzf --ansi --delimiter : --preview "bat --color=always {1} --highlight-line {2}" --preview-window "right:60%:+{2}+3/3" | awk -F: '{print $1, $2}')"
    [[ -n "$file" ]] && ${EDITOR:-nvim} "$file" "+$line"
}

# Interactive docker container management
fdocker() {
    local container
    container=$(docker ps -a | sed 1d | fzf --multi | awk '{print $1}')
    [[ -n "$container" ]] && docker "$@" $container
}

# Browse and checkout git commits
fcommit() {
    local commit
    commit=$(git log --oneline --color=always | fzf --ansi --preview "git show --color=always {1}" --preview-window=right:60% | awk '{print $1}')
    [[ -n "$commit" ]] && git checkout "$commit"
}

# Interactive npm script runner
fnpm() {
    local script
    script=$(cat package.json | jq -r '.scripts | keys[]' | fzf --preview "cat package.json | jq -r '.scripts.\"{}\"'")
    [[ -n "$script" ]] && npm run "$script"
}

# =============================================================================
# Source FZF key bindings
# =============================================================================

# Source FZF key bindings if available (installed via package manager)
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f /usr/share/fzf/key-bindings.zsh ] && source /usr/share/fzf/key-bindings.zsh
[ -f /usr/share/fzf/completion.zsh ] && source /usr/share/fzf/completion.zsh
[ -f /opt/homebrew/opt/fzf/shell/key-bindings.zsh ] && source /opt/homebrew/opt/fzf/shell/key-bindings.zsh
[ -f /opt/homebrew/opt/fzf/shell/completion.zsh ] && source /opt/homebrew/opt/fzf/shell/completion.zsh