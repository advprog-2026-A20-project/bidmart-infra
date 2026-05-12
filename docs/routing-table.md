# Routing Table

| Public Path Prefix | Target Service | Internal URL | Status |
|---|---|---|---|
| `/api/auth` | gateway -> auth-service | `http://auth-service:8081` | aktif |
| `/api/wallet` | gateway -> wallet-service | `http://wallet-service:8085` | aktif |
| `/api/auctions` (GET) | gateway -> auction-query-service | `http://auction-query-service:8083` | aktif |
| `/api/auctions` (POST command) | gateway -> bidding-command-service | `http://bidding-command-service:8084` | aktif |
| `/api/listings` (GET) | gateway -> listing-query-service | `http://listing-query-service:8082` | aktif |
| `/` | frontend | `http://frontend:5173` | aktif |
| `/notifications` | notification-service | `http://notification-service:8086` | opsional |
