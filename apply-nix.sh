#!/usr/bin/env bash
set -e

# Nix 設定を適用するスクリプト
# macOS: darwin-rebuild switch
# Linux: home-manager switch

HOSTNAME=$(hostname)

if [[ "$OSTYPE" == "darwin"* ]]; then
    echo "🍎 Applying Nix configuration for macOS ($HOSTNAME)..."

    # Build first (as user), then activate (with sudo)
    echo "📦 Building configuration..."
    nix build ".#darwinConfigurations.$HOSTNAME.system" --impure

    echo "🔧 Activating configuration (sudo required)..."
    sudo ./result/sw/bin/darwin-rebuild activate

    # Clean up
    rm -f result
else
    echo "🐧 Applying Nix configuration for Linux ($USER@$HOSTNAME)..."
    home-manager switch --impure --flake ".#$USER@$HOSTNAME" -b backup
fi

echo "✅ Configuration applied successfully!"
