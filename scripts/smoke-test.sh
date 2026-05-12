#!/usr/bin/env bash
set -euo pipefail

API_BASE_URL="${API_BASE_URL:-http://localhost:8080/api}"
SUFFIX="$(date +%s)"
SELLER_EMAIL="seller-${SUFFIX}@example.com"
BUYER_EMAIL="buyer-${SUFFIX}@example.com"
PASSWORD="password123"

require_cmd() {
  if ! command -v "$1" >/dev/null 2>&1; then
    echo "Missing required command: $1" >&2
    exit 1
  fi
}

require_cmd curl
require_cmd jq

echo "[0/9] Wait for gateway health"
for _ in $(seq 1 60); do
  if curl -fsS "http://localhost:8080/actuator/health" >/dev/null 2>&1; then
    break
  fi
  sleep 1
done
curl -fsS "http://localhost:8080/actuator/health" >/dev/null

echo "[1/9] Register seller"
curl -sfS -X POST "${API_BASE_URL}/auth/register" \
  -H 'Content-Type: application/json' \
  -d "{\"email\":\"${SELLER_EMAIL}\",\"password\":\"${PASSWORD}\",\"role\":\"SELLER\"}" >/dev/null

echo "[2/9] Register buyer"
curl -sfS -X POST "${API_BASE_URL}/auth/register" \
  -H 'Content-Type: application/json' \
  -d "{\"email\":\"${BUYER_EMAIL}\",\"password\":\"${PASSWORD}\",\"role\":\"BUYER\"}" >/dev/null

echo "[3/9] Login seller"
SELLER_TOKEN="$(curl -sfS -X POST "${API_BASE_URL}/auth/login" \
  -H 'Content-Type: application/json' \
  -d "{\"email\":\"${SELLER_EMAIL}\",\"password\":\"${PASSWORD}\"}" | jq -r '.accessToken')"

if [ -z "${SELLER_TOKEN}" ] || [ "${SELLER_TOKEN}" = "null" ]; then
  echo "Failed to obtain seller token" >&2
  exit 1
fi

echo "[4/9] Login buyer"
BUYER_TOKEN="$(curl -sfS -X POST "${API_BASE_URL}/auth/login" \
  -H 'Content-Type: application/json' \
  -d "{\"email\":\"${BUYER_EMAIL}\",\"password\":\"${PASSWORD}\"}" | jq -r '.accessToken')"

if [ -z "${BUYER_TOKEN}" ] || [ "${BUYER_TOKEN}" = "null" ]; then
  echo "Failed to obtain buyer token" >&2
  exit 1
fi

echo "[5/9] Seller creates auction"
AUCTION_ID="$(curl -sfS -X POST "${API_BASE_URL}/auctions" \
  -H "Authorization: Bearer ${SELLER_TOKEN}" \
  -H 'Content-Type: application/json' \
  -d '{"title":"Smoke Test Item","description":"Auction for smoke test","imageUrl":"https://example.com/item.png","category":"ELECTRONICS","startingPrice":10000,"reservePrice":12000,"minimumBidIncrement":500,"durationMinutes":60,"activateNow":true}' | jq -r '.id')"

if [ -z "${AUCTION_ID}" ] || [ "${AUCTION_ID}" = "null" ]; then
  echo "Failed to create auction" >&2
  exit 1
fi

echo "[6/9] Buyer places bid"
curl -sfS -X POST "${API_BASE_URL}/auctions/${AUCTION_ID}/bids" \
  -H "Authorization: Bearer ${BUYER_TOKEN}" \
  -H 'Content-Type: application/json' \
  -d '{"amount":12500}' >/dev/null

echo "[7/9] Verify auction query"
curl -sfS "${API_BASE_URL}/auctions/${AUCTION_ID}" >/dev/null
curl -sfS "${API_BASE_URL}/auctions/${AUCTION_ID}/bids" >/dev/null

echo "[8/9] Wallet top-up + transactions"
curl -sfS -X POST "${API_BASE_URL}/wallet/topup" \
  -H "Authorization: Bearer ${BUYER_TOKEN}" \
  -H 'Content-Type: application/json' \
  -d '{"amount":50000}' >/dev/null
curl -sfS "${API_BASE_URL}/wallet/balance" -H "Authorization: Bearer ${BUYER_TOKEN}" >/dev/null
curl -sfS "${API_BASE_URL}/wallet/transactions" -H "Authorization: Bearer ${BUYER_TOKEN}" >/dev/null

echo "[9/9] Listing/catalog and auth me"
curl -sfS "${API_BASE_URL}/listings" >/dev/null
curl -sfS "${API_BASE_URL}/auth/me" -H "Authorization: Bearer ${BUYER_TOKEN}" >/dev/null

echo "Smoke test passed"
