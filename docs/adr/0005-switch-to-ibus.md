# ADR-0005: fcitx5 から ibus への切り替え

## ステータス
採用

## コンテキスト
Linux 環境での日本語入力に fcitx5-mozc を使用していたが、キーバインドの設定に問題があった。

具体的には以下の動作が期待通りに機能しなかった:
- **変換キー (Henkan)** でひらがなモードに切り替え
- **無変換キー (Muhenkan)** で直接入力モードに切り替え

これらは日本語キーボードの標準的な使い方であり、macOS や Windows では一般的に使われているキーバインドである。

## 決定
fcitx5 から ibus に切り替える。

変更内容:
- `fcitx5`, `fcitx5-mozc`, `fcitx5-gtk` を削除
- `ibus`, `ibus-engines.mozc` をインストール
- 環境変数を fcitx から ibus に変更 (`GTK_IM_MODULE`, `QT_IM_MODULE`, `XMODIFIERS`)
- fcitx5 の設定ファイルリンクを削除

## 理由
1. **キーバインドの問題**: fcitx5 では Henkan/Muhenkan キーでのモード切り替えが思った通りに動作しなかった
2. **シンプルさ**: ibus は Pop!_OS のデフォルト IME であり、システムとの統合が良好
3. **安定性**: ibus は長い歴史があり、Linux デスクトップ環境での動作が安定している

## 結果
- Henkan/Muhenkan キーでの日本語入力モード切り替えが期待通りに動作するようになる
- fcitx5 固有の設定ファイル (`.config/fcitx5`, `.config/akaza`) が不要になる
- ibus-setup で GUI から簡単に設定できる
- 適用後はログアウト/ログインまたは再起動が必要
