# bidmart-infra

`bidmart-infra` adalah pusat local development untuk seluruh microservice BidMart.

## Tujuan

- menjalankan semua service end-to-end dengan satu command
- menyatukan env/port/dependency service
- menyediakan smoke test integrasi

## Service di Compose

- `gateway` (8080)
- `auth-service` (8081)
- `listing-query-service` (8082)
- `auction-query-service` (8083)
- `bidding-command-service` (8084)
- `wallet-service` (8085)
- `notification-service` (8086, optional profile)
- `frontend` (5173)
- `postgres` (5432)

## Setup

```bash
cp .env.example .env
```

## Run End-to-End

```bash
docker compose --env-file .env up -d --build
```

Atau:

```bash
./scripts/up.sh
```

Stop:

```bash
./scripts/down.sh
```

## Smoke Test

```bash
./scripts/smoke-test.sh
```

Flow yang diverifikasi:

- register/login
- create auction + place bid
- auction/listing query
- wallet topup/balance/transactions
- auth me

## Catatan Arsitektur

- auth source of truth: `bidmart-auth-service`
- wallet source of truth: `bidmart-wallet-service`
- auction/bidding command source of truth: `bidmart-bidding-command-service`
- gateway hanya routing/proxy untuk domain tersebut
