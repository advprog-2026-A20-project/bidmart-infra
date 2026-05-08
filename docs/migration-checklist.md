# Migration Checklist Monolith -> Multi-Repo

## Fondasi Infra
- [x] Repository `bidmart-infra` dibuat.
- [x] `docker-compose.yml` baseline tersedia.
- [x] `.env.example` tersedia tanpa secret real.
- [x] Dokumen routing table awal tersedia.

## Integrasi Service
- [ ] Semua image container service tersedia di registry.
- [ ] Healthcheck per service distandarkan.
- [ ] Kontrak environment variable per service distandarkan.
- [ ] Strategi database final (shared vs isolated) diputuskan.

## Gateway Strangler
- [ ] Route lama monolith dipetakan dan diberi prioritas migrasi.
- [ ] Fallback ke legacy monolith diverifikasi.
- [ ] Versioning endpoint antar service disepakati.

## Operasional Lokal
- [ ] Seed data lokal lintas service.
- [ ] Script e2e smoke test gabungan.
- [ ] Observability lokal (logging/tracing) dasar.
