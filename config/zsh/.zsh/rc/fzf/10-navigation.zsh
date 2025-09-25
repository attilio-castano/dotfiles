#!/usr/bin/env zsh
# General-purpose FZF helpers (files, navigation, search)

ff() {
    fd --type f --hidden --exclude .git |
        fzf --bind "esc:abort" \
            --preview "bat --color=always --style=numbers,changes,header {}" \
            --preview-window=right:60% "$@"
}

fe() {
    local files
    IFS=$'\n' files=($(ff --multi))
    [[ -n "$files" ]] && ${EDITOR:-nvim} "${files[@]}"
}

fcd() {
    local dir
    dir=$(fd --type d --hidden --exclude .git --exclude node_modules --exclude Library --max-depth 5 |
        fzf --bind "esc:abort" \
            --preview "eza -la --icons --color=always {}" \
            --preview-window=right:60%)
    [[ -n "$dir" ]] && cd "$dir"
}

zf() {
    if ! command -v zoxide &>/dev/null; then
        echo "zoxide is not installed"
        return 1
    fi

    local dir
    dir=$(zoxide query -l |
        fzf --bind "esc:abort" \
            --preview "realpath {} 2>/dev/null && echo && eza -la --icons --color=always {}" \
            --preview-window=right:60%)
    [[ -n "$dir" ]] && cd "$dir"
}

lg() {
    if ! command -v rg &>/dev/null; then
        echo "ripgrep is not installed"
        return 1
    fi

    rg --hidden --color=always --line-number --no-heading --smart-case "${*:-}" |
        fzf --ansi \
            --bind "esc:abort" \
            --delimiter : \
            --preview "bat --color=always {1} --highlight-line {2}" \
            --preview-window "right:60%:+{2}+3/3"
}

rgl() {
    if ! command -v rg &>/dev/null; then
        echo "ripgrep is not installed"
        return 1
    fi

    rg --hidden --color=always --line-number --no-heading --smart-case "" |
        fzf --ansi \
            --bind "esc:abort" \
            --disabled \
            --query "$1" \
            --bind "change:reload:rg --hidden --color=always --line-number --no-heading --smart-case {q} || true" \
            --delimiter : \
            --preview "bat --color=always {1} --highlight-line {2}" \
            --preview-window "right:60%:+{2}+3/3"
}

fr() {
    local selected_file
    selected_file=$(fc -l 1 |
        grep "nvim " |
        sed "s/.*nvim //" |
        awk "!seen[\$0]++" |
        fzf --bind "esc:abort" --preview "bat --color=always {}")
    [[ -n "$selected_file" ]] && nvim "$selected_file"
}

fkill() {
    local pid
    pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')
    if [[ -n "$pid" ]]; then
        echo $pid | xargs kill -${1:-9}
    fi
}

rge() {
    local file line
    read -r file line <<<"$(rg --hidden --color=always --line-number --no-heading --smart-case "${*:-}" |
        fzf --ansi --delimiter : \
            --preview "bat --color=always {1} --highlight-line {2}" \
            --preview-window "right:60%:+{2}+3/3" |
        awk -F: '{print $1, $2}')"
    [[ -n "$file" ]] && ${EDITOR:-nvim} "$file" "+$line"
}
