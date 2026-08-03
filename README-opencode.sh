opencode を setup/setup-opencode.sh でインストール。

1password に入っている token を取り出して

    opencode auth login

して、"Other" をえらんで、"sakura" というID で入れる。


## opencode v2 (opencode2)

v2 はコマンド名が `opencode2` で、v1 とは別バイナリなので共存できる。
mise registry / 公式インストーラがまだ v2 に対応していないため、
npm の `next` タグから mise の npm バックエンドで入れている (ADR-0038)。

定義は `config/.config/mise/config.toml`:

    "npm:@opencode-ai/cli" = { version = "0.0.0-next-16694", allow_builds = ["@opencode-ai/cli"] }

- postinstall でプラットフォーム別バイナリを取得するため `allow_builds` が必要。
  `npm_args = "--ignore-scripts=false"` は npm CLI にしか効かず、
  mise が内蔵の aube でインストールする環境 (mac 側がそうだった) では無視される。
- バージョンを上げるときは `npm view @opencode-ai/cli dist-tags` の `next` を見て手で書き換える。
  すでに入っているバージョンを入れ直す場合は `mise uninstall npm:@opencode-ai/cli@<version>` してから
  `mise install npm:@opencode-ai/cli`。

認証は v1 とは別に必要:

    opencode2 auth login

移行手順の詳細は https://opencode.ai/v2/docs/migrate-v1 を参照。
