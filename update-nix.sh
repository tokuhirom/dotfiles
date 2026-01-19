#!/usr/bin/env bash
set -e

# Nix flake を更新するスクリプト

# ログディレクトリ
LOG_DIR="$HOME/.local/share/nix-logs"
mkdir -p "$LOG_DIR"
LOG_FILE="$LOG_DIR/update-$(date +%Y%m%d-%H%M%S).log"

# stdout/stderr をログファイルにも出力
exec > >(tee -a "$LOG_FILE") 2>&1

echo "📝 Log file: $LOG_FILE"
echo "---"

echo "🔄 Updating Nix flake..."
nix flake update

echo "✅ Flake updated successfully!"
echo ""
echo "Run ./apply-nix.sh to apply the updated configuration."
