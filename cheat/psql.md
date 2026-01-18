# psql チートシート

## 接続オプション

```bash
psql -h HOST -p PORT -U USER -d DATABASE
```

| オプション | 説明 |
|-----------|------|
| `-h HOST` | ホスト名 (デフォルト: localhost) |
| `-p PORT` | ポート番号 (デフォルト: 5432) |
| `-U USER` | ユーザー名 |
| `-d DATABASE` | データベース名 |
| `-W` | パスワード入力を強制 |
| `-w` | パスワード入力なし |
| `-f FILE` | SQLファイルを実行 |
| `-c "SQL"` | SQLを実行して終了 |

## 接続文字列

```bash
psql "postgresql://user:password@host:port/database"
psql "host=localhost port=5432 dbname=mydb user=myuser"
```

## メタコマンド (psql内)

### データベース操作

| コマンド | 説明 | MySQL相当 |
|---------|------|-----------|
| `\l` | データベース一覧 | `SHOW DATABASES` |
| `\c dbname` | データベース切り替え | `USE dbname` |
| `\conninfo` | 現在の接続情報 | |

### テーブル操作

| コマンド | 説明 | MySQL相当 |
|---------|------|-----------|
| `\dt` | テーブル一覧 | `SHOW TABLES` |
| `\dt+` | テーブル一覧 (サイズ付き) | |
| `\dt schema.*` | 特定スキーマのテーブル | |
| `\d tablename` | テーブル構造 | `DESCRIBE table` |
| `\d+ tablename` | テーブル構造 (詳細) | `SHOW CREATE TABLE` に近い |

### インデックス・制約

| コマンド | 説明 |
|---------|------|
| `\di` | インデックス一覧 |
| `\di+ tablename` | テーブルのインデックス詳細 |

### その他のオブジェクト

| コマンド | 説明 |
|---------|------|
| `\dv` | ビュー一覧 |
| `\df` | 関数一覧 |
| `\ds` | シーケンス一覧 |
| `\du` | ユーザー/ロール一覧 |
| `\dn` | スキーマ一覧 |

### 出力制御

| コマンド | 説明 |
|---------|------|
| `\x` | 拡張表示トグル (縦表示) |
| `\x auto` | 自動切り替え |
| `\pset format` | 出力形式設定 |
| `\o filename` | 出力先をファイルに |
| `\o` | 出力先を標準出力に戻す |

### 実行・編集

| コマンド | 説明 |
|---------|------|
| `\i filename` | SQLファイル実行 |
| `\e` | エディタでクエリ編集 |
| `\g` | 直前のクエリ再実行 |
| `\s` | コマンド履歴表示 |
| `\timing` | 実行時間表示トグル |

### ヘルプ・終了

| コマンド | 説明 |
|---------|------|
| `\?` | メタコマンドヘルプ |
| `\h SQL` | SQLコマンドヘルプ |
| `\q` | 終了 |

## CREATE TABLE 文の取得

```sql
-- pg_dump を使う方法 (推奨)
pg_dump -h HOST -U USER -d DATABASE -t tablename --schema-only

-- 情報スキーマから取得
SELECT column_name, data_type, is_nullable, column_default
FROM information_schema.columns
WHERE table_name = 'tablename';
```

## よく使うクエリ

```sql
-- テーブルサイズ
SELECT pg_size_pretty(pg_total_relation_size('tablename'));

-- 実行中クエリ
SELECT pid, query, state, query_start
FROM pg_stat_activity
WHERE state = 'active';

-- クエリをキャンセル
SELECT pg_cancel_backend(pid);

-- 接続を強制切断
SELECT pg_terminate_backend(pid);
```
