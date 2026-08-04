# ADR-0039: Playwright CLI を mise の npm バックエンドで管理する

## ステータス
採用

## コンテキスト

`@playwright/cli` (コマンド名 `playwright-cli`) を使いたくなった。
導入経路が複数あり、実際に二重管理になっていた。

- Homebrew の `playwright-cli` formula が `Brewfile` に入っていた (macOS のみ)。
- 公式が案内しているのは `npm install -g @playwright/cli@latest`。
  ただしグローバル npm インストールはバージョンが dotfiles に残らない。
- mise の registry には `playwright-cli` が無い (`mise registry` に該当なし)。

Linux 機では Homebrew を使っていないので、macOS だけ brew 版が入っていて
Linux では入らない、という非対称も生まれていた。

## 決定

mise の npm バックエンドで、実バージョンを pin して入れる。
`config/.config/mise/config.toml`:

```toml
"npm:@playwright/cli" = "0.1.17"
```

あわせて `Brewfile` の `brew "playwright-cli"` は行ごと削除する。

## 理由

- **npm バックエンド**: mise registry が対応するまでの繋ぎとして、公式が案内している
  npm パッケージをそのまま使える。ADR-0038 (opencode2) と同じ手口。
  registry 対応後は通常のツール定義に移せばよい。
- **実バージョンを pin**: supply chain 方針 (ADR-0016〜0021) に沿って、何が入るかを
  dotfiles 側で固定する。`mise.lock` にも記録される。
- **`allow_builds` は不要**: `@playwright/cli` とその依存 (`playwright` /
  `playwright-core`) には postinstall スクリプトが無いため、opencode2 のような
  ビルド許可は要らない。mise のデフォルト (install script 無効) のままで動く。
- **Brewfile から削除**: ADR-0029 と同じく、mise 管理済みのものを Homebrew にも
  残すとバージョンがずれ、どちらが PATH 上で使われるか分かりにくくなる。
  バージョンの単一の真実は mise (`config.toml` / `mise.lock`) に置く。

## 結果

- macOS / Linux の両方で `playwright-cli` が mise 経由で入る。
- macOS では `bin/brew-sync` 実行時に Homebrew 版がアンインストールされる。
- バージョン更新は手動。`npm view @playwright/cli version` を見て
  `config.toml` を書き換え、`MISE_EXPERIMENTAL=1 mise lock` で lockfile を更新する。
- ブラウザバイナリ (chromium など) は dotfiles では管理しない。必要になったら
  `npx playwright install chromium` 相当を都度実行する。巨大かつマシン依存のため。
