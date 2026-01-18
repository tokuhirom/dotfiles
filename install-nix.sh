#!/usr/bin/env bash
# Install Nix and apply dotfiles configuration
# This script installs Nix using the Determinate Systems installer
# and sets up home-manager with the dotfiles configuration.

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

print_header() {
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${BLUE}  $1${NC}"
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo
}

print_success() {
    echo -e "${GREEN}✓${NC} $1"
}

print_error() {
    echo -e "${RED}✗${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

print_info() {
    echo -e "${BLUE}ℹ${NC} $1"
}

# Detect OS
detect_os() {
    if [[ "$OSTYPE" == "darwin"* ]]; then
        echo "darwin"
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        echo "linux"
    else
        echo "unknown"
    fi
}

# Check if Nix is already installed
check_nix() {
    if command -v nix &> /dev/null; then
        return 0
    else
        return 1
    fi
}

# Install Nix using Determinate installer
install_nix() {
    print_header "Installing Nix"

    if check_nix; then
        print_success "Nix is already installed"
        nix --version
        return 0
    fi

    print_info "Installing Nix using Determinate Systems installer..."
    print_info "This installer:"
    echo "  • Enables flakes by default"
    echo "  • Has better uninstall support"
    echo "  • More reliable than the official installer"
    echo

    print_info "Downloading installer (progress will be shown)..."
    curl --proto '=https' --tlsv1.2 -fL --progress-bar https://install.determinate.systems/nix | sh -s -- install

    print_success "Nix installed successfully!"
}

# Source Nix profile
source_nix() {
    print_header "Configuring Nix environment"

    if [[ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]]; then
        print_info "Sourcing Nix daemon profile..."
        . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
        print_success "Nix environment configured"
    elif [[ -e "$HOME/.nix-profile/etc/profile.d/nix.sh" ]]; then
        print_info "Sourcing Nix profile..."
        . "$HOME/.nix-profile/etc/profile.d/nix.sh"
        print_success "Nix environment configured"
    else
        print_error "Could not find Nix profile script"
        print_info "You may need to restart your shell or source Nix manually"
        return 1
    fi
}

# Apply configuration
apply_config() {
    print_header "Applying dotfiles configuration"

    OS=$(detect_os)
    HOSTNAME=$(hostname)

    if [[ "$OS" == "darwin" ]]; then
        print_info "Detected macOS"
        print_warning "Please update flake.nix with your Mac hostname before running:"
        print_info "  1. Get your hostname: scutil --get LocalHostName"
        print_info "  2. Replace 'YOUR-MAC-HOSTNAME' in flake.nix"
        print_info "  3. Run: darwin-rebuild switch --flake ."
        echo
        print_info "For first-time setup, run:"
        echo "  nix run nix-darwin -- switch --flake ."

    elif [[ "$OS" == "linux" ]]; then
        print_info "Detected Linux"
        print_info "Hostname: $HOSTNAME"
        print_info "Applying home-manager configuration..."
        echo

        # First time setup - install home-manager and apply config
        if ! command -v home-manager &> /dev/null; then
            print_info "Installing and activating home-manager..."
            print_info "This will download packages - progress will be shown below"
            echo
            nix run home-manager/master --print-build-logs -- switch --flake ".#tokuhirom@$HOSTNAME" --show-trace
        else
            print_info "Updating home-manager configuration..."
            echo
            home-manager switch --flake ".#tokuhirom@$HOSTNAME" --show-trace
        fi

        echo
        print_success "Configuration applied successfully!"

    else
        print_error "Unknown operating system"
        return 1
    fi
}

# Verify installation
verify_install() {
    print_header "Verifying installation"

    if check_nix; then
        print_success "Nix is installed"
        nix --version
    else
        print_error "Nix is not available"
        return 1
    fi

    if nix flake --version &> /dev/null; then
        print_success "Flakes are enabled"
    else
        print_warning "Flakes are not enabled"
    fi

    echo
    print_info "Checking Nix-managed packages..."
    for cmd in git nvim tmux rg bat jq fd gh fzf; do
        if command -v $cmd &> /dev/null; then
            path=$(which $cmd)
            if [[ $path == /nix/store/* ]]; then
                print_success "$cmd → $path"
            else
                print_info "$cmd → $path (not from Nix yet)"
            fi
        fi
    done
}

# Main installation flow
main() {
    print_header "Nix Installation for dotfiles"
    echo "This script will:"
    echo "  1. Install Nix using Determinate Systems installer"
    echo "  2. Configure your environment"
    echo "  3. Apply dotfiles configuration"
    echo

    # Change to dotfiles directory
    cd "$(dirname "$0")"
    print_info "Working directory: $(pwd)"
    echo

    # Install Nix
    install_nix
    echo

    # Source Nix
    source_nix
    echo

    # Apply configuration
    apply_config
    echo

    # Verify
    verify_install
    echo

    print_header "Installation complete! 🎉"
    echo
    print_success "Next steps:"
    echo
    echo "  1. Restart your shell or source Nix:"
    echo "     source /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh"
    echo
    echo "  2. Verify packages are from Nix store:"
    echo "     which git nvim tmux"
    echo
    echo "  3. Run verification script:"
    echo "     ./verify-nix.sh"
    echo
    echo "  4. Read NIX_README.md for complete documentation"
    echo
    print_info "Current status: Phase 1 (Foundation) complete"
    print_info "Ready for Phase 2 (Package Management Migration)"
    echo
}

# Run main function
main
