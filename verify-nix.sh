#!/usr/bin/env bash
# Verification script for Nix installation and configuration

set -e

echo "🔍 Verifying Nix installation and configuration..."
echo

# Check if Nix is installed
if ! command -v nix &> /dev/null; then
    echo "❌ Nix is not installed"
    echo "   Install with: curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install"
    exit 1
fi

echo "✅ Nix is installed"
nix --version
echo

# Check if flakes are enabled
if nix flake --version &> /dev/null; then
    echo "✅ Flakes are enabled"
else
    echo "❌ Flakes are not enabled"
    echo "   The Determinate installer should enable this by default"
    exit 1
fi
echo

# Try to evaluate the flake
echo "📦 Checking flake configuration..."
echo "   (This may download some packages on first run)"
if nix flake show --print-build-logs . 2>&1; then
    echo "✅ Flake configuration is valid"
else
    echo "❌ Flake configuration has errors"
    exit 1
fi
echo

# Check which packages are from Nix store
echo "🔧 Checking Nix-managed packages..."
for cmd in git nvim tmux rg bat jq fd gh fzf; do
    if command -v $cmd &> /dev/null; then
        path=$(which $cmd)
        if [[ $path == /nix/store/* ]]; then
            echo "  ✅ $cmd -> $path"
        else
            echo "  ⚠️  $cmd -> $path (not from Nix, this is OK for Phase 1)"
        fi
    else
        echo "  ❌ $cmd not found"
    fi
done
echo

echo "✨ Verification complete!"
echo
echo "Next steps:"
echo "1. Apply the configuration (with progress shown):"
echo "   home-manager switch --flake .#tokuhirom@$(hostname) --show-trace"
echo
echo "2. Verify packages point to /nix/store"
echo "3. Continue to Phase 2 for full package migration"
echo
echo "💡 Tip: Always use --print-build-logs or --show-trace to see progress!"
