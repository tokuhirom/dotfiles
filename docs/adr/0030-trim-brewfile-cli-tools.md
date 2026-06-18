# ADR-0030: Brewfile の CLI ツールを整理する（廃止・プロジェクト移行・グローバル移行）

## ステータス
採用

## コンテキスト
ADR-0029 で mise と重複していた formula を Brewfile から削除した。続けて
Brewfile に残る CLI ツールを棚卸しした結果、次の3種類に分類できた。

1. もう使っていない / 別手段で代替できるもの（廃止）
2. 特定プロジェクトでしか使わないため、グローバルに常駐させる必要がないもの
   （各プロジェクトの `mise.toml` で管理する）
3. 全環境で使うため、グローバル mise (`config/.config/mise/config.toml`) に
   一本化したほうがよいもの

Homebrew にグローバル常駐させていると、どのプロジェクトが何に依存しているのか
分からなくなり、バージョンも固定されない。プロジェクト単位で必要なものは
プロジェクトの `mise.toml` に書くほうが、依存とバージョンが明確になる。

## 決定

### 廃止（Brewfile から削除し、再インストールしない）
- `crush` — 使っていない（ADR-0029 から本 ADR の廃止枠へ移動）
- `mercurial` — 使っていない
- `lv` — 使っていない
- `ranger` — 使っていない
- `emacs` — 使っていない
- `docker` / `docker-compose` — colima 同梱の docker CLI で足りる
- `lm-studio` — 使っていない
- `kind` — 使っていない
- `lazydocker` — 使っていない
- `skopeo` — 使っていない
- `buildpacks/tap/pack` — 使っていない
- `ditaa` — 使っていない
- `d2` — 使っていない

`docker-compose` 廃止に伴い、`bin/brew-sync` の docker-compose プラグイン
symlink 生成ブロックも削除した。

### プロジェクトの mise.toml で管理（Brewfile から削除）
グローバル常駐をやめ、必要なプロジェクトの `mise.toml` で入れる。
- `colima`, `crane`, `usacloud`, `playwright-cli`, `awscli`, `entr`,
  `just`, `go-task`, `s3cmd`, `graphviz`, `sops`, `sops-sakura-kms`

すでにコメントアウト済みだった `atlas` / `psqldef` / `runn` / `tbls` /
`borders` / `sketchybar` / `aerospace`(cask) も同方針で、対応する tap
(`ariga/tap`, `sqldef/sqldef`, `k1low/tap`, `felixkratz/formulae`,
`sacloud/usacloud`, `nikitabobko/tap`, `charmbracelet/tap`,
`buildpacks/tap`) ごと Brewfile から削除した。
`tokuhirom/tap` は `dcv` / `notebeam` / `sakpilot` が残るため維持する。

### グローバル mise (config.toml) で管理
全環境で使うため Brewfile から削除し、`config.toml` の `[tools]` に置く。
- `perl` — もともと `perl = "5.42.0"` が config.toml にあり重複していた
- `uv` — `uv = "0.10.8"` を新規追加

GUI アプリ (cask) は対象外。ただし `notebeam` / `sakpilot` は引き続き
Homebrew cask で管理する（mise は cask を扱えないため、GUI は Homebrew が適切）。

## 理由
- グローバルに常駐させる CLI を最小化し、何が入っているかを把握しやすくする。
- プロジェクト固有のツールはプロジェクトの `mise.toml` に置くことで、依存と
  バージョンがプロジェクトごとに明確になる。
- 削除はコメントで残さず物理削除する。撤去の記録は本 ADR と git 履歴に残る。

## 結果
- `bin/brew-sync` 実行時に、廃止・移行対象の formula が Homebrew から
  アンインストールされる。
- プロジェクト移行したツールは、使うプロジェクトの `mise.toml` に追記する
  必要がある（グローバルには入らなくなる）。
- `uv` は今後 `config/.config/mise/config.toml` でバージョン管理する。
- Brewfile の CLI セクションが整理され、常駐ツールが最小限になった。
