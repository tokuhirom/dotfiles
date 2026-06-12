# ADR-0017: vim-plug 本体をリポジトリに vendoring する

## ステータス

採用

## コンテキスト

ADR-0016 で vim プラグインを commit hash で固定したが、プラグインマネージャである
vim-plug 本体 (`~/.vim/autoload/plug.vim`) は

```
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

と master の HEAD を取得する手順のままだった。plug.vim はすべてのプラグインの
取得・実行を仲介するため、ここが侵害されると ADR-0016 の固定が無意味になる。
ADR-0016 の「今後の課題」として挙げていた項目である。

また、この dotfiles リポジトリは公開しているため、vendoring したファイル自体が
第三者に再配布される。出自の検証可能性とライセンス遵守の両方が必要になる。

## 決定

vim-plug の `plug.vim` を `config/.vim/autoload/plug.vim` としてリポジトリに
vendoring し、`link.sh` で `~/.vim/autoload/plug.vim` に symlink する。

- pin した commit: `3f17a5cc3d7b0b7699bb5963fef9435a839dada0` (2025-11-06)
- SHA-256: `e0999e57304865e75f5b15ee8637dc4ce5ba95917557f38f7cb63d454b53cfb4`

取り込み時の検証:

- raw URL からの curl ではなく `git clone` + `git show <commit>:plug.vim` で取得し、
  内容が commit hash に紐づくことを保証した
- 決定時点でローカルにインストール済みだった (= 動作確認済みの) plug.vim と
  バイト単位で一致することを確認した (ADR-0016 と同じ「動作実績のある版を採用する」方針)

ライセンス遵守:

- vim-plug は MIT License。公開リポジトリでの再配布にあたり、同じ commit の
  LICENSE を `config/.vim/autoload/plug.vim.LICENSE` として同梱した

## 理由

- vendoring により、plug.vim の内容が git で追跡され、変更はすべて diff として
  レビュー可能になる。upstream が侵害されても curl で取り込んでしまうことがない
- 新しいマシンのセットアップ時にネットワーク経由の取得が不要になり、
  セットアップ手順も `link.sh` に一本化される
- タグ (例: 0.14.0) ではなく commit hash を記録するのは、タグは移動できるが
  commit hash は内容に紐づくため

## 結果

- `link.sh` に `link .vim/autoload/plug.vim` を追加した
- `.vimrc` の curl によるインストール手順の記載を削除した
- 更新手順は `config/.vim/README.md` に記載。更新時は upstream の diff を
  レビューし、commit hash と SHA-256 を README に記録した上でコミットする
- セキュリティ修正も自動では入らないため、必要に応じて手動で更新する
