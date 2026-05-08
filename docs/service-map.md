# BidMart Service Map

## Entry Point

- Frontend memanggil gateway melalui `/api/*`.
- Gateway bertindak sebagai strangler facade dan fallback legacy.

## Read Side

- `bidmart-auction-query-service`: `GET /api/auctions*`.
- `bidmart-listing-query-service`: `GET /api/listings*`.

## Command Side Target

- `bidmart-bidding-command-service`: auction lifecycle dan place bid.
- `bidmart-wallet-service`: saldo, hold, release, capture.
- `bidmart-auth-service`: register, login, token.
- `bidmart-notification-service`: async notification.

## Urutan Aman

1. Stabilkan query service dan gateway rollout.
2. Pisahkan frontend.
3. Rapikan wallet source of truth.
4. Baru ekstrak bidding command.
5. Tambah event broker/outbox untuk projection dan notification.
