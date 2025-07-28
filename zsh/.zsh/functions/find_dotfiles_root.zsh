# Find the dotfiles repository root by locating the .root marker file
find_dotfiles_root() {
    local root_file
    root_file=$(find ~ -name ".root" -path "*dotfiles*" 2>/dev/null | head -1)
    
    if [[ -n "$root_file" ]]; then
        dirname "$root_file"
    else
        echo "Error: Could not find dotfiles root (.root file not found)" >&2
        return 1
    fi
}