# bidmart-infra

Repository ini berfungsi sebagai pusat **local development infrastructure** untuk ekosistem microservice BidMart (docker compose, template environment, dan dokumentasi integrasi). Repository ini **tidak menyimpan business logic**.

## Scope Repository
- Menjalankan seluruh service BidMart secara lokal dengan satu perintah.
- Menyediakan baseline port mapping agar tidak tabrakan.
- Mendokumentasikan routing table gateway (draft).
- Menjadi checklist migrasi strangler pattern dari monolith ke multi-repo.

## Service Target
- bidmart-gateway
- bidmart-frontend
- bidmart-auth-service
- bidmart-listing-query-service
- bidmart-auction-query-service
- bidmart-bidding-command-service
- bidmart-wallet-service
- bidmart-notification-service (opsional)

## Struktur Folder

```txt
.
├── docker-compose.yml
├── .env.example
├── gateway/
├── postgres/
│   ├── data/
│   └── init.sql
├── scripts/
│   ├── up.sh
│   └── down.sh
└── docs/
    ├── routing-table.md
    └── migration-checklist.md
```

## Clone Semua Repository Service

Contoh clone (ganti sesuai akses SSH/HTTPS):

```bash
git clone https://github.com/advprog-2026-A20-project/bidmart-infra.git
git clone https://github.com/advprog-2026-A20-project/bidmart-gateway.git
git clone https://github.com/advprog-2026-A20-project/bidmart-frontend.git
git clone https://github.com/advprog-2026-A20-project/bidmart-auth-service.git
git clone https://github.com/advprog-2026-A20-project/bidmart-listing-query-service.git
git clone https://github.com/advprog-2026-A20-project/bidmart-auction-query-service.git
git clone https://github.com/advprog-2026-A20-project/bidmart-bidding-command-service.git
git clone https://github.com/advprog-2026-A20-project/bidmart-wallet-service.git
git clone https://github.com/advprog-2026-A20-project/bidmart-notification-service.git
```

## Setup Environment

```bash
cp .env.example .env
```

> Jangan commit `.env`.

## Jalankan Lokal

```bash
docker compose --env-file .env up -d
```

Atau gunakan helper script:

```bash
./scripts/up.sh
```

Stop:

```bash
./scripts/down.sh
```

## Port Mapping

- gateway: `8080`
- auth-service: `8081`
- listing-query-service: `8082`
- auction-query-service: `8083`
- bidding-command-service: `8084`
- wallet-service: `8085`
- notification-service: `8086` (opsional)
- frontend: `5173`
- postgres: `5432`

## Routing Table

Lihat `docs/routing-table.md` untuk route prefix -> target service.

## Dependency Antar Service

- `gateway` bergantung pada seluruh backend service.
- `frontend` mengakses `gateway` sebagai BFF/public API.
- `auth-service`, `listing-query-service`, `auction-query-service`, `bidding-command-service`, `wallet-service` bergantung pada `postgres`.
- `notification-service` saat ini opsional (profile `optional`).

## TODO / Asumsi

- **Asumsi**: image container tiap service dipublish ke GHCR dengan tag `staging`.
- Sinkronisasi nama environment variable per service mungkin perlu penyesuaian setelah contract config final.
- Gateway config detail (Nginx/Traefik/Envoy) belum final, masih placeholder di folder `gateway/`.
- Isolasi database per service belum final; saat ini menggunakan satu instance Postgres lokal dengan schema terpisah.
