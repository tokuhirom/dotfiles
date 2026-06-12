# ADR-0020: lazy.nvim 本体を lockfile の commit に固定する

## ステータス

採用

## コンテキスト

supply chain risk の棚卸し (ADR-0016〜0019 の続き)。

nvim のプラグインは lazy.nvim の `lazy-lock.json` で全 23 個が commit 固定
されており、ADR-0016 (vim) と同等の状態が既に実現できていた。

しかし `lazy-bootstrap.lua` はプラグインマネージャである lazy.nvim 本体を
`--branch=stable` で clone しており、stable タグは upstream が動かせるため
commit 固定になっていなかった。vim-plug 本体が未固定だった問題 (ADR-0017)
と同じ構図で、ここが侵害されると lockfile による固定が無意味になる。

## 決定

`lazy-bootstrap.lua` を変更し、clone 後に `lazy-lock.json` に記録された
lazy.nvim 自身の commit を checkout する。

- pin の情報源は `lazy-lock.json` に一本化する (lazy.nvim は自分自身も
  lockfile で管理しているため、これを読むだけでよい)
- bootstrap にハッシュを直書きしないので、`:Lazy update` で lockfile が
  更新されれば bootstrap も自動的に追従し、二重管理が発生しない

vendoring (ADR-0017 の方式) ではなく checkout 方式にしたのは、lazy.nvim が
60k 行超と大きく diff レビューが現実的でないこと、commit hash の checkout で
内容がハッシュに紐づくため改竄検知の効果は同等であることによる。

## 理由

- プラグイン本体だけ固定してもマネージャが未固定では意味がない (ADR-0017 と同じ)
- lockfile を単一の情報源にすることで、更新時のオペレーションが
  「`:Lazy update` → lockfile の diff をレビュー → コミット」だけで済む

## 結果

- 新マシンでの初回起動時、lazy.nvim は lockfile の commit で配置される。
  動作検証済み (一時ディレクトリで bootstrap を実行し、checkout された HEAD が
  lockfile の commit と一致することを確認した)
- プラグイン更新の運用ルールを `config/.config/nvim/README.md` に記載した
- mason がインストールする LSP サーバーと treesitter パーサーは lockfile の
  管轄外であり、別途扱いを決める (→ ADR-0021)
