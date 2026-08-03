# ADR-0038: opencode v2 (opencode2) を npm バックエンド経由で mise に追加する

## ステータス
採用

## コンテキスト

opencode に v2 が出た。コマンド名は `opencode2` で、v1 の `opencode` とは
別バイナリなので共存できる。

導入経路が問題になった。

- mise の registry (`opencode`) はまだ v1 のみで、v2 に対応していない。
- 公式インストーラ (`curl https://opencode.ai/install | bash`) も v2 は未対応。
  v1 は `setup/setup-opencode.sh` がこれを使っている。
- 公式が案内している導入方法は `npm install -g @opencode-ai/cli@next`。

一方で、グローバルな `npm install -g` はバージョンが dotfiles に残らず、
他のツールが mise 管理なのと揃わない。

## 決定

mise の npm バックエンドで、実バージョンを pin して入れる。
`config/.config/mise/config.toml`:

```toml
"npm:@opencode-ai/cli" = { version = "0.0.0-next-16694", allow_builds = ["@opencode-ai/cli"] }
```

- v1 (`setup/setup-opencode.sh` の公式インストーラ経由) はそのまま残す。
- 更新は `npm view @opencode-ai/cli dist-tags` の `next` を見て手で書き換える。

## 理由

- **npm バックエンド**: mise registry が対応するまでの繋ぎとして、
  公式が案内している npm パッケージをそのまま使える。
  対応後は `opencode2 = "..."` のような通常の定義に移せばよい。
- **`@next` ではなく実バージョンを pin**: supply chain 方針 (ADR-0016〜0021) に沿って、
  何が入るかを dotfiles 側で固定する。`mise.lock` にも記録される。
  `next` タグは日に数回動くので、タグ指定だと再現性がない。
- **`allow_builds = ["@opencode-ai/cli"]`**: このパッケージは postinstall で
  プラットフォーム別バイナリを取得する。mise はデフォルトでインストールスクリプトを
  無効にするので、それだと起動時に「postinstall script was not run」で落ちる。
  スクリプト実行を許可する分だけ supply chain 上のリスクは上がるが、
  バージョンを pin しており、許可するパッケージも配列で明示している。

  最初は `npm_args = "--ignore-scripts=false"` にしていたが、これは npm CLI に
  引数を渡すオプションで、mise が内蔵の aube でインストールする環境では効かなかった
  (Linux 側は npm CLI、mac 側は aube になっていた)。`allow_builds` はどちらでも効く。
- **v1 を残す**: バイナリ名が違うので衝突しない。v2 が壊れているときの
  切り分けにも v1 が残っていた方がよい (ADR-0029 で opencode を mise に寄せたのと同じ動機)。

## 結果

- `opencode2` が mise 経由で使えるようになる。バージョンは dotfiles で管理される。
- 認証は v1 とは別に `opencode2 auth login` が必要。
- バージョン更新は手動。`next` タグの更新頻度が高いので、追随するかは都度判断する。
- mise registry が v2 に対応したら、この定義は通常のツール定義に置き換える。
