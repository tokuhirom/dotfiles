#!/bin/bash
# macOS システム設定
# Usage: ./setup/setup-mac-settings.sh

set -e

echo "==> macOS システム設定を適用中..."

# === グローバル設定 ===

# ダークモード
defaults write NSGlobalDomain AppleInterfaceStyle -string "Dark"

# キーリピート設定
defaults write NSGlobalDomain InitialKeyRepeat -int 15  # 225 ms
defaults write NSGlobalDomain KeyRepeat -int 2          # 30 ms

# スマートクォートを無効化
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false

# Press and Hold を無効化（k を連打したら特殊な k を入力しようとする機能）
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

# すべてのファイル名拡張子を表示
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# ウィンドウアニメーションを無効化
defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false

# メニューバーを自動的に隠さない
defaults write NSGlobalDomain _HIHideMenuBar -bool false

# === Dock 設定 ===

# Dock を自動的に隠す
defaults write com.apple.dock autohide -bool true

# === Finder 設定 ===

# すべてのファイル名拡張子を表示
defaults write com.apple.finder AppleShowAllExtensions -bool true

# === ウィンドウマネージャー設定 ===

# 壁紙クリックでデスクトップ表示を無効化
defaults write com.apple.WindowManager EnableStandardClickToShowDesktop -bool false

# === CapsLock を Control にマッピング ===
# 1452-628-0 はキーボードの製品ID
defaults -currentHost write -g com.apple.keyboard.modifiermapping.1452-628-0 -array \
  "<dict><key>HIDKeyboardModifierMappingSrc</key><integer>30064771129</integer><key>HIDKeyboardModifierMappingDst</key><integer>30064771296</integer></dict>"

# === バッテリー残量をパーセント表示 ===
defaults write com.apple.menuextra.battery ShowPercent -bool true

# === メニューバーのボリューム表示を非表示 ===
defaults write com.apple.systemuiserver "NSStatusItem Visible com.apple.menuextra.volume" -int 0

# === キーボードショートカットの無効化 ===

# 前の入力ソースを選択（無効化）
/usr/libexec/PlistBuddy -c "Set AppleSymbolicHotKeys:60:enabled false" ~/Library/Preferences/com.apple.symbolichotkeys.plist 2>/dev/null || true

# 次の入力ソースを選択（無効化）
/usr/libexec/PlistBuddy -c "Set AppleSymbolicHotKeys:61:enabled false" ~/Library/Preferences/com.apple.symbolichotkeys.plist 2>/dev/null || true

# Spotlight を無効化
/usr/libexec/PlistBuddy -c "Set AppleSymbolicHotKeys:64:enabled false" ~/Library/Preferences/com.apple.symbolichotkeys.plist 2>/dev/null || true

# Dictation ショートカットを無効化（Control キーのダブルプレス）
/usr/libexec/PlistBuddy -c "Set AppleSymbolicHotKeys:164:enabled false" ~/Library/Preferences/com.apple.symbolichotkeys.plist 2>/dev/null || true

# === 設定を反映 ===

# Dock を再起動
killall Dock 2>/dev/null || true

# Finder を再起動
killall Finder 2>/dev/null || true

echo "==> 完了!"
echo "    一部の設定は再起動後に反映されます。"
