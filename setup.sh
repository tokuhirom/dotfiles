#!/bin/bash
# マシンセットアップのエントリポイント (ADR-0027)
#
# mise bootstrap でセットアップを一本化した:
#   - dotfiles の symlink : mise.toml / mise.{macos,linux}.toml の [dotfiles]
#   - ツール             : config/.config/mise/config.toml の [tools] (ADR-0023)
#   - OS パッケージ等     : mise.toml の [tasks.bootstrap] (既存 setup スクリプトを呼ぶ)
#
# OS 固有の dotfiles を読み込むため `-E macos|linux` を付けて mise bootstrap を呼ぶ。
# このラッパは OS 検出と trust だけを担当する。中身は `mise bootstrap --help` 参照。

set -eu

cd "$(dirname "$0")"

case "$(uname -s)" in
Darwin) MISE_OS_ENV=macos ;;
Linux) MISE_OS_ENV=linux ;;
*)
    echo "未対応の OS: $(uname -s)" >&2
    exit 1
    ;;
esac

# mise 本体が無ければ導入する
if ! command -v mise >/dev/null 2>&1 && [ ! -x ~/.local/bin/mise ]; then
    curl https://mise.run | sh
fi
MISE=mise
command -v mise >/dev/null 2>&1 || MISE=~/.local/bin/mise

# 初回はリポジトリの mise 設定を信頼する必要がある
"$MISE" trust . >/dev/null 2>&1 || true

exec "$MISE" bootstrap -E "$MISE_OS_ENV" "$@"
