# ADR-0029: mise 管理済みの重複 formula を Brewfile から削除

## ステータス
採用

## コンテキスト
Brewfile の整理を進めるなかで、すでに mise の `[tools]`
(`config/.config/mise/config.toml`) で管理されているのに、Brewfile にも
`brew` エントリが残っている formula が複数見つかった。

| Brewfile | mise の定義 |
|----------|-------------|
| `brew "zellij"` | `zellij = "0.43.1"` |
| `brew "tmux"`   | `tmux = "3.6a"` |
| `brew "duckdb"` | `duckdb = "1.4.4"` |
| `brew "fd"`     | `fd = "10.3.0"` |
| `brew "opencode"` | `github:anomalyco/opencode = "1.3.0"` |

二重管理になっており、バージョンが Homebrew 側と mise 側でずれる、どちらが
実際に PATH 上で使われているか分かりにくい、という問題があった。

## 決定
これらの formula を Brewfile から削除し、mise 側 (`[tools]`) に一本化する。
バージョンの単一の真実は mise (`config.toml` / `mise.lock`) に置く。

Brewfile からは行を物理削除する。どこへ移したかは本 ADR と git 履歴で追える。

## 理由
- mise でツールバージョンを管理する方針 (ADR-0023: mise lockfile) に揃える。
- これらはすでに mise レジストリ / GitHub backend で問題なく導入できており、
  Homebrew で入れ直す必要がない。
- 二重管理を解消し、バージョンの単一の真実 (mise.lock) を維持する。

## 結果
- `bin/brew-sync` 実行時に上記 formula が Homebrew からアンインストールされる
  (mise 側のバイナリが PATH で使われる)。
- 今後これらのバージョン更新は `config/.config/mise/config.toml` で行う。
- Brewfile から CLI ツールを mise へ移す作業の第一歩。残りの CLI の整理は
  ADR-0030 で扱う。
