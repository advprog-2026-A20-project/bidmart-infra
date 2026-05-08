# Routing Table (Draft)

| Public Path Prefix | Target Service | Internal URL | Status |
|---|---|---|---|
| `/api/auth` | auth-service | `http://auth-service:8081` | aktif (target) |
| `/api/listings` | listing-query-service | `http://listing-query-service:8082` | aktif (target) |
| `/api/auctions` | auction-query-service | `http://auction-query-service:8083` | aktif (target) |
| `/api/bids` | bidding-command-service | `http://bidding-command-service:8084` | aktif (target) |
| `/api/wallet` | wallet-service | `http://wallet-service:8085` | aktif (target) |
| `/api/notifications` | notification-service | `http://notification-service:8086` | opsional |
| `/` | frontend | `http://frontend:5173` | aktif (target) |

> Catatan: path final mengikuti implementasi `bidmart-gateway`.
