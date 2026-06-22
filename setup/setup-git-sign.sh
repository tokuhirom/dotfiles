#!/bin/bash
# コミット署名 (1Password の SSH 署名) のマシン固有設定をセットアップする (ADR-0032)
#
# 署名鍵・op-ssh-sign のパス・gpgsign はマシンごとに異なるため、
# 共有 dotfile (config/.gitconfig) には入れず ~/.gitconfig.local に置く。
# config/.gitconfig は末尾で `[include] path = ~/.gitconfig.local` している。
#
# このスクリプトは ~/.gitconfig.local の雛形を生成するだけ（OS 判定で
# op-ssh-sign のパスを埋める）。signingkey は手動で書き換えること。

set -eu

DEST="$HOME/.gitconfig.local"

if [ -e "$DEST" ]; then
    echo "$DEST は既に存在するため何もしない。"
    echo "署名鍵を変えたい場合は直接編集すること。"
    exit 0
fi

# OS ごとの 1Password op-ssh-sign のパス
case "$(uname -s)" in
Darwin) OP_SSH_SIGN="/Applications/1Password.app/Contents/MacOS/op-ssh-sign" ;;
Linux) OP_SSH_SIGN="/opt/1Password/op-ssh-sign" ;;
*)
    echo "未対応の OS: $(uname -s)" >&2
    exit 1
    ;;
esac

cat >"$DEST" <<EOF
# このマシン限定のコミット署名設定 (ADR-0032 / setup-git-sign.sh が生成)
# signingkey は自分の 1Password 署名鍵の公開鍵に書き換えること（ssh-add -L で確認可）。

[user]
	signingkey = ssh-ed25519 AAAA...ここを自分の公開鍵に書き換える...

[gpg]
	format = ssh

[gpg "ssh"]
	program = $OP_SSH_SIGN
	allowedSignersFile = ~/.config/git/allowed_signers

[commit]
	gpgsign = true

[tag]
	gpgsign = true
EOF

echo "$DEST を生成した。"
echo "次にやること: $DEST の signingkey を自分の公開鍵に書き換える。"
echo "  ssh-add -L   # 1Password SSH agent の公開鍵一覧"
