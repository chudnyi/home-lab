#!/usr/bin/env bash
set -eo pipefail
SELF_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "# Генерируется! Переменные задаём в .env.source" > "$SELF_DIR/.env"
cat "$SELF_DIR/.env.source" >> "$SELF_DIR/.env"
echo "SSH_PRIVATE_KEY=$(base64 < "$HOME/.ssh/id_rsa")" >> "$SELF_DIR/.env"
