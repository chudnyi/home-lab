#!/usr/bin/env bash
set -euo pipefail
#set -x

# https://www.docker.com/blog/how-to-deploy-on-remote-docker-hosts-with-docker-compose/

[[ ! -f ".env" ]] && echo "Не найден конфигурационный файл: .env" && exit 1
source .env
# Команды docker compose будут выполняться на этом хосте
export DOCKER_HOST="ssh://$SERVER_USER@$SERVER_HOST"

# Чтобы убрать сервис с сервера, закомментируй его конфиг в списке ниже
COMPOSE_STACKS=(
  "-f" "compose/traefik/docker-compose.yml"
  "-f" "compose/docker-host/docker-compose.yml"
  "-f" "compose/portainer/docker-compose.yml"
  "-f" "compose/jellyfin/docker-compose.yml"
  "-f" "compose/ssh-tunnel/docker-compose.yml"
  "-f" "compose/freshrss/docker-compose.yml"
  "-f" "compose/syncthing/docker-compose.yml"
  "-f" "compose/transmission/docker-compose.yml"
  "-f" "compose/uptime-kuma/docker-compose.yml"
  "-f" "compose/adguard/docker-compose.yml"
#  "-f" "compose/redis/docker-compose.yml"
#  "-f" "compose/photoprism/docker-compose.yml"
)

up() {
  echo "DOCKER_HOST: $DOCKER_HOST"
  docker compose -p "${STACK_NAME}" --env-file .env \
    "${COMPOSE_STACKS[@]}" \
    up --detach --remove-orphans
}

"$@"
