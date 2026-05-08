#!/usr/bin/env bash
set -euo pipefail

cp -n .env.example .env || true
docker compose --env-file .env up -d
