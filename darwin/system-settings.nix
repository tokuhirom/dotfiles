{ config, pkgs, ... }: {
  # macOS システム設定
  # setup/setup-mac-settings.sh を宣言的に置き換え

  system.defaults = {
    # グローバル設定
    NSGlobalDomain = {
      # ダークモード
      AppleInterfaceStyle = "Dark";

      # キーリピート設定
      InitialKeyRepeat = 15;  # 通常の最小値は 15 (225 ms)
      KeyRepeat = 2;  # 通常の最小値は 2 (30 ms)

      # スマートクォートを無効化
      NSAutomaticQuoteSubstitutionEnabled = false;

      # Press and Hold を無効化（k を連打したら特殊な k を入力しようとする機能）
      ApplePressAndHoldEnabled = false;

      # すべてのファイル名拡張子を表示
      AppleShowAllExtensions = true;
    };

    # Dock 設定
    dock = {
      # Dock を自動的に隠す
      autohide = true;
    };

    # Finder 設定
    finder = {
      # すべてのファイル名拡張子を表示
      AppleShowAllExtensions = true;
    };

    # ウィンドウマネージャー設定
    WindowManager = {
      # 壁紙クリックでデスクトップ表示を無効化
      EnableStandardClickToShowDesktop = false;
    };

    # メニューバー設定
    menuExtraClock = {
      # バッテリー残量をパーセント表示
      # Note: この設定は com.apple.menuextra.battery で管理されます
    };
  };

  # 上記の system.defaults では設定できない項目を activation scripts で設定
  system.activationScripts.extraActivation.text = ''
    echo "macOS の追加設定を適用中..."

    # CapsLock を Control にマッピング（1452-628-0 はキーボードの製品ID）
    defaults -currentHost write -g com.apple.keyboard.modifiermapping.1452-628-0 -array \
      "<dict><key>HIDKeyboardModifierMappingSrc</key><integer>30064771129</integer><key>HIDKeyboardModifierMappingDst</key><integer>30064771296</integer></dict>"

    # バッテリー残量をパーセント表示
    defaults write com.apple.menuextra.battery ShowPercent -bool true

    # メニューバーのボリューム表示
    defaults write com.apple.systemuiserver "NSStatusItem Visible com.apple.menuextra.volume" -int 0

    # キーボードショートカットの設定
    # 注意: 初回適用時は再起動が必要な場合があります

    # 前の入力ソースを選択（無効化）
    /usr/libexec/PlistBuddy -c "Set AppleSymbolicHotKeys:60:enabled false" ~/Library/Preferences/com.apple.symbolichotkeys.plist 2>/dev/null || true

    # 次の入力ソースを選択（無効化）
    /usr/libexec/PlistBuddy -c "Set AppleSymbolicHotKeys:61:enabled false" ~/Library/Preferences/com.apple.symbolichotkeys.plist 2>/dev/null || true

    # Spotlight を無効化
    /usr/libexec/PlistBuddy -c "Set AppleSymbolicHotKeys:64:enabled false" ~/Library/Preferences/com.apple.symbolichotkeys.plist 2>/dev/null || true

    # Dictation ショートカットを無効化（Control キーのダブルプレス）
    /usr/libexec/PlistBuddy -c "Set AppleSymbolicHotKeys:164:enabled false" ~/Library/Preferences/com.apple.symbolichotkeys.plist 2>/dev/null || true

    echo "macOS の追加設定を適用しました"
  '';
}
