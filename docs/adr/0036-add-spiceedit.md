# ADR-0036: spiceedit (マウス操作前提のターミナルエディタ) を試験導入する

## ステータス
廃止（2026-07-23 に試用して即撤去。理由は末尾の「撤去 (2026-07-23)」を参照）

## コンテキスト

AI コーディングエージェント (claude / codex / crush など) を常用するようになり、
エディタで長時間コードを書くよりも、**エージェントが書いたコードをざっと見て
数行だけ手直しする**という使い方が増えてきた。

この用途では vim/neovim のキーバインドを思い出すコストの方が大きく、
「ファイルツリーをクリックして開き、該当行をクリックして直す」程度の操作で済む
軽量なエディタがあると都合がよい。

[SpiceEdit](https://github.com/cloudmanic/spice-edit) はこの用途に合致する:

- 単一の Go バイナリ (約 10MB)、依存なし、MIT ライセンス
- ターミナル内で動くが VS Code ライクな UI (左にファイルツリー、上部にタブ、
  シンタックスハイライト、下部にステータスバー)
- マウス駆動 (クリックで開く / ドラッグで選択 / ホイールでスクロール)
- SSH 先や zellij / tmux の中で使うことを想定した設計
- goreleaser 製のリリースがあり、mise の github バックエンドでそのまま導入できる

## 決定

`config/.config/mise/config.toml` の `[tools]` に以下を追加し、
mise の github バックエンドで導入する。

```toml
"github:cloudmanic/spice-edit" = "v0.0.41"
```

- バイナリ名は `spiceedit` (リポジトリ名 `spice-edit` とはハイフンの有無が違う)
- `mise.lock` に全プラットフォーム分の URL と sha256 を固定する (ADR-0023)

## 理由

- **mise で入れる**: 単一バイナリかつ goreleaser 形式のリリースがあるため、
  Homebrew を経由せず mise の github バックエンドで完結する。
  lockfile で URL と checksum を固定できるのでサプライチェーン方針 (ADR-0016〜0021)
  にも沿う。Linux / macOS 両方で同じ手順になる利点もある。
- **v0.0.41 を選んだ理由**: `config.toml` の `install_before = "7d"`
  (リリース直後の版を避ける方針) に合わせ、執筆時点の最新 v0.0.43 (当日リリース)
  ではなく約 1 ヶ月前の v0.0.41 を pin した。
- **バージョンが 0.0.x であること**: まだ初期段階のツールなので、
  「常用エディタを置き換える」のではなく **neovim と併用する試用** という位置づけ。

## 結果

- `spiceedit <path>` でエディタが起動する。
- neovim / vim の設定 (`config/.config/nvim/`, `config/.vimrc`) は一切変更しない。
  主エディタは引き続き neovim。
- 合わなければ `config.toml` から 1 行消して `mise.lock` を更新するだけで撤去できる
  (設定ファイルを `config/.config/` に置かないため、残骸が出ない)。
- 更新時は「バージョン更新の手順」(`cheat mise`) に従い、
  `config.toml` を書き換えてから lockfile を更新する。

## 撤去 (2026-07-23)

導入当日に試用したところ、**日本語が正しく表示されず実用にならなかった**ため撤去した。

原因は East Asian Width の扱いで、全角文字を 1 カラム幅として計算しているために
描画が 1 文字ずつずれ、結果として 1 文字おきに欠落して見える。ファイルツリーの
ファイル名・バッファ内のテキストの両方で発生する。

upstream にも同じ内容の issue が上がっているが、報告から 2 ヶ月経っても
コメント 0 件・open のままで、修正の見込みが立っていない:

- [cloudmanic/spice-edit#39 CJK (Chinese/Japanese/Korean) characters display incorrectly - missing characters](https://github.com/cloudmanic/spice-edit/issues/39)
  (2026-05-20 報告)

「エージェントが書いたコードをざっと見て手直しする」という当初の用途では
日本語のコメントや文字列を読む場面が普通にあるため、この状態では使えない。

撤去内容:

- `config/.config/mise/config.toml` から `"github:cloudmanic/spice-edit"` の行を削除
- `config/.config/mise/mise.lock` から該当エントリを削除
- `mise uninstall github:cloudmanic/spice-edit@0.0.41`

### 再検討する場合の条件

issue #39 が解消され、go-runewidth 相当の幅計算が入ったバージョンが出たら
再度試す価値はある。ツール自体のコンセプト (マウス駆動・単一バイナリ・SSH 前提) は
当初の想定どおり有用だった。
