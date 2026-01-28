# uv チートシート

## インラインスクリプト（依存関係埋め込み）

```python
#!/usr/bin/env -S uv run --script
# /// script
# requires-python = ">=3.12"
# dependencies = [
#     "requests>=2.31",
#     "pyfiglet>=1.0.4",
# ]
# ///

import requests
import pyfiglet

print(pyfiglet.figlet_format("Hello"))
```

`chmod +x script.py && ./script.py` で実行可能。
依存関係は自動でインストールされる。

## 基本コマンド

```bash
# プロジェクト初期化
uv init

# 依存関係追加
uv add requests
uv add --dev pytest

# 依存関係インストール
uv sync

# スクリプト実行
uv run python script.py
uv run pytest

# venv 作成
uv venv

# pip 互換
uv pip install requests
uv pip freeze
```

## ツールのインストール

```bash
# グローバルにツールをインストール
uv tool install ruff
uv tool install black

# ツール一覧
uv tool list
```

## Python バージョン管理

```bash
# Python インストール
uv python install 3.12

# Python 一覧
uv python list

# 特定バージョンで実行
uv run --python 3.12 script.py
```
