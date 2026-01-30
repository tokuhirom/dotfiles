# Prometheus / PromQL チートシート

## 基本クエリ

```promql
# 全メトリクス一覧
{__name__=~".+"}

# 特定のメトリクス
up
node_cpu_seconds_total

# ラベルでフィルタ（完全一致）
node_cpu_seconds_total{mode="idle"}

# ラベルでフィルタ（正規表現）
node_cpu_seconds_total{mode=~"idle|iowait"}

# ラベル否定
node_cpu_seconds_total{mode!="idle"}

# 正規表現否定
node_cpu_seconds_total{mode!~"idle|iowait"}
```

## 範囲ベクトル

```promql
# 過去5分間のデータ
http_requests_total[5m]

# 使える単位: s, m, h, d, w, y
```

## 集約関数

```promql
# 合計
sum(http_requests_total)

# ラベルごとに合計
sum by (method) (http_requests_total)

# ラベルを除外して合計
sum without (instance) (http_requests_total)

# その他の集約: min, max, avg, count, stddev, stdvar
# topk, bottomk, quantile, count_values
topk(5, http_requests_total)
quantile(0.95, http_request_duration_seconds)
```

## レート計算

```promql
# 毎秒あたりの増加率（counter 向け）
rate(http_requests_total[5m])

# 瞬間的な増加率
irate(http_requests_total[5m])

# 範囲内の増加量
increase(http_requests_total[1h])
```

## 算術演算

```promql
# エラー率
sum(rate(http_requests_total{status=~"5.."}[5m]))
  /
sum(rate(http_requests_total[5m]))

# CPU 使用率(%)
100 - (avg by (instance) (rate(node_cpu_seconds_total{mode="idle"}[5m])) * 100)

# メモリ使用率(%)
(1 - node_memory_MemAvailable_bytes / node_memory_MemTotal_bytes) * 100
```

## ヒストグラム

```promql
# p95 レイテンシ
histogram_quantile(0.95, rate(http_request_duration_seconds_bucket[5m]))

# ラベル付き p99
histogram_quantile(0.99, sum by (le, method) (rate(http_request_duration_seconds_bucket[5m])))
```

## 便利な関数

```promql
# 値が存在するか（アラート向け）
absent(up{job="myservice"})

# ラベル操作
label_replace(up, "host", "$1", "instance", "(.*):.*")
label_join(up, "new_label", "-", "job", "instance")

# 時間関数
time()                          # 現在の Unix タイムスタンプ
timestamp(up)                   # メトリクスのタイムスタンプ

# クランプ
clamp_min(metric, 0)
clamp_max(metric, 100)

# 変化検出
changes(metric[5m])             # 値が変化した回数
resets(counter[5m])             # カウンターがリセットされた回数
deriv(gauge[5m])                # 線形回帰による変化率
predict_linear(gauge[1h], 3600) # 1時間後の予測値

# ソート
sort(metric)
sort_desc(metric)
```

## よく使うアラート例

```promql
# インスタンスダウン
up == 0

# ディスク残量 10% 以下
(node_filesystem_avail_bytes / node_filesystem_size_bytes) < 0.1

# 5xx エラー率が 5% 超え
sum(rate(http_requests_total{status=~"5.."}[5m]))
  /
sum(rate(http_requests_total[5m]))
  > 0.05

# メモリ使用率 90% 超え
(1 - node_memory_MemAvailable_bytes / node_memory_MemTotal_bytes) > 0.9
```

## HTTP API

```bash
# 即時クエリ
curl 'http://localhost:9090/api/v1/query?query=up'

# 範囲クエリ
curl 'http://localhost:9090/api/v1/query_range?query=up&start=2024-01-01T00:00:00Z&end=2024-01-02T00:00:00Z&step=15s'

# ラベル値一覧
curl 'http://localhost:9090/api/v1/label/job/values'

# メトリクス一覧
curl 'http://localhost:9090/api/v1/label/__name__/values'

# ターゲット一覧
curl 'http://localhost:9090/api/v1/targets'
```
