# ADR-0028: Nix を完全に廃止する

## ステータス
採用（ADR-0015 の「Nix を部分的に残す」方針を更新）

## コンテキスト
かつては CLI ツールを Nix (nix-darwin / home-manager)、ツール管理を devbox (内部で Nix を使用)
で管理していた。その後、段階的に Nix から離れてきた。

- ADR-0014: devbox を廃止し、ツール管理を mise に戻した（Nix 不要に）
- ADR-0015: macOS では Homebrew を Nix より優先することにした。ただしこの時点では
  「Homebrew で入手できないパッケージのみ Nix に残す」「nix-darwin は dotfiles リンクの
  管理に使用」とし、**Nix を部分的に残す前提**だった。最終的な廃止は「可能性を見据えている」
  という意向どまりだった。
- ADR-0007: dotfiles を素の symlink (link.sh) に移行
- ADR-0027: マシンセットアップを mise bootstrap に移行（dotfiles は mise の [dotfiles]）

この結果、Nix が実際に担っている役割は無くなった。ツールは mise、パッケージは Homebrew / apt、
dotfiles は mise の [dotfiles]、macOS 設定は setup スクリプトが担当している。
リポジトリに残っていた Nix 用ファイル (flake.nix を前提とした nix-darwin / home-manager
モジュール、`update-nix.sh`) は、`flake.nix` 自体が既に存在せず動かせない死蔵状態だった。

ADR-0015 が「Nix を部分的に残す」と読めるため、現状（Nix を一切使わない）と齟齬があった。
そこで Nix の完全廃止を正式な決定として記録する。

## 決定
Nix（nix-darwin / home-manager / devbox 経由を含む）を完全に廃止する。
Nix 関連のファイル・ドキュメントをリポジトリから削除する。

## 理由
- ADR-0014 / ADR-0015 / ADR-0027 を経て、Nix が担う役割が実際に無くなった。
- `flake.nix` が無く、残っていた Nix 用ファイルは動かせない死蔵ファイルだった。
- ツール=mise、パッケージ=Homebrew/apt、dotfiles=mise [dotfiles] という構成で完結しており、
  Nix を残す理由がない。
- ADR-0015 の「部分的に残す」前提を現状に合わせて明確に更新する必要があった。

## 結果
- 以下を削除した:
  - `update-nix.sh`（`nix flake update` 実行スクリプト）
  - `darwin/`（nix-darwin モジュール: default/homebrew/packages/system-settings.nix）
  - `home/`（home-manager モジュール: common/darwin/default/development/linux.nix）
  - `cheat/nix.md`（Nix チートシート）
  - `docs/package-mappings.md`（Homebrew → Nix のパッケージ名対応表）
- 今後パッケージ・ツール管理に Nix は使わない。
- 過去の ADR（ADR-0004, 0010, 0014, 0015 など）に残る Nix への言及は、当時の意思決定の
  歴史的記録としてそのまま残す。

## 関連
- ADR-0014: devbox から mise に戻す
- ADR-0015: macOS では Homebrew を Nix より優先する（本 ADR が方針を更新）
- ADR-0027: マシンセットアップを mise bootstrap に移行する
