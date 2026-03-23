    OLLAMA_FLASH_ATTENTION="1" OLLAMA_KV_CACHE_TYPE="q8_0" /opt/homebrew/opt/ollama/bin/ollama serve

`OLLAMA_FLASH_ATTENTION`: Flash Attention は attention 計算を最適化してVRAM消費を減らしつつ高速化する手法。オンにして損することはほぼない。
`OLLAMA_KV_CACHE_TYPE=q8_0`: メモリ使用量 約50% に。
`OLLAMA_KV_CACHE_TYPE=q4_0`: メモリ使用量 約33% に。

glm-4.7-flash だと  19.5GB ぐらいメモリ食う印象。

## Model


 * `ollama run qwen3-coder:30b`
   * 速い。
 * `ollama run qwen3:8b`
   * planning 用にちょうどいいかもしれない


