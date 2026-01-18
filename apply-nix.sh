#!/usr/bin/env bash
set -e

# Nix 設定を適用するスクリプト
# macOS: darwin-rebuild switch
# Linux: home-manager switch

HOSTNAME=$(hostname)

if [[ "$OSTYPE" == "darwin"* ]]; then
    echo "🍎 Applying Nix configuration for macOS ($HOSTNAME)..."
    darwin-rebuild switch --impure --flake ".#$HOSTNAME"
else
    echo "🐧 Applying Nix configuration for Linux ($USER@$HOSTNAME)..."
    home-manager switch --impure --flake ".#$USER@$HOSTNAME" -b backup
fi

echo "✅ Configuration applied successfully!"
