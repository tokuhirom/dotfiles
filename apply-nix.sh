#!/usr/bin/env bash
set -e

# Nix 設定を適用するスクリプト
# macOS: darwin-rebuild switch
# Linux: home-manager switch

# ログディレクトリ
LOG_DIR="$HOME/.local/share/nix-logs"
mkdir -p "$LOG_DIR"
LOG_FILE="$LOG_DIR/apply-$(date +%Y%m%d-%H%M%S).log"

# stdout/stderr をログファイルにも出力
exec > >(tee -a "$LOG_FILE") 2>&1

echo "📝 Log file: $LOG_FILE"
echo "---"

HOSTNAME=$(hostname)

if [[ "$OSTYPE" == "darwin"* ]]; then
    echo "🍎 Applying Nix configuration for macOS ($HOSTNAME)..."

    if command -v darwin-rebuild &> /dev/null; then
        sudo darwin-rebuild switch --impure --flake ".#$HOSTNAME"
    else
        # 初回セットアップ時は nix run で実行
        sudo nix run nix-darwin -- switch --impure --flake ".#$HOSTNAME"
    fi
else
    echo "🐧 Applying Nix configuration for Linux ($USER@$HOSTNAME)..."
    home-manager switch --impure --flake ".#$USER@$HOSTNAME" -b backup
fi

echo "✅ Configuration applied successfully!"
