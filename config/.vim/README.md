# .vim

## プラグインのセキュリティ監査

commit 固定している全 vim プラグインのソースコード監査記録は
[AUDIT.md](AUDIT.md) を参照 (ADR-0025)。

## autoload/plug.vim (vim-plug 本体)

supply chain risk 低減のため、vim-plug 本体をこのリポジトリに vendoring している
(ADR-0017)。curl で master から取得する手順は廃止した。

- 取得元: https://github.com/junegunn/vim-plug
- pin している commit: `3f17a5cc3d7b0b7699bb5963fef9435a839dada0` (2025-11-06)
- SHA-256: `e0999e57304865e75f5b15ee8637dc4ce5ba95917557f38f7cb63d454b53cfb4`
- ライセンス: MIT (`plug.vim.LICENSE` として同梱)

### 更新手順

upstream の変更内容を確認した上で、git 経由で取得して commit hash で検証する
(raw URL からの curl は使わない):

```bash
git clone https://github.com/junegunn/vim-plug.git /tmp/vim-plug
cd /tmp/vim-plug
git log --oneline plug.vim   # 変更内容をレビュー
PIN=<新しい commit hash>
git show $PIN:plug.vim > ~/dotfiles/config/.vim/autoload/plug.vim
git show $PIN:LICENSE  > ~/dotfiles/config/.vim/autoload/plug.vim.LICENSE
sha256sum ~/dotfiles/config/.vim/autoload/plug.vim
```

更新したらこの README の commit hash と SHA-256 も書き換えること。
