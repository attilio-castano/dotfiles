ssh_key_setup() {
    local ssh_key="$HOME/.ssh/id_ed25519"
    local ssh_pub="$HOME/.ssh/id_ed25519.pub"
    
    if [[ -f "$ssh_key" && -f "$ssh_pub" ]]; then
        echo "SSH Key exists:"
        cat "$ssh_pub"
    else
        echo "Generating new SSH key..."
        [[ ! -d "$HOME/.ssh" ]] && mkdir -p "$HOME/.ssh" && chmod 700 "$HOME/.ssh"
        ssh-keygen -t ed25519 -C "$USER_EMAIL" -f "$ssh_key" -N ""
        echo "New SSH key:"
        cat "$ssh_pub"
        ssh-add "$ssh_key" 2>/dev/null
    fi
}