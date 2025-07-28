# Add directory to PATH if not already present
# Usage: path_add "/path/to/dir" [prepend|append]
path_add() {
    local dir="$1"
    local position="${2:-prepend}"  # Default to prepend
    
    # Validate input
    if [[ -z "$dir" ]]; then
        echo "path_add: directory argument required" >&2
        return 1
    fi
    
    # Resolve ~ and variables
    dir=$(eval echo "$dir")
    
    # Check if directory exists (optional warning)
    if [[ ! -d "$dir" ]]; then
        echo "path_add: warning: directory does not exist: $dir" >&2
    fi
    
    # Check if already in PATH using colon-wrapped comparison
    case ":${PATH}:" in
        *:"$dir":*)
            # Already exists, do nothing
            return 0
            ;;
        *)
            # Add to PATH based on position
            if [[ "$position" == "append" ]]; then
                export PATH="$PATH:$dir"
            else
                # Default: prepend (allows overriding system binaries)
                export PATH="$dir:$PATH"
            fi
            ;;
    esac
}