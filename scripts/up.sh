#!/usr/bin/env bash
set -euo pipefail

cp -n .env.example .env || true
if grep -qi '^ENABLE_NOTIFICATION=true' .env; then
  docker compose --env-file .env --profile optional up -d --build --remove-orphans
else
  docker compose --env-file .env up -d --build --remove-orphans
fi
