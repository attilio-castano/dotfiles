# Git configuration helper functions

# Set git user configuration from environment variables
git_setup_user() {
    if [[ -n "$USER_NAME" && -n "$USER_EMAIL" ]]; then
        git config --global user.name "$USER_NAME"
        git config --global user.email "$USER_EMAIL"
        echo "Git user config updated:"
        echo "  Name: $USER_NAME"
        echo "  Email: $USER_EMAIL"
    else
        echo "Error: USER_NAME and USER_EMAIL environment variables not set" >&2
        return 1
    fi
}

# Show current git user configuration
git_show_user() {
    echo "Current git user configuration:"
    echo "  Name: $(git config --get user.name)"
    echo "  Email: $(git config --get user.email)"
}