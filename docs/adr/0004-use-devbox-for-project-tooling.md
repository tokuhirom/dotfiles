# ADR-0004: プロジェクトのツールバージョン固定に devbox を使用

## ステータス
検討中

## コンテキスト
プロジェクトでのツールのバージョン固定を flake.nix で行っていたが、Nix に慣れていないメンバーが参加することを考えると、よりとっつきやすいツールが必要。

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
