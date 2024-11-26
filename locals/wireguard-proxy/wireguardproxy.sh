#!/usr/bin/env bash
SELF_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SELF_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/$(basename "${BASH_SOURCE[0]}")"

wireguardproxy() {
# ✅ Работает.
  docker run \
      --name wireguardproxy \
      --restart unless-stopped \
      --privileged \
      -d \
      --label "script=$SELF_PATH" \
      -v "$SELF_DIR/entrypoint.sh:/entrypoint.sh:ro" \
      -v "$HOME/apps/wireguard/timeweb1.conf:/etc/wireguard/wgcf.conf:ro" \
      -p 1081:1080 \
      diwu1989/wireguardproxy:latest

# https://github.com/diwu1989/docker-wireguard-socks/blob/master/entrypoint.sh
# curl --socks5 127.0.0.1:1081 https://ipinfo.io
}

wireguardproxy
