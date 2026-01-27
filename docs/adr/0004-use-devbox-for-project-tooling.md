# ADR-0004: プロジェクトのツールバージョン固定に devbox を使用

## ステータス
採用

## コンテキスト
プロジェクトでのツールのバージョン固定を flake.nix で行っていたが、Nix に慣れていないメンバーが参加することを考えると、よりとっつきやすいツールが必要。

また、これまで mise でプログラミング言語のバージョン管理を行っていたが、devbox に統一していく方針とする。

参考記事: https://zenn.dev/shimarisu_121/articles/12cbe01ee9fbe8

## 決定
devbox を試用する。

## 理由
- **学習コストが低い**: Nix の知識がなくても `devbox add` で簡単にパッケージ追加可能
- **JSON ベースの設定**: `devbox.json` は flake.nix より読みやすい
- **チーム導入しやすい**: 新メンバーでもすぐに環境構築できる
- **Nix の恩恵**: 内部的には Nix を使っているので再現性は確保される

## flake.nix との比較

| 項目 | flake.nix | devbox |
|------|-----------|--------|
| 学習コスト | 高い | 低い |
| 柔軟性 | 非常に高い | 中程度 |
| カスタムパッケージ | 自由に定義可能 | `github:owner/repo` で追加可能 |
| 設定ファイル | Nix 言語 | JSON |
| チーム導入 | Nix 知識が必要 | 容易 |

### nixpkgs 未登録パッケージの扱い

**flake.nix の場合:**
```nix
# 別プロジェクトの flake を inputs で参照
inputs.apprun-provisioner.url = "github:tokuhirom/apprun-dedicated-provisioner";
```

**devbox の場合:**
```bash
# GitHub の flake を追加
devbox add github:tokuhirom/apprun-dedicated-provisioner
```

devbox でも flake を参照できるが、flake.nix ほどの柔軟性（overlay、カスタムビルド設定など）はない。

## 結果
- `home/common.nix` に devbox を追加
- プロジェクトでは `devbox.json` でツールを管理
- 複雑なカスタマイズが必要な場合は flake.nix を併用

## mise からの移行方針

これまでプログラミング言語のバージョン管理には mise を使用していたが、devbox に統一していく。

### 変更点
- mise は zsh 起動時に自動ロードしない（`mise-activate` で手動有効化）
- 新規プロジェクトでは devbox を使用
- 既存プロジェクトは徐々に移行

### mise vs devbox

| 項目 | mise | devbox |
|------|------|--------|
| バックエンド | 各言語のバージョン管理ツール | Nix |
| 再現性 | 中程度 | 高い（Nix のおかげ） |
| 設定ファイル | `.mise.toml` | `devbox.json` |
| チーム導入 | 容易 | 容易 |

### 移行しない場合
- mise 固有の機能が必要な場合
- Nix でビルドできないパッケージがある場合
