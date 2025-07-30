# Platform detection utilities
# Provides consistent platform detection across different systems

# Detect the current platform
# Sets PLATFORM to one of: macos, linux, bsd, windows, unknown
detect_platform() {
    case "$OSTYPE" in
        darwin*)
            export PLATFORM="macos"
            export PLATFORM_FAMILY="unix"
            ;;
        linux*)
            export PLATFORM="linux"
            export PLATFORM_FAMILY="unix"
            ;;
        freebsd*|openbsd*|netbsd*|dragonfly*)
            export PLATFORM="bsd"
            export PLATFORM_FAMILY="unix"
            ;;
        msys*|cygwin*|mingw*)
            export PLATFORM="windows"
            export PLATFORM_FAMILY="windows"
            ;;
        *)
            export PLATFORM="unknown"
            export PLATFORM_FAMILY="unknown"
            ;;
    esac
}

# Detect the CPU architecture
# Sets ARCH to one of: x86_64, arm64, x86, unknown
detect_architecture() {
    local machine_type=$(uname -m)
    case "$machine_type" in
        x86_64|amd64)
            export ARCH="x86_64"
            export ARCH_FAMILY="x86"
            ;;
        arm64|aarch64)
            export ARCH="arm64"
            export ARCH_FAMILY="arm"
            ;;
        i386|i686)
            export ARCH="x86"
            export ARCH_FAMILY="x86"
            ;;
        armv7*|armv6*)
            export ARCH="arm"
            export ARCH_FAMILY="arm"
            ;;
        *)
            export ARCH="unknown"
            export ARCH_FAMILY="unknown"
            ;;
    esac
}

# Detect Linux distribution if on Linux
# Sets DISTRO to one of: ubuntu, debian, fedora, rhel, arch, suse, alpine, unknown
detect_linux_distro() {
    if [[ "$PLATFORM" != "linux" ]]; then
        export DISTRO="none"
        return
    fi
    
    if [[ -f /etc/os-release ]]; then
        # Modern Linux distributions
        source /etc/os-release
        case "$ID" in
            ubuntu) export DISTRO="ubuntu" ;;
            debian) export DISTRO="debian" ;;
            fedora) export DISTRO="fedora" ;;
            rhel|centos) export DISTRO="rhel" ;;
            arch) export DISTRO="arch" ;;
            opensuse*) export DISTRO="suse" ;;
            alpine) export DISTRO="alpine" ;;
            *) export DISTRO="unknown" ;;
        esac
    elif [[ -f /etc/redhat-release ]]; then
        export DISTRO="rhel"
    elif [[ -f /etc/debian_version ]]; then
        export DISTRO="debian"
    else
        export DISTRO="unknown"
    fi
}

# Check if running on macOS with Apple Silicon
is_apple_silicon() {
    [[ "$PLATFORM" == "macos" && "$ARCH" == "arm64" ]]
}

# Check if running on macOS with Intel
is_intel_mac() {
    [[ "$PLATFORM" == "macos" && "$ARCH" == "x86_64" ]]
}

# Check if running on any macOS
is_macos() {
    [[ "$PLATFORM" == "macos" ]]
}

# Check if running on Linux
is_linux() {
    [[ "$PLATFORM" == "linux" ]]
}

# Check if running on WSL
is_wsl() {
    [[ "$PLATFORM" == "linux" && -n "$WSL_DISTRO_NAME" ]]
}

# Platform-specific path helper
# Usage: platform_path "macos:/opt/homebrew/bin" "linux:/usr/local/bin"
platform_path() {
    for arg in "$@"; do
        local platform="${arg%%:*}"
        local path="${arg#*:}"
        
        if [[ "$platform" == "$PLATFORM" ]]; then
            echo "$path"
            return 0
        fi
    done
    
    # No match found
    return 1
}

# Run detection on source
detect_platform
detect_architecture
detect_linux_distro

# Export convenience variables
export IS_MACOS=$(is_macos && echo "true" || echo "false")
export IS_LINUX=$(is_linux && echo "true" || echo "false")
export IS_WSL=$(is_wsl && echo "true" || echo "false")
export IS_APPLE_SILICON=$(is_apple_silicon && echo "true" || echo "false")
export IS_INTEL_MAC=$(is_intel_mac && echo "true" || echo "false")