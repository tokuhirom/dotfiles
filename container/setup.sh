#!/bin/sh
# nkf はなかった
container machine run -n dev --root apk add vim zsh curl bash git libstdc++ libgcc uv w3m jq tree wget the_silver_searcher ripgrep

