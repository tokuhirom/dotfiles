# ADR-0040: Claude Code の statusline を自前スクリプトにする

## ステータス
採用

## コンテキスト

Claude Code の statusline はデフォルトのままだった。実際に使っていて知りたいのは
次の 2 つ。

- **今週のレート制限をどのくらいのペースで消費しているか。**
  Claude のサブスクリプションには 7 日ウィンドウの利用上限がある。`/usage` を
  叩けば現在の使用率は見られるが、それは「今何 % 使ったか」でしかない。週の
  前半なのか後半なのかを頭で補正しないと、そのペースで使い続けて上限に当たるか
  判断できない。
- **どのモデルで喋っているか。** `opus[1m]` を既定にしつつ場面によって
  切り替えるので、今どれなのかが常に見えていてほしい。

Claude Code の statusline コマンドには stdin から JSON が渡る。v2.1.251 の
実装を確認したところ、以下が入っている。

- `.model.display_name` — モデル表示名
- `.rate_limits.seven_day` — `{ used_percentage, resets_at }` 7 日ウィンドウ
- `.rate_limits.five_hour` — `{ used_percentage, resets_at }` 5 時間ウィンドウ
- `.rate_limits.spend_limit` — gateway 利用時のみ
- `.context_window` — `{ used_percentage, total_input_tokens, ... }`
- `.workspace.current_dir`, `.cost`, `.prompt_cache`, `.pr`, `.worktree` など

`resets_at` が epoch 秒で取れるので、ウィンドウ経過率を自前で計算できる。

## 決定

`bin/claude-statusline`（bash + jq）を追加し、`~/.claude/settings.json` の
`statusLine.command` から呼ぶ。表示内容は

```
~/dotfiles │ main │ Opus5(1M) │ ctx 42% │ 7d 38% →89% (3d23h)
```

- `Opus5(1M)` — モデル名。素の `display_name` は `Opus 5 (1M context)` のように
  横幅を食うので、先頭の `Claude `・カッコ内の ` context`・数字と `(` の前の
  スペースを削って詰めている
- `ctx 42%` — コンテキストウィンドウの使用率
- `7d 38%` — 週次ウィンドウの現在の使用率
- `→89%` — **このペースで使い続けた場合の、リセット時点での予測使用率**
- `(3d23h)` — リセットまでの残り時間

予測値は `used_percentage / (ウィンドウ経過率)` で求める。ウィンドウ開始直後は
経過率が 0 に近く予測が発散するため、経過率は 2% で下限クランプする。

色はレート制限の使用率・予測値それぞれに対して 80% 未満=緑 / 80% 以上=黄 /
100% 以上=赤。コンテキスト使用率は 100% に達する前に auto-compact が走るので、
しきい値を下げて 70% 未満=緑 / 70% 以上=黄 / 90% 以上=赤 とする。

`rate_limits` は API キー利用時など存在しない場合があるので、無ければその
セクションごと出さない。

## 理由

- 「今 38%」より「このままだと週末に 89%」の方が、そのまま行動を決められる。
  100% を超えた予測が赤で出れば、ペースを落とすか軽いモデルに切り替える判断が
  その場でできる。
- `ccusage` のような外部ツールを入れずに済む。必要な数値は Claude Code 自身が
  stdin で渡してくれるので、依存は jq だけ。
- コンテキスト使用率は compaction が走る前に気付きたい値なので、レート制限とは
  別のしきい値を持たせている。
- 5 時間ウィンドウ（`.rate_limits.five_hour`）も同じ JSON から取れるので、欲しく
  なったら数行で足せる。今回は表示を詰め込みすぎないよう見送った。

## 結果

- `bin/claude-statusline` が追加された。
- `~/.claude/settings.json` に `statusLine` エントリが入った。この設定ファイルは
  dotfiles 管理下にないため、新しいマシンでは手動で設定する必要がある。
- statusline は毎回このスクリプトを起動するので、重い処理は足さないこと。
  現状は `git symbolic-ref` 1 回と `jq` 1 回のみ。
