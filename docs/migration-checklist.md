# Migration Checklist Monolith -> Microservices

## Infra
- [x] Compose satu command untuk seluruh stack lokal
- [x] `.env.example` sinkron dengan service aktif
- [x] Smoke test end-to-end tersedia

## Ownership Migration
- [x] Auth dipindah ke `bidmart-auth-service`
- [x] Wallet dipindah ke `bidmart-wallet-service`
- [x] Auction/Bidding command dipindah ke `bidmart-bidding-command-service`
- [x] Gateway route command/auth/wallet sudah ke service masing-masing

## Gateway Cleanup
- [x] Runtime monolith logic untuk auth dihapus dari gateway
- [x] Runtime monolith logic untuk wallet dihapus dari gateway
- [x] Runtime monolith logic untuk auction/bidding command dihapus dari gateway
- [x] Test legacy command/auth/wallet gateway sudah dihapus/diganti proxy test

## Verification
- [x] `./scripts/smoke-test.sh` pass
- [x] Compose `up -d --build` pass
