# BidMart Infra

Repository ini berisi konfigurasi infrastruktur lokal dan deployment helper untuk migrasi BidMart ke microservice multi-repo.

## Boundary Repo

Infra repo bertanggung jawab untuk:

- `docker-compose` lokal lintas service.
- Contoh environment variable tanpa secret.
- Dokumentasi port dan dependency antar service.
- Tempat awal konfigurasi broker, database lokal, observability, dan deployment script.

Infra repo tidak menyimpan source code domain service dan tidak boleh menyimpan credential asli.

## Run Lokal

Salin `.env.example` menjadi `.env.local` di mesin masing-masing jika dibutuhkan. Jangan commit file `.env`.

```bash
docker compose up --build
```

## Service Port

| Service | Port |
| --- | --- |
| Gateway | `8080` |
| Auction query | `8081` |
| Listing query | `8082` |
| Auth | `8083` |
| Wallet | `8084` |
| Bidding command | `8085` |
| Notification | `8086` |
| Frontend | `5173` |

## Test

Infra tidak memiliki unit test saat ini. Validasi utama:

```bash
docker compose config
```

## Catatan Migrasi

- Compose ini adalah target awal, bukan bukti semua service sudah production-ready.
- Service command yang masih scaffold dapat tetap dimatikan sampai logic dipindahkan dari gateway.
- Jangan commit secret, token, private key, dump database, atau artifact build.
